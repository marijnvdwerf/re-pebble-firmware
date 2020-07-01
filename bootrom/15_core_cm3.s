.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x800190C
    .global cortex_m3_system_reset
    .thumb_func
cortex_m3_system_reset:
    dsb sy
    ldr r2, [pc, #0x10]
    ldr r3, [pc, #0x14]
    ldr r1, [r2, #0xc]
    and r1, r1, #0x700
    orrs r3, r1
    str r3, [r2, #0xc]
    dsb sy

    @ 0x8001922
loc_8001922:
    b.n loc_8001922

    @ 0x8001924
_8001924:
    .4byte 0xE000ED00

    @ 0x8001928
_8001928:
    .4byte 0x5FA0004
