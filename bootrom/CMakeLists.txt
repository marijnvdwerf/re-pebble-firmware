include_directories(bootrom)

set(mySrcs
        startup.s
        main.s
        )

set(TARGET_NAME "bootrom")

set(CMAKE_ASM_FLAGS "-I${CMAKE_CURRENT_SOURCE_DIR} -mthumb -mcpu=cortex-m3  ")

set(LINKER_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/bootrom.ld")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T ${LINKER_SCRIPT} -nostdlib -Wl,--Map=output.map")
#set(CMAKE_ASM_LINK_EXECUTABLE "/Users/Marijn/Downloads/pebble-sdk-4.5-mac/arm-cs-tools/bin/arm-none-eabi-gcc <FLAGS> <CMAKE_ASM_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")

set(CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS}  -I${CMAKE_SOURCE_DIR}  -mcpu=cortex-m3 -mthumb -Os")
add_executable(${TARGET_NAME}  ${mySrcs})

get_target_property(ELF ${TARGET_NAME} RUNTIME_OUTPUT_NAME)
add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
        COMMAND ${CMAKE_OBJCOPY} ARGS -O binary "$<TARGET_FILE:${TARGET_NAME}>" "${TARGET_NAME}.bin"
        )
#set_target_properties(${TARGET_NAME} PROPERTIES LINK_DEPENDS ${LINKER_SCRIPT})
