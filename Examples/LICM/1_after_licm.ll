; ModuleID = '1_before_licm.ll'
source_filename = "1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@global_counter = dso_local global i32 0, align 4

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @simple_invariant(i32 noundef %0, i32 noundef %1) #0 {
  %3 = mul nsw i32 %1, 2
  %4 = add nsw i32 %3, 1
  br label %5

5:                                                ; preds = %9, %2
  %.01 = phi i32 [ 0, %2 ], [ %8, %9 ]
  %.0 = phi i32 [ 0, %2 ], [ %10, %9 ]
  %6 = icmp slt i32 %.0, %0
  br i1 %6, label %7, label %11

7:                                                ; preds = %5
  %8 = add nsw i32 %.01, %4
  br label %9

9:                                                ; preds = %7
  %10 = add nsw i32 %.0, 1
  br label %5, !llvm.loop !6

11:                                               ; preds = %5
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @invariant_chain(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = mul nsw i32 %1, %2
  %5 = add nsw i32 %4, 1
  %6 = mul nsw i32 %5, 2
  br label %7

7:                                                ; preds = %12, %3
  %.01 = phi i32 [ 0, %3 ], [ %11, %12 ]
  %.0 = phi i32 [ 0, %3 ], [ %13, %12 ]
  %8 = icmp slt i32 %.0, %0
  br i1 %8, label %9, label %14

9:                                                ; preds = %7
  %10 = add nsw i32 %.01, %6
  %11 = add nsw i32 %10, %.0
  br label %12

12:                                               ; preds = %9
  %13 = add nsw i32 %.0, 1
  br label %7, !llvm.loop !8

14:                                               ; preds = %7
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @invariant_condition(i32 noundef %0, i32 noundef %1) #0 {
  %3 = mul nsw i32 %1, 3
  %4 = icmp sgt i32 %3, 0
  br label %5

5:                                                ; preds = %11, %2
  %.01 = phi i32 [ 0, %2 ], [ %.1, %11 ]
  %.0 = phi i32 [ 0, %2 ], [ %12, %11 ]
  %6 = icmp slt i32 %.0, %0
  br i1 %6, label %7, label %13

7:                                                ; preds = %5
  br i1 %4, label %8, label %10

8:                                                ; preds = %7
  %9 = add nsw i32 %.01, 1
  br label %10

10:                                               ; preds = %8, %7
  %.1 = phi i32 [ %9, %8 ], [ %.01, %7 ]
  br label %11

11:                                               ; preds = %10
  %12 = add nsw i32 %.0, 1
  br label %5, !llvm.loop !9

13:                                               ; preds = %5
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @not_invariant_uses_iv(i32 noundef %0) #0 {
  br label %2

2:                                                ; preds = %7, %1
  %.01 = phi i32 [ 0, %1 ], [ %6, %7 ]
  %.0 = phi i32 [ 0, %1 ], [ %8, %7 ]
  %3 = icmp slt i32 %.0, %0
  br i1 %3, label %4, label %9

4:                                                ; preds = %2
  %5 = mul nsw i32 %.0, 2
  %6 = add nsw i32 %.01, %5
  br label %7

7:                                                ; preds = %4
  %8 = add nsw i32 %.0, 1
  br label %2, !llvm.loop !10

9:                                                ; preds = %2
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @looks_invariant_but_is_load(i32 noundef %0, ptr noundef %1) #0 {
  br label %3

3:                                                ; preds = %9, %2
  %.01 = phi i32 [ 0, %2 ], [ %8, %9 ]
  %.0 = phi i32 [ 0, %2 ], [ %10, %9 ]
  %4 = icmp slt i32 %.0, %0
  br i1 %4, label %5, label %11

5:                                                ; preds = %3
  %6 = load i32, ptr %1, align 4
  %7 = mul nsw i32 %6, 2
  %8 = add nsw i32 %.01, %7
  br label %9

9:                                                ; preds = %5
  %10 = add nsw i32 %.0, 1
  br label %3, !llvm.loop !11

11:                                               ; preds = %3
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @has_function_call(i32 noundef %0, i32 noundef %1) #0 {
  br label %3

3:                                                ; preds = %8, %2
  %.01 = phi i32 [ 0, %2 ], [ %7, %8 ]
  %.0 = phi i32 [ 0, %2 ], [ %9, %8 ]
  %4 = icmp slt i32 %.0, %0
  br i1 %4, label %5, label %10

5:                                                ; preds = %3
  %6 = call i32 @compute(i32 noundef %1)
  %7 = add nsw i32 %.01, %6
  br label %8

8:                                                ; preds = %5
  %9 = add nsw i32 %.0, 1
  br label %3, !llvm.loop !12

10:                                               ; preds = %3
  ret i32 %.01
}

declare i32 @compute(i32 noundef) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @nested_multi_level_hoist(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = mul nsw i32 %2, %3
  br label %6

6:                                                ; preds = %18, %4
  %.02 = phi i32 [ 0, %4 ], [ %.1, %18 ]
  %.01 = phi i32 [ 0, %4 ], [ %19, %18 ]
  %7 = icmp slt i32 %.01, %0
  br i1 %7, label %8, label %20

8:                                                ; preds = %6
  br label %9

9:                                                ; preds = %15, %8
  %.1 = phi i32 [ %.02, %8 ], [ %14, %15 ]
  %.0 = phi i32 [ 0, %8 ], [ %16, %15 ]
  %10 = icmp slt i32 %.0, %1
  br i1 %10, label %11, label %17

11:                                               ; preds = %9
  %12 = add nsw i32 %.1, %5
  %13 = add nsw i32 %12, %.01
  %14 = add nsw i32 %13, %.0
  br label %15

15:                                               ; preds = %11
  %16 = add nsw i32 %.0, 1
  br label %9, !llvm.loop !13

17:                                               ; preds = %9
  br label %18

18:                                               ; preds = %17
  %19 = add nsw i32 %.01, 1
  br label %6, !llvm.loop !14

20:                                               ; preds = %6
  ret i32 %.02
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @nested_inner_only_invariant(i32 noundef %0, i32 noundef %1) #0 {
  br label %3

3:                                                ; preds = %15, %2
  %.02 = phi i32 [ 0, %2 ], [ %.1, %15 ]
  %.01 = phi i32 [ 0, %2 ], [ %16, %15 ]
  %4 = icmp slt i32 %.01, %0
  br i1 %4, label %5, label %17

5:                                                ; preds = %3
  %6 = mul nsw i32 %.01, 2
  br label %7

7:                                                ; preds = %12, %5
  %.1 = phi i32 [ %.02, %5 ], [ %11, %12 ]
  %.0 = phi i32 [ 0, %5 ], [ %13, %12 ]
  %8 = icmp slt i32 %.0, %1
  br i1 %8, label %9, label %14

9:                                                ; preds = %7
  %10 = add nsw i32 %.1, %6
  %11 = add nsw i32 %10, %.0
  br label %12

12:                                               ; preds = %9
  %13 = add nsw i32 %.0, 1
  br label %7, !llvm.loop !15

14:                                               ; preds = %7
  br label %15

15:                                               ; preds = %14
  %16 = add nsw i32 %.01, 1
  br label %3, !llvm.loop !16

17:                                               ; preds = %3
  ret i32 %.02
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @partially_invariant(i32 noundef %0, i32 noundef %1) #0 {
  %3 = mul nsw i32 %1, 2
  br label %4

4:                                                ; preds = %9, %2
  %.01 = phi i32 [ 0, %2 ], [ %8, %9 ]
  %.0 = phi i32 [ 0, %2 ], [ %10, %9 ]
  %5 = icmp slt i32 %.0, %0
  br i1 %5, label %6, label %11

6:                                                ; preds = %4
  %7 = add nsw i32 %3, %.0
  %8 = add nsw i32 %.01, %7
  br label %9

9:                                                ; preds = %6
  %10 = add nsw i32 %.0, 1
  br label %4, !llvm.loop !17

11:                                               ; preds = %4
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @invariant_from_arguments(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = mul nsw i32 %1, %2
  %6 = add nsw i32 %5, %3
  %7 = icmp sgt i32 %6, %1
  br label %8

8:                                                ; preds = %14, %4
  %.01 = phi i32 [ 0, %4 ], [ %.1, %14 ]
  %.0 = phi i32 [ 0, %4 ], [ %15, %14 ]
  %9 = icmp slt i32 %.0, %0
  br i1 %9, label %10, label %16

10:                                               ; preds = %8
  br i1 %7, label %11, label %13

11:                                               ; preds = %10
  %12 = add nsw i32 %.01, 1
  br label %13

13:                                               ; preds = %11, %10
  %.1 = phi i32 [ %12, %11 ], [ %.01, %10 ]
  br label %14

14:                                               ; preds = %13
  %15 = add nsw i32 %.0, 1
  br label %8, !llvm.loop !18

16:                                               ; preds = %8
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @no_invariant_candidates(i32 noundef %0) #0 {
  br label %2

2:                                                ; preds = %7, %1
  %.01 = phi i32 [ 0, %1 ], [ %6, %7 ]
  %.0 = phi i32 [ 0, %1 ], [ %8, %7 ]
  %3 = icmp slt i32 %.0, %0
  br i1 %3, label %4, label %9

4:                                                ; preds = %2
  %5 = mul nsw i32 %.0, %.0
  %6 = add nsw i32 %.01, %5
  br label %7

7:                                                ; preds = %4
  %8 = add nsw i32 %.0, 1
  br label %2, !llvm.loop !19

9:                                                ; preds = %2
  ret i32 %.01
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.0"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
