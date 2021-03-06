/*========================== begin_copyright_notice ============================

Copyright (C) 2017-2021 Intel Corporation

SPDX-License-Identifier: MIT

============================= end_copyright_notice ===========================*/

#include "../include/BiF_Definitions.cl"
#include "../../Headers/spirv.h"

INLINE float __builtin_spirv_OpenCL_sqrt_f32( float x )
{
    return __builtin_spirv_OpenCL_native_sqrt_f32(x);
}

GENERATE_VECTOR_FUNCTIONS_1ARG( __builtin_spirv_OpenCL_sqrt, float, float, f32 )

#ifdef cl_fp64_basic_ops

INLINE double __builtin_spirv_OpenCL_sqrt_f64( double x )
{
    return __builtin_spirv_OpenCL_native_sqrt_f64(x);
}

GENERATE_VECTOR_FUNCTIONS_1ARG( __builtin_spirv_OpenCL_sqrt, double, double, f64 )

#endif // cl_fp64_basic_ops

#if defined(cl_khr_fp16)

INLINE half __builtin_spirv_OpenCL_sqrt_f16( half x )
{
    return __builtin_spirv_OpenCL_native_sqrt_f32((float)x);
}

GENERATE_VECTOR_FUNCTIONS_1ARG( __builtin_spirv_OpenCL_sqrt, half, half, f16 )

#endif // defined(cl_khr_fp16)
