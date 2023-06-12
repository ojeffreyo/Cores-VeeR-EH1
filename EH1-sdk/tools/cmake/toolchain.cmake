############################################################################
# Copyright 2019-2030 Bouffalolab team
# Copyright (c) 2021, ZGOO Technology Inc.
# 
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.  The
# ASF licenses this file to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.
###########################################################################
SET(CMAKE_SYSTEM_NAME putuo-sdk)
SET(CMAKE_SYSTEM_VERSION 0.1)
set(CMAKE_SYSTEM_PROCESSOR RISCV)

if(MINGW OR CYGWIN OR WIN32)
    set(WHERE_CMD where)
    set(TOOLCHAIN_SUFFIX ".exe")
elseif(UNIX OR APPLE)
    set(WHERE_CMD which)
    set(TOOLCHAIN_SUFFIX "")
endif()

if(MINGW OR CYGWIN OR WIN32)
    set(TOOLCHAIN_PREFIX riscv64-unknown-elf-)
else()
    set(TOOLCHAIN_PREFIX riscv64-unknown-elf-)
endif()

execute_process(
  COMMAND ${WHERE_CMD} ${TOOLCHAIN_PREFIX}gcc
  OUTPUT_VARIABLE TOOLCHAIN_PATH
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

message(STATUS "TOOLCHAIN_PATH:${TOOLCHAIN_PATH}")
# specify cross compilers and tools
SET(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
SET(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREFIX}gcc${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
set(CMAKE_LINKER ${TOOLCHAIN_PREFIX}ld${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
set(CMAKE_OBJDUMP ${TOOLCHAIN_PREFIX}objdump${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
set(CMAKE_SIZE ${TOOLCHAIN_PREFIX}size${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
set(CMAKE_OPENOCD openocd${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")
set(CMAKE_XXD xxd${TOOLCHAIN_SUFFIX} CACHE INTERNAL "")  
set(CMAKE_PERL perl${TOOLCHAIN_SUFFIX} CACHE INTERNAL "") 

set(CMAKE_C_COMPILER_WORKS 1)  
set(CMAKE_CXX_COMPILER_WORKS 1)

set(CMAKE_FIND_ROOT_PATH ${TOOLCHAIN_PATH})
# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)