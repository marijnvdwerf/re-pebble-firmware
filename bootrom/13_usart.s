.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x8001220
    .global sub_8001220
    .thumb_func
sub_8001220:
    ldrh r3, [r0, #0xc]
    cbz R1, loc_800122C
    uxth r3, r3
    orr r3, r3, #0x2000
    b.n loc_8001234

    @ 0x800122C
loc_800122C:
    bic r3, r3, #0x2000
    lsls r3, r3, #0x10
    lsrs r3, r3, #0x10

    @ 0x8001234
loc_8001234:
    strh r3, [r0, #0xc]
    bx lr

    @ 0x8001238
    .global USART_SendData
    .thumb_func
USART_SendData:
    ubfx r1, r1, #0, #9
    strh r1, [r0, #4]
    bx lr

    @ 0x8001240
    .global USART_GetFlagStatus
    .thumb_func
USART_GetFlagStatus:
    ldrh r3, [r0]
    tst r1, r3
    ite eq
    moveq r0, #0
    movne r0, #1
    bx lr
