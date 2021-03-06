;=========================== begin_copyright_notice ============================
;
; Copyright (C) 2017-2021 Intel Corporation
;
; SPDX-License-Identifier: MIT
;
;============================ end_copyright_notice =============================

; RUN: opt -igc-legalization -verify -S %s -o - | FileCheck %s
; XFAIL: *

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f16:16:16-f32:32:32-f64:64:64-f80:128:128-v16:16:16-v24:32:32-v32:32:32-v48:64:64-v64:64:64-v96:128:128-v128:128:128-v192:256:256-v256:256:256-v512:512:512-v1024:1024:1024-a:64:64-f80:128:128-n8:16:32:64"
target triple = "igil_64_GEN9"

; Check if vector condition and values scalarized appropriately
define <2 x float> @foo(<2 x i1> %cond, <2 x float> %trueVal, <2 x float> %falseVal) {
  %res = select <2 x i1> %cond, <2 x float> %trueVal, <2 x float> %falseVal
  ret <2 x float> %res
}

; CHECK-LABEL: foo
; CHECK:         %[[cond0:[a-zA-Z0-9_.]+]]    = extractelement <2 x i1> %cond, i32 0
; CHECK-NEXT:     %[[true0:[a-zA-Z0-9_.]+]]    = extractelement <2 x float> %trueVal, i32 0
; CHECK-NEXT:     %[[false0:[a-zA-Z0-9_.]+]]     = extractelement <2 x float> %falseVal, i32 0
; CHECK-NEXT:     %[[sel0:[a-zA-Z0-9_.]+]]        = select i1 %[[cond0]], float %[[true0]], float %[[false0]]
; CHECK-NEXT:     %[[res0:[a-zA-Z0-9_.]+]]        = insertelement <2 x float> undef, float %[[sel0]], i32 0
; CHECK-NEXT:     %[[cond1:[a-zA-Z0-9_.]+]]    = extractelement <2 x i1> %cond, i32 1
; CHECK-NEXT:     %[[true1:[a-zA-Z0-9_.]+]]    = extractelement <2 x float> %trueVal, i32 1
; CHECK-NEXT:     %[[false1:[a-zA-Z0-9_.]+]]     = extractelement <2 x float> %falseVal, i32 1
; CHECK-NEXT:     %[[sel1:[a-zA-Z0-9_.]+]]     = select i1 %[[cond1]], float %[[true1]], float %[[false1]]
; CHECK-NEXT:     %[[res:[a-zA-Z0-9_.]+]]         = insertelement <2 x float> %[[res0]], float %[[sel1]], i32 1
; CHECK-NEXT:     ret <2 x float> %[[res]]


; Check if scalar condition and values scalarized appropriately
define <2 x float> @bar(i1 %cond, <2 x float> %trueVal, <2 x float> %falseVal) {
  %res = select i1 %cond, <2 x float> %trueVal, <2 x float> %falseVal
  ret <2 x float> %res
}
; CHECK-LABEL: bar
; CHECK:         %[[true0:[a-zA-Z0-9_.]+]]    = extractelement <2 x float> %trueVal, i32 0
; CHECK-NEXT:     %[[false0:[a-zA-Z0-9_.]+]]     = extractelement <2 x float> %falseVal, i32 0
; CHECK-NEXT:     %[[sel0:[a-zA-Z0-9_.]+]]        = select i1 %cond, float %[[true0]], float %[[false0]]
; CHECK-NEXT:     %[[res0:[a-zA-Z0-9_.]+]]        = insertelement <2 x float> undef, float %[[sel0]], i32 0
; CHECK-NEXT:     %[[true1:[a-zA-Z0-9_.]+]]     = extractelement <2 x float> %trueVal, i32 1
; CHECK-NEXT:     %[[false1:[a-zA-Z0-9_.]+]]     = extractelement <2 x float> %falseVal, i32 1
; CHECK-NEXT:     %[[sel1:[a-zA-Z0-9_.]+]]     = select i1 %cond, float %[[true1]], float %[[false1]]
; CHECK-NEXT:     %[[res:[a-zA-Z0-9_.]+]]         = insertelement <2 x float> %[[res0]], float %[[sel1]], i32 1
; CHECK-NEXT:     ret <2 x float> %[[res]]

!igc.functions = !{!0, !4}
!0 = metadata !{<2 x float> (<2 x i1>, <2 x float>, <2 x float>)* @foo, metadata !1}
!1 = metadata !{metadata !2, metadata !3}
!2 = metadata !{metadata !"function_type", i32 0}
!3 = metadata !{metadata !"implicit_arg_desc"}
!4 = metadata !{<2 x float> (i1, <2 x float>, <2 x float>)* @bar, metadata !1}
