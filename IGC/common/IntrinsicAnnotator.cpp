/*========================== begin_copyright_notice ============================

Copyright (C) 2017-2021 Intel Corporation

SPDX-License-Identifier: MIT

============================= end_copyright_notice ===========================*/

#include "IntrinsicAnnotator.hpp"
#include "common/LLVMWarningsPush.hpp"
#include <llvm/Support/FormattedStream.h>
#include "common/LLVMWarningsPop.hpp"
#include "GenISAIntrinsics/GenIntrinsics.h"

using namespace llvm;
using namespace IGC;
using namespace GenISAIntrinsic;

void IntrinsicAnnotator::emitFunctionAnnot(const Function* func, formatted_raw_ostream& OS)
{
    if (isIntrinsic(func))
    {
        auto ID = getIntrinsicID(func);
        IntrinsicComments comments = getIntrinsicComments(ID);
        OS << "; Function Desc: " << comments.funcDescription << "\n";
        for (auto out : comments.outputs)
        {
            OS << "; Ouput: " << out << "\n";
        }
        for (std::vector<int>::size_type i = 0; i != comments.inputs.size(); i++)
        {
            OS << "; Arg " << i << ": " << comments.inputs[i] << "\n";
        }
    }
}



