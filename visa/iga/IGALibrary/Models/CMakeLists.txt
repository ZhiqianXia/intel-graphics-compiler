#=========================== begin_copyright_notice ============================
#
# Copyright (c) 2019-2021 Intel Corporation
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom
# the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
#
#============================ end_copyright_notice =============================


set(IGA_ModelsOpen
  ${CMAKE_CURRENT_SOURCE_DIR}/Models.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/Models.hpp
  ${CMAKE_CURRENT_SOURCE_DIR}/OpSpec.hpp
  ${CMAKE_CURRENT_SOURCE_DIR}/OpSpec.cpp
  ${CMAKE_CURRENT_SOURCE_DIR}/bxml/ModelGen7p5.hpp
  ${CMAKE_CURRENT_SOURCE_DIR}/bxml/ModelGen8.hpp
  ${CMAKE_CURRENT_SOURCE_DIR}/bxml/ModelGen9.hpp
  ${CMAKE_CURRENT_SOURCE_DIR}/bxml/ModelGen10.hpp
  ${CMAKE_CURRENT_SOURCE_DIR}/bxml/ModelGen11.hpp
  ${CMAKE_CURRENT_SOURCE_DIR}/bxml/ModelXe.hpp
)
set(IGA_ModelsExteneded )

set(IGA_Models
  ${IGA_ModelsOpen}
  ${IGA_ModelsExteneded}
  PARENT_SCOPE
)
