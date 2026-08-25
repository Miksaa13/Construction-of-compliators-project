define i32 @testmul(i32 %b) {
entry:
  %tmp1 = mul i32 %b, 4
  %tmp2 = mul i32 %tmp1, 3
  ret i32 %tmp2
}
