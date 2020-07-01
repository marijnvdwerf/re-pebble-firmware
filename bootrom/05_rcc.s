.include "constants.s"

.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x80009FC
    .global sub_80009FC
    .thumb_func
sub_80009FC:
    ldr r3, [pc, #0x28]
    movs r1, #0
    ldr r2, [r3]
    orr r2, r2, #1
    str r2, [r3]
    str r1, [r3, #8]
    ldr r2, [r3]
    bic r2, r2, #0x1080000
    bic r2, r2, #0x10000
    str r2, [r3]
    ldr r2, [pc, #0x14]
    str r2, [r3, #4]
    ldr r2, [r3]
    bic r2, r2, #0x40000
    str r2, [r3]
    str r1, [r3, #0xc]
    bx lr
    .align 2

    @ 0x8000A28
_8000A28:
    .4byte 0x40023800

    @ 0x8000A2C
_8000A2C:
    .4byte 0x24003010

    @ 0x8000A30
    .global sub_8000A30
    .thumb_func
sub_8000A30:
    ldr r3, [pc, #0x18]
    movs r2, #0
    cmp r0, #1
    strb r2, [r3]
    strb r2, [r3]
    beq.n loc_8000A42
    cmp r0, #4
    beq.n loc_8000A46
    bx lr

    @ 0x8000A42
loc_8000A42:
    strb r0, [r3]
    bx lr

    @ 0x8000A46
loc_8000A46:
    movs r2, #5
    strb r2, [r3]
    bx lr

    @ 0x8000A4C
_8000A4C:
    .4byte 0x40023870

    @ 0x8000A50
    .global sub_8000A50
    .thumb_func
sub_8000A50:
    ldr r3, [pc, #0x74]
    push {r4, lr}
    ldr r2, [r3, #8]
    and r2, r2, #0xc
    cmp r2, #4
    beq.n loc_8000A66
    cmp r2, #8
    beq.n loc_8000A6A
    ldr r3, [pc, #0x68]
    b.n loc_8000A98

    @ 0x8000A66
loc_8000A66:
    ldr r3, [pc, #0x68]
    b.n loc_8000A98

    @ 0x8000A6A
loc_8000A6A:
    ldr r1, [r3, #4]
    ldr r2, [r3, #4]
    tst.w r1, #0x400000
    ldr r1, [r3, #4]
    ite ne
    ldrne r3, [pc, #0x58]
    ldreq r3, [pc, #0x50]
    and r2, r2, #0x3f
    udiv r3, r3, r2
    ldr r2, [pc, #0x44]
    ubfx r1, r1, #6, #9
    ldr r2, [r2, #4]
    muls r3, r1, r3
    ubfx r2, r2, #0x10, #2
    adds r2, #1
    lsls r2, r2, #1
    udiv r3, r3, r2

    @ 0x8000A98
loc_8000A98:
    ldr r1, [pc, #0x2c]
    str r3, [r0]
    ldr r3, [r1, #8]
    ldr R2, _8000AD4
    ubfx r3, r3, #4, #4
    ldrb r4, [r2, r3]
    ldr r3, [r0]
    lsrs r3, r4
    str r3, [r0, #4]
    ldr r4, [r1, #8]
    ubfx r4, r4, #0xa, #3
    ldrb r4, [r2, r4]
    lsr.w r4, r3, r4
    str r4, [r0, #8]
    ldr r1, [r1, #8]
    ubfx r1, r1, #0xd, #3
    ldrb r2, [r2, r1]
    lsrs r3, r2
    str r3, [r0, #0xc]
    pop {r4, pc}

    @ 0x8000AC8
_8000AC8:
    .4byte 0x40023800

    @ 0x8000ACC
_8000ACC:
    .4byte 0xF42400

    @ 0x8000AD0
_8000AD0:
    .4byte 0x17D7840

    @ 0x8000AD4
_8000AD4:
    .4byte _8003FD0

    @ 0x8000AD8
    .global sub_8000AD8
    .thumb_func
sub_8000AD8:
    and r3, r0, #0x300
    cmp.w r3, #0x300
    ldr r3, [pc, #0x20]
    bne.n loc_8000AF6
    ldr r1, [r3, #8]
    bic r2, r0, #0xf0000000
    bic r1, r1, #0x1f0000
    bic r2, r2, #0x300
    orrs r2, r1
    str r2, [r3, #8]

    @ 0x8000AF6
loc_8000AF6:
    ldr r2, [r3, #0x70]
    ubfx r0, r0, #0, #0xc
    orrs r0, r2
    str r0, [r3, #0x70]
    bx lr
    .align 2

    @ 0x8000B04
_8000B04:
    .4byte 0x40023800

    @ 0x8000B08
    .global sub_8000B08
    .thumb_func
sub_8000B08:
    ldr r3, [pc, #4]
    str r0, [r3]
    bx lr
    .align 2

    @ 0x8000B10
_8000B10:
    .4byte 0x42470E3C

    @ 0x8000B14
    .global rcc_set_ahb1_enable
    .thumb_func
rcc_set_ahb1_enable:
    ldr r3, [pc, #0x10]
    ldr r2, [r3, #0x30]
    cbz R1, loc_8000B1E
    orrs r0, r2
    b.n loc_8000B22

    @ 0x8000B1E
loc_8000B1E:
    bic.w r0, r2, r0

    @ 0x8000B22
loc_8000B22:
    str r0, [r3, #0x30]
    bx lr
    .align 2

    @ 0x8000B28
_8000B28:
    .4byte 0x40023800

    @ 0x8000B2C
    .global rcc_set_apb1_clk
    .thumb_func
rcc_set_apb1_clk:
    ldr r3, [pc, #0x10]
    ldr r2, [r3, #0x40]
    cbz R1, loc_8000B36
    orrs r0, r2
    b.n loc_8000B3A

    @ 0x8000B36
loc_8000B36:
    bic.w r0, r2, r0

    @ 0x8000B3A
loc_8000B3A:
    str r0, [r3, #0x40]
    bx lr
    .align 2

    @ 0x8000B40
_8000B40:
    .4byte 0x40023800

    @ 0x8000B44
    .global rcc_set_apb2_enable
    .thumb_func
rcc_set_apb2_enable:
    ldr R3, _8000B58
    ldr r2, [r3, #0x44]
    cbz R1, loc_8000B4E
    orrs r0, r2
    b.n loc_8000B52

    @ 0x8000B4E
loc_8000B4E:
    bic.w r0, r2, r0

    @ 0x8000B52
loc_8000B52:
    str r0, [r3, #0x44]
    bx lr
    .align 2

    @ 0x8000B58
_8000B58:
    .4byte RCC_BASE

    @ 0x8000B5C
    .global rcc_set_ahb1_reset
    .thumb_func
rcc_set_ahb1_reset:
    ldr r3, [pc, #0x10]
    ldr r2, [r3, #0x10]
    cbz R1, loc_8000B66
    orrs r0, r2
    b.n loc_8000B6A

    @ 0x8000B66
loc_8000B66:
    bic.w r0, r2, r0

    @ 0x8000B6A
loc_8000B6A:
    str r0, [r3, #0x10]
    bx lr
    .align 2

    @ 0x8000B70
_8000B70:
    .4byte 0x40023800

    @ 0x8000B74
    .global rcc_set_ahb2_reset
    .thumb_func
rcc_set_ahb2_reset:
    ldr r3, [pc, #0x10]
    ldr r2, [r3, #0x14]
    cbz R1, loc_8000B7E
    orrs r0, r2
    b.n loc_8000B82

    @ 0x8000B7E
loc_8000B7E:
    bic.w r0, r2, r0

    @ 0x8000B82
loc_8000B82:
    str r0, [r3, #0x14]
    bx lr
    .align 2

    @ 0x8000B88
_8000B88:
    .4byte 0x40023800

    @ 0x8000B8C
    .global rcc_set_ahb3_reset
    .thumb_func
rcc_set_ahb3_reset:
    ldr r3, [pc, #0x10]
    ldr r2, [r3, #0x18]
    cbz R1, loc_8000B96
    orrs r0, r2
    b.n loc_8000B9A

    @ 0x8000B96
loc_8000B96:
    bic.w r0, r2, r0

    @ 0x8000B9A
loc_8000B9A:
    str r0, [r3, #0x18]
    bx lr
    .align 2

    @ 0x8000BA0
_8000BA0:
    .4byte 0x40023800

    @ 0x8000BA4
    .global rcc_set_apb1_reset
    .thumb_func
rcc_set_apb1_reset:
    ldr r3, [pc, #0x10]
    ldr r2, [r3, #0x20]
    cbz R1, loc_8000BAE
    orrs r0, r2
    b.n loc_8000BB2

    @ 0x8000BAE
loc_8000BAE:
    bic.w r0, r2, r0

    @ 0x8000BB2
loc_8000BB2:
    str r0, [r3, #0x20]
    bx lr
    .align 2

    @ 0x8000BB8
_8000BB8:
    .4byte 0x40023800

    @ 0x8000BBC
    .global rcc_set_apb2_reset
    .thumb_func
rcc_set_apb2_reset:
    ldr r3, [pc, #0x10]
    ldr r2, [r3, #0x24]
    cbz R1, loc_8000BC6
    orrs r0, r2
    b.n loc_8000BCA

    @ 0x8000BC6
loc_8000BC6:
    bic.w r0, r2, r0

    @ 0x8000BCA
loc_8000BCA:
    str r0, [r3, #0x24]
    bx lr
    .align 2

    @ 0x8000BD0
_8000BD0:
    .4byte 0x40023800

    @ 0x8000BD4
    .global rcc_select_bit_and_stuff
    .thumb_func
rcc_select_bit_and_stuff:
    lsrs r3, r0, #5
    cmp r3, #1
    ldr r2, [pc, #0x1c]
    bne.n loc_8000BE0
    ldr r3, [r2]
    b.n loc_8000BE8

    @ 0x8000BE0
loc_8000BE0:
    cmp r3, #2
    ite eq
    ldreq r3, [r2, #0x70]
    ldrne r3, [r2, #0x74]

    @ 0x8000BE8
loc_8000BE8:
    and r0, r0, #0x1f
    lsr.w r0, r3, r0
    and r0, r0, #1
    bx lr
    .align 2

    @ 0x8000BF8
_8000BF8:
    .4byte 0x40023800
