/*========================== begin_copyright_notice ============================

Copyright (c) 2020-2021 Intel Corporation

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

#include "MessageDecoder.hpp"

#include <tuple>
#include <utility>


using namespace iga;

void MessageDecoder::decodePayloadSizes() {
    bool hasMLenRLenInDesc = true;
    bool hasXLenInExDesc = true;
    auto plural = [](int x) {return x == 1 ? "" : "s";};
    if (hasMLenRLenInDesc) {
        decodeDescField("Mlen", 25, 4,
            [&] (std::stringstream &ss, uint32_t val) {
                ss << val << " address register" << plural(val) << " written";
            });
        decodeDescField("Rlen", 20, 5,
            [&] (std::stringstream &ss, uint32_t val) {
                ss << val << " register" << plural(val) << " read back";
            });
    }
    if (hasXLenInExDesc) {
        decodeDescField("Xlen", 32 + 6, 5,
            [&] (std::stringstream &ss, uint32_t val) {
                ss << val << " data register" << plural(val) << " written";
            });
    }
    if (platform() <= Platform::GEN11) {
        decodeDescField("SFID", 32 + 0, 4,
            [] (std::stringstream &ss, uint32_t val) {
                ss << val << " shared function ID";
            });
    }
}

