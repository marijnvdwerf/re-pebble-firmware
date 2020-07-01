.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x80009C0
    .global sub_80009C0
    .thumb_func
sub_80009C0:
    ldr r3, [pc, #4]
    str r0, [r3]
    bx lr
    .align 2

    @ 0x80009C8
_80009C8:
    .4byte 0x420E0020

    @ 0x80009CC
    .global sub_80009CC
    .thumb_func
sub_80009CC:
    ldr r3, [pc, #4]
    str r0, [r3]
    bx lr
    .align 2

    @ 0x80009D4
_80009D4:
    .4byte 0x420E00A0

    @ 0x80009D8
    .global sub_80009D8
    .thumb_func
sub_80009D8:
    ldr r3, [pc, #0xc]
    ldr r3, [r3, #4]
    tst r0, r3
    ite eq
    moveq r0, #0
    movne r0, #1
    bx lr
    .align 2

    @ 0x80009E8
_80009E8:
    .4byte 0x40007000

    @ 0x80009EC
    .global sub_80009EC
    .thumb_func
sub_80009EC:
    ldr r3, [pc, #8]
    ldr r2, [r3]
    orr.w r0, r2, r0, lsl #2
    str r0, [r3]
    bx lr

    @ 0x80009F8
_80009F8:
    .4byte 0x40007000
