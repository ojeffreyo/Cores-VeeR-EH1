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

#set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
# Object build options
# -O0                   No optimizations, reduce compilation time and make debugging produce the expected results.
# -fno-builtin          Do not use built-in functions provided by GCC.
# -Wall                 Print only standard warnings, for all use Wextra
# -ffunction-sections   Place each function item into its own section in the output file.
# -fdata-sections       Place each data item into its own section in the output file.
# -fomit-frame-pointer  Omit the frame pointer in functions that don’t need one.
# -Og   Enables optimizations that do not interfere with debugging.
# -g    Produce debugging information in the operating system’s native format.
# -Os   Optimize for size. -Os enables all -O2 optimizations.
# -flto Runs the standard link-time optimizer.

SET(MARCH "rv32imc")
# -mabi Specify integer and floating-point calling convention
SET(MABI "ilp32")
SET(MCU_FLAG "-march=${MARCH} -mabi=${MABI}")

#SET(COMMON_FLAGS "-O2 -g3 -fshort-enums -fno-common \
#-fms-extensions -ffunction-sections -fdata-sections -fstrict-volatile-bitfields \
#-Wall -Wshift-negative-value -Wchar-subscripts -Wformat -Wuninitialized -Winit-self -fno-jump-tables \
#-Wignored-qualifiers -Wswitch-default -Wunused -Wundef -msmall-data-limit=4")
#SET(COMMON_FLAGS "-O0 -g -ffreestanding ")
SET(COMMON_FLAGS "-Og -g -ffreestanding ")
#SET(COMMON_FLAGS "-O3 -ffreestanding ")
#SET(COMMON_FLAGS "-Os -ffreestanding ")

# compiler: language specific flags
set(CMAKE_C_FLAGS "${MCU_FLAG} ${COMMON_FLAGS}"  CACHE INTERNAL "c compiler flags")
set(CMAKE_C_FLAGS_DEBUG "-Og -g" CACHE INTERNAL "c compiler flags: Debug")
set(CMAKE_C_FLAGS_RELEASE "-Os -flto" CACHE INTERNAL "c compiler flags: Release")

# message("")
# message("-----------------------------------------------------------------------------------------------------------------------------------------------------")
# message("Setting C compiler")
# message("C compiler flags options:   ${CMAKE_C_FLAGS}")
# message("C compiler debug options: ${CMAKE_C_FLAGS_DEBUG}")
# message("C compiler release options: ${CMAKE_C_FLAGS_RELEASE}")
# message("-----------------------------------------------------------------------------------------------------------------------------------------------------")


set(CMAKE_CXX_FLAGS "${MCU_FLAG} ${COMMON_FLAGS} -std=c++11 " CACHE INTERNAL "cxx compiler flags")
set(CMAKE_CXX_FLAGS_DEBUG "-Og -g" CACHE INTERNAL "cxx compiler flags: Debug")
set(CMAKE_CXX_FLAGS_RELEASE "-Os -flto" CACHE INTERNAL "cxx compiler flags: Release")

# message("")
# message("-----------------------------------------------------------------------------------------------------------------------------------------------------")
# message("Setting C++ compiler")
# message("C++ compiler flags options:   ${CMAKE_CXX_FLAGS}")
# message("C++ compiler debug options: ${CMAKE_CXX_FLAGS_DEBUG}")
# message("C++ compiler release options: ${CMAKE_CXX_FLAGS_RELEASE}")
# message("-----------------------------------------------------------------------------------------------------------------------------------------------------")


set(CMAKE_ASM_FLAGS  "${MCU_FLAG} ${COMMON_FLAGS}" CACHE INTERNAL "asm compiler flags")
set(CMAKE_ASM_FLAGS_DEBUG "-Og -g" CACHE INTERNAL "asm compiler flags: Debug")
set(CMAKE_ASM_FLAGS_RELEASE "-Os -flto" CACHE INTERNAL "asm compiler flags: Release")

# message("")
# message("-----------------------------------------------------------------------------------------------------------------------------------------------------")
# message("Setting ASM compiler")
# message("ASM compiler flags options:   ${CMAKE_ASM_FLAGS}")
# message("ASM compiler debug options: ${CMAKE_ASM_FLAGS_DEBUG}")
# message("ASM compiler release options: ${CMAKE_ASM_FLAGS_RELEASE}")
# message("-----------------------------------------------------------------------------------------------------------------------------------------------------")

# -Wl,--gc-sections     Perform the dead code elimination.
# --specs=nano.specs    Link with newlib-nano.
# --specs=nosys.specs   No syscalls, provide empty implementations for the POSIX system calls.

#if(${SUPPORT_SHELL} STREQUAL "ENABLE")
#add_definitions(-DSHELL_SUPPORT)
#else()
#endif()

if(${BOARD} MATCHES "(genesys2-fpga)")

else()
endif()

if(${RTOS} STREQUAL "rtthread")
    SET(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/drivers/linkerscript/link.ld)
elseif(${RTOS} STREQUAL "uvm")
    SET(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/drivers/linkerscript/link.ld)
elseif(${RTOS} STREQUAL "ram")
    SET(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/drivers/linkerscript/link.ld)
else()
    SET(LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/drivers/linkerscript/link.ld)
endif()



#set(CMAKE_EXE_LINKER_FLAGS "${MCU_FLAG} -Wl,-Bstatic,-T, -nostartfiles \
#    -lc -lm -lgcc -std=c99" CACHE INTERNAL "Linker options")
set(CMAKE_EXE_LINKER_FLAGS "${MCU_FLAG} -Wl,-Map=system.map -Wl,--cref -Wl,--gc-sections -nostartfiles -lc -lm -g3  \
-fms-extensions -ffunction-sections -fdata-sections -Wall -Wchar-subscripts \
-Wformat -Wuninitialized -Winit-self -Wignored-qualifiers -Wswitch-default \
-Wunused -Wundef -std=c99" CACHE INTERNAL "Linker options")
