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
"${CMAKE_CURRENT_SOURCE_DIR}/common/"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/crc"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/dma"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/efc"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/exti"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/gpio"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/i2c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/iwdg"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/pmu"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/rtc"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/sclic"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/spi"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/tim"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/usart"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/rcc"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/mcpwm"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/cordic"
# "${CMAKE_CURRENT_SOURCE_DIR}/putuo-irq/include"
# "${CMAKE_CURRENT_SOURCE_DIR}/common/include"
)
#######################################################

################# Add private include #################

#######################################################

############## Add current dir source files ###########
file(GLOB_RECURSE sources
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/adc/adc.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/crc/crc.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/dma/dma.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/efc/efc.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/exti/exti.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/gpio/gpio.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/i2c/i2c.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/iwdg/iwdg.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/pmu/pmu.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/rtc/rtc.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/sclic/sclic.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/spi/spi.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/tim/tim.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/usart/usart.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/rcc/rcc.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/mcpwm/mcpwm.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/std_drivers/cordic/cordic.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/putuo-irq/source/*.c"
# "${CMAKE_CURRENT_SOURCE_DIR}/common/source/*.c"
"${CMAKE_CURRENT_SOURCE_DIR}/${ASSE_DIR}/crt0.s"
# "${CMAKE_CURRENT_SOURCE_DIR}/${ASSE_DIR}/akina_irq_vectors.S"
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
