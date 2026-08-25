; ModuleID = 'test.ll'
source_filename = "1.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 !dbg !10 {
  call void @llvm.dbg.value(metadata ptr %0, metadata !16, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.value(metadata i32 %1, metadata !18, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.value(metadata i32 %2, metadata !19, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.value(metadata i32 0, metadata !20, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.value(metadata i32 0, metadata !21, metadata !DIExpression()), !dbg !23
  br label %4, !dbg !24

4:                                                ; preds = %17, %3
  %.01 = phi i32 [ 0, %3 ], [ %.1, %17 ], !dbg !17
  %.0 = phi i32 [ 0, %3 ], [ %18, %17 ], !dbg !25
  call void @llvm.dbg.value(metadata i32 %.0, metadata !21, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.value(metadata i32 %.01, metadata !20, metadata !DIExpression()), !dbg !17
  %5 = icmp slt i32 %.0, %1, !dbg !26
  br i1 %5, label %6, label %19, !dbg !28

6:                                                ; preds = %4
  %7 = mul nsw i32 %2, 2, !dbg !29
  %8 = add nsw i32 %7, 1, !dbg !31
  call void @llvm.dbg.value(metadata i32 %8, metadata !32, metadata !DIExpression()), !dbg !33
  %9 = icmp sgt i32 %8, 0, !dbg !34
  br i1 %9, label %10, label %16, !dbg !36

10:                                               ; preds = %6
  %11 = sext i32 %.0 to i64, !dbg !37
  %12 = getelementptr inbounds i32, ptr %0, i64 %11, !dbg !37
  %13 = load i32, ptr %12, align 4, !dbg !37
  %14 = add nsw i32 %13, %8, !dbg !38
  %15 = add nsw i32 %.01, %14, !dbg !39
  call void @llvm.dbg.value(metadata i32 %15, metadata !20, metadata !DIExpression()), !dbg !17
  br label %16, !dbg !40

16:                                               ; preds = %10, %6
  %.1 = phi i32 [ %15, %10 ], [ %.01, %6 ], !dbg !17
  call void @llvm.dbg.value(metadata i32 %.1, metadata !20, metadata !DIExpression()), !dbg !17
  br label %17, !dbg !41

17:                                               ; preds = %16
  %18 = add nsw i32 %.0, 1, !dbg !42
  call void @llvm.dbg.value(metadata i32 %18, metadata !21, metadata !DIExpression()), !dbg !23
  br label %4, !dbg !43, !llvm.loop !44

19:                                               ; preds = %4
  ret i32 %.01, !dbg !47
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !48 {
  ret i32 0, !dbg !51
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.value(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4, !5, !6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C11, file: !1, producer: "clang version 17.0.0", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "1.c", directory: "/home/mihajlo/projekti/llvm-project/build", checksumkind: CSK_MD5, checksum: "44186e9369e91b1fbe5ad00a56d84d63")
!2 = !{i32 7, !"Dwarf Version", i32 5}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{i32 8, !"PIC Level", i32 2}
!6 = !{i32 7, !"PIE Level", i32 2}
!7 = !{i32 7, !"uwtable", i32 2}
!8 = !{i32 7, !"frame-pointer", i32 2}
!9 = !{!"clang version 17.0.0"}
!10 = distinct !DISubprogram(name: "f", scope: !1, file: !1, line: 4, type: !11, scopeLine: 4, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!11 = !DISubroutineType(types: !12)
!12 = !{!13, !14, !13, !13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!15 = !{}
!16 = !DILocalVariable(name: "a", arg: 1, scope: !10, file: !1, line: 4, type: !14)
!17 = !DILocation(line: 0, scope: !10)
!18 = !DILocalVariable(name: "n", arg: 2, scope: !10, file: !1, line: 4, type: !13)
!19 = !DILocalVariable(name: "k", arg: 3, scope: !10, file: !1, line: 4, type: !13)
!20 = !DILocalVariable(name: "s", scope: !10, file: !1, line: 5, type: !13)
!21 = !DILocalVariable(name: "i", scope: !22, file: !1, line: 6, type: !13)
!22 = distinct !DILexicalBlock(scope: !10, file: !1, line: 6, column: 3)
!23 = !DILocation(line: 0, scope: !22)
!24 = !DILocation(line: 6, column: 8, scope: !22)
!25 = !DILocation(line: 6, scope: !22)
!26 = !DILocation(line: 6, column: 21, scope: !27)
!27 = distinct !DILexicalBlock(scope: !22, file: !1, line: 6, column: 3)
!28 = !DILocation(line: 6, column: 3, scope: !22)
!29 = !DILocation(line: 7, column: 15, scope: !30)
!30 = distinct !DILexicalBlock(scope: !27, file: !1, line: 6, column: 31)
!31 = !DILocation(line: 7, column: 19, scope: !30)
!32 = !DILocalVariable(name: "t", scope: !30, file: !1, line: 7, type: !13)
!33 = !DILocation(line: 0, scope: !30)
!34 = !DILocation(line: 8, column: 11, scope: !35)
!35 = distinct !DILexicalBlock(scope: !30, file: !1, line: 8, column: 9)
!36 = !DILocation(line: 8, column: 9, scope: !30)
!37 = !DILocation(line: 9, column: 12, scope: !35)
!38 = !DILocation(line: 9, column: 17, scope: !35)
!39 = !DILocation(line: 9, column: 9, scope: !35)
!40 = !DILocation(line: 9, column: 7, scope: !35)
!41 = !DILocation(line: 10, column: 3, scope: !30)
!42 = !DILocation(line: 6, column: 27, scope: !27)
!43 = !DILocation(line: 6, column: 3, scope: !27)
!44 = distinct !{!44, !28, !45, !46}
!45 = !DILocation(line: 10, column: 3, scope: !22)
!46 = !{!"llvm.loop.mustprogress"}
!47 = !DILocation(line: 11, column: 3, scope: !10)
!48 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 15, type: !49, scopeLine: 15, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !15)
!49 = !DISubroutineType(types: !50)
!50 = !{!13}
!51 = !DILocation(line: 18, column: 5, scope: !48)
