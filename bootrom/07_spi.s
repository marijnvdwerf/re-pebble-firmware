.include "constants.s"

.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x8000F60
    .global spi_toggle_reset
    .thumb_func
spi_toggle_reset:
    push {r3, lr}
    ldr R3, _8000FB0
    cmp r0, r3
    bne.n loc_8000F7E
    mov.w r0, #0x1000
    movs r1, #1
    bl rcc_set_apb2_reset
    mov.w r0, #0x1000
    movs r1, #0
    bl rcc_set_apb2_reset
    pop {r3, pc}

    @ 0x8000F7E
loc_8000F7E:
    ldr R3, _8000FB4
    cmp r0, r3
    bne.n loc_8000F94
    mov.w r0, #0x4000
    movs r1, #1
    bl rcc_set_apb1_reset
    mov.w r0, #0x4000
    b.n loc_8000FA8

    @ 0x8000F94
loc_8000F94:
    ldr R3, _8000FB8
    cmp r0, r3
    bne.n loc_8000FAE
    mov.w r0, #0x8000
    movs r1, #1
    bl rcc_set_apb1_reset
    mov.w r0, #0x8000

    @ 0x8000FA8
loc_8000FA8:
    movs r1, #0
    bl rcc_set_apb1_reset

    @ 0x8000FAE
loc_8000FAE:
    pop {r3, pc}

    @ 0x8000FB0
_8000FB0:
    .4byte SPI1_BASE

    @ 0x8000FB4
_8000FB4:
    .4byte SPI2_BASE

    @ 0x8000FB8
_8000FB8:
    .4byte SPI3_BASE
