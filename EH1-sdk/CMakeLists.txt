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

cmake_minimum_required(VERSION 3.3.2)
#set(CMAKE_GENERATOR "Ninja")

add_definitions(-DUSART_REMAP_0)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/tools/cmake/toolchain.cmake)
include(${CMAKE_SOURCE_DIR}/tools/cmake/compiler.cmake)
include(${CMAKE_SOURCE_DIR}/tools/cmake/func.cmake)

PROJECT(${BOARD} C CXX ASM)

include_directories(${CMAKE_SOURCE_DIR}/drivers)

##add definitions
add_definitions(-DAKINA)

##add add subdirectory
add_subdirectory(${CMAKE_SOURCE_DIR}/drivers)
add_subdirectory(${CMAKE_SOURCE_DIR}/libc)
# add_subdirectory(${CMAKE_SOURCE_DIR}/bsp)
# add_subdirectory(${CMAKE_SOURCE_DIR}/rt_thread)#RT-Thread added

search_application(${CMAKE_SOURCE_DIR}/examples)
#search_application(${CMAKE_SOURCE_DIR}/rt_thread/bsp/qemu-riscv-virt32/applications)
program_flash()


