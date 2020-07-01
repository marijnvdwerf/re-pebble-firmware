.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x8000810
    .global sub_8000810
    .thumb_func
sub_8000810:
    ldr r3, [pc, #4]
    movs r2, #1
    str r2, [r3, #8]
    bx lr

    @ 0x8000818
_8000818:
    .4byte 0x40023000

    @ 0x800081C
    .global sub_800081C
    .thumb_func
sub_800081C:
    ldr r3, [pc, #4]
    str r0, [r3]
    ldr r0, [r3]
    bx lr

    @ 0x8000824
_8000824:
    .4byte 0x40023000

    @ 0x8000828
    .global sub_8000828
    .thumb_func
sub_8000828:
    add.w r1, r0, r1, lsl #2

    @ 0x800082C
loc_800082C:
    cmp r0, r1
    ldr r3, [pc, #0x10]
    beq.n loc_800083A
    ldr r2, [r0], #4
    str r2, [r3]
    b.n loc_800082C

    @ 0x800083A
loc_800083A:
    ldr r0, [r3]
    bx lr
    .align 4

    @ 0x8000840
_8000840:
    .4byte 0x40023000

    @ 0x8000844
    .global sub_8000844
    .thumb_func
sub_8000844:
    ldr r3, [pc, #4]
    ldr r0, [r3]
    bx lr
    .align 2

    @ 0x800084C
_800084C:
    .4byte 0x40023000
