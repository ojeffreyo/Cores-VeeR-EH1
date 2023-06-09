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
function(generate_library)
    get_filename_component(library_name ${CMAKE_CURRENT_LIST_DIR} NAME)
    message(STATUS "[register library component: ${library_name} ], path:${CMAKE_CURRENT_LIST_DIR}")

    # Add src to lib
    if(ADD_SRCS)
        add_library(${library_name} STATIC ${ADD_SRCS})
        set(include_type PUBLIC)
    else()
        add_library(${library_name} INTERFACE)
        set(include_type INTERFACE)
    endif()

    # Add include
    foreach(include_dir ${ADD_INCLUDE})
        get_filename_component(abs_dir ${include_dir} ABSOLUTE BASE_DIR ${CMAKE_CURRENT_LIST_DIR})
        if(NOT IS_DIRECTORY ${abs_dir})
            message(FATAL_ERROR "${CMAKE_CURRENT_LIST_FILE}: ${include_dir} not found!")
        endif()
        target_include_directories(${library_name} ${include_type} ${abs_dir})
    endforeach()

    # Add private include
    foreach(include_dir ${ADD_PRIVATE_INCLUDE})
        if(${include_type} STREQUAL INTERFACE)
            message(FATAL_ERROR "${CMAKE_CURRENT_LIST_FILE}: ADD_PRIVATE_INCLUDE set but no source file！")
        endif()
        get_filename_component(abs_dir ${include_dir} ABSOLUTE BASE_DIR ${CMAKE_CURRENT_LIST_DIR})
        if(NOT IS_DIRECTORY ${abs_dir})
            message(FATAL_ERROR "${CMAKE_CURRENT_LIST_FILE}: ${include_dir} not found!")
        endif()
        target_include_directories(${library_name} PRIVATE ${abs_dir})
    endforeach()

    # Add global config include
    target_include_directories(${library_name} PUBLIC ${global_config_dir})

    # Add requirements
    target_link_libraries(${library_name} ${ADD_REQUIREMENTS})

    # Add definitions public
    foreach(difinition ${ADD_DEFINITIONS})
        target_compile_options(${library_name} PUBLIC ${difinition})
    endforeach()

    # Add definitions private
    foreach(difinition ${ADD_DEFINITIONS_PRIVATE})
        target_compile_options(${library_name} PRIVATE ${difinition})
    endforeach()

    # Add static lib
    if(ADD_STATIC_LIB)
        foreach(lib ${ADD_STATIC_LIB})
            if(NOT EXISTS "${lib}")
                prepend(lib_full "${CMAKE_CURRENT_LIST_DIR}/" ${lib})
                if(NOT EXISTS "${lib_full}")
                    message(FATAL_ERROR "Can not find ${lib} or ${lib_full}")
                endif()
                set(lib ${lib_full})
            endif()
            target_link_libraries(${library_name} ${lib})
        endforeach()
    endif()
    # Add dynamic lib
    if(ADD_DYNAMIC_LIB)
        set(dynamic_libs ${g_dynamic_libs})
        foreach(lib ${ADD_DYNAMIC_LIB})
            if(NOT EXISTS "${lib}")
                prepend(lib_full "${CMAKE_CURRENT_LIST_DIR}/" ${lib})
                if(NOT EXISTS "${lib_full}")
                    message(FATAL_ERROR "Can not find ${lib} or ${lib_full}")
                endif()
                set(lib ${lib_full})
            endif()
            list(APPEND dynamic_libs ${lib})
            get_filename_component(lib_dir ${lib} DIRECTORY)
            get_filename_component(lib_name ${lib} NAME)
            target_link_libraries(${library_name} -L${lib_dir} ${lib_name})
        endforeach()
        set(g_dynamic_libs ${dynamic_libs}  CACHE INTERNAL "g_dynamic_libs")
    endif()
endfunction()

function(generate_bin)

    get_filename_component(current_relative_dir_name ${CMAKE_CURRENT_LIST_DIR} NAME)

    #上面写法等价于string(REGEX REPLACE ".*/(.*)" "\\1" current_relative_dir_name ${CMAKE_CURRENT_LIST_DIR})
    string(REGEX REPLACE "(.*)/${current_relative_dir_name}$" "\\1" above_absolute_dir ${CMAKE_CURRENT_LIST_DIR})

    get_filename_component(above_relative_dir_name ${above_absolute_dir} NAME)

    #set(platform ${CMAKE_SOURCE_DIR}/bsp/bsp_common/platform/bflb_platform.c)

    foreach(mainfile IN LISTS mains)
    # Get file name without directory
    get_filename_component(mainname ${mainfile} NAME_WE)

	if(DEFINED OUTPUT)
        set(OUTPUT_DIR ${OUTPUT})
        set(target_name firmware)
    else()
        if(${above_relative_dir_name} STREQUAL "examples")
            set(OUTPUT_DIR ${CMAKE_SOURCE_DIR}/output/${current_relative_dir_name})
            set(target_name ${current_relative_dir_name})
        else()
            set(OUTPUT_DIR ${CMAKE_SOURCE_DIR}/output/${above_relative_dir_name}/${current_relative_dir_name})
            set(target_name ${current_relative_dir_name}_${mainname})
        endif()

    endif()

	file(MAKE_DIRECTORY ${OUTPUT_DIR})
	set(HEX_FILE ${OUTPUT_DIR}/${current_relative_dir_name}.hex)
    set(BIN_FILE ${OUTPUT_DIR}/${current_relative_dir_name}.bin)
    set(MAP_FILE ${OUTPUT_DIR}/${current_relative_dir_name}.map)
    set(DUMP_FILE ${OUTPUT_DIR}/${current_relative_dir_name}.dump)

    if(TARGET_REQUIRED_SRCS)
        #list(APPEND SRCS ${TARGET_REQUIRED_SRCS})
        foreach(src ${TARGET_REQUIRED_SRCS})
            if((NOT EXISTS ${src}) AND (NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${src}))
            message(FATAL_ERROR "${src} not exist,maybe you should autocomplete your path\r\n")
            endif()
            list(APPEND SRCS ${src})
        endforeach()
    endif()

    add_executable(${target_name}.elf ${mainfile} ${SRCS} )

    set_target_properties(${target_name}.elf PROPERTIES LINK_FLAGS "-T${LINKER_SCRIPT}")
    set_target_properties(${target_name}.elf PROPERTIES LINK_DEPENDS ${LINKER_SCRIPT})
    set_target_properties(${target_name}.elf PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${OUTPUT_DIR}")

    # Add private include
    foreach(include_dir ${TARGET_REQUIRED_PRIVATE_INCLUDE})
        get_filename_component(abs_dir ${include_dir} ABSOLUTE BASE_DIR ${CMAKE_SOURCE_DIR})
        if(NOT IS_DIRECTORY ${abs_dir})
            message(FATAL_ERROR "${CMAKE_CURRENT_LIST_FILE}: ${include_dir} not found!")
        endif()
        target_include_directories(${target_name}.elf PRIVATE ${abs_dir})
    endforeach()

    # Add definitions private
    foreach(difinition ${TARGET_REQUIRED_PRIVATE_OPTIONS})
        target_compile_options(${target_name}.elf PRIVATE ${difinition})
    endforeach()

    # Add common libs
    target_link_libraries(${target_name}.elf drivers)
    # Add stdlib
    target_link_libraries(${target_name}.elf libc)
    # Add bsplib
    target_link_libraries(${target_name}.elf bsp)

    if(TARGET_REQUIRED_LIBS)
        target_link_libraries(${target_name}.elf ${TARGET_REQUIRED_LIBS})
    endif()

    #target_link_libraries(${target_name}.elf "-Wl,-Map=${MAP_FILE}")

    add_custom_command(TARGET ${target_name}.elf POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${target_name}.elf> ${BIN_FILE}
        COMMAND ${CMAKE_OBJCOPY} -Oihex $<TARGET_FILE:${target_name}.elf> ${HEX_FILE}
        COMMAND ${CMAKE_OBJDUMP} -D $<TARGET_FILE:${target_name}.elf> > ${DUMP_FILE}
        COMMAND ${CMAKE_SIZE} -d $<TARGET_FILE:${target_name}.elf>
        COMMAND ${CMAKE_COMMAND} -E copy ${BIN_FILE} ${CMAKE_SOURCE_DIR}/tools/flash_tool/img/${current_relative_dir_name}.bin
        COMMENT "Generate ${BIN_FILE}\r\nGenerate ${HEX_FILE}\r\nGenerate ${DUMP_FILE}\r\nCopy ${BIN_FILE} into download path")
    endforeach()
endfunction(generate_bin)

function(search_application component_path)

    if(DEFINED APP)
    
        file(GLOB_RECURSE cmakelists_files ${component_path}/CMakeLists.txt)
        set(app_find_ok 0)
    
        foreach(cmakelists_file ${cmakelists_files})
        get_filename_component(app_relative_dir ${cmakelists_file} DIRECTORY)
        get_filename_component(app_name ${app_relative_dir} NAME)
            if(${APP} STREQUAL "all")
                message("[run app:${app_name}],path:${app_relative_dir}")
                add_subdirectory(${app_relative_dir})
                set(app_find_ok 1)
            elseif(${app_name} MATCHES "^${APP}")
                message("[run app:${app_name}],path:${app_relative_dir}")
                add_subdirectory(${app_relative_dir})
                set(app_find_ok 1)
            endif()
        endforeach()
        if(NOT app_find_ok)
        message(FATAL_ERROR "can not find app:${APP}")
        endif()
    else()
    #add_subdirectory($ENV{PROJECT_DIR}/src src)
    endif()

endfunction()

function(program_flash)
    message("program_flash test")
    set(CFG_DIR ${CMAKE_SOURCE_DIR}/tools/openocd)
    set(CFG_FILE ${CFG_DIR}/board/akina-genesys2.cfg)
    set(ELF_FILE ${CMAKE_SOURCE_DIR}/output/${APP}/${APP}.elf)
    add_custom_target(programunlock
        COMMAND ${CMAKE_OPENOCD} -s ${CFG_DIR} -f ${CFG_FILE} -c init -c halt -c "zg32vf103 unlock 0" -c exit
    )
    add_custom_target(programtask
        # COMMAND ${CMAKE_OPENOCD} -f ${CFG_FILE} -c init -c halt -c "flash erase_sector wch_riscv 0 last " -c exit
        COMMAND ${CMAKE_OPENOCD} -s ${CFG_DIR} -f ${CFG_FILE} -c init -c halt -c "program ${ELF_FILE} reset" -c exit
        # COMMAND ${CMAKE_OPENOCD} -s ${CFG_DIR} -f ${CFG_FILE} -c init -c halt -c "verify_image ${ELF_FILE}" -c exit
        COMMAND ${CMAKE_COMMAND} -E echo Download finish
    )
endfunction(program_flash)

function(generate_vmem)
    set(BIN_FILE ${CMAKE_SOURCE_DIR}/output/${APP}/${APP}.bin)
    set(FOO_FILE ${CMAKE_SOURCE_DIR}/output/${APP}/${APP}foo.hex)
    set(VMEM_FILE ${CMAKE_SOURCE_DIR}/output/${APP}/${APP}.vmem)
    set(perl_opt  'if(/:\\s(..)(..)(..)(..)\\s/){printf("%s%s%s%s\\n" , $$4,$$3,$$2,$$1)}')
    add_custom_target(vmemtask
        COMMAND ${CMAKE_XXD} -l 0x10000 -g 4 -c 4 ${BIN_FILE} > ${FOO_FILE}
        COMMAND ${CMAKE_PERL} -ne ${perl_opt} ${FOO_FILE} > ${VMEM_FILE}
        COMMAND ${CMAKE_COMMAND} -E echo VMEM generate finish
    )
endfunction(generate_vmem)
