/*========================== begin_copyright_notice ============================

Copyright (C) 2017-2021 Intel Corporation

SPDX-License-Identifier: MIT

============================= end_copyright_notice ===========================*/

#include "../include/BiF_Definitions.cl"
#include "spirv.h"

INLINE float OVERLOADABLE fast_normalize( float p )
{
    return __builtin_spirv_OpenCL_fast_normalize_f32( p );
}

INLINE float2 OVERLOADABLE fast_normalize( float2 p )
{
    return __builtin_spirv_OpenCL_fast_normalize_v2f32( p );
}

INLINE float3 OVERLOADABLE fast_normalize( float3 p )
{
    return __builtin_spirv_OpenCL_fast_normalize_v3f32( p );
}

INLINE float4 OVERLOADABLE fast_normalize( float4 p )
{
    return __builtin_spirv_OpenCL_fast_normalize_v4f32( p );
}
