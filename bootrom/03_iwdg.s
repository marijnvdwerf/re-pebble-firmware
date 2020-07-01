.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x800097C
    .global sub_800097C
    .thumb_func
sub_800097C:
    ldr r3, [pc, #4]
    str r0, [r3]
    bx lr
    .align 2

    @ 0x8000984
_8000984:
    .4byte 0x40003000

    @ 0x8000988
    .global sub_8000988
    .thumb_func
sub_8000988:
    ldr r3, [pc, #4]
    str r0, [r3, #4]
    bx lr
    .align 2

    @ 0x8000990
_8000990:
    .4byte 0x40003000

    @ 0x8000994
    .global sub_8000994
    .thumb_func
sub_8000994:
    ldr r3, [pc, #4]
    str r0, [r3, #8]
    bx lr
    .align 2

    @ 0x800099C
_800099C:
    .4byte 0x40003000

    @ 0x80009A0
    .global sub_80009A0
    .thumb_func
sub_80009A0:
    ldr r3, [pc, #8]
    movw r2, #0xaaaa
    str r2, [r3]
    bx lr
    .align 2

    @ 0x80009AC
_80009AC:
    .4byte 0x40003000

    @ 0x80009B0
    .global sub_80009B0
    .thumb_func
sub_80009B0:
    ldr r3, [pc, #8]
    movw r2, #0xcccc
    str r2, [r3]
    bx lr
    .align 2

    @ 0x80009BC
_80009BC:
    .4byte 0x40003000
