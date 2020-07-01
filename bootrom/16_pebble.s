.include "constants.s"

.thumb
.syntax unified
.section .text.pebble

    @ 0x800192C
    .global putchar
    .thumb_func
putchar:
    push {r4, lr}
    mov r4, r0

    @ 0x8001930
loc_8001930:
    ldr r0, [pc, #0x20]
    movs r1, #0x40
    bl uart_srtest
    cmp r0, #0
    beq.n loc_8001930
    ldr r0, [pc, #0x14]
    mov r1, r4
    bl uart_putdr

    @ 0x8001944
loc_8001944:
    ldr r0, [pc, #0xc]
    movs r1, #0x40
    bl uart_srtest
    cmp r0, #0
    beq.n loc_8001944
    pop {r4, pc}
    .align 2

    @ 0x8001954
result:
    .4byte USART3_BASE

    @ 0x8001958
    .global spi2_write
    .thumb_func
spi2_write:
    mov r1, r0
    push {r3, lr}
    ldr r0, [pc, #0x10]
    bl spi_write_dr

    @ 0x8001962
loc_8001962:
    ldr r0, [pc, #0xc]
    movs r1, #2
    bl spi_get_sr_mask
    cmp r0, #0
    beq.n loc_8001962
    pop {r3, pc}

    @ 0x8001970
spi:
    .4byte SPI2_BASE

    @ 0x8001974
    .thumb_func
is_newos:
    cbnz R0, loc_8001978
    ldr r0, [pc, #0x1c]

    @ 0x8001978
loc_8001978:
    ldr r3, [r0]
    adds r3, #1
    beq.n loc_8001990
    ldr r3, [r0, #4]
    adds r3, #1
    beq.n loc_8001990
    ldr r0, [r0, #0x1c]
    ldr r3, [pc, #0x10]
    subs r3, r0, r3
    rsbs r0, r3, #0
    adcs r0, r3
    bx lr

    @ 0x8001990
loc_8001990:
    movs r0, #0
    bx lr

    @ 0x8001994
_8001994:
    .4byte 0x8004000

    @ 0x8001998
_8001998:
    .4byte 0x4E65576F

    @ 0x800199C
    .thumb_func
sub_800199C:
    ldr r3, [pc, #0x1c]
    ldr r2, [r3, #0x10]
    ubfx r2, r2, #0x10, #7
    cmp r2, #0x7f
    bne.n loc_80019B8
    ldr r0, [r3, #0x10]
    ubfx r0, r0, #0, #0xd
    subs.w r3, r0, #0xff
    rsbs r0, r3, #0
    adcs r0, r3
    bx lr

    @ 0x80019B8
loc_80019B8:
    movs r0, #0
    bx lr

    @ 0x80019BC
_80019BC:
    .4byte 0x40002800

    @ 0x80019C0
    .thumb_func
gpio_disableclk:
    add.w r0, r0, #-0x41000000
    add.w r0, r0, #0xfe0000
    lsrs r0, r0, #0xa
    cmp r0, #8
    bhi.n loc_80019EE
    ldr R2, _80019F0
    ldr.w r3, [r2, r0, lsl #2]
    cbz R3, loc_80019EE
    subs r3, #1
    str.w r3, [r2, r0, lsl #2]
    cbnz R3, loc_80019EE
    movs r1, #1
    lsl.w r0, r1, r0
    ldr R3, _80019F4
    ldr r2, [r3, #0x30]
    bic.w r0, r2, r0
    str r0, [r3, #0x30]

    @ 0x80019EE
loc_80019EE:
    bx lr

    @ 0x80019F0
_80019F0:
    .4byte _20000020

    @ 0x80019F4
_80019F4:
    .4byte RCC_BASE

    @ 0x80019F8
    .thumb_func
gpio_enableclk:
    add.w r0, r0, #-0x41000000
    add.w r0, r0, #0xfe0000
    lsrs r0, r0, #0xa
    cmp r0, #8
    bhi.n loc_8001A22
    ldr R2, _8001A24
    ldr.w r3, [r2, r0, lsl #2]
    adds r1, r3, #1
    str.w r1, [r2, r0, lsl #2]
    cbnz R3, loc_8001A22
    movs r1, #1
    lsl.w r0, r1, r0
    ldr R3, _8001A28
    ldr r2, [r3, #0x30]
    orrs r0, r2
    str r0, [r3, #0x30]

    @ 0x8001A22
loc_8001A22:
    bx lr

    @ 0x8001A24
_8001A24:
    .4byte _20000020

    @ 0x8001A28
_8001A28:
    .4byte RCC_BASE

    @ 0x8001A2C
    .global display_cs_clear
    .thumb_func
display_cs_clear:
    push {r4, lr}
    ldr r4, [pc, #0x30]
    mov r0, r4
    bl gpio_enableclk
    movs r0, #7
    bl usleep_spin
    mov.w r1, #0x1000
    movs r2, #0
    mov r0, r4
    bl gpio_setclr
    movs r0, #4
    bl usleep_spin
    mov r0, r4
    bl gpio_disableclk
    mov.w r0, #0x4000
    movs r1, #0
    bl rcc_set_apb1_clk
    pop {r4, pc}

    @ 0x8001A60
gpiobase:
    .4byte GPIOB_BASE

    @ 0x8001A64
    .global display_cs_set
    .thumb_func
display_cs_set:
    push {r4, lr}
    ldr r4, [pc, #0x2c]
    movs r1, #1
    mov.w r0, #0x4000
    bl rcc_set_apb1_clk
    mov r0, r4
    bl gpio_enableclk
    mov r0, r4
    mov.w r1, #0x1000
    movs r2, #1
    bl gpio_setclr
    movs r0, #7
    bl usleep_spin
    mov r0, r4
    bl gpio_disableclk
    pop {r4, pc}
    .align 2

    @ 0x8001A94
_8001A94:
    .4byte 0x40020400

    @ 0x8001A98
    .thumb_func
display_update_progress:
    push {r4, r5, r6, r7, lr}
    movs r5, #0x5e
    muls r0, r5, r0
    ldr R3, _8001B20
    udiv r5, r0, r1
    ldr r2, [r3]
    subw sp, sp, #0xbdc
    cmp r5, r2
    beq.n loc_8001B18
    add r4, sp, #8
    movs r1, #0
    mov.w r2, #0xbd0
    mov r0, r4
    str r5, [r3]
    bl memset
    movs r3, #0x1b
    stm.w sp, {r3, r4}
    ldr R0, src
    movs r1, #0x10
    movs r2, #0x40
    movs r3, #0x69
    bl bitblt
    movs r3, #8
    stm.w sp, {r3, r4}
    ldr r0, [pc, #0x50]
    movs r3, #0x60
    movs r1, #0x18
    movs r2, #0x6a
    bl bitblt
    addw r6, sp, #0x7fa
    addw r3, sp, #0x78e

    @ 0x8001AEA
loc_8001AEA:
    movs r2, #0

    @ 0x8001AEC
loc_8001AEC:
    cmp r2, r5
    beq.n loc_8001B0C
    add.w r0, r2, #0x19
    uxtb r0, r0
    lsrs r1, r0, #3
    movs r7, #1
    and r0, r0, #7
    lsl.w r0, r7, r0
    ldrb r7, [r3, r1]
    adds r2, #1
    orrs r0, r7
    strb r0, [r3, r1]
    b.n loc_8001AEC

    @ 0x8001B0C
loc_8001B0C:
    adds r3, #0x12
    cmp r3, r6
    bne.n loc_8001AEA
    mov r0, r4
    bl display_blit

    @ 0x8001B18
loc_8001B18:
    addw sp, sp, #0xbdc
    pop {r4, r5, r6, r7, pc}
    .align 2

    @ 0x8001B20
_8001B20:
    .4byte _20000000

    @ 0x8001B24
src:
    .4byte _80037FC

    @ 0x8001B28
_8001B28:
    .4byte _8003B91

    @ 0x8001B2C
    .thumb_func
display_sad_watch:
    push.w {r4, r5, r6, r7, r8, sb, lr}
    subw sp, sp, #0xbdc
    add r4, sp, #8
    movs r1, #0
    mov.w r2, #0xbd0
    mov r8, r0
    mov r0, r4
    bl memset
    movs r3, #0x2c
    stm.w sp, {r3, r4}
    movs r2, #0x20
    ldr R0, _8001BF0
    movs r1, #0x18
    movs r3, #0x5c
    bl bitblt
    movs r2, #0x1c
    mov r5, r2

    @ 0x8001B5A
loc_8001B5A:
    movs r7, #0xf
    lsls r7, r2
    and.w r7, r7, r8
    lsrs r7, r2
    ldr R3, _8001BF4
    movs r1, #0x24
    mla r7, r1, r7, r3
    add.w r6, sp, #0x830
    movs r1, #0

    @ 0x8001B72
loc_8001B72:
    ldrb.w ip, [r7, r1]
    movs r3, #0

    @ 0x8001B78
loc_8001B78:
    cmp r3, #8
    beq.n loc_8001B8C
    movs r0, #1
    lsls r0, r3
    tst.w r0, ip
    ite eq
    moveq r0, #0
    movne r0, #1
    b.n loc_8001B94

    @ 0x8001B8C
loc_8001B8C:
    adds r0, r7, r1
    ldrb r0, [r0, #1]
    and r0, r0, #1

    @ 0x8001B94
loc_8001B94:
    cbz R0, loc_8001BB6
    adds r0, r3, r5
    uxtb r0, r0
    lsr.w lr, r0, #3
    mov.w sb, #1
    and r0, r0, #7
    lsl.w r0, sb, r0
    ldrb.w sb, [r6, lr]
    orr.w r0, r0, sb
    strb.w r0, [r6, lr]

    @ 0x8001BB6
loc_8001BB6:
    adds r3, #1
    cmp r3, #9
    bne.n loc_8001B78
    adds r1, #2
    cmp r1, #0x24
    add.w r6, r6, #0x12
    bne.n loc_8001B72
    adds r5, #0xb
    cmp r5, #0x74
    sub.w r2, r2, #4
    bne.n loc_8001B5A
    movs r3, #0xe
    stm.w sp, {r3, r4}
    movs r1, #0x10
    movs r2, #0x90
    movs r3, #0x6d
    ldr R0, _8001BF8
    bl bitblt
    mov r0, r4
    bl display_blit
    addw sp, sp, #0xbdc
    pop.w {r4, r5, r6, r7, r8, sb, pc}

    @ 0x8001BF0
_8001BF0:
    .4byte _80035EC

    @ 0x8001BF4
_8001BF4:
    .4byte _80032E8

    @ 0x8001BF8
_8001BF8:
    .4byte _8003528

    @ 0x8001BFC
    .thumb_func
display_pebble_logo:
    push {r4, lr}
    subw sp, sp, #0xbd8
    add r4, sp, #8
    mov r0, r4
    movs r1, #0
    mov.w r2, #0xbd0
    bl memset
    movs r3, #0x1b
    stm.w sp, {r3, r4}
    movs r1, #0x10
    movs r2, #0x40
    movs r3, #0x69
    ldr R0, _8001C30
    bl bitblt
    mov r0, r4
    bl display_blit
    addw sp, sp, #0xbd8
    pop {r4, pc}
    .align 2

    @ 0x8001C30
_8001C30:
    .4byte _80037FC

    @ 0x8001C34
    .thumb_func
display_init:
    push.w {r0, r1, r2, r4, r5, r6, r7, r8, sb, sl, fp, lr}
    ldr r6, [pc, #0x10c]
    ldr r7, [pc, #0x110]
    movs r1, #1
    mov.w r0, #0x4000
    bl rcc_set_apb1_clk
    mov r0, r6
    bl gpio_enableclk
    mov r0, r7
    ldr R4, _8001D50
    bl gpio_enableclk
    mov r0, r6
    movs r1, #0xd
    movs r2, #5
    bl gpio_set_af
    movs r2, #5
    mov r0, r6
    movs r1, #0xf
    bl gpio_set_af
    mov r0, r6
    mov r1, r4
    movs r5, #1
    bl gpio_configure
    movs r3, #0x20
    mov r0, r7
    mov r1, r4
    str r3, [r4]
    strb r5, [r4, #4]
    strb r5, [r4, #6]
    mov.w sl, #0
    str r3, [sp, #4]
    mov.w fp, #0x1000
    bl gpio_configure
    mov r0, r6
    mov r1, r4
    mov.w r8, #2
    mov.w sb, #0x4000
    strb r5, [r4, #4]
    strb.w sl, [r4, #6]
    str.w fp, [r4]
    bl gpio_configure
    mov r0, r6
    mov r1, r4
    strb.w r8, [r4, #4]
    str.w r8, [r4]
    bl gpio_configure
    mov r1, r4
    strb r5, [r4, #4]
    strb r5, [r4, #6]
    str.w sb, [r4]
    ldr r4, [pc, #0x90]
    mov r0, r6
    bl gpio_configure
    mov r0, r4
    bl spi_toggle_reset
    mov r0, r4
    ldr R1, _8001D58
    bl spi_configure
    mov r0, r4
    mov r1, r5
    bl spi_enable
    ldr r3, [sp, #4]
    mov r0, r7
    mov r1, r3
    mov r2, sl
    bl gpio_setclr
    mov r2, r5
    mov r0, r6
    mov r1, sb
    bl gpio_setclr
    mov r0, r8
    mov r1, r5
    bl rcc_set_apb1_clk
    sub.w r4, r4, #0x3400
    movs r3, #0x80
    strh r3, [r4]
    movs r3, #0xf9
    strh r3, [r4, #0x28]
    mov.w r2, #0x7800
    movw r3, #0xf9ff
    str r3, [r4, #0x2c]
    mov r0, r6
    strh r2, [r4, #0x1c]
    mov r1, r5
    str r3, [r4, #0x40]
    mov r2, r8
    strh.w fp, [r4, #0x20]
    bl gpio_set_af
    mov r1, r5
    mov r0, r4
    strh r5, [r4, #0x14]
    bl timer_enable
    mov r0, r7
    bl gpio_disableclk
    mov r0, r6
    bl gpio_disableclk
    mov r0, sb
    mov r1, sl
    bl rcc_set_apb1_clk
    add sp, #0xc
    pop.w {r4, r5, r6, r7, r8, sb, sl, fp, pc}

    @ 0x8001D48
_8001D48:
    .4byte 0x40020400

    @ 0x8001D4C
_8001D4C:
    .4byte 0x40020800

    @ 0x8001D50
_8001D50:
    .4byte _data1

    @ 0x8001D54
_8001D54:
    .4byte 0x40003800

    @ 0x8001D58
_8001D58:
    .4byte _2000000C

    @ 0x8001D5C
    .thumb_func
    .global spiflash_disable_cs
spiflash_disable_cs:
    push {r4, lr}
    ldr r4, [pc, #0x1c]
    mov r0, r4
    bl gpio_enableclk
    mov r0, r4
    movs r1, #0x10
    bl gpio_set
    mov r0, r4
    bl gpio_disableclk
    movs r0, #1
    bl usleep_spin
    pop {r4, pc}

    @ 0x8001D7C
_8001D7C:
    .4byte GPIOA_BASE

    @ 0x8001D80
    .global button_read
    .thumb_func
button_read:
    push {r3, r4, r5, lr}
    ldr R3, _8001DAC
    movs r4, #0xc
    mla r4, r4, r0, r3
    ldr r0, [r4, #4]
    bl gpio_enableclk
    ldrh r1, [r4, #8]
    ldr r0, [r4, #4]
    bl gpio_read
    mov r5, r0
    ldr r0, [r4, #4]
    bl gpio_disableclk
    rsbs.w r0, r5, #1
    it lo
    movlo r0, #0
    pop {r3, r4, r5, pc}
    .align 2

    @ 0x8001DAC
_8001DAC:
    .4byte buttons

    @ 0x8001DB0
    .global spiflash_enable_cs
    .thumb_func
spiflash_enable_cs:
    push {r4, lr}
    ldr r4, [pc, #0x18]
    mov r0, r4
    bl gpio_enableclk
    mov r0, r4
    movs r1, #0x10
    bl gpio_clr
    mov r0, r4
    bl gpio_disableclk
    pop {r4, pc}
    .align 2

    @ 0x8001DCC
_8001DCC:
    .4byte GPIOA_BASE

    @ 0x8001DD0
    .thumb_func
enter_standby:
    push {r4, r5, r6, r7, lr}
    sub sp, #0x1c
    bl sub_800199C
    cmp r0, #0
    bne.n loc_8001E60
    movs r0, #3
    bl rtc_backup_get
    mov r7, r0
    movs r0, #4
    bl rtc_backup_get
    ldr r3, [pc, #0x11c]
    movs r4, #0xa
    ldr r2, [r3]
    ubfx r5, r2, #0x10, #6
    ubfx r6, r2, #8, #7
    ubfx r3, r2, #4, #3
    and r2, r2, #0xf
    mla r2, r4, r3, r2
    lsrs r3, r6, #4
    and r6, r6, #0xf
    mla r6, r4, r3, r6
    lsrs r3, r5, #4
    and r5, r5, #0xf
    mla r3, r4, r3, r5
    movs r5, #0x3c
    mla r3, r5, r3, r6
    mla r3, r5, r3, r2
    subs r1, r3, r0
    itt mi
    addmi.w r1, r1, #0x15000
    addmi.w r1, r1, #0x180
    add.w r1, r7, r1, lsr #10
    movs r0, #3
    bl rtc_backup_set
    add r0, sp, #0xc
    bl sub_800118E
    add r0, sp, #0xc
    bl sub_8000C4C
    add r0, sp, #4
    bl sub_800119A
    add r1, sp, #4
    movs r0, #0
    bl sub_8000CD4
    add r0, sp, #8
    bl sub_80011A6
    movs r0, #0
    add r1, sp, #8
    bl sub_8000DA8

    @ 0x8001E60
loc_8001E60:
    movs r4, #0xa

    @ 0x8001E62
loc_8001E62:
    movw r5, #0x2710

    @ 0x8001E66
loc_8001E66:
    bl button_read_all
    cbnz R0, loc_8001E72
    subs r5, #1
    bne.n loc_8001E66
    b.n loc_8001E82

    @ 0x8001E72
loc_8001E72:
    ldr r5, [pc, #0x98]

    @ 0x8001E74
loc_8001E74:
    bl button_read_all
    cbz R0, loc_8001E7E
    subs r5, #1
    bne.n loc_8001E74

    @ 0x8001E7E
loc_8001E7E:
    subs r4, #1
    bne.n loc_8001E62

    @ 0x8001E82
loc_8001E82:
    movs r0, #0
    bl sub_80009CC
    movs r1, #0
    movw r0, #0xf004
    bl sub_8000EEC
    mov.w r0, #0x2f00
    bl sub_8000F44
    ldr r3, [pc, #0x74]
    movs r0, #1
    ldr r2, [r3]
    orr r2, r2, #4
    str r2, [r3]
    bl sub_80009CC
    ldr r3, [pc, #0x68]
    ldrb r3, [r3]
    cbz R3, loc_8001EB8
    ldr r0, [pc, #0x64]
    bl putsnl
    b.n loc_8001ECA

    @ 0x8001EB8
loc_8001EB8:
    ldr r0, [pc, #0x60]
    bl strlen
    ldr r1, [pc, #0x5c]
    mov r2, r0
    ldr r0, [pc, #0x5c]
    bl memcmp
    cbz R0, loc_8001EE8

    @ 0x8001ECA
loc_8001ECA:
    ldr r0, [pc, #0x58]
    bl putsnl
    movs r0, #0
    bl sub_8000ED4
    movs r0, #8
    movs r1, #1
    bl sub_8000E6C
    mov.w r0, #0x8000
    movs r1, #1
    bl sub_8000EEC

    @ 0x8001EE8
loc_8001EE8:
    ldr r0, [pc, #0x3c]
    bl putsnl
    ldr r3, [pc, #0x20]
    ldr r2, [r3]
    orr r2, r2, #2
    str r2, [r3]
    ldr r3, [pc, #0x30]
    ldr r2, [r3, #0x10]
    orr r2, r2, #4
    str r2, [r3, #0x10]
    wfi
    add sp, #0x1c
    pop {r4, r5, r6, r7, pc}

    @ 0x8001F08
_8001F08:
    .4byte 0x40002800

    @ 0x8001F0C
_8001F0C:
    .4byte 0x186A0

    @ 0x8001F10
_8001F10:
    .4byte 0x40007000

    @ 0x8001F14
_8001F14:
    .4byte 0x1FFF7A01

    @ 0x8001F18
_8001F18:
    .4byte 0x8003976

    @ 0x8001F1C
_8001F1C:
    .4byte 0x800398B

    @ 0x8001F20
_8001F20:
    .4byte 0x1FFF7820

    @ 0x8001F24
_8001F24:
    .4byte 0x8003991

    @ 0x8001F28
_8001F28:
    .4byte 0x80039A6

    @ 0x8001F2C
_8001F2C:
    .4byte 0xE000ED00

    @ 0x8001F30
    .thumb_func
sub_8001F30:
    cmp.w r0, #0x8000000
    push {r4, lr}
    mov r4, r0
    bhs.n loc_8001F52
    ldr r0, [pc, #0x34]
    bl puts
    mov r0, r4
    bl puthex
    ldr r0, [pc, #0x2c]
    bl putsnl
    mov.w r0, #-1
    pop {r4, pc}

    @ 0x8001F52
loc_8001F52:
    ldr r2, [pc, #0x24]
    movs r3, #0

    @ 0x8001F56
loc_8001F56:
    ldr r1, [r2, #4]!
    cmp r1, r4
    bhi.n loc_8001F64
    ldr r1, [r2, #4]
    cmp r4, r1
    blo.n loc_8001F6A

    @ 0x8001F64
loc_8001F64:
    adds r3, #1
    cmp r3, #7
    bne.n loc_8001F56

    @ 0x8001F6A
loc_8001F6A:
    mov r0, r3
    pop {r4, pc}
    .align 2

    @ 0x8001F70
s:
    .4byte aFailedToWriteA+16

    @ 0x8001F74
_8001F74:
    .4byte aIsOutsideSyste

    @ 0x8001F78
_8001F78:
    .4byte _800327C

    @ 0x8001F7C
    .global hardfault
    .thumb_func
hardfault:
    push {r3, lr}
    ldr R0, _8001F88
    bl putsnl
    bl cortex_m3_system_reset

    @ 0x8001F88
_8001F88:
    .4byte aHardFault

    @ 0x8001F8C
    .global spi1_write_read
    .thumb_func
spi1_write_read:
    push {r4, lr}
    mov r4, r0

    @ 0x8001F90
loc_8001F90:
    ldr r0, [pc, #0x28]
    movs r1, #2
    bl spi_get_sr_mask
    cmp r0, #0
    beq.n loc_8001F90
    ldr r0, [pc, #0x1c]
    mov r1, r4
    bl spi_write_dr

    @ 0x8001FA4
loc_8001FA4:
    ldr r0, [pc, #0x14]
    movs r1, #1
    bl spi_get_sr_mask
    cmp r0, #0
    beq.n loc_8001FA4
    ldr r0, [pc, #8]
    bl spi_read_dr
    uxtb r0, r0
    pop {r4, pc}
    .align 2

    @ 0x8001FBC
_8001FBC:
    .4byte 0x40013000

    @ 0x8001FC0
    .thumb_func
update_firmware:
    push.w {r4, r5, r6, r7, r8, sb, sl, fp, lr}
    sub sp, #0x1c
    movs r1, #1
    mov sb, r0
    add r7, sp, #0
    movs r0, #0
    bl display_update_progress
    movs r0, #4
    bl boot_status_set
    add.w r0, r7, #0xc
    mov r1, sb
    movs r2, #0xc
    bl sub_80031E2
    ldr r5, [r7, #0xc]
    ldr r4, [r7, #0x10]
    cmp r5, #0xc
    ldr.w fp, [r7, #0x14]
    beq.n loc_8002018
    ldr r0, [pc, #0x264]
    bl puts
    mov r0, r5
    bl puthex
    ldr R0, _800225C
    bl puts
    mov r0, r4
    bl puthex
    ldr r0, [pc, #0x254]
    bl puts
    mov r0, fp
    bl puthex
    ldr r0, [pc, #0x24c]
    b.n loc_8002080

    @ 0x8002018
loc_8002018:
    ldr R0, _8002268
    bl putsnl
    mov.w r0, #0x1000
    movs r1, #1
    bl rcc_set_ahb1_enable
    add.w sb, sb, #0xc
    mov sl, sp
    bl CRC_ResetDR
    sub sp, #0x80
    mov r6, sp
    mov r5, r4
    mov r8, sb

    @ 0x800203A
loc_800203A:
    cmp r5, #0x80
    bls.n loc_8002058
    mov r1, r8
    mov r0, r6
    movs r2, #0x80
    bl sub_80031E2
    mov r0, r6
    movs r1, #0x20
    bl CRC_CalcBlockCRC
    subs r5, #0x80
    add.w r8, r8, #0x80
    b.n loc_800203A

    @ 0x8002058
loc_8002058:
    cbz R5, loc_8002064
    mov r0, r6
    mov r1, r8
    mov r2, r5
    bl sub_80031E2

    @ 0x8002064
loc_8002064:
    mov r1, r5
    mov r0, r6
    bl sub_8003000
    movs r1, #0
    mov r8, r0
    mov.w r0, #0x1000
    bl rcc_set_ahb1_enable
    cmp r8, fp
    mov sp, sl
    beq.n loc_8002088
    ldr r0, [pc, #0x1ec]

    @ 0x8002080
loc_8002080:
    bl putsnl
    movs r0, #1
    b.n loc_8002250

    @ 0x8002088
loc_8002088:
    sub sp, #0x20
    mov r0, sp
    mov r1, sb
    movs r2, #0x20
    bl sub_80031E2
    mov r0, sp
    bl is_newos
    str r0, [r7, #4]
    ldr R0, _8002270
    mov sp, sl
    bl putsnl
    ldr r3, [r7, #4]
    cbnz R3, loc_80020B4
    ldr r0, [pc, #0x1c8]
    bl putsnl
    add.w r6, r4, #0xc000
    b.n loc_80020B6

    @ 0x80020B4
loc_80020B4:
    mov r6, r4

    @ 0x80020B6
loc_80020B6:
    cmp r6, #0
    beq.n loc_8002132
    ldr r0, [pc, #0x1bc]
    bl sub_8001F30
    mov r5, r0
    ldr r0, [pc, #0x1b8]
    add r0, r6
    bl sub_8001F30
    cmp r5, #0
    mov sl, r0
    blt.n loc_8002132
    cmp r0, #0
    blt.n loc_8002132
    subs r3, r0, r5
    adds r3, #1
    lsl.w fp, r3, #1
    movs r0, #0
    mov r1, fp
    bl display_update_progress
    bl flash_unlock
    ldr R3, _8002280
    movs r6, #0
    add.w r3, r3, r5, lsl #1
    str r3, [r7]

    @ 0x80020F2
loc_80020F2:
    cmp r5, sl
    bgt.n loc_800212E
    movs r0, #0xf3
    bl flash_set_sr
    ldr r3, [r7]
    movs r1, #0
    ldrh.w r0, [r3, r6, lsl #1]
    bl sub_80008D4
    cmp r0, #8
    add.w r6, r6, #1
    beq.n loc_8002122
    ldr r0, [pc, #0x170]
    bl puts
    mov r0, r5
    bl puthex
    bl putnewline
    b.n loc_800212E

    @ 0x8002122
loc_8002122:
    mov r0, r6
    mov r1, fp
    bl display_update_progress
    adds r5, #1
    b.n loc_80020F2

    @ 0x800212E
loc_800212E:
    bl flash_set_lock

    @ 0x8002132
loc_8002132:
    ldr r0, [pc, #0x154]
    bl putsnl
    ldr r3, [r7, #4]
    cbz R3, loc_8002140
    ldr r3, [pc, #0x138]
    b.n loc_8002142

    @ 0x8002140
loc_8002140:
    ldr r3, [pc, #0x148]

    @ 0x8002142
loc_8002142:
    str r3, [r7, #4]
    lsrs r3, r4, #1
    str r3, [r7]
    movs r5, #0

    @ 0x800214A
loc_800214A:
    cmp r5, r4
    bhs.n loc_80021C8
    subs r6, r4, r5
    cmp.w r6, #0x10000
    it hs
    movhs.w r6, #0x10000
    cbz R6, loc_8002168
    ldr R0, _8002290
    add.w r1, r5, sb
    mov r2, r6
    bl sub_80031E2

    @ 0x8002168
loc_8002168:
    ldr.w sl, [r7, #4]
    bl flash_unlock
    movs r0, #0xf3
    bl flash_set_sr
    add sl, r5
    mov.w fp, #0

    @ 0x800217C
loc_800217C:
    cmp fp, r6
    beq.n loc_80021B4
    ldr R1, _8002290
    add.w r0, fp, sl
    ldrb.w r1, [r1, fp]
    bl sub_8000944
    cmp r0, #8
    beq.n loc_80021AE
    ldr r0, [pc, #0x100]
    bl puts
    mov r0, sl
    bl puthex
    bl putnewline
    bl flash_set_lock
    ldr r0, [pc, #0xf0]
    bl putsnl
    b.n loc_80021C8

    @ 0x80021AE
loc_80021AE:
    add.w fp, fp, #1
    b.n loc_800217C

    @ 0x80021B4
loc_80021B4:
    bl flash_set_lock
    ldr r3, [r7]
    mov r1, r4
    add.w r0, r3, r5, lsr #1
    bl display_update_progress
    add r5, fp
    b.n loc_800214A

    @ 0x80021C8
loc_80021C8:
    ldr r0, [pc, #0xd0]
    bl puts
    mov r0, r4
    bl puthex
    ldr R0, _80022A0
    bl putsnl
    movs r0, #0
    bl is_newos
    cbz R0, loc_80021EC
    ldr r0, [pc, #0xc0]
    bl putsnl
    ldr r5, [pc, #0x8c]
    b.n loc_80021F4

    @ 0x80021EC
loc_80021EC:
    ldr R0, _80022A8
    bl putsnl
    ldr r5, [pc, #0x98]

    @ 0x80021F4
loc_80021F4:
    mov.w r0, #0x1000
    movs r1, #1
    lsrs r6, r4, #2
    bl rcc_set_ahb1_enable
    bl CRC_ResetDR
    mov r1, r6
    mov r0, r5
    bl CRC_CalcBlockCRC
    and r1, r4, #3
    add.w r0, r5, r6, lsl #2
    bl sub_8003000
    movs r1, #0
    mov r4, r0
    mov.w r0, #0x1000
    bl rcc_set_ahb1_enable
    ldr r0, [pc, #0x84]
    bl puts
    mov r0, r8
    bl puthex
    ldr R0, _80022B0
    bl puts
    mov r0, r4
    bl puthex
    bl putnewline
    cmp r4, r8
    beq.n loc_800224E
    ldr r0, [pc, #0x6c]
    bl putsnl
    movs r0, #2
    b.n loc_8002250

    @ 0x800224E
loc_800224E:
    movs r0, #0

    @ 0x8002250
loc_8002250:
    adds r7, #0x1c
    mov sp, r7
    pop.w {r4, r5, r6, r7, r8, sb, sl, fp, pc}

    @ 0x8002258
_8002258:
    .4byte aDesclen

    @ 0x800225C
_800225C:
    .4byte aFirmlen

    @ 0x8002260
_8002260:
    .4byte aXsum

    @ 0x8002264
_8002264:
    .4byte _80039F5

    @ 0x8002268
_8002268:
    .4byte aChecksummingFi

    @ 0x800226C
_800226C:
    .4byte aInvalidFirmwar

    @ 0x8002270
_8002270:
    .4byte aErase_old_firm

    @ 0x8002274
_8002274:
    .4byte aOldWorldFirm_0

    @ 0x8002278
_8002278:
    .4byte 0x8004000

    @ 0x800227C
_800227C:
    .4byte 0x8003FFF

    @ 0x8002280
_8002280:
    .4byte _80032D8

    @ 0x8002284
_8002284:
    .4byte aFailedToEraseS

    @ 0x8002288
_8002288:
    .4byte aWrite_new_firm

    @ 0x800228C
_800228C:
    .4byte 0x8010000

    @ 0x8002290
_8002290:
    .4byte _20000044

    @ 0x8002294
_8002294:
    .4byte aFailedToWriteA

    @ 0x8002298
_8002298:
    .4byte aWeReDead

    @ 0x800229C
_800229C:
    .4byte aChecksumming

    @ 0x80022A0
_80022A0:
    .4byte aBytes

    @ 0x80022A4
_80022A4:
    .4byte _8003AE3

    @ 0x80022A8
_80022A8:
    .4byte aOldWorldFirmwa

    @ 0x80022AC
_80022AC:
    .4byte aChecksumWanted

    @ 0x80022B0
_80022B0:
    .4byte aGot

    @ 0x80022B4
_80022B4:
    .4byte aOurInternalFla

    @ 0x80022B8
    .thumb_func
spiflash_init:
    push {r4, r5, r6, lr}
    mov.w r0, #0x1000
    movs r1, #1
    bl rcc_set_apb2_enable
    bl spiflash_enable_cs
    movs r0, #5
    ldr r4, [pc, #0x58]
    bl spi1_write_read

    @ 0x80022D0
loc_80022D0:
    cmp r4, #0
    add.w r4, r4, #-1
    bgt.n loc_8002318

    @ 0x80022D8
loc_80022D8:
    bl spiflash_disable_cs
    bl spiflash_enable_cs
    movs r0, #0x9f
    bl spi1_write_read
    movs r0, #0xa9
    bl spi1_write_read
    mov r5, r0
    movs r0, #0xa9
    bl spi1_write_read
    mov r6, r0
    movs r0, #0xa9
    bl spi1_write_read
    lsls r6, r6, #8
    mov r4, r0
    orr.w r5, r6, r5, lsl #16
    bl spiflash_disable_cs
    mov.w r0, #0x1000
    movs r1, #0
    bl rcc_set_apb2_enable
    orr.w r0, r5, r4
    pop {r4, r5, r6, pc}

    @ 0x8002318
loc_8002318:
    movs r0, #0xa9
    bl spi1_write_read
    lsls r3, r0, #0x1f
    bmi.n loc_80022D0
    b.n loc_80022D8

    @ 0x8002324
_8002324:
    .4byte 0x3D09000

    @ 0x8002328
    .thumb_func
sad_watch:
    push {r3, lr}
    mov r4, r0
    ldr r0, [pc, #0x44]
    bl puts
    mov r0, r4
    bl puthex
    bl putnewline
    mov r0, r4
    bl display_sad_watch
    bl button_read_all
    ldr R3, _8002378
    bic r0, r0, #4
    strb r0, [r3]
    mov r5, r3

    @ 0x8002350
loc_8002350:
    bl button_read_all
    ldrb r3, [r5]
    and r0, r0, #0xfb
    cmp r3, r0
    bne.n loc_8002362
    movs r4, #0xb
    b.n loc_8002366

    @ 0x8002362
loc_8002362:
    bl pebble_sys_reset

    @ 0x8002366
loc_8002366:
    subs r4, #1
    beq.n loc_8002350
    mov.w r0, #0x3e8
    bl usleep_spin
    b.n loc_8002366

    @ 0x8002374
_8002374:
    .4byte aSadWatch

    @ 0x8002378
_8002378:
    .4byte _20010044

    @ 0x800237C
    .thumb_func
main:
    push {r7, lr}
    ldr R3, _8002498
    mov.w r2, #0x600
    sub sp, #0x40
    str r2, [r3]
    movs r1, #1
    mov.w r0, #0x10000000
    bl rcc_set_apb1_clk
    movs r0, #1
    bl sub_80009C0
    ldr R0, a1
    bl gpio_enableclk
    mov.w r0, #0x40000
    movs r1, #1
    bl rcc_set_apb1_clk
    ldr R0, a1
    movs r1, #0xa
    movs r2, #7
    bl gpio_set_af
    movs r2, #7
    ldr R0, a1
    movs r1, #0xb
    bl gpio_set_af
    add r7, sp, #0x40
    mov.w r3, #0x400
    str r3, [r7, #-0x38]!
    movs r4, #0
    mov.w r8, #1
    movs r5, #2
    ldr R0, a1
    mov r1, r7
    strb.w r4, [sp, #0xe]
    strb.w r8, [sp, #0xf]
    strb.w r5, [sp, #0xc]
    strb.w r5, [sp, #0xd]
    bl gpio_configure
    mov.w r3, #0x800
    ldr R0, a1
    mov r1, r7
    str r3, [sp, #8]
    strb.w r5, [sp, #0xc]
    add r6, sp, #0x10
    bl gpio_configure
    mov.w r3, #0x38400
    str r3, [sp, #0x10]
    ldr R0, _80024A0
    movs r3, #0xc
    mov r1, r6
    strh.w r3, [sp, #0x1a]
    strh.w r4, [sp, #0x14]
    strh.w r4, [sp, #0x16]
    strh.w r4, [sp, #0x18]
    strh.w r4, [sp, #0x1c]
    bl sub_8000FBC
    mov r1, r8
    ldr R0, _80024A0
    bl sub_8001220
    ldr R0, a1
    bl gpio_disableclk
    ldr r0, [pc, #0x74]
    bl puts
    ldr R3, _80024A8
    ldr r0, [r3, #0x74]
    bl puthex
    bl putnewline
    movs r0, #0x79
    bl rcc_select_bit_and_stuff
    cmp r0, r8
    bne.n loc_800244E
    ldr r0, [pc, #0x60]
    bl putsnl

    @ 0x800244E
loc_800244E:
    movs r0, #1
    bl boot_status_test
    cbnz R0, loc_800245C
    movs r1, #1
    bl rtc_backup_set

    @ 0x800245C
loc_800245C:
    movs r0, #0x41
    bl rcc_select_bit_and_stuff
    cbnz R0, loc_80024BC
    ldr r0, [pc, #0x48]
    bl putsnl
    movs r0, #1
    bl sub_8000A30
    movw r4, #0x7530

    @ 0x8002474
loc_8002474:
    movs r0, #0x41
    bl rcc_select_bit_and_stuff
    cbnz R0, loc_80024BC
    mov.w r0, #0x3e8
    bl usleep_spin
    subs r4, #1
    bne.n loc_8002474
    ldr r0, [pc, #0x28]
    bl putsnl
    bl display_init
    ldr r0, [pc, #0x24]
    b.n loc_8002706
    .align 2

    @ 0x8002498
_8002498:
    .4byte FLASH_BASE

    @ 0x800249C
a1:
    .4byte GPIOC_BASE

    @ 0x80024A0
_80024A0:
    .4byte USART3_BASE

    @ 0x80024A4
_80024A4:
    .4byte aResetRegister

    @ 0x80024A8
_80024A8:
    .4byte RCC_BASE

    @ 0x80024AC
_80024AC:
    .4byte aBrownOutReset

    @ 0x80024B0
_80024B0:
    .4byte aStartingLseOsc

    @ 0x80024B4
_80024B4:
    .4byte aLseOscillatorD

    @ 0x80024B8
_80024B8:
    .4byte 0xFE504511

    @ 0x80024BC
loc_80024BC:
    mov.w r0, #0x100
    bl sub_8000AD8
    movs r0, #1
    bl sub_8000B08
    bl sub_8000C90
    movs r0, #0
    bl sub_80009CC
    movs r1, #1
    mov.w r0, #0x4000
    bl rcc_set_apb2_enable
    ldr R0, gpio
    bl gpio_enableclk
    mov r0, r6
    bl gpio_default
    movs r4, #0
    movs r5, #1
    ldr R0, gpio
    mov r1, r6
    strb.w r4, [sp, #0x15]
    strb.w r4, [sp, #0x16]
    strb.w r4, [sp, #0x17]
    str r5, [sp, #0x10]
    strb.w r5, [sp, #0x14]
    bl gpio_configure
    mov r2, r4
    ldr R0, gpio
    mov r1, r5
    bl gpio_setclr
    ldr R0, gpio
    bl gpio_disableclk
    ldr R4, _80027D0
    add.w sb, r4, #0x30

    @ 0x800251E
loc_800251E:
    ldr r0, [r4, #-0x4]
    bl gpio_enableclk
    mov r0, r6
    bl gpio_default
    ldr r3, [r4]
    ldr r0, [r4, #-0x4]
    mov.w r8, #0
    mov r1, r6
    movs r5, #2
    str r3, [sp, #0x10]
    strb.w r8, [sp, #0x14]
    strb.w r5, [sp, #0x15]
    strb.w r8, [sp, #0x17]
    adds r4, #0xc
    bl gpio_configure
    ldr r0, [r4, #-0x10]
    bl gpio_disableclk
    cmp r4, sb
    bne.n loc_800251E
    mov.w r0, #0x4000
    mov r1, r8
    bl rcc_set_apb2_enable
    mov.w r0, #0x100
    bl boot_status_test
    cmp r0, #0
    beq.w loc_800270A
    mov.w r0, #0x100
    bl boot_status_clear
    bl enter_standby

    @ 0x800257E
loc_800257E:
    ldr r0, [pc, #0x254]
    bl putsnl
    movs r0, #2
    bl rtc_backup_get
    ldr r1, [pc, #0x24c]
    cmp r0, r1
    beq.n loc_8002596
    movs r0, #2
    bl rtc_backup_set

    @ 0x8002596
loc_8002596:
    ldr r0, [pc, #0x244]
    bl puts
    movs r0, #2
    bl rtc_backup_get
    bl puthex
    bl putnewline
    mov.w r0, #0x4000
    bl boot_status_test
    cbz R0, loc_80025DA
    ldr R0, _80027E0
    bl putsnl
    mov.w r0, #0x4000
    bl boot_status_clear
    movs r0, #8
    bl boot_status_clear
    movs r0, #0x10
    bl boot_status_clear
    movs r0, #0x20
    bl boot_status_clear
    movs r0, #0x40
    bl boot_status_clear

    @ 0x80025DA
loc_80025DA:
    bl display_init
    bl display_pebble_logo
    movs r1, #1
    mov.w r0, #0x1000
    bl rcc_set_apb2_enable
    ldr R0, gpio
    bl gpio_enableclk
    movs r0, #1
    mov r1, r0
    bl rcc_set_ahb1_enable
    movs r1, #5
    mov r2, r1
    ldr R0, gpio
    bl gpio_set_af
    ldr R0, gpio
    movs r1, #6
    movs r2, #5
    bl gpio_set_af
    movs r2, #5
    ldr R0, gpio
    movs r1, #7
    bl gpio_set_af
    movs r4, #0
    movs r5, #2
    movs r3, #0xc0
    ldr R0, gpio
    mov r1, r7
    strb.w r5, [sp, #0xc]
    strb.w r5, [sp, #0xd]
    str r3, [sp, #8]
    strb.w r4, [sp, #0xe]
    strb.w r4, [sp, #0xf]
    bl gpio_configure
    movs r3, #0x20
    ldr R0, gpio
    mov r1, r7
    strb.w r5, [sp, #0xf]
    str r3, [sp, #8]
    movs r5, #1
    bl gpio_configure
    movs r3, #0x10
    mov r1, r7
    ldr R0, gpio
    str r3, [sp, #8]
    strb.w r5, [sp, #0xc]
    strb.w r5, [sp, #0xf]
    bl gpio_configure
    ldr R0, _80027E4
    bl spi_toggle_reset
    mov.w r3, #0x104
    strh.w r3, [sp, #0x12]
    mov.w r3, #0x200
    strh.w r3, [sp, #0x1a]
    ldr R0, _80027E4
    movs r3, #7
    mov r1, r6
    strh.w r3, [sp, #0x20]
    strh.w r4, [sp, #0x10]
    strh.w r4, [sp, #0x14]
    strh.w r4, [sp, #0x16]
    strh.w r4, [sp, #0x18]
    strh.w r4, [sp, #0x1c]
    strh.w r4, [sp, #0x1e]
    bl spi_configure
    mov r1, r5
    ldr R0, _80027E4
    bl spi_enable
    ldr R0, gpio
    bl gpio_disableclk
    bl spiflash_enable_cs
    movs r0, #0xab
    bl spi1_write_read
    bl spiflash_disable_cs
    movs r0, #0x64
    bl usleep_spin
    mov r1, r4
    mov.w r0, #0x1000
    bl rcc_set_apb2_enable
    bl spiflash_init
    mov r0, r5
    bl rtc_backup_get
    mov r5, r4
    str r0, [sp, #0x10]

    @ 0x80026D4
loc_80026D4:
    uxtb r0, r5
    bl button_read
    cbnz R0, loc_8002744
    strb r0, [r6, r5]

    @ 0x80026DE
loc_80026DE:
    adds r5, #1
    cmp r5, #4
    bne.n loc_80026D4
    ldr r5, [sp, #0x10]
    cbz R5, loc_80026F8
    ldr R0, _80027E8
    bl puts
    mov r0, r5
    bl puthex
    bl putnewline

    @ 0x80026F8
loc_80026F8:
    movs r0, #1
    mov r1, r5
    bl rtc_backup_set
    cmp r4, #0
    beq.n loc_8002780
    ldr r0, [pc, #0xe4]

    @ 0x8002706
loc_8002706:
    bl sad_watch

    @ 0x800270A
loc_800270A:
    mov r0, r5
    bl sub_80009D8
    cmp r0, #1
    bne.n loc_800273E
    mov r0, r5
    bl sub_80009EC
    mov.w r0, #0x800
    bl sub_8000F28
    cbz R0, loc_800272C
    ldr R0, _80027F0
    bl putsnl
    b.n loc_80028A0

    @ 0x800272C
loc_800272C:
    ldr r4, [pc, #0xc4]

    @ 0x800272E
loc_800272E:
    bl button_read_all
    cmp r0, #0
    beq.w loc_8002940
    subs r4, #1
    bne.n loc_800272E
    b.n loc_80028A0

    @ 0x800273E
loc_800273E:
    bl sub_80030BC
    b.n loc_800257E

    @ 0x8002744
loc_8002744:
    ldrb r3, [r6, r5]
    cmp r3, #4
    ble.n loc_8002760
    ldr r0, [pc, #0xac]
    bl putsnl
    ldr r0, [sp, #0x10]
    bl puthex
    movs r0, #1
    movs r1, #0
    bl rtc_backup_set
    b.n loc_8002780

    @ 0x8002760
loc_8002760:
    adds r3, #1
    uxtb r3, r3
    cmp r3, #4
    strb r3, [r6, r5]
    ble.n loc_80026DE
    ldr r0, [pc, #0x90]
    bl puts
    mov r0, r5
    bl puthex
    ldr R0, _8002800
    bl putsnl
    movs r4, #1
    b.n loc_80026DE

    @ 0x8002780
loc_8002780:
    bl spiflash_init
    ldr r3, [pc, #0x7c]
    add r3, r0
    cmp r3, #1
    bls.n loc_8002790
    ldr r0, [pc, #0x78]
    b.n loc_8002706

    @ 0x8002790
loc_8002790:
    ldr R0, _800280C
    bl puts
    movs r0, #0
    bl rtc_backup_get
    bl puthex
    bl putnewline
    movs r0, #0x80
    bl boot_status_test
    cbz R0, loc_80027B4
    movs r0, #0x80
    bl boot_status_clear
    b.n loc_800289C

    @ 0x80027B4
loc_80027B4:
    mov.w r0, #0x20000
    bl boot_status_test
    mov r4, r0
    cbz R0, loc_8002810
    mov.w r0, #0x20000
    bl boot_status_clear
    b.n loc_80029D4
    .align 2

    @ 0x80027CC
gpio:
    .4byte GPIOA_BASE

    @ 0x80027D0
_80027D0:
    .4byte buttons+8

    @ 0x80027D4
_80027D4:
    .4byte a______________

    @ 0x80027D8
a2:
    .4byte 0x56418670

    @ 0x80027DC
_80027DC:
    .4byte aBootloaderVers

    @ 0x80027E0
_80027E0:
    .4byte aLastFirmwareBo

    @ 0x80027E4
_80027E4:
    .4byte SPI1_BASE

    @ 0x80027E8
_80027E8:
    .4byte aButtonWasPushe

    @ 0x80027EC
errorcode:
    .4byte 0xFE504501

    @ 0x80027F0
_80027F0:
    .4byte aUsbWakeup

    @ 0x80027F4
_80027F4:
    .4byte 0x186A0

    @ 0x80027F8
_80027F8:
    .4byte aStuckButtonReg

    @ 0x80027FC
_80027FC:
    .4byte aButtonId

    @ 0x8002800
_8002800:
    .4byte aIsStuck

    @ 0x8002804
_8002804:
    .4byte 0xFFDF44EA

    @ 0x8002808
_8002808:
    .4byte 0xFE504502

    @ 0x800280C
_800280C:
    .4byte aBootBits

    @ 0x8002810
loc_8002810:
    movs r0, #1
    bl button_read
    cbz R0, loc_8002850
    mov r0, r4
    bl button_read
    cbz R0, loc_8002850
    ldr R0, _8002B00
    bl putsnl
    movw r4, #0x1388

    @ 0x800282A
loc_800282A:
    movs r0, #1
    bl button_read
    cmp r0, #0
    beq.w loc_800294C
    movs r0, #0
    bl button_read
    cmp r0, #0
    beq.w loc_800294C
    mov.w r0, #0x3e8
    bl usleep_spin
    subs r4, #1
    bne.n loc_800282A
    b.n loc_80029D4

    @ 0x8002850
loc_8002850:
    movs r0, #0
    bl is_newos
    cbz R0, loc_800285C
    ldr r3, [pc, #0x2a8]
    b.n loc_800285E

    @ 0x800285C
loc_800285C:
    ldr r3, [pc, #0x2a8]

    @ 0x800285E
loc_800285E:
    ldm r3, {r2, r3}
    adds r3, #1
    beq.n loc_8002868
    adds r2, #1
    bne.n loc_800294C

    @ 0x8002868
loc_8002868:
    ldr R0, _8002B0C
    bl putsnl
    b.n loc_80029D4

    @ 0x8002870
loc_8002870:
    ldr R0, _8002B10
    bl putsnl
    movs r0, #8
    bl boot_status_clear
    movs r0, #0x10
    bl boot_status_clear
    movs r0, #0x20
    bl boot_status_clear
    movs r0, #0x40
    bl boot_status_clear
    movs r4, #0

    @ 0x8002890
loc_8002890:
    movs r0, #4
    bl boot_status_clear
    cmp r4, #0
    bne.w loc_8002AAC

    @ 0x800289C
loc_800289C:
    ldr r0, [pc, #0x274]
    b.n loc_8002706

    @ 0x80028A0
loc_80028A0:
    bl sub_800199C
    cmp r0, #0
    beq.n loc_8002938
    movs r0, #0
    add r1, sp, #4
    ldr R5, _8002B18
    bl sub_8000D64
    mov r4, r6
    movs r0, #0
    mov r1, r7
    bl sub_8000E2C
    ldm r5!, {r0, r1, r2, r3}
    stm r4!, {r0, r1, r2, r3}
    ldm r5!, {r0, r1, r2, r3}
    stm r4!, {r0, r1, r2, r3}
    ldm.w r5, {r0, r1, r2, r3}
    stm.w r4, {r0, r1, r2, r3}
    ldrb.w r2, [sp, #9]
    add r1, sp, #0x40
    add.w r3, r1, r2, lsl #2
    ldrb.w lr, [sp, #0xb]
    ldr r3, [r3, #-0x34]
    movw r1, #0x16d
    mla r3, r1, lr, r3
    add.w r3, r3, lr, lsr #2
    add.w lr, lr, #1
    tst.w lr, #3
    bne.n loc_80028FA
    cmp r2, #2
    it hi
    addhi r3, #1

    @ 0x80028FA
loc_80028FA:
    ldrb.w r4, [sp, #0xa]
    ldrb.w r1, [sp, #4]
    subs r4, #1
    add r3, r4
    movs r4, #0x18
    mla r4, r4, r3, r1
    ldrb.w r1, [sp, #5]
    movs r2, #0x3c
    mla r4, r2, r4, r1
    ldrb.w r1, [sp, #6]
    movs r0, #3
    mla r4, r2, r4, r1
    bl rtc_backup_get
    adds r1, r0, r4
    movs r0, #3
    bl rtc_backup_set
    movs r0, #4
    movs r1, #0
    bl rtc_backup_set
    bl sub_80030BC

    @ 0x8002938
loc_8002938:
    ldr r0, [pc, #0x1e0]
    bl putsnl
    b.n loc_800257E

    @ 0x8002940
loc_8002940:
    ldr r0, [pc, #0x1dc]
    bl putsnl
    bl enter_standby
    b.n loc_8002938

    @ 0x800294C
loc_800294C:
    movs r0, #0x7d
    bl rcc_select_bit_and_stuff
    cbnz R0, loc_8002972
    mov.w r0, #0x200
    bl boot_status_test
    cbnz R0, loc_8002972
    ldr r0, [pc, #0x1c4]
    bl putsnl
    movs r0, #8
    bl boot_status_clear
    movs r0, #0x10
    bl boot_status_clear
    b.n loc_8002A7E

    @ 0x8002972
loc_8002972:
    movs r0, #0x7d
    bl rcc_select_bit_and_stuff
    cbz R0, loc_8002980
    ldr R0, _8002B28
    bl putsnl

    @ 0x8002980
loc_8002980:
    mov.w r0, #0x200
    bl boot_status_test
    cbz R0, loc_8002990
    ldr R0, _8002B2C
    bl putsnl

    @ 0x8002990
loc_8002990:
    mov.w r0, #0x200
    bl boot_status_clear
    movs r0, #0x10
    bl boot_status_test
    cbz R0, loc_80029B4
    ldr R0, _8002B30
    bl putsnl
    movs r0, #8
    bl boot_status_clear
    movs r0, #0x10
    bl boot_status_clear
    b.n loc_80029DA

    @ 0x80029B4
loc_80029B4:
    movs r0, #8
    bl boot_status_test
    cbz R0, loc_80029C6
    ldr R0, _8002B34
    bl putsnl
    movs r0, #0x10
    b.n loc_80029CE

    @ 0x80029C6
loc_80029C6:
    ldr R0, _8002B38
    bl putsnl
    movs r0, #8

    @ 0x80029CE
loc_80029CE:
    bl boot_status_set
    b.n loc_8002A7E

    @ 0x80029D4
loc_80029D4:
    ldr R0, _8002B3C
    bl putsnl

    @ 0x80029DA
loc_80029DA:
    ldr R0, _8002B40
    bl putsnl
    mov.w r0, #0x200000
    bl update_firmware
    cbz R0, loc_80029F0
    cmp r0, #2
    bhi.n loc_8002A40
    b.n loc_8002A04

    @ 0x80029F0
loc_80029F0:
    movs r0, #0x20
    bl boot_status_clear
    movs r0, #0x40
    bl boot_status_clear
    movs r0, #0x80
    bl boot_status_set
    b.n loc_8002A40

    @ 0x8002A04
loc_8002A04:
    movs r0, #8
    bl boot_status_set
    movs r0, #0x10
    bl boot_status_set
    movs r0, #0x20
    bl boot_status_test
    cbnz R0, loc_8002A22
    ldr R0, _8002B44
    bl putsnl
    movs r0, #0x20
    b.n loc_8002A36

    @ 0x8002A22
loc_8002A22:
    movs r0, #0x40
    bl boot_status_test
    cmp r0, #0
    bne.w loc_8002870
    ldr r0, [pc, #0x118]
    bl putsnl
    movs r0, #0x40

    @ 0x8002A36
loc_8002A36:
    bl boot_status_set
    mov.w r0, #0x200
    b.n loc_8002A76

    @ 0x8002A40
loc_8002A40:
    movs r4, #1
    b.n loc_8002890

    @ 0x8002A44
loc_8002A44:
    ldr R0, _8002B4C
    bl putsnl
    movs r0, #8
    bl boot_status_clear
    movs r0, #0x10
    bl boot_status_clear
    movs r0, #0x20
    bl boot_status_clear
    movs r0, #0x40
    bl boot_status_clear
    mov r0, r4
    bl update_firmware
    cmp r0, #2
    bne.w loc_8002C56
    movs r0, #8
    bl boot_status_set
    movs r0, #0x10

    @ 0x8002A76
loc_8002A76:
    bl boot_status_set
    bl pebble_sys_reset

    @ 0x8002A7E
loc_8002A7E:
    movs r0, #2
    bl boot_status_test
    cbz R0, loc_8002AAC
    movs r0, #4
    bl boot_status_test
    mov r4, r0
    cmp r0, #0
    beq.n loc_8002A44
    ldr R0, _8002B50
    bl putsnl
    movs r0, #4
    bl boot_status_clear
    movs r0, #2
    bl boot_status_clear
    mov.w r0, #0x8000
    bl boot_status_clear

    @ 0x8002AAC
loc_8002AAC:
    mov.w r0, #0x2000
    bl boot_status_test
    mov r4, r0
    mov.w r0, #0x1000
    bl boot_status_test
    lsls r0, r0, #1
    orr.w r4, r0, r4, lsl #2
    mov.w r0, #0x800
    bl boot_status_test
    uxtb r4, r4
    orrs r0, r4
    adds r3, r0, #1
    and r3, r3, #0xff
    subs r3, #1
    mov.w r0, #0x800
    cmp r3, #6
    bhi.n loc_8002B9A
    tbb [pc, r3]

    @ 0x8002AE4
jpt_8002AE0:
    .byte 0x3C
    .byte 0x38
    .byte 0x3C
    .byte 0x4
    .byte 0x3C
    .byte 0x38
    .byte 0x3C
    .align 1

    @ 0x8002AEC
loc_8002AEC:
    bl boot_status_clear
    mov.w r0, #0x1000
    bl boot_status_clear
    mov.w r0, #0x2000
    b.n loc_8002B5C
    .align 2

    @ 0x8002B00
_8002B00:
    .4byte aHoldDownUpBack

    @ 0x8002B04
_8002B04:
    .4byte 0x8004000

    @ 0x8002B08
_8002B08:
    .4byte 0x8010000

    @ 0x8002B0C
_8002B0C:
    .4byte aFirmwareIsEras

    @ 0x8002B10
_8002B10:
    .4byte aFailedToLoadRe

    @ 0x8002B14
_8002B14:
    .4byte 0xFE504503

    @ 0x8002B18
_8002B18:
    .4byte _8003250

    @ 0x8002B1C
_8002B1C:
    .4byte aLeavingStandby

    @ 0x8002B20
_8002B20:
    .4byte aReturningToSta

    @ 0x8002B24
_8002B24:
    .4byte aBootingNormall

    @ 0x8002B28
_8002B28:
    .4byte aWatchdogCaused

    @ 0x8002B2C
_8002B2C:
    .4byte aSoftwareFailur

    @ 0x8002B30
_8002B30:
    .4byte aBootFailedSt_0

    @ 0x8002B34
_8002B34:
    .4byte aBootFailedStri

    @ 0x8002B38
_8002B38:
    .4byte aBootFailedSt_1

    @ 0x8002B3C
_8002B3C:
    .4byte aForceBootingRe

    @ 0x8002B40
_8002B40:
    .4byte aLoadingRecover

    @ 0x8002B44
_8002B44:
    .4byte aFailedToLoad_1

    @ 0x8002B48
_8002B48:
    .4byte aFailedToLoad_0

    @ 0x8002B4C
_8002B4C:
    .4byte aNewFirmwareIsA

    @ 0x8002B50
_8002B50:
    .4byte aOurPreviousFir

    @ 0x8002B54
loc_8002B54:
    bl boot_status_clear
    mov.w r0, #0x1000

    @ 0x8002B5C
loc_8002B5C:
    bl boot_status_set
    movw r0, #0x5555
    bl sub_800097C
    movs r0, #4
    bl sub_8000988
    movw r0, #0xfff
    bl sub_8000994
    movs r0, #0
    bl sub_800097C
    mov.w r0, #0x1000
    movs r1, #1
    bl sub_8000850
    bl sub_80009B0
    bl sub_80009A0
    movs r0, #0
    bl is_newos
    cbnz R0, loc_8002BB2
    ldr r3, [pc, #0xd4]
    b.n loc_8002BB4

    @ 0x8002B9A
loc_8002B9A:
    bl boot_status_clear
    mov.w r0, #0x1000
    bl boot_status_clear
    mov.w r0, #0x2000
    bl boot_status_clear
    ldr r0, [pc, #0xc0]
    b.n loc_8002706

    @ 0x8002BB2
loc_8002BB2:
    ldr r3, [pc, #0xc0]

    @ 0x8002BB4
loc_8002BB4:
    ldr r5, [r3, #4]
    ldr r0, [pc, #0xc0]
    ldr r6, [r3]
    bl puts
    mov r0, r5
    bl puthex
    bl putnewline
    bl putnewline
    movs r3, #0

    @ 0x8002BCE
loc_8002BCE:
    lsls r2, r3, #2
    add.w r2, r2, #-0x20000000
    adds r3, #1
    add.w r2, r2, #0xe100
    mov.w r1, #-1
    cmp r3, #8
    str.w r1, [r2, #0x80]
    str.w r1, [r2, #0x180]
    bne.n loc_8002BCE
    ldr R3, _8002C7C
    movs r4, #0
    str r4, [r3, #0x30]
    str r4, [r3, #0x34]
    str r4, [r3, #0x38]
    str r4, [r3, #0x40]
    str r4, [r3, #0x44]
    bl sub_80009FC
    ldr r0, [pc, #0x80]
    movs r1, #1
    bl rcc_set_ahb1_reset
    mov r1, r4
    ldr r0, [pc, #0x78]
    bl rcc_set_ahb1_reset
    movs r0, #0xf1
    movs r1, #1
    bl rcc_set_ahb2_reset
    mov r1, r4
    movs r0, #0xf1
    bl rcc_set_ahb2_reset
    movs r0, #1
    mov r1, r0
    bl rcc_set_ahb3_reset
    mov r1, r4
    movs r0, #1
    bl rcc_set_ahb3_reset
    ldr r0, [pc, #0x54]
    movs r1, #1
    bl rcc_set_apb1_reset
    mov r1, r4
    ldr r0, [pc, #0x4c]
    bl rcc_set_apb1_reset
    ldr r0, [pc, #0x48]
    movs r1, #1
    bl rcc_set_apb2_reset
    ldr r0, [pc, #0x40]
    mov r1, r4
    bl rcc_set_apb2_reset
    cpsie if
    mov.w lr, #-1
    mov sp, r6
    bx r5

    @ 0x8002C56
loc_8002C56:
    movs r0, #4
    bl boot_status_clear
    movs r0, #2
    bl boot_status_clear
    mov.w r0, #0x8000
    bl boot_status_set
    b.n loc_8002AAC

    @ 0x8002C6C
_8002C6C:
    .4byte 0x8010000

    @ 0x8002C70
_8002C70:
    .4byte 0xFE504504

    @ 0x8002C74
_8002C74:
    .4byte 0x8004000

    @ 0x8002C78
_8002C78:
    .4byte aBootingFirmwar

    @ 0x8002C7C
_8002C7C:
    .4byte RCC_BASE

    @ 0x8002C80
_8002C80:
    .4byte 0x22601000

    @ 0x8002C84
_8002C84:
    .4byte 0x36FEC9FF

    @ 0x8002C88
bits:
    .4byte 0x75933

    @ 0x8002C8C
    .global _entry
    .thumb_func
_entry:
    ldr R0, _8002CAC
    ldr R2, _8002CB0
    push {r3, lr}
    ldr R1, _8002CB4
    subs r2, r2, r0
    bl memcpy
    ldr R0, _8002CB8
    ldr R2, _8002CBC
    movs r1, #0
    subs r2, r2, r0
    bl memset
    bl main
    nop

    @ 0x8002CAC
_8002CAC:
    .4byte _sdata

    @ 0x8002CB0
_8002CB0:
    .4byte _edata

    @ 0x8002CB4
_8002CB4:
    .4byte _sidata

    @ 0x8002CB8
_8002CB8:
    .4byte _20000020

    @ 0x8002CBC
_8002CBC:
    .4byte _20010048

    .section ".rodata"

    .align 2
    @ 0x8003250
_8003250:
    .4byte 0x0
    .byte 0x1F
    .byte 0x0
    .byte 0x0
    .byte 0x0
    .byte 0x3B
    .byte 0x0
    .byte 0x0
    .byte 0x0
    .byte 0x5A
    .byte 0x0
    .byte 0x0
    .byte 0x0
    .byte 0x78
    .byte 0x0
    .byte 0x0
    .byte 0x0
    .byte 0x97
    .byte 0x0
    .byte 0x0
    .byte 0x0
    .byte 0xB5
    .byte 0x0
    .byte 0x0
    .byte 0x0
    .byte 0xD4
    .byte 0x0
    .byte 0x0
    .byte 0x0
    .byte 0xF3
    .byte 0x0
    .byte 0x0
    .byte 0x0
    .byte 0x11
    .byte 0x1
    .byte 0x0
    .byte 0x0
    .byte 0x30
    .byte 0x1
    .byte 0x0
    .byte 0x0

    @ 0x800327C
_800327C:
    .byte 0x4E
    .byte 0x1
    .byte 0x0
    .byte 0x0

    @ 0x8003280
_8003280:
    .4byte 0x8000000
    .byte 0x00
    .byte 0x40
    .byte 0x0
    .byte 0x8
    .4byte 0x8008000
    .4byte 0x800C000
    .4byte 0x8010000
    .4byte 0x8020000
    .4byte 0x8040000
    .4byte 0x8060000

    @ 0x80032A0
buttons:
    .4byte aBack
    .byte 0x0
    .byte 0x8
    .byte 0x2
    .byte 0x40
    .byte 0x8
    .byte 0x0
    .byte 0x0
    .byte 0x0
    .4byte aUp
    .byte 0x0
    .byte 0x0
    .byte 0x2
    .byte 0x40
    .byte 0x4
    .byte 0x0
    .byte 0x0
    .byte 0x0
    .4byte aSelect
    .byte 0x0
    .byte 0x8
    .byte 0x2
    .byte 0x40
    .byte 0x40
    .byte 0x0
    .byte 0x0
    .byte 0x0
    .4byte aDown
    .byte 0x0
    .byte 0x0
    .byte 0x2
    .byte 0x40
    .byte 0x2
    .byte 0x0
    .byte 0x0
    .byte 0x0
    .byte 0x00
    .byte 0x00
    .byte 0x02
    .byte 0x40
    .byte 0x01
    .byte 0x00
    .byte 0x00
    .byte 0x00

    @ 0x80032D8
_80032D8:
    .4byte 0x80000
    .4byte 0x180010
    .4byte 0x280020
    .4byte 0x380030

.include "gfx/hex-chars.s"

.include "gfx/pebble-com-error.s"
.include "gfx/sad-watch.s"
.include "gfx/pebble-logo.s"

    @ 0x8003976
aNoHwVersionInO:
    .asciz "No HW Version in OTP"

    @ 0x800398B
aBb2_0:
    .asciz "BB2.0"

    @ 0x8003991
aUsbWakeupSuppo:
    .asciz "usb wakeup supported"

    @ 0x80039A6
aEnteringStandb:
    .asciz "Entering standby"

    @ 0x80039B7
aIsOutsideSyste:
    .asciz " is outside system flash"

    @ 0x80039D0
aHardFault:
    .asciz "HARD FAULT"

    @ 0x80039DB
aDesclen:
    .asciz "Desclen "

    @ 0x80039E4
aFirmlen:
    .asciz "\nFirmlen "

    @ 0x80039EE
aXsum:
    .asciz "\nXsum "

    @ 0x80039F5
_80039F5:
    .asciz "\nInvalid firmware description!"

    @ 0x8003A14
aChecksummingFi:
    .asciz "Checksumming firmware update"

    @ 0x8003A31
aInvalidFirmwar:
    .asciz "Invalid firmware CRC in SPI flash!"

    @ 0x8003A54
aErase_old_firm:
    .asciz "erase_old_firmware"

    @ 0x8003A67
aOldWorldFirm_0:
    .asciz "Old World firmware base"

    @ 0x8003A7F
aFailedToEraseS:
    .asciz "failed to erase sector "

    @ 0x8003A97
aWrite_new_firm:
    .asciz "write_new_firmware"

    @ 0x8003AAA
aFailedToWriteA:
    .asciz "failed to write address "

    @ 0x8003AC3
aWeReDead:
    .asciz "We're dead"

    @ 0x8003ACE
aChecksumming:
    .asciz "Checksumming "

    @ 0x8003ADC
aBytes:
    .asciz " bytes"

    @ 0x8003AE3
_8003AE3:
    .asciz "New World firmware system_flash_base"

    @ 0x8003B08
aOldWorldFirmwa:
    .asciz "Old World firmware system_flash_base"

    @ 0x8003B2D
aChecksumWanted:
    .asciz "Checksum - wanted "

    @ 0x8003B40
aGot:
    .asciz " got "

    @ 0x8003B46
aOurInternalFla:
    .asciz "Our internal flash contents are bad (checksum failed)! This is really bad!"

.include "gfx/progress-bar.s"

    @ 0x8003BF1
aSadWatch:
    .asciz "SAD WATCH: "

    @ 0x8003BFD
aResetRegister:
    .asciz "Reset Register "

    @ 0x8003C0D
aBrownOutReset:
    .asciz "Brown out reset"

    @ 0x8003C1D
aStartingLseOsc:
    .asciz "Starting LSE oscillator"

    @ 0x8003C35
aLseOscillatorD:
    .asciz "LSE oscillator did not start"

    @ 0x8003C52
aUsbWakeup:
    .asciz "USB wakeup"

    @ 0x8003C5D
aLeavingStandby:
    .asciz "leaving standby"

    @ 0x8003C6D
a______________:
    .ascii " ______    __\r\n"
    .ascii "/_  __/ __/ /\r\n"
    .ascii " / /   /_  __/\r\n"
    .asciz "/_/     /_/\r\n"

    @ 0x8003CA9
aBootloaderVers:
    .asciz "Bootloader version: "

    @ 0x8003CBE
aLastFirmwareBo:
    .asciz "Last firmware boot was stable; clear strikes"

    @ 0x8003CEB
aStuckButtonReg:
    .asciz "Stuck button register is invalid, clearing."

    @ 0x8003D17
aButtonId:
    .asciz "Button id "

    @ 0x8003D22
aIsStuck:
    .asciz "is stuck!"

    @ 0x8003D2C
aButtonWasPushe:
    .asciz "Button was pushed on boot. Button counter: "

    @ 0x8003D58
aBootBits:
    .asciz "Boot bits: "

    @ 0x8003D64
aHoldDownUpBack:
    .asciz "Hold down UP + BACK for 5 secs. to force-boot PRF"

    @ 0x8003D96
aFirmwareIsEras:
    .asciz "Firmware is erased"

    @ 0x8003DA9
aBootingNormall:
    .asciz "Booting normally"

    @ 0x8003DBA
aWatchdogCaused:
    .asciz "Watchdog caused a reset"

    @ 0x8003DD2
aSoftwareFailur:
    .asciz "Software failure caused a reset"

    @ 0x8003DF2
aBootFailedSt_0:
    .asciz "Boot failed, strike 3"

    @ 0x8003E08
aBootFailedStri:
    .asciz "Boot failed, strike 2"

    @ 0x8003E1E
aBootFailedSt_1:
    .asciz "Boot failed, strike 1"

    @ 0x8003E34
aLoadingRecover:
    .asciz "Loading recovery firmware"

    @ 0x8003E4E
aFailedToLoad_1:
    .asciz "Failed to load recovery firmware, strike one. Try again."

    @ 0x8003E87
aFailedToLoad_0:
    .asciz "Failed to load recovery firmware, strike two. Try again."

    @ 0x8003EC0
aFailedToLoadRe:
    .asciz "Failed to load recovery firmware, strike three. SAD WATCH"

    @ 0x8003EFA
aOurPreviousFir:
    .asciz "Our previous firmware update failed, aborting update."

    @ 0x8003F30
aNewFirmwareIsA:
    .asciz "New firmware is available!"

    @ 0x8003F4B
aBootingFirmwar:
    .asciz "Booting firmware @ "

    @ 0x8003F5F
aReturningToSta:
    .asciz "returning to standby"

    @ 0x8003F74
aForceBootingRe:
    .asciz "Force-booting recovery mode..."

    @ 0x8003F93
aBack:
    .asciz "Back"

    @ 0x8003F98
aUp:
    .asciz "Up"

    @ 0x8003F9B
aSelect:
    .asciz "Select"

    @ 0x8003FA2
aDown:
    .asciz "Down"

    @ 0x8003FA7
    .global a0123456789ab_0
a0123456789ab_0:
    .asciz "0123456789ABCDEF"

    @ 0x8003FB8
    .global a0123456789abcd
a0123456789abcd:
    .asciz "0123456789abcdef"

    @ 0x8003FC9
    .global aNull
aNull:
    .asciz "(null)"

    @ 0x8003FD0
    .global _8003FD0
_8003FD0:
    .4byte 0x0
    .byte 0x01
    .byte 0x2
    .byte 0x3
    .byte 0x4
    .4byte 0x4030201
    .4byte 0x9080706

