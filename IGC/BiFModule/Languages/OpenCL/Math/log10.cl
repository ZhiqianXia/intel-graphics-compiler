/*========================== begin_copyright_notice ============================

Copyright (C) 2017-2021 Intel Corporation

SPDX-License-Identifier: MIT

============================= end_copyright_notice ===========================*/

#include "../include/BiF_Definitions.cl"
#include "spirv.h"

INLINE float OVERLOADABLE log10( float x )
{
    return __builtin_spirv_OpenCL_log10_f32( x );
}

GENERATE_VECTOR_FUNCTIONS_1ARG_LOOP( log10, float, float )

#if defined(cl_khr_fp64)

INLINE double OVERLOADABLE log10( double x )
{
    return __builtin_spirv_OpenCL_log10_f64( x );
}

GENERATE_VECTOR_FUNCTIONS_1ARG_LOOP( log10, double, double )

#endif // defined(cl_khr_fp64)

#if defined(cl_khr_fp16)

INLINE half OVERLOADABLE log10( half x )
{
    return __builtin_spirv_OpenCL_log10_f16( x );
}

GENERATE_VECTOR_FUNCTIONS_1ARG_LOOP( log10, half, half )

#endif // defined(cl_khr_fp16)
