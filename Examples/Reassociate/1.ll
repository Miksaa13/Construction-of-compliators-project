define i32 @test(i32 %a) {
entry:
  %tmp1 = add i32 %a, 5
  %tmp2 = add i32 %tmp1, 3
  ret i32 %tmp2
}
