// Primeri razlicitih petlji za testiranje LICM (Loop Invariant Code Motion) pass-a
// Svaka funkcija pokazuje drugaciji slucaj!
// Napomena: pre pokretanja LICM passa, obavezno prvo pokrenuti mem2reg,
// inace su sve promenljive alloca/load/store i nista nece biti prepoznato.

int global_counter = 0;

// 1) Osnovni slucaj - jednostavna invarijantna aritmetika
// 'k * 2 + 1' ne zavisi od 'i', racuna se identicno u svakoj iteraciji
// OCEKIVANO: mul i add se premestaju u preheader
int simple_invariant(int n, int k) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        int t = k * 2 + 1;
        s = s + t;
    }
    return s;
}

// 2) Lanac zavisnosti (chain) - visestepena invarijantna ekspresija
// svaka sledeca instrukcija zavisi od prethodne, koja je vec invarijantna
// OCEKIVANO: sve tri instrukcije (mul, add, mul) se premestaju, tacnim redosledom
int invariant_chain(int n, int a, int b) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        int x = a * b;
        int y = x + 1;
        int z = y * 2;
        s = s + z + i;   // 'i' ovde spreci samo ovaj sabirak, ne i x/y/z
    }
    return s;
}

// 3) Invarijantno poredjenje (icmp)
// 't > 0' zavisi samo od 'k', ne od 'i' -> uslov je isti u svakoj iteraciji
// OCEKIVANO: icmp (i mul/add koji ga racunaju) se premesta u preheader
int invariant_condition(int n, int k) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        int t = k * 3;
        if (t > 0)
            s = s + 1;
    }
    return s;
}

// 4) NIJE invarijantno - direktno zavisi od promenljive petlje
// 'i * 2' se racuna razlicito u svakoj iteraciji
// OCEKIVANO: mul NE SME biti hoistovan (i menja vrednost svaki put)
int not_invariant_uses_iv(int n) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        int t = i * 2;
        s = s + t;
    }
    return s;
}

// 5) Izgleda invarijantno, ali dolazi iz load-a preko pokazivaca
// 'k' se cita iz memorije svaki put; bez alias analize ne mozemo
// garantovati da se ta memorija ne menja unutar petlje (npr. preko drugog pokazivaca)
// OCEKIVANO: load NIJE kandidat (namerno iskljucen iz obima),
// pa cak i da je 'k' aritmeticki invarijantno, mul koji ga koristi
// NE SME biti hoistovan jer mu je operand definisan unutar petlje (rezultat load-a)
int looks_invariant_but_is_load(int n, int *k_ptr) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        int k = *k_ptr;      // load - NIJE kandidat
        int t = k * 2;       // operand je load rezultat -> NIJE invarijantno
        s = s + t;
    }
    return s;
}

// 6) Sadrzi poziv funkcije
// aritmetika oko poziva moze izgledati invarijantna, ali call ima
// potencijalne bocne efekte i namerno je van obima
// OCEKIVANO: call se ne dira; ako neka aritmetika zavisi od rezultata poziva,
// ni ona ne moze biti invarijantna (rezultat poziva definisan je unutar petlje)
extern int compute(int x);

int has_function_call(int n, int k) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        int t = compute(k);   // call - NIJE kandidat
        s = s + t;
    }
    return s;
}

// 7) Ugnjezdene petlje - visestepeni hoisting
// 'a * b' je invarijantno u odnosu na UNUTRASNJU petlju (ne zavisi od 'j'),
// pa ce prvo biti podignuto u preheader unutrasnje petlje.
// Buduci da ni tamo ne zavisi od 'i', sledeci prolaz (za spoljnu petlju)
// bi trebalo da ga podigne JOS JEDAN nivo, do preheadera spoljne petlje.
// OCEKIVANO: 'a * b' zavrsava u preheaderu SPOLJNE petlje (dvostepeni hoisting)
int nested_multi_level_hoist(int n, int m, int a, int b) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            int c = a * b;      // invarijantno i za unutrasnju i za spoljnu petlju
            s = s + c + i + j;
        }
    }
    return s;
}

// 8) Ugnjezdene petlje - invarijantno SAMO za unutrasnju petlju
// 'i * 2' zavisi od 'i', pa je invarijantno u odnosu na UNUTRASNJU petlju
// (jer se 'i' ne menja dok se vrti unutrasnja petlja po 'j'),
// ali NIJE invarijantno u odnosu na spoljnu petlju.
// OCEKIVANO: 'i * 2' zavrsava u preheaderu UNUTRASNJE petlje, ali NE ide dalje
int nested_inner_only_invariant(int n, int m) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < m; j++) {
            int t = i * 2;      // invarijantno za unutrasnju, ne za spoljnu
            s = s + t + j;
        }
    }
    return s;
}

// 9) Mesovita ekspresija - deo invarijantan, deo nije
// 'k * 2' je invarijantno, ali 'x + i' nije (zavisi od 'i')
// OCEKIVANO: SAMO 'k * 2' (mul) se hoistuje; 'add' sa 'i' ostaje u petlji
int partially_invariant(int n, int k) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        int x = k * 2;
        int y = x + i;
        s = s + y;
    }
    return s;
}

// 10) Invarijantno preko argumenata funkcije (bez ijedne konstante)
// svi operandi su argumenti funkcije - definisani van (pre) petlje po definiciji
// OCEKIVANO: ceo lanac (mul, add, icmp) se hoistuje
int invariant_from_arguments(int n, int a, int b, int c) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        int t = a * b;
        int u = t + c;
        if (u > a)
            s = s + 1;
    }
    return s;
}

// 11) Petlja bez tela koje ima invarijantnih kandidata
// sve zavisi od 'i' - ne bi trebalo da bude promena
// OCEKIVANO: pass ne pravi nikakav hoisting (broj hoistovanih instrukcija = 0)
int no_invariant_candidates(int n) {
    int s = 0;
    for (int i = 0; i < n; i++) {
        s = s + i * i;
    }
    return s;
}