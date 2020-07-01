.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x8000FBC
    .global sub_8000FBC
    .thumb_func
sub_8000FBC:
    ldrh r3, [r0, #0x10]
    ldrh r2, [r1, #6]
    uxth r3, r3
    bic r3, r3, #0x3000
    push {r4, r5, lr}
    orrs r3, r2
    mov r5, r1
    strh r3, [r0, #0x10]
    ldrh r1, [r1, #8]
    ldrh r3, [r5, #4]
    ldrh r2, [r0, #0xc]
    orrs r3, r1
    ldrh r1, [r5, #0xa]
    uxth r2, r2
    orrs r3, r1
    bic r2, r2, #0x1600
    bic r2, r2, #0xc
    uxth r3, r3
    orrs r3, r2
    strh r3, [r0, #0xc]
    ldrh r3, [r0, #0x14]
    ldrh r2, [r5, #0xc]
    uxth r3, r3
    bic r3, r3, #0x300
    orrs r3, r2
    sub sp, #0x14
    strh r3, [r0, #0x14]
    mov r4, r0
    mov r0, sp
    bl sub_8000A50
    ldr r3, [pc, #0x64]
    cmp r4, r3
    beq.n loc_8001010
    add.w r3, r3, #0x400
    cmp r4, r3
    bne.n loc_8001014

    @ 0x8001010
loc_8001010:
    ldr r3, [sp, #0xc]
    b.n loc_8001016

    @ 0x8001014
loc_8001014:
    ldr r3, [sp, #8]

    @ 0x8001016
loc_8001016:
    ldrh r2, [r4, #0xc]
    movs r1, #0x19
    sxth r2, r2
    muls r1, r3, r1
    cmp r2, #0
    ldr r2, [r5]
    mov.w r3, #0x64
    ite lt
    lsllt r2, r2, #1
    lslge r2, r2, #2
    udiv r1, r1, r2
    udiv r2, r1, r3
    lsls r2, r2, #4
    lsrs r0, r2, #4
    mls r1, r3, r0, r1
    ldrh r0, [r4, #0xc]
    sxth r0, r0
    cmp r0, #0
    bge.n loc_8001052
    lsls r1, r1, #3
    adds r1, #0x32
    udiv r3, r1, r3
    and r3, r3, #7
    b.n loc_800105E

    @ 0x8001052
loc_8001052:
    lsls r1, r1, #4
    adds r1, #0x32
    udiv r3, r1, r3
    and r3, r3, #0xf

    @ 0x800105E
loc_800105E:
    orrs r2, r3
    uxth r2, r2
    strh r2, [r4, #8]
    add sp, #0x14
    pop {r4, r5, pc}

    @ 0x8001068
_8001068:
    .4byte 0x40011000
