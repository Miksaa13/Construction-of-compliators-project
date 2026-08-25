; ModuleID = 't.mem2reg.ll'
source_filename = "1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@global_counter = dso_local global i32 0, align 4, !dbg !0

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @simple_invariant(i32 noundef %0, i32 noundef %1) #0 !dbg !14 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !18, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.value(metadata i32 %1, metadata !20, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.value(metadata i32 0, metadata !21, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.value(metadata i32 0, metadata !22, metadata !DIExpression()), !dbg !24
  %3 = mul nsw i32 %1, 2, !dbg !25
  %4 = add nsw i32 %3, 1, !dbg !28
  br label %5, !dbg !29

5:                                                ; preds = %9, %2
  %.01 = phi i32 [ 0, %2 ], [ %8, %9 ], !dbg !19
  %.0 = phi i32 [ 0, %2 ], [ %10, %9 ], !dbg !30
  call void @llvm.dbg.value(metadata i32 %.0, metadata !22, metadata !DIExpression()), !dbg !24
  call void @llvm.dbg.value(metadata i32 %.01, metadata !21, metadata !DIExpression()), !dbg !19
  %6 = icmp slt i32 %.0, %0, !dbg !31
  br i1 %6, label %7, label %11, !dbg !32

7:                                                ; preds = %5
  call void @llvm.dbg.value(metadata i32 %4, metadata !33, metadata !DIExpression()), !dbg !34
  %8 = add nsw i32 %.01, %4, !dbg !35
  call void @llvm.dbg.value(metadata i32 %8, metadata !21, metadata !DIExpression()), !dbg !19
  br label %9, !dbg !36

9:                                                ; preds = %7
  %10 = add nsw i32 %.0, 1, !dbg !37
  call void @llvm.dbg.value(metadata i32 %10, metadata !22, metadata !DIExpression()), !dbg !24
  br label %5, !dbg !38, !llvm.loop !39

11:                                               ; preds = %5
  ret i32 %.01, !dbg !42
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @invariant_chain(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !43 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !46, metadata !DIExpression()), !dbg !47
  call void @llvm.dbg.value(metadata i32 %1, metadata !48, metadata !DIExpression()), !dbg !47
  call void @llvm.dbg.value(metadata i32 %2, metadata !49, metadata !DIExpression()), !dbg !47
  call void @llvm.dbg.value(metadata i32 0, metadata !50, metadata !DIExpression()), !dbg !47
  call void @llvm.dbg.value(metadata i32 0, metadata !51, metadata !DIExpression()), !dbg !53
  %4 = mul nsw i32 %1, %2, !dbg !54
  %5 = add nsw i32 %4, 1, !dbg !57
  %6 = mul nsw i32 %5, 2, !dbg !58
  br label %7, !dbg !59

7:                                                ; preds = %12, %3
  %.01 = phi i32 [ 0, %3 ], [ %11, %12 ], !dbg !47
  %.0 = phi i32 [ 0, %3 ], [ %13, %12 ], !dbg !60
  call void @llvm.dbg.value(metadata i32 %.0, metadata !51, metadata !DIExpression()), !dbg !53
  call void @llvm.dbg.value(metadata i32 %.01, metadata !50, metadata !DIExpression()), !dbg !47
  %8 = icmp slt i32 %.0, %0, !dbg !61
  br i1 %8, label %9, label %14, !dbg !62

9:                                                ; preds = %7
  call void @llvm.dbg.value(metadata i32 %4, metadata !63, metadata !DIExpression()), !dbg !64
  call void @llvm.dbg.value(metadata i32 %5, metadata !65, metadata !DIExpression()), !dbg !64
  call void @llvm.dbg.value(metadata i32 %6, metadata !66, metadata !DIExpression()), !dbg !64
  %10 = add nsw i32 %.01, %6, !dbg !67
  %11 = add nsw i32 %10, %.0, !dbg !68
  call void @llvm.dbg.value(metadata i32 %11, metadata !50, metadata !DIExpression()), !dbg !47
  br label %12, !dbg !69

12:                                               ; preds = %9
  %13 = add nsw i32 %.0, 1, !dbg !70
  call void @llvm.dbg.value(metadata i32 %13, metadata !51, metadata !DIExpression()), !dbg !53
  br label %7, !dbg !71, !llvm.loop !72

14:                                               ; preds = %7
  ret i32 %.01, !dbg !74
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @invariant_condition(i32 noundef %0, i32 noundef %1) #0 !dbg !75 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !76, metadata !DIExpression()), !dbg !77
  call void @llvm.dbg.value(metadata i32 %1, metadata !78, metadata !DIExpression()), !dbg !77
  call void @llvm.dbg.value(metadata i32 0, metadata !79, metadata !DIExpression()), !dbg !77
  call void @llvm.dbg.value(metadata i32 0, metadata !80, metadata !DIExpression()), !dbg !82
  %3 = mul nsw i32 %1, 3, !dbg !83
  %4 = icmp sgt i32 %3, 0, !dbg !86
  br label %5, !dbg !88

5:                                                ; preds = %11, %2
  %.01 = phi i32 [ 0, %2 ], [ %.1, %11 ], !dbg !77
  %.0 = phi i32 [ 0, %2 ], [ %12, %11 ], !dbg !89
  call void @llvm.dbg.value(metadata i32 %.0, metadata !80, metadata !DIExpression()), !dbg !82
  call void @llvm.dbg.value(metadata i32 %.01, metadata !79, metadata !DIExpression()), !dbg !77
  %6 = icmp slt i32 %.0, %0, !dbg !90
  br i1 %6, label %7, label %13, !dbg !91

7:                                                ; preds = %5
  call void @llvm.dbg.value(metadata i32 %3, metadata !92, metadata !DIExpression()), !dbg !93
  br i1 %4, label %8, label %10, !dbg !94

8:                                                ; preds = %7
  %9 = add nsw i32 %.01, 1, !dbg !95
  call void @llvm.dbg.value(metadata i32 %9, metadata !79, metadata !DIExpression()), !dbg !77
  br label %10, !dbg !96

10:                                               ; preds = %8, %7
  %.1 = phi i32 [ %9, %8 ], [ %.01, %7 ], !dbg !77
  call void @llvm.dbg.value(metadata i32 %.1, metadata !79, metadata !DIExpression()), !dbg !77
  br label %11, !dbg !97

11:                                               ; preds = %10
  %12 = add nsw i32 %.0, 1, !dbg !98
  call void @llvm.dbg.value(metadata i32 %12, metadata !80, metadata !DIExpression()), !dbg !82
  br label %5, !dbg !99, !llvm.loop !100

13:                                               ; preds = %5
  ret i32 %.01, !dbg !102
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @not_invariant_uses_iv(i32 noundef %0) #0 !dbg !103 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !106, metadata !DIExpression()), !dbg !107
  call void @llvm.dbg.value(metadata i32 0, metadata !108, metadata !DIExpression()), !dbg !107
  call void @llvm.dbg.value(metadata i32 0, metadata !109, metadata !DIExpression()), !dbg !111
  br label %2, !dbg !112

2:                                                ; preds = %7, %1
  %.01 = phi i32 [ 0, %1 ], [ %6, %7 ], !dbg !107
  %.0 = phi i32 [ 0, %1 ], [ %8, %7 ], !dbg !113
  call void @llvm.dbg.value(metadata i32 %.0, metadata !109, metadata !DIExpression()), !dbg !111
  call void @llvm.dbg.value(metadata i32 %.01, metadata !108, metadata !DIExpression()), !dbg !107
  %3 = icmp slt i32 %.0, %0, !dbg !114
  br i1 %3, label %4, label %9, !dbg !116

4:                                                ; preds = %2
  %5 = mul nsw i32 %.0, 2, !dbg !117
  call void @llvm.dbg.value(metadata i32 %5, metadata !119, metadata !DIExpression()), !dbg !120
  %6 = add nsw i32 %.01, %5, !dbg !121
  call void @llvm.dbg.value(metadata i32 %6, metadata !108, metadata !DIExpression()), !dbg !107
  br label %7, !dbg !122

7:                                                ; preds = %4
  %8 = add nsw i32 %.0, 1, !dbg !123
  call void @llvm.dbg.value(metadata i32 %8, metadata !109, metadata !DIExpression()), !dbg !111
  br label %2, !dbg !124, !llvm.loop !125

9:                                                ; preds = %2
  ret i32 %.01, !dbg !127
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @looks_invariant_but_is_load(i32 noundef %0, ptr noundef %1) #0 !dbg !128 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !132, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata ptr %1, metadata !134, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata i32 0, metadata !135, metadata !DIExpression()), !dbg !133
  call void @llvm.dbg.value(metadata i32 0, metadata !136, metadata !DIExpression()), !dbg !138
  br label %3, !dbg !139

3:                                                ; preds = %9, %2
  %.01 = phi i32 [ 0, %2 ], [ %8, %9 ], !dbg !133
  %.0 = phi i32 [ 0, %2 ], [ %10, %9 ], !dbg !140
  call void @llvm.dbg.value(metadata i32 %.0, metadata !136, metadata !DIExpression()), !dbg !138
  call void @llvm.dbg.value(metadata i32 %.01, metadata !135, metadata !DIExpression()), !dbg !133
  %4 = icmp slt i32 %.0, %0, !dbg !141
  br i1 %4, label %5, label %11, !dbg !143

5:                                                ; preds = %3
  %6 = load i32, ptr %1, align 4, !dbg !144
  call void @llvm.dbg.value(metadata i32 %6, metadata !146, metadata !DIExpression()), !dbg !147
  %7 = mul nsw i32 %6, 2, !dbg !148
  call void @llvm.dbg.value(metadata i32 %7, metadata !149, metadata !DIExpression()), !dbg !147
  %8 = add nsw i32 %.01, %7, !dbg !150
  call void @llvm.dbg.value(metadata i32 %8, metadata !135, metadata !DIExpression()), !dbg !133
  br label %9, !dbg !151

9:                                                ; preds = %5
  %10 = add nsw i32 %.0, 1, !dbg !152
  call void @llvm.dbg.value(metadata i32 %10, metadata !136, metadata !DIExpression()), !dbg !138
  br label %3, !dbg !153, !llvm.loop !154

11:                                               ; preds = %3
  ret i32 %.01, !dbg !156
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @has_function_call(i32 noundef %0, i32 noundef %1) #0 !dbg !157 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !158, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.value(metadata i32 %1, metadata !160, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.value(metadata i32 0, metadata !161, metadata !DIExpression()), !dbg !159
  call void @llvm.dbg.value(metadata i32 0, metadata !162, metadata !DIExpression()), !dbg !164
  br label %3, !dbg !165

3:                                                ; preds = %8, %2
  %.01 = phi i32 [ 0, %2 ], [ %7, %8 ], !dbg !159
  %.0 = phi i32 [ 0, %2 ], [ %9, %8 ], !dbg !166
  call void @llvm.dbg.value(metadata i32 %.0, metadata !162, metadata !DIExpression()), !dbg !164
  call void @llvm.dbg.value(metadata i32 %.01, metadata !161, metadata !DIExpression()), !dbg !159
  %4 = icmp slt i32 %.0, %0, !dbg !167
  br i1 %4, label %5, label %10, !dbg !169

5:                                                ; preds = %3
  %6 = call i32 @compute(i32 noundef %1), !dbg !170
  call void @llvm.dbg.value(metadata i32 %6, metadata !172, metadata !DIExpression()), !dbg !173
  %7 = add nsw i32 %.01, %6, !dbg !174
  call void @llvm.dbg.value(metadata i32 %7, metadata !161, metadata !DIExpression()), !dbg !159
  br label %8, !dbg !175

8:                                                ; preds = %5
  %9 = add nsw i32 %.0, 1, !dbg !176
  call void @llvm.dbg.value(metadata i32 %9, metadata !162, metadata !DIExpression()), !dbg !164
  br label %3, !dbg !177, !llvm.loop !178

10:                                               ; preds = %3
  ret i32 %.01, !dbg !180
}

declare i32 @compute(i32 noundef) #2

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @nested_multi_level_hoist(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 !dbg !181 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !184, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.value(metadata i32 %1, metadata !186, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.value(metadata i32 %2, metadata !187, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.value(metadata i32 %3, metadata !188, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.value(metadata i32 0, metadata !189, metadata !DIExpression()), !dbg !185
  call void @llvm.dbg.value(metadata i32 0, metadata !190, metadata !DIExpression()), !dbg !192
  %5 = mul nsw i32 %2, %3, !dbg !193
  br label %6, !dbg !199

6:                                                ; preds = %18, %4
  %.02 = phi i32 [ 0, %4 ], [ %.1, %18 ], !dbg !200
  %.01 = phi i32 [ 0, %4 ], [ %19, %18 ], !dbg !201
  call void @llvm.dbg.value(metadata i32 %.01, metadata !190, metadata !DIExpression()), !dbg !192
  call void @llvm.dbg.value(metadata i32 %.02, metadata !189, metadata !DIExpression()), !dbg !185
  %7 = icmp slt i32 %.01, %0, !dbg !202
  br i1 %7, label %8, label %20, !dbg !203

8:                                                ; preds = %6
  call void @llvm.dbg.value(metadata i32 0, metadata !204, metadata !DIExpression()), !dbg !205
  br label %9, !dbg !206

9:                                                ; preds = %15, %8
  %.1 = phi i32 [ %.02, %8 ], [ %14, %15 ], !dbg !185
  %.0 = phi i32 [ 0, %8 ], [ %16, %15 ], !dbg !207
  call void @llvm.dbg.value(metadata i32 %.0, metadata !204, metadata !DIExpression()), !dbg !205
  call void @llvm.dbg.value(metadata i32 %.1, metadata !189, metadata !DIExpression()), !dbg !185
  %10 = icmp slt i32 %.0, %1, !dbg !208
  br i1 %10, label %11, label %17, !dbg !209

11:                                               ; preds = %9
  call void @llvm.dbg.value(metadata i32 %5, metadata !210, metadata !DIExpression()), !dbg !211
  %12 = add nsw i32 %.1, %5, !dbg !212
  %13 = add nsw i32 %12, %.01, !dbg !213
  %14 = add nsw i32 %13, %.0, !dbg !214
  call void @llvm.dbg.value(metadata i32 %14, metadata !189, metadata !DIExpression()), !dbg !185
  br label %15, !dbg !215

15:                                               ; preds = %11
  %16 = add nsw i32 %.0, 1, !dbg !216
  call void @llvm.dbg.value(metadata i32 %16, metadata !204, metadata !DIExpression()), !dbg !205
  br label %9, !dbg !217, !llvm.loop !218

17:                                               ; preds = %9
  br label %18, !dbg !220

18:                                               ; preds = %17
  %19 = add nsw i32 %.01, 1, !dbg !221
  call void @llvm.dbg.value(metadata i32 %19, metadata !190, metadata !DIExpression()), !dbg !192
  br label %6, !dbg !222, !llvm.loop !223

20:                                               ; preds = %6
  ret i32 %.02, !dbg !225
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @nested_inner_only_invariant(i32 noundef %0, i32 noundef %1) #0 !dbg !226 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !227, metadata !DIExpression()), !dbg !228
  call void @llvm.dbg.value(metadata i32 %1, metadata !229, metadata !DIExpression()), !dbg !228
  call void @llvm.dbg.value(metadata i32 0, metadata !230, metadata !DIExpression()), !dbg !228
  call void @llvm.dbg.value(metadata i32 0, metadata !231, metadata !DIExpression()), !dbg !233
  br label %3, !dbg !234

3:                                                ; preds = %15, %2
  %.02 = phi i32 [ 0, %2 ], [ %.1, %15 ], !dbg !235
  %.01 = phi i32 [ 0, %2 ], [ %16, %15 ], !dbg !236
  call void @llvm.dbg.value(metadata i32 %.01, metadata !231, metadata !DIExpression()), !dbg !233
  call void @llvm.dbg.value(metadata i32 %.02, metadata !230, metadata !DIExpression()), !dbg !228
  %4 = icmp slt i32 %.01, %0, !dbg !237
  br i1 %4, label %5, label %17, !dbg !239

5:                                                ; preds = %3
  call void @llvm.dbg.value(metadata i32 0, metadata !240, metadata !DIExpression()), !dbg !243
  %6 = mul nsw i32 %.01, 2, !dbg !244
  br label %7, !dbg !247

7:                                                ; preds = %12, %5
  %.1 = phi i32 [ %.02, %5 ], [ %11, %12 ], !dbg !228
  %.0 = phi i32 [ 0, %5 ], [ %13, %12 ], !dbg !248
  call void @llvm.dbg.value(metadata i32 %.0, metadata !240, metadata !DIExpression()), !dbg !243
  call void @llvm.dbg.value(metadata i32 %.1, metadata !230, metadata !DIExpression()), !dbg !228
  %8 = icmp slt i32 %.0, %1, !dbg !249
  br i1 %8, label %9, label %14, !dbg !250

9:                                                ; preds = %7
  call void @llvm.dbg.value(metadata i32 %6, metadata !251, metadata !DIExpression()), !dbg !252
  %10 = add nsw i32 %.1, %6, !dbg !253
  %11 = add nsw i32 %10, %.0, !dbg !254
  call void @llvm.dbg.value(metadata i32 %11, metadata !230, metadata !DIExpression()), !dbg !228
  br label %12, !dbg !255

12:                                               ; preds = %9
  %13 = add nsw i32 %.0, 1, !dbg !256
  call void @llvm.dbg.value(metadata i32 %13, metadata !240, metadata !DIExpression()), !dbg !243
  br label %7, !dbg !257, !llvm.loop !258

14:                                               ; preds = %7
  br label %15, !dbg !260

15:                                               ; preds = %14
  %16 = add nsw i32 %.01, 1, !dbg !261
  call void @llvm.dbg.value(metadata i32 %16, metadata !231, metadata !DIExpression()), !dbg !233
  br label %3, !dbg !262, !llvm.loop !263

17:                                               ; preds = %3
  ret i32 %.02, !dbg !265
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @partially_invariant(i32 noundef %0, i32 noundef %1) #0 !dbg !266 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !267, metadata !DIExpression()), !dbg !268
  call void @llvm.dbg.value(metadata i32 %1, metadata !269, metadata !DIExpression()), !dbg !268
  call void @llvm.dbg.value(metadata i32 0, metadata !270, metadata !DIExpression()), !dbg !268
  call void @llvm.dbg.value(metadata i32 0, metadata !271, metadata !DIExpression()), !dbg !273
  %3 = mul nsw i32 %1, 2, !dbg !274
  br label %4, !dbg !277

4:                                                ; preds = %9, %2
  %.01 = phi i32 [ 0, %2 ], [ %8, %9 ], !dbg !268
  %.0 = phi i32 [ 0, %2 ], [ %10, %9 ], !dbg !278
  call void @llvm.dbg.value(metadata i32 %.0, metadata !271, metadata !DIExpression()), !dbg !273
  call void @llvm.dbg.value(metadata i32 %.01, metadata !270, metadata !DIExpression()), !dbg !268
  %5 = icmp slt i32 %.0, %0, !dbg !279
  br i1 %5, label %6, label %11, !dbg !280

6:                                                ; preds = %4
  call void @llvm.dbg.value(metadata i32 %3, metadata !281, metadata !DIExpression()), !dbg !282
  %7 = add nsw i32 %3, %.0, !dbg !283
  call void @llvm.dbg.value(metadata i32 %7, metadata !284, metadata !DIExpression()), !dbg !282
  %8 = add nsw i32 %.01, %7, !dbg !285
  call void @llvm.dbg.value(metadata i32 %8, metadata !270, metadata !DIExpression()), !dbg !268
  br label %9, !dbg !286

9:                                                ; preds = %6
  %10 = add nsw i32 %.0, 1, !dbg !287
  call void @llvm.dbg.value(metadata i32 %10, metadata !271, metadata !DIExpression()), !dbg !273
  br label %4, !dbg !288, !llvm.loop !289

11:                                               ; preds = %4
  ret i32 %.01, !dbg !291
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @invariant_from_arguments(i32 noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 !dbg !292 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !293, metadata !DIExpression()), !dbg !294
  call void @llvm.dbg.value(metadata i32 %1, metadata !295, metadata !DIExpression()), !dbg !294
  call void @llvm.dbg.value(metadata i32 %2, metadata !296, metadata !DIExpression()), !dbg !294
  call void @llvm.dbg.value(metadata i32 %3, metadata !297, metadata !DIExpression()), !dbg !294
  call void @llvm.dbg.value(metadata i32 0, metadata !298, metadata !DIExpression()), !dbg !294
  call void @llvm.dbg.value(metadata i32 0, metadata !299, metadata !DIExpression()), !dbg !301
  %5 = mul nsw i32 %1, %2, !dbg !302
  %6 = add nsw i32 %5, %3, !dbg !305
  %7 = icmp sgt i32 %6, %1, !dbg !306
  br label %8, !dbg !308

8:                                                ; preds = %14, %4
  %.01 = phi i32 [ 0, %4 ], [ %.1, %14 ], !dbg !294
  %.0 = phi i32 [ 0, %4 ], [ %15, %14 ], !dbg !309
  call void @llvm.dbg.value(metadata i32 %.0, metadata !299, metadata !DIExpression()), !dbg !301
  call void @llvm.dbg.value(metadata i32 %.01, metadata !298, metadata !DIExpression()), !dbg !294
  %9 = icmp slt i32 %.0, %0, !dbg !310
  br i1 %9, label %10, label %16, !dbg !311

10:                                               ; preds = %8
  call void @llvm.dbg.value(metadata i32 %5, metadata !312, metadata !DIExpression()), !dbg !313
  call void @llvm.dbg.value(metadata i32 %6, metadata !314, metadata !DIExpression()), !dbg !313
  br i1 %7, label %11, label %13, !dbg !315

11:                                               ; preds = %10
  %12 = add nsw i32 %.01, 1, !dbg !316
  call void @llvm.dbg.value(metadata i32 %12, metadata !298, metadata !DIExpression()), !dbg !294
  br label %13, !dbg !317

13:                                               ; preds = %11, %10
  %.1 = phi i32 [ %12, %11 ], [ %.01, %10 ], !dbg !294
  call void @llvm.dbg.value(metadata i32 %.1, metadata !298, metadata !DIExpression()), !dbg !294
  br label %14, !dbg !318

14:                                               ; preds = %13
  %15 = add nsw i32 %.0, 1, !dbg !319
  call void @llvm.dbg.value(metadata i32 %15, metadata !299, metadata !DIExpression()), !dbg !301
  br label %8, !dbg !320, !llvm.loop !321

16:                                               ; preds = %8
  ret i32 %.01, !dbg !323
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @no_invariant_candidates(i32 noundef %0) #0 !dbg !324 {
  call void @llvm.dbg.value(metadata i32 %0, metadata !325, metadata !DIExpression()), !dbg !326
  call void @llvm.dbg.value(metadata i32 0, metadata !327, metadata !DIExpression()), !dbg !326
  call void @llvm.dbg.value(metadata i32 0, metadata !328, metadata !DIExpression()), !dbg !330
  br label %2, !dbg !331

2:                                                ; preds = %7, %1
  %.01 = phi i32 [ 0, %1 ], [ %6, %7 ], !dbg !326
  %.0 = phi i32 [ 0, %1 ], [ %8, %7 ], !dbg !332
  call void @llvm.dbg.value(metadata i32 %.0, metadata !328, metadata !DIExpression()), !dbg !330
  call void @llvm.dbg.value(metadata i32 %.01, metadata !327, metadata !DIExpression()), !dbg !326
  %3 = icmp slt i32 %.0, %0, !dbg !333
  br i1 %3, label %4, label %9, !dbg !335

4:                                                ; preds = %2
  %5 = mul nsw i32 %.0, %.0, !dbg !336
  %6 = add nsw i32 %.01, %5, !dbg !338
  call void @llvm.dbg.value(metadata i32 %6, metadata !327, metadata !DIExpression()), !dbg !326
  br label %7, !dbg !339

7:                                                ; preds = %4
  %8 = add nsw i32 %.0, 1, !dbg !340
  call void @llvm.dbg.value(metadata i32 %8, metadata !328, metadata !DIExpression()), !dbg !330
  br label %2, !dbg !341, !llvm.loop !342

9:                                                ; preds = %2
  ret i32 %.01, !dbg !344
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!6, !7, !8, !9, !10, !11, !12}
!llvm.ident = !{!13}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "global_counter", scope: !2, file: !3, line: 6, type: !5, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "clang version 17.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "1.c", directory: "/home/mihajlo/projekti/llvm-project/build", checksumkind: CSK_MD5, checksum: "38e44260cfc459b3bb544c79a34e9d04")
!4 = !{!0}
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{i32 7, !"Dwarf Version", i32 5}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{i32 8, !"PIC Level", i32 2}
!10 = !{i32 7, !"PIE Level", i32 2}
!11 = !{i32 7, !"uwtable", i32 2}
!12 = !{i32 7, !"frame-pointer", i32 2}
!13 = !{!"clang version 17.0.0"}
!14 = distinct !DISubprogram(name: "simple_invariant", scope: !3, file: !3, line: 11, type: !15, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!15 = !DISubroutineType(types: !16)
!16 = !{!5, !5, !5}
!17 = !{}
!18 = !DILocalVariable(name: "n", arg: 1, scope: !14, file: !3, line: 11, type: !5)
!19 = !DILocation(line: 0, scope: !14)
!20 = !DILocalVariable(name: "k", arg: 2, scope: !14, file: !3, line: 11, type: !5)
!21 = !DILocalVariable(name: "s", scope: !14, file: !3, line: 12, type: !5)
!22 = !DILocalVariable(name: "i", scope: !23, file: !3, line: 13, type: !5)
!23 = distinct !DILexicalBlock(scope: !14, file: !3, line: 13, column: 5)
!24 = !DILocation(line: 0, scope: !23)
!25 = !DILocation(line: 14, column: 19, scope: !26)
!26 = distinct !DILexicalBlock(scope: !27, file: !3, line: 13, column: 33)
!27 = distinct !DILexicalBlock(scope: !23, file: !3, line: 13, column: 5)
!28 = !DILocation(line: 14, column: 23, scope: !26)
!29 = !DILocation(line: 13, column: 10, scope: !23)
!30 = !DILocation(line: 13, scope: !23)
!31 = !DILocation(line: 13, column: 23, scope: !27)
!32 = !DILocation(line: 13, column: 5, scope: !23)
!33 = !DILocalVariable(name: "t", scope: !26, file: !3, line: 14, type: !5)
!34 = !DILocation(line: 0, scope: !26)
!35 = !DILocation(line: 15, column: 15, scope: !26)
!36 = !DILocation(line: 16, column: 5, scope: !26)
!37 = !DILocation(line: 13, column: 29, scope: !27)
!38 = !DILocation(line: 13, column: 5, scope: !27)
!39 = distinct !{!39, !32, !40, !41}
!40 = !DILocation(line: 16, column: 5, scope: !23)
!41 = !{!"llvm.loop.mustprogress"}
!42 = !DILocation(line: 17, column: 5, scope: !14)
!43 = distinct !DISubprogram(name: "invariant_chain", scope: !3, file: !3, line: 23, type: !44, scopeLine: 23, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!44 = !DISubroutineType(types: !45)
!45 = !{!5, !5, !5, !5}
!46 = !DILocalVariable(name: "n", arg: 1, scope: !43, file: !3, line: 23, type: !5)
!47 = !DILocation(line: 0, scope: !43)
!48 = !DILocalVariable(name: "a", arg: 2, scope: !43, file: !3, line: 23, type: !5)
!49 = !DILocalVariable(name: "b", arg: 3, scope: !43, file: !3, line: 23, type: !5)
!50 = !DILocalVariable(name: "s", scope: !43, file: !3, line: 24, type: !5)
!51 = !DILocalVariable(name: "i", scope: !52, file: !3, line: 25, type: !5)
!52 = distinct !DILexicalBlock(scope: !43, file: !3, line: 25, column: 5)
!53 = !DILocation(line: 0, scope: !52)
!54 = !DILocation(line: 26, column: 19, scope: !55)
!55 = distinct !DILexicalBlock(scope: !56, file: !3, line: 25, column: 33)
!56 = distinct !DILexicalBlock(scope: !52, file: !3, line: 25, column: 5)
!57 = !DILocation(line: 27, column: 19, scope: !55)
!58 = !DILocation(line: 28, column: 19, scope: !55)
!59 = !DILocation(line: 25, column: 10, scope: !52)
!60 = !DILocation(line: 25, scope: !52)
!61 = !DILocation(line: 25, column: 23, scope: !56)
!62 = !DILocation(line: 25, column: 5, scope: !52)
!63 = !DILocalVariable(name: "x", scope: !55, file: !3, line: 26, type: !5)
!64 = !DILocation(line: 0, scope: !55)
!65 = !DILocalVariable(name: "y", scope: !55, file: !3, line: 27, type: !5)
!66 = !DILocalVariable(name: "z", scope: !55, file: !3, line: 28, type: !5)
!67 = !DILocation(line: 29, column: 15, scope: !55)
!68 = !DILocation(line: 29, column: 19, scope: !55)
!69 = !DILocation(line: 30, column: 5, scope: !55)
!70 = !DILocation(line: 25, column: 29, scope: !56)
!71 = !DILocation(line: 25, column: 5, scope: !56)
!72 = distinct !{!72, !62, !73, !41}
!73 = !DILocation(line: 30, column: 5, scope: !52)
!74 = !DILocation(line: 31, column: 5, scope: !43)
!75 = distinct !DISubprogram(name: "invariant_condition", scope: !3, file: !3, line: 37, type: !15, scopeLine: 37, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!76 = !DILocalVariable(name: "n", arg: 1, scope: !75, file: !3, line: 37, type: !5)
!77 = !DILocation(line: 0, scope: !75)
!78 = !DILocalVariable(name: "k", arg: 2, scope: !75, file: !3, line: 37, type: !5)
!79 = !DILocalVariable(name: "s", scope: !75, file: !3, line: 38, type: !5)
!80 = !DILocalVariable(name: "i", scope: !81, file: !3, line: 39, type: !5)
!81 = distinct !DILexicalBlock(scope: !75, file: !3, line: 39, column: 5)
!82 = !DILocation(line: 0, scope: !81)
!83 = !DILocation(line: 40, column: 19, scope: !84)
!84 = distinct !DILexicalBlock(scope: !85, file: !3, line: 39, column: 33)
!85 = distinct !DILexicalBlock(scope: !81, file: !3, line: 39, column: 5)
!86 = !DILocation(line: 41, column: 15, scope: !87)
!87 = distinct !DILexicalBlock(scope: !84, file: !3, line: 41, column: 13)
!88 = !DILocation(line: 39, column: 10, scope: !81)
!89 = !DILocation(line: 39, scope: !81)
!90 = !DILocation(line: 39, column: 23, scope: !85)
!91 = !DILocation(line: 39, column: 5, scope: !81)
!92 = !DILocalVariable(name: "t", scope: !84, file: !3, line: 40, type: !5)
!93 = !DILocation(line: 0, scope: !84)
!94 = !DILocation(line: 41, column: 13, scope: !84)
!95 = !DILocation(line: 42, column: 19, scope: !87)
!96 = !DILocation(line: 42, column: 13, scope: !87)
!97 = !DILocation(line: 43, column: 5, scope: !84)
!98 = !DILocation(line: 39, column: 29, scope: !85)
!99 = !DILocation(line: 39, column: 5, scope: !85)
!100 = distinct !{!100, !91, !101, !41}
!101 = !DILocation(line: 43, column: 5, scope: !81)
!102 = !DILocation(line: 44, column: 5, scope: !75)
!103 = distinct !DISubprogram(name: "not_invariant_uses_iv", scope: !3, file: !3, line: 50, type: !104, scopeLine: 50, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!104 = !DISubroutineType(types: !105)
!105 = !{!5, !5}
!106 = !DILocalVariable(name: "n", arg: 1, scope: !103, file: !3, line: 50, type: !5)
!107 = !DILocation(line: 0, scope: !103)
!108 = !DILocalVariable(name: "s", scope: !103, file: !3, line: 51, type: !5)
!109 = !DILocalVariable(name: "i", scope: !110, file: !3, line: 52, type: !5)
!110 = distinct !DILexicalBlock(scope: !103, file: !3, line: 52, column: 5)
!111 = !DILocation(line: 0, scope: !110)
!112 = !DILocation(line: 52, column: 10, scope: !110)
!113 = !DILocation(line: 52, scope: !110)
!114 = !DILocation(line: 52, column: 23, scope: !115)
!115 = distinct !DILexicalBlock(scope: !110, file: !3, line: 52, column: 5)
!116 = !DILocation(line: 52, column: 5, scope: !110)
!117 = !DILocation(line: 53, column: 19, scope: !118)
!118 = distinct !DILexicalBlock(scope: !115, file: !3, line: 52, column: 33)
!119 = !DILocalVariable(name: "t", scope: !118, file: !3, line: 53, type: !5)
!120 = !DILocation(line: 0, scope: !118)
!121 = !DILocation(line: 54, column: 15, scope: !118)
!122 = !DILocation(line: 55, column: 5, scope: !118)
!123 = !DILocation(line: 52, column: 29, scope: !115)
!124 = !DILocation(line: 52, column: 5, scope: !115)
!125 = distinct !{!125, !116, !126, !41}
!126 = !DILocation(line: 55, column: 5, scope: !110)
!127 = !DILocation(line: 56, column: 5, scope: !103)
!128 = distinct !DISubprogram(name: "looks_invariant_but_is_load", scope: !3, file: !3, line: 65, type: !129, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!129 = !DISubroutineType(types: !130)
!130 = !{!5, !5, !131}
!131 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!132 = !DILocalVariable(name: "n", arg: 1, scope: !128, file: !3, line: 65, type: !5)
!133 = !DILocation(line: 0, scope: !128)
!134 = !DILocalVariable(name: "k_ptr", arg: 2, scope: !128, file: !3, line: 65, type: !131)
!135 = !DILocalVariable(name: "s", scope: !128, file: !3, line: 66, type: !5)
!136 = !DILocalVariable(name: "i", scope: !137, file: !3, line: 67, type: !5)
!137 = distinct !DILexicalBlock(scope: !128, file: !3, line: 67, column: 5)
!138 = !DILocation(line: 0, scope: !137)
!139 = !DILocation(line: 67, column: 10, scope: !137)
!140 = !DILocation(line: 67, scope: !137)
!141 = !DILocation(line: 67, column: 23, scope: !142)
!142 = distinct !DILexicalBlock(scope: !137, file: !3, line: 67, column: 5)
!143 = !DILocation(line: 67, column: 5, scope: !137)
!144 = !DILocation(line: 68, column: 17, scope: !145)
!145 = distinct !DILexicalBlock(scope: !142, file: !3, line: 67, column: 33)
!146 = !DILocalVariable(name: "k", scope: !145, file: !3, line: 68, type: !5)
!147 = !DILocation(line: 0, scope: !145)
!148 = !DILocation(line: 69, column: 19, scope: !145)
!149 = !DILocalVariable(name: "t", scope: !145, file: !3, line: 69, type: !5)
!150 = !DILocation(line: 70, column: 15, scope: !145)
!151 = !DILocation(line: 71, column: 5, scope: !145)
!152 = !DILocation(line: 67, column: 29, scope: !142)
!153 = !DILocation(line: 67, column: 5, scope: !142)
!154 = distinct !{!154, !143, !155, !41}
!155 = !DILocation(line: 71, column: 5, scope: !137)
!156 = !DILocation(line: 72, column: 5, scope: !128)
!157 = distinct !DISubprogram(name: "has_function_call", scope: !3, file: !3, line: 82, type: !15, scopeLine: 82, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!158 = !DILocalVariable(name: "n", arg: 1, scope: !157, file: !3, line: 82, type: !5)
!159 = !DILocation(line: 0, scope: !157)
!160 = !DILocalVariable(name: "k", arg: 2, scope: !157, file: !3, line: 82, type: !5)
!161 = !DILocalVariable(name: "s", scope: !157, file: !3, line: 83, type: !5)
!162 = !DILocalVariable(name: "i", scope: !163, file: !3, line: 84, type: !5)
!163 = distinct !DILexicalBlock(scope: !157, file: !3, line: 84, column: 5)
!164 = !DILocation(line: 0, scope: !163)
!165 = !DILocation(line: 84, column: 10, scope: !163)
!166 = !DILocation(line: 84, scope: !163)
!167 = !DILocation(line: 84, column: 23, scope: !168)
!168 = distinct !DILexicalBlock(scope: !163, file: !3, line: 84, column: 5)
!169 = !DILocation(line: 84, column: 5, scope: !163)
!170 = !DILocation(line: 85, column: 17, scope: !171)
!171 = distinct !DILexicalBlock(scope: !168, file: !3, line: 84, column: 33)
!172 = !DILocalVariable(name: "t", scope: !171, file: !3, line: 85, type: !5)
!173 = !DILocation(line: 0, scope: !171)
!174 = !DILocation(line: 86, column: 15, scope: !171)
!175 = !DILocation(line: 87, column: 5, scope: !171)
!176 = !DILocation(line: 84, column: 29, scope: !168)
!177 = !DILocation(line: 84, column: 5, scope: !168)
!178 = distinct !{!178, !169, !179, !41}
!179 = !DILocation(line: 87, column: 5, scope: !163)
!180 = !DILocation(line: 88, column: 5, scope: !157)
!181 = distinct !DISubprogram(name: "nested_multi_level_hoist", scope: !3, file: !3, line: 97, type: !182, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!182 = !DISubroutineType(types: !183)
!183 = !{!5, !5, !5, !5, !5}
!184 = !DILocalVariable(name: "n", arg: 1, scope: !181, file: !3, line: 97, type: !5)
!185 = !DILocation(line: 0, scope: !181)
!186 = !DILocalVariable(name: "m", arg: 2, scope: !181, file: !3, line: 97, type: !5)
!187 = !DILocalVariable(name: "a", arg: 3, scope: !181, file: !3, line: 97, type: !5)
!188 = !DILocalVariable(name: "b", arg: 4, scope: !181, file: !3, line: 97, type: !5)
!189 = !DILocalVariable(name: "s", scope: !181, file: !3, line: 98, type: !5)
!190 = !DILocalVariable(name: "i", scope: !191, file: !3, line: 99, type: !5)
!191 = distinct !DILexicalBlock(scope: !181, file: !3, line: 99, column: 5)
!192 = !DILocation(line: 0, scope: !191)
!193 = !DILocation(line: 101, column: 23, scope: !194)
!194 = distinct !DILexicalBlock(scope: !195, file: !3, line: 100, column: 37)
!195 = distinct !DILexicalBlock(scope: !196, file: !3, line: 100, column: 9)
!196 = distinct !DILexicalBlock(scope: !197, file: !3, line: 100, column: 9)
!197 = distinct !DILexicalBlock(scope: !198, file: !3, line: 99, column: 33)
!198 = distinct !DILexicalBlock(scope: !191, file: !3, line: 99, column: 5)
!199 = !DILocation(line: 99, column: 10, scope: !191)
!200 = !DILocation(line: 98, column: 9, scope: !181)
!201 = !DILocation(line: 99, scope: !191)
!202 = !DILocation(line: 99, column: 23, scope: !198)
!203 = !DILocation(line: 99, column: 5, scope: !191)
!204 = !DILocalVariable(name: "j", scope: !196, file: !3, line: 100, type: !5)
!205 = !DILocation(line: 0, scope: !196)
!206 = !DILocation(line: 100, column: 14, scope: !196)
!207 = !DILocation(line: 100, scope: !196)
!208 = !DILocation(line: 100, column: 27, scope: !195)
!209 = !DILocation(line: 100, column: 9, scope: !196)
!210 = !DILocalVariable(name: "c", scope: !194, file: !3, line: 101, type: !5)
!211 = !DILocation(line: 0, scope: !194)
!212 = !DILocation(line: 102, column: 19, scope: !194)
!213 = !DILocation(line: 102, column: 23, scope: !194)
!214 = !DILocation(line: 102, column: 27, scope: !194)
!215 = !DILocation(line: 103, column: 9, scope: !194)
!216 = !DILocation(line: 100, column: 33, scope: !195)
!217 = !DILocation(line: 100, column: 9, scope: !195)
!218 = distinct !{!218, !209, !219, !41}
!219 = !DILocation(line: 103, column: 9, scope: !196)
!220 = !DILocation(line: 104, column: 5, scope: !197)
!221 = !DILocation(line: 99, column: 29, scope: !198)
!222 = !DILocation(line: 99, column: 5, scope: !198)
!223 = distinct !{!223, !203, !224, !41}
!224 = !DILocation(line: 104, column: 5, scope: !191)
!225 = !DILocation(line: 105, column: 5, scope: !181)
!226 = distinct !DISubprogram(name: "nested_inner_only_invariant", scope: !3, file: !3, line: 113, type: !15, scopeLine: 113, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!227 = !DILocalVariable(name: "n", arg: 1, scope: !226, file: !3, line: 113, type: !5)
!228 = !DILocation(line: 0, scope: !226)
!229 = !DILocalVariable(name: "m", arg: 2, scope: !226, file: !3, line: 113, type: !5)
!230 = !DILocalVariable(name: "s", scope: !226, file: !3, line: 114, type: !5)
!231 = !DILocalVariable(name: "i", scope: !232, file: !3, line: 115, type: !5)
!232 = distinct !DILexicalBlock(scope: !226, file: !3, line: 115, column: 5)
!233 = !DILocation(line: 0, scope: !232)
!234 = !DILocation(line: 115, column: 10, scope: !232)
!235 = !DILocation(line: 114, column: 9, scope: !226)
!236 = !DILocation(line: 115, scope: !232)
!237 = !DILocation(line: 115, column: 23, scope: !238)
!238 = distinct !DILexicalBlock(scope: !232, file: !3, line: 115, column: 5)
!239 = !DILocation(line: 115, column: 5, scope: !232)
!240 = !DILocalVariable(name: "j", scope: !241, file: !3, line: 116, type: !5)
!241 = distinct !DILexicalBlock(scope: !242, file: !3, line: 116, column: 9)
!242 = distinct !DILexicalBlock(scope: !238, file: !3, line: 115, column: 33)
!243 = !DILocation(line: 0, scope: !241)
!244 = !DILocation(line: 117, column: 23, scope: !245)
!245 = distinct !DILexicalBlock(scope: !246, file: !3, line: 116, column: 37)
!246 = distinct !DILexicalBlock(scope: !241, file: !3, line: 116, column: 9)
!247 = !DILocation(line: 116, column: 14, scope: !241)
!248 = !DILocation(line: 116, scope: !241)
!249 = !DILocation(line: 116, column: 27, scope: !246)
!250 = !DILocation(line: 116, column: 9, scope: !241)
!251 = !DILocalVariable(name: "t", scope: !245, file: !3, line: 117, type: !5)
!252 = !DILocation(line: 0, scope: !245)
!253 = !DILocation(line: 118, column: 19, scope: !245)
!254 = !DILocation(line: 118, column: 23, scope: !245)
!255 = !DILocation(line: 119, column: 9, scope: !245)
!256 = !DILocation(line: 116, column: 33, scope: !246)
!257 = !DILocation(line: 116, column: 9, scope: !246)
!258 = distinct !{!258, !250, !259, !41}
!259 = !DILocation(line: 119, column: 9, scope: !241)
!260 = !DILocation(line: 120, column: 5, scope: !242)
!261 = !DILocation(line: 115, column: 29, scope: !238)
!262 = !DILocation(line: 115, column: 5, scope: !238)
!263 = distinct !{!263, !239, !264, !41}
!264 = !DILocation(line: 120, column: 5, scope: !232)
!265 = !DILocation(line: 121, column: 5, scope: !226)
!266 = distinct !DISubprogram(name: "partially_invariant", scope: !3, file: !3, line: 127, type: !15, scopeLine: 127, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!267 = !DILocalVariable(name: "n", arg: 1, scope: !266, file: !3, line: 127, type: !5)
!268 = !DILocation(line: 0, scope: !266)
!269 = !DILocalVariable(name: "k", arg: 2, scope: !266, file: !3, line: 127, type: !5)
!270 = !DILocalVariable(name: "s", scope: !266, file: !3, line: 128, type: !5)
!271 = !DILocalVariable(name: "i", scope: !272, file: !3, line: 129, type: !5)
!272 = distinct !DILexicalBlock(scope: !266, file: !3, line: 129, column: 5)
!273 = !DILocation(line: 0, scope: !272)
!274 = !DILocation(line: 130, column: 19, scope: !275)
!275 = distinct !DILexicalBlock(scope: !276, file: !3, line: 129, column: 33)
!276 = distinct !DILexicalBlock(scope: !272, file: !3, line: 129, column: 5)
!277 = !DILocation(line: 129, column: 10, scope: !272)
!278 = !DILocation(line: 129, scope: !272)
!279 = !DILocation(line: 129, column: 23, scope: !276)
!280 = !DILocation(line: 129, column: 5, scope: !272)
!281 = !DILocalVariable(name: "x", scope: !275, file: !3, line: 130, type: !5)
!282 = !DILocation(line: 0, scope: !275)
!283 = !DILocation(line: 131, column: 19, scope: !275)
!284 = !DILocalVariable(name: "y", scope: !275, file: !3, line: 131, type: !5)
!285 = !DILocation(line: 132, column: 15, scope: !275)
!286 = !DILocation(line: 133, column: 5, scope: !275)
!287 = !DILocation(line: 129, column: 29, scope: !276)
!288 = !DILocation(line: 129, column: 5, scope: !276)
!289 = distinct !{!289, !280, !290, !41}
!290 = !DILocation(line: 133, column: 5, scope: !272)
!291 = !DILocation(line: 134, column: 5, scope: !266)
!292 = distinct !DISubprogram(name: "invariant_from_arguments", scope: !3, file: !3, line: 140, type: !182, scopeLine: 140, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!293 = !DILocalVariable(name: "n", arg: 1, scope: !292, file: !3, line: 140, type: !5)
!294 = !DILocation(line: 0, scope: !292)
!295 = !DILocalVariable(name: "a", arg: 2, scope: !292, file: !3, line: 140, type: !5)
!296 = !DILocalVariable(name: "b", arg: 3, scope: !292, file: !3, line: 140, type: !5)
!297 = !DILocalVariable(name: "c", arg: 4, scope: !292, file: !3, line: 140, type: !5)
!298 = !DILocalVariable(name: "s", scope: !292, file: !3, line: 141, type: !5)
!299 = !DILocalVariable(name: "i", scope: !300, file: !3, line: 142, type: !5)
!300 = distinct !DILexicalBlock(scope: !292, file: !3, line: 142, column: 5)
!301 = !DILocation(line: 0, scope: !300)
!302 = !DILocation(line: 143, column: 19, scope: !303)
!303 = distinct !DILexicalBlock(scope: !304, file: !3, line: 142, column: 33)
!304 = distinct !DILexicalBlock(scope: !300, file: !3, line: 142, column: 5)
!305 = !DILocation(line: 144, column: 19, scope: !303)
!306 = !DILocation(line: 145, column: 15, scope: !307)
!307 = distinct !DILexicalBlock(scope: !303, file: !3, line: 145, column: 13)
!308 = !DILocation(line: 142, column: 10, scope: !300)
!309 = !DILocation(line: 142, scope: !300)
!310 = !DILocation(line: 142, column: 23, scope: !304)
!311 = !DILocation(line: 142, column: 5, scope: !300)
!312 = !DILocalVariable(name: "t", scope: !303, file: !3, line: 143, type: !5)
!313 = !DILocation(line: 0, scope: !303)
!314 = !DILocalVariable(name: "u", scope: !303, file: !3, line: 144, type: !5)
!315 = !DILocation(line: 145, column: 13, scope: !303)
!316 = !DILocation(line: 146, column: 19, scope: !307)
!317 = !DILocation(line: 146, column: 13, scope: !307)
!318 = !DILocation(line: 147, column: 5, scope: !303)
!319 = !DILocation(line: 142, column: 29, scope: !304)
!320 = !DILocation(line: 142, column: 5, scope: !304)
!321 = distinct !{!321, !311, !322, !41}
!322 = !DILocation(line: 147, column: 5, scope: !300)
!323 = !DILocation(line: 148, column: 5, scope: !292)
!324 = distinct !DISubprogram(name: "no_invariant_candidates", scope: !3, file: !3, line: 154, type: !104, scopeLine: 154, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !17)
!325 = !DILocalVariable(name: "n", arg: 1, scope: !324, file: !3, line: 154, type: !5)
!326 = !DILocation(line: 0, scope: !324)
!327 = !DILocalVariable(name: "s", scope: !324, file: !3, line: 155, type: !5)
!328 = !DILocalVariable(name: "i", scope: !329, file: !3, line: 156, type: !5)
!329 = distinct !DILexicalBlock(scope: !324, file: !3, line: 156, column: 5)
!330 = !DILocation(line: 0, scope: !329)
!331 = !DILocation(line: 156, column: 10, scope: !329)
!332 = !DILocation(line: 156, scope: !329)
!333 = !DILocation(line: 156, column: 23, scope: !334)
!334 = distinct !DILexicalBlock(scope: !329, file: !3, line: 156, column: 5)
!335 = !DILocation(line: 156, column: 5, scope: !329)
!336 = !DILocation(line: 157, column: 19, scope: !337)
!337 = distinct !DILexicalBlock(scope: !334, file: !3, line: 156, column: 33)
!338 = !DILocation(line: 157, column: 15, scope: !337)
!339 = !DILocation(line: 158, column: 5, scope: !337)
!340 = !DILocation(line: 156, column: 29, scope: !334)
!341 = !DILocation(line: 156, column: 5, scope: !334)
!342 = distinct !{!342, !335, !343, !41}
!343 = !DILocation(line: 158, column: 5, scope: !329)
!344 = !DILocation(line: 159, column: 5, scope: !324)
