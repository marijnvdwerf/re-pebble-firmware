.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x8001162
    .global conv_to_bcd
    .thumb_func
conv_to_bcd:
    movs r3, #0

    @ 0x8001164
loc_8001164:
    cmp r0, #9
    uxtb r2, r3
    add.w r3, r3, #1
    bls.n loc_8001174
    subs r0, #0xa
    uxtb r0, r0
    b.n loc_8001164

    @ 0x8001174
loc_8001174:
    orr.w r0, r0, r2, lsl #4
    uxtb r0, r0
    bx lr

    @ 0x800117C
    .global conv_from_bcd
    .thumb_func
conv_from_bcd:
    lsrs r3, r0, #4
    add.w r3, r3, r3, lsl #2
    and r0, r0, #0xf
    add.w r0, r0, r3, lsl #1
    uxtb r0, r0
    bx lr

    @ 0x800118E
    .global sub_800118E
    .thumb_func
sub_800118E:
    movs r1, #0
    movs r2, #0x7f
    movs r3, #0xff
    stm.w r0, {r1, r2, r3}
    bx lr

    @ 0x800119A
    .global sub_800119A
    .thumb_func
sub_800119A:
    movs r3, #0
    strb r3, [r0, #3]
    strb r3, [r0]
    strb r3, [r0, #1]
    strb r3, [r0, #2]
    bx lr

    @ 0x80011A6
    .global sub_80011A6
    .thumb_func
sub_80011A6:
    movs r3, #1
    strb r3, [r0]
    strb r3, [r0, #2]
    strb r3, [r0, #1]
    movs r3, #0
    strb r3, [r0, #3]
    bx lr
