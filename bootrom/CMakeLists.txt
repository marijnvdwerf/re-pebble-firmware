include_directories(bootrom)

set(mySrcs
        startup.s
        string.c
        rom.s
        00_crc.c
        stm32f2xx_dbgmcu.c
        02_flash.s
        03_iwdg.s
        04_pwr.s
        05_rcc.s
        06_rtc.s
        07_spi.s
        08_usart.s
        09_flash.s
        10_gpio.s
        11_rtc.s
        12_spi.s
        13_usart.s
        14_ctrings.s
        15_core_cm3.s
        16_pebble.c
        16_pebble.s
        17_strings.s
        18_pebble.s

        data.c
        )

set(TARGET_NAME "bootrom")

set(CMAKE_ASM_FLAGS "-I${CMAKE_CURRENT_SOURCE_DIR} -mthumb -mcpu=cortex-m3  ")
set(CMAKE_C_FLAGS "-I${CMAKE_CURRENT_SOURCE_DIR} -std=c99 -mcpu=cortex-m3 -mthumb -ffunction-sections -fdata-sections -g -fPIE -Os")

set(LINKER_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/bootrom.ld")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T ${LINKER_SCRIPT} -nostdlib -Wl,--Map=output.map")
#set(CMAKE_ASM_LINK_EXECUTABLE "/Users/Marijn/Downloads/pebble-sdk-4.5-mac/arm-cs-tools/bin/arm-none-eabi-gcc <FLAGS> <CMAKE_ASM_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")

set(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS}  -I${CMAKE_SOURCE_DIR}  -mcpu=cortex-m3 -mthumb -Os")
add_executable(${TARGET_NAME}  ${mySrcs})
target_link_libraries(${TARGET_NAME} stm32f2xx)

get_target_property(ELF ${TARGET_NAME} RUNTIME_OUTPUT_NAME)
add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} ARGS -O binary "$<TARGET_FILE:${TARGET_NAME}>" "${TARGET_NAME}.bin"
        )
#set_target_properties(${TARGET_NAME} PROPERTIES LINK_DEPENDS ${LINKER_SCRIPT})
