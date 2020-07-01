.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x800108E
    .global gpio_configure
    .thumb_func
gpio_configure:
    push.w {r4, r5, r6, r7, r8, lr}
    ldr r7, [r1]
    movs r3, #0

    @ 0x8001096
loc_8001096:
    movs r2, #1
    lsls r2, r3
    and.w r5, r2, r7
    cmp r5, r2
    bne.n loc_8001104
    lsls r2, r3, #1
    movs r4, #3
    lsls r4, r2
    ldr r6, [r0]
    mvns r4, r4
    ands r6, r4
    str r6, [r0]
    ldrb r6, [r1, #4]
    ldr.w ip, [r0]
    lsl.w r8, r6, r2
    subs r6, #1
    orr.w ip, r8, ip
    cmp r6, #1
    str.w ip, [r0]
    bhi.n loc_80010F2
    ldrb.w ip, [r1, #5]
    ldr r6, [r0, #8]
    lsl.w ip, ip, r2
    ands r6, r4
    str r6, [r0, #8]
    ldr r6, [r0, #8]
    orr.w r6, ip, r6
    str r6, [r0, #8]
    ldr r6, [r0, #4]
    bic.w r5, r6, r5
    str r5, [r0, #4]
    ldrb r5, [r1, #6]
    ldr r6, [r0, #4]
    lsls r5, r3
    uxth r5, r5
    orrs r5, r6
    str r5, [r0, #4]

    @ 0x80010F2
loc_80010F2:
    ldr r5, [r0, #0xc]
    ands r4, r5
    ldrb r5, [r1, #7]
    str r4, [r0, #0xc]
    lsl.w r2, r5, r2
    ldr r4, [r0, #0xc]
    orrs r2, r4
    str r2, [r0, #0xc]

    @ 0x8001104
loc_8001104:
    adds r3, #1
    cmp r3, #0x10
    bne.n loc_8001096
    pop.w {r4, r5, r6, r7, r8, pc}

    @ 0x800110E
    .global gpio_default
    .thumb_func
gpio_default:
    movw r3, #0xffff
    str r3, [r0]
    movs r3, #0
    strb r3, [r0, #4]
    strb r3, [r0, #5]
    strb r3, [r0, #6]
    strb r3, [r0, #7]
    bx lr

    @ 0x8001120
    .global gpio_read
    .thumb_func
gpio_read:
    ldr r3, [r0, #0x10]
    tst r1, r3
    ite eq
    moveq r0, #0
    movne r0, #1
    bx lr

    @ 0x800112C
    .global gpio_set
    .thumb_func
gpio_set:
    strh r1, [r0, #0x18]
    bx lr

    @ 0x8001130
    .global gpio_clr
    .thumb_func
gpio_clr:
    strh r1, [r0, #0x1a]
    bx lr

    @ 0x8001134
    .global gpio_setclr
    .thumb_func
gpio_setclr:
    cbz R2, loc_800113A
    strh r1, [r0, #0x18]
    bx lr

    @ 0x800113A
loc_800113A:
    strh r1, [r0, #0x1a]
    bx lr

    @ 0x800113E
    .global gpio_set_af
    .thumb_func
gpio_set_af:
    and r3, r1, #7
    lsrs r1, r1, #3
    add.w r0, r0, r1, lsl #2
    lsls r3, r3, #2
    movs r1, #0xf
    lsls r1, r3
    lsls r2, r3
    push {r4, lr}
    ldr r4, [r0, #0x20]
    bic.w r1, r4, r1
    str r1, [r0, #0x20]
    ldr r1, [r0, #0x20]
    orrs r1, r2
    str r1, [r0, #0x20]
    pop {r4, pc}
