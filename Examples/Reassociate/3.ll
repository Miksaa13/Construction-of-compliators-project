; Bez konstanti - ne treba nista da se menja
define i32 @nema_konstanti(i32 %x, i32 %y) {
entry:
  %tmp1 = add i32 %x, %y
  ret i32 %tmp1
}

; Samo jedna konstanta - nema sta da se sazme, ne treba da se menja
define i32 @jedna_konstanta(i32 %x) {
entry:
  %tmp1 = add i32 %x, 5
  ret i32 %tmp1
}

; Vise promenljivih i vise konstanti pomesano
define i32 @mesovito(i32 %x, i32 %y) {
entry:
  %tmp1 = add i32 %x, 5
  %tmp2 = add i32 %tmp1, %y
  %tmp3 = add i32 %tmp2, 3
  ret i32 %tmp3
}

; Duzi lanac konstanti
define i32 @duzi_lanac(i32 %x) {
entry:
  %tmp1 = add i32 %x, 1
  %tmp2 = add i32 %tmp1, 2
  %tmp3 = add i32 %tmp2, 3
  %tmp4 = add i32 %tmp3, 4
  ret i32 %tmp4
}
