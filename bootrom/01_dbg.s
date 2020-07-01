.thumb
.syntax unified
.section .text.asm,"ax",%progbits

    @ 0x8000850
    .global sub_8000850
    .thumb_func
sub_8000850:
    ldr r3, [pc, #0x10]
    ldr r2, [r3, #8]
    cbz R1, loc_800085A
    orrs r0, r2
    b.n loc_800085E

    @ 0x800085A
loc_800085A:
    bic.w r0, r2, r0

    @ 0x800085E
loc_800085E:
    str r0, [r3, #8]
    bx lr
    .align 2

    @ 0x8000864
_8000864:
    .4byte 0xE0042000
