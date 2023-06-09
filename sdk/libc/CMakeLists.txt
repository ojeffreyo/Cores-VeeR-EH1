if(${RTOS} STREQUAL "rtthread")
    set(ASSE_DIR startup_${RTOS})
elseif(${RTOS} STREQUAL "uvm")
    set(ASSE_DIR startup_${RTOS})
elseif(${RTOS} STREQUAL "ram")
    set(ASSE_DIR startup_${RTOS})
else()
    set(ASSE_DIR startup)
endif()

################# Add global include #################
list(APPEND ADD_INCLUDE
"${CMAKE_CURRENT_SOURCE_DIR}/include"
)
#######################################################

################# Add private include #################

#######################################################

############## Add current dir source files ###########
file(GLOB_RECURSE sources
"${CMAKE_CURRENT_SOURCE_DIR}/source/printf.c"
)
list(APPEND ADD_SRCS  ${sources})
#######################################################

########### Add required/dependent components #########

#######################################################

############ Add static libs ##########################

#######################################################

############ Add dynamic libs #########################

#######################################################

############ Add global compile option ################
#add components denpend on this component
list(APPEND ADD_DEFINITIONS -DARCH_RISCV)
#######################################################

############ Add private compile option ################
#add compile option for this component that won't affect other modules
#######################################################

generate_library()
