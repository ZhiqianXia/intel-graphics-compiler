/*========================== begin_copyright_notice ============================

Copyright (c) 2019-2021 Intel Corporation

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom
the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE SOFTWARE.

============================= end_copyright_notice ===========================*/

#ifndef _IGA_ENCODER_WRAPPER_HPP
#define _IGA_ENCODER_WRAPPER_HPP

#include "../IR/Kernel.hpp"
#include "iga.h"

// entry point for binary encoding of a IGA IR kernel
class KernelEncoder
{
    void* m_buf = nullptr;
    uint32_t m_binarySize = 0;
    iga::Kernel* m_kernel = nullptr;
    bool m_autoCompact = false;
    // enable IGA swsb set
    bool m_enableAutoDeps = false;
    // swsb encoding mode
    iga::SWSB_ENCODE_MODE m_swsbEncodeMode = iga::SWSB_ENCODE_MODE::SWSBInvalidMode;

public:
    // @param compact: auto compact instructions if applicable
    // @param noCompactFisrtEightInst: Force NOCOMPACT the first 8 instructions in this encoding unit
    //     The first eight instructions must be in the same bb
    //     This can be set simulataneously with compact. The first 8 instructions will not be cmopacted
    //     even if it is compactable
    KernelEncoder(iga::Kernel* k, bool compact)
        : m_kernel(k)
        , m_autoCompact(compact)
    { }

    iga_status_t encode();
    void* getBinary() const { return m_buf; }
    uint32_t getBinarySize() const { return m_binarySize; }

    // patchImmValue - Decode the first instruction start from binary, and patch the imm field to given val
    // input type - the type of given immediate value
    // input val - the given immediate value
    // return - true on success, false if any error
    // This function is used by visa to patch the add or mov instructions' imm field for the indirect call
    // FIXME: Move this api to somewhere else that's more apporopriate
    static bool patchImmValue(const iga::Model& model, unsigned char* binary, iga::Type type, const iga::ImmVal &val);

    // set swsb encoding mode. If not set, the encoding mode will be derived from platform
    void setSWSBEncodingMode(iga::SWSB_ENCODE_MODE mode)
    {
        m_swsbEncodeMode = mode;
    }

    // enable IGA swsb set. When enabled, the original swsb in the input instructions will
    // be obsoleted
    void enableIGAAutoDeps(bool enable = true)
    {
        m_enableAutoDeps = enable;
    }
};

#endif // _IGA_ENCODER_WRAPPER_HPP
