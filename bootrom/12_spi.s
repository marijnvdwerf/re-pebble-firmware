.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x80011B4
    .global spi_configure
    .thumb_func
spi_configure:
    ldrh r3, [r1]
    push {r4, lr}
    ldrh r4, [r1, #2]
    ldrh r2, [r0]
    orrs r3, r4
    ldrh r4, [r1, #4]
    and r2, r2, #0x3040
    orrs r3, r4
    ldrh r4, [r1, #6]
    orrs r3, r4
    ldrh r4, [r1, #8]
    orrs r3, r4
    ldrh r4, [r1, #0xa]
    orrs r3, r4
    ldrh r4, [r1, #0xc]
    orrs r3, r4
    ldrh r4, [r1, #0xe]
    orrs r3, r4
    orrs r3, r2
    uxth r3, r3
    strh r3, [r0]
    ldrh r3, [r0, #0x1c]
    bic r3, r3, #0x800
    lsls r3, r3, #0x10
    lsrs r3, r3, #0x10
    strh r3, [r0, #0x1c]
    ldrh r3, [r1, #0x10]
    strh r3, [r0, #0x10]
    pop {r4, pc}

    @ 0x80011F2
    .global spi_enable
    .thumb_func
spi_enable:
    ldrh r3, [r0]
    cbz R1, loc_80011FE
    uxth r3, r3
    orr r3, r3, #0x40
    b.n loc_8001206

    @ 0x80011FE
loc_80011FE:
    bic r3, r3, #0x40
    lsls r3, r3, #0x10
    lsrs r3, r3, #0x10

    @ 0x8001206
loc_8001206:
    strh r3, [r0]
    bx lr

    @ 0x800120A
    .global spi_read_dr
    .thumb_func
spi_read_dr:
    ldrh r0, [r0, #0xc]
    uxth r0, r0
    bx lr

    @ 0x8001210
    .global spi_write_dr
    .thumb_func
spi_write_dr:
    strh r1, [r0, #0xc]
    bx lr

    @ 0x8001214
    .global spi_get_sr_mask
    .thumb_func
spi_get_sr_mask:
    ldrh r3, [r0, #8]
    tst r1, r3
    ite eq
    moveq r0, #0
    movne r0, #1
    bx lr
