.thumb
.syntax unified
.section .text.asm

    @ 0x8002FEC
    .global fault_entry
    .thumb_func
fault_entry:
    tst.w lr, #4
    ite eq
    mrseq r0, msp
    mrsne r0, psp
    b.w hardfault
    bx lr

    @ 0x8003000
    .global sub_8003000
    .thumb_func
sub_8003000:
    cmp r1, #3
    push {r4, r5, r6, lr}
    mov r5, r0
    mov r4, r1
    bls.n loc_8003018
    lsrs r6, r1, #2
    mov r1, r6
    bl CRC_CalcBlockCRC
    lsls r6, r6, #2
    add r5, r6
    subs r4, r4, r6

    @ 0x8003018
loc_8003018:
    cbnz R4, loc_8003020
    bl CRC_GetCRC
    pop {r4, r5, r6, pc}

    @ 0x8003020
loc_8003020:
    movs r3, #0
    mov r0, r3

    @ 0x8003024
loc_8003024:
    ldrb r2, [r5, r3]
    adds r3, #1
    cmp r3, r4
    orr.w r0, r2, r0, lsl #8
    bne.n loc_8003024
    bl CRC_CalcCRC
    pop {r4, r5, r6, pc}

    @ 0x8003036
    .global bitblt
    .thumb_func
bitblt:
    push.w {r4, r5, r6, r7, r8, lr}
    adds r3, #7
    lsrs r6, r3, #3
    ldr r3, [sp, #0x1c]
    mov.w r8, #0x12
    mla r2, r8, r2, r3
    adds r1, #7
    ldr r7, [sp, #0x18]
    mov r5, r0
    add.w r8, r2, r1, lsr #3
    movs r4, #0

    @ 0x8003054
loc_8003054:
    cmp r4, r7
    beq.n loc_800306C
    movs r0, #0x12
    mla r0, r0, r4, r8
    mov r1, r5
    mov r2, r6
    bl memcpy
    adds r4, #1
    add r5, r6
    b.n loc_8003054

    @ 0x800306C
loc_800306C:
    pop.w {r4, r5, r6, r7, r8, pc}

    @ 0x8003070
    .global usleep_spin
    .thumb_func
usleep_spin:
    movs r3, #6
    muls r0, r3, r0

    @ 0x8003074
loc_8003074:
    subs r0, #1
    bne.w loc_8003074
    bx lr

    @ 0x800307C
    .global boot_status_test
    .thumb_func
boot_status_test:
    push {r4, lr}
    mov r4, r0
    movs r0, #0
    bl rtc_backup_get
    tst r0, r4
    ite eq
    moveq r0, #0
    movne r0, #1
    pop {r4, pc}

    @ 0x8003090
    .global boot_status_clear
    .thumb_func
boot_status_clear:
    push {r4, lr}
    mov r4, r0
    movs r0, #0
    bl rtc_backup_get
    bic.w r1, r0, r4
    movs r0, #0
    bl rtc_backup_set
    pop {r4, pc}

    @ 0x80030A6
    .global boot_status_set
    .thumb_func
boot_status_set:
    push {r4, lr}
    mov r4, r0
    movs r0, #0
    bl rtc_backup_get
    orr.w r1, r0, r4
    movs r0, #0
    bl rtc_backup_set
    pop {r4, pc}

    @ 0x80030BC
    .global sub_80030BC
    .thumb_func
sub_80030BC:
    push {r0, r1, r2, r3, r4, lr}
    add r0, sp, #4
    bl sub_800118E
    movs r3, #7
    str r3, [sp, #8]
    add r0, sp, #4
    movs r3, #3
    str r3, [sp, #0xc]
    bl sub_8000C4C
    mov r0, sp
    bl sub_800119A
    mov r1, sp
    movs r0, #0
    bl sub_8000CD4
    add sp, #0x14
    ldr pc, [sp], #4

    @ 0x80030E6
    .global pebble_sys_reset
    .thumb_func
pebble_sys_reset:
    push {r3, lr}
    bl display_cs_set
    movs r0, #0
    bl spi2_write
    movs r0, #0
    bl spi2_write
    movs r0, #0
    bl spi2_write
    bl display_cs_clear
    bl rcc_set_csr_rmvf
    bl cortex_m3_system_reset

    @ 0x800310A
    .global display_blit
    .thumb_func
display_blit:
    push {r4, r5, r6, lr}
    mov r6, r0
    bl display_cs_set
    movs r0, #0x80
    bl spi2_write
    movs r4, #0xa8

    @ 0x800311A
loc_800311A:
    rev r0, r4
    rbit r0, r0
    uxtb r0, r0
    bl spi2_write
    movs r5, #0x11

    @ 0x8003128
loc_8003128:
    ldrb r0, [r6, r5]
    bl spi2_write
    adds.w r5, r5, #-1
    bhs.n loc_8003128
    movs r0, #0
    bl spi2_write
    subs r4, #1
    add.w r6, r6, #0x12
    bne.n loc_800311A
    mov r0, r4
    bl spi2_write
    bl display_cs_clear
    pop {r4, r5, r6, pc}

    @ 0x800314E
    .global button_read_all
    .thumb_func
button_read_all:
    push {r3, r4, r5, lr}
    movs r4, #0
    mov r5, r4

    @ 0x8003154
loc_8003154:
    uxtb r0, r4
    bl button_read
    lsls r0, r4
    adds r4, #1
    orrs r5, r0
    cmp r4, #4
    uxtb r5, r5
    bne.n loc_8003154
    mov r0, r5
    pop {r3, r4, r5, pc}

    @ 0x800316A
    .global putnewline
    .thumb_func
putnewline:
    push {r3, lr}
    movs r0, #0xd
    bl putchar
    movs r0, #0xa
    bl putchar
    pop {r3, pc}

    @ 0x800317A
    .global puts
    .thumb_func
puts:
    push {r4, lr}
    subs r4, r0, #1

    @ 0x800317E
loc_800317E:
    ldrb r0, [r4, #1]!
    cbz R0, loc_800318A
    bl putchar
    b.n loc_800317E

    @ 0x800318A
loc_800318A:
    pop {r4, pc}

    @ 0x800318C
    .global putsnl
    .thumb_func
putsnl:
    push {r3, lr}
    bl puts
    bl putnewline
    pop {r3, pc}

    @ 0x8003198
    .global puthex
    .thumb_func
puthex:
    push {r0, r1, r2, r3, r4, lr}
    movs r3, #0x30
    strb.w r3, [sp, #4]
    movs r3, #0x78
    strb.w r3, [sp, #5]
    movs r3, #7

    @ 0x80031A8
loc_80031A8:
    lsls r1, r3, #2
    movs r2, #0xf
    lsls r2, r1
    ands r2, r0
    lsrs r2, r1
    cmp r2, #9
    bhi.n loc_80031BA
    adds r2, #0x30
    b.n loc_80031C0

    @ 0x80031BA
loc_80031BA:
    cmp r2, #0xf
    bhi.n loc_80031C4
    adds r2, #0x57

    @ 0x80031C0
loc_80031C0:
    uxtb r2, r2
    b.n loc_80031C6

    @ 0x80031C4
loc_80031C4:
    movs r2, #0x20

    @ 0x80031C6
loc_80031C6:
    add r1, sp, #4
    subs r4, r1, r3
    adds.w r3, r3, #-1
    strb r2, [r4, #9]
    bhs.n loc_80031A8
    movs r3, #0
    mov r0, r1
    strb.w r3, [sp, #0xe]
    bl puts
    add sp, #0x10
    pop {r4, pc}

    @ 0x80031E2
    .global sub_80031E2
    .thumb_func
sub_80031E2:
    push {r4, r5, r6, lr}
    mov r4, r0
    mov r5, r1
    mov.w r0, #0x1000
    movs r1, #1
    mov r6, r2
    bl rcc_set_apb2_enable
    bl spiflash_enable_cs
    movs r0, #5
    bl spi1_write_read

    @ 0x80031FE
loc_80031FE:
    movs r0, #0xa9
    bl spi1_write_read
    lsls r3, r0, #0x1f
    bmi.n loc_80031FE
    bl spiflash_disable_cs
    bl spiflash_enable_cs
    movs r0, #3
    bl spi1_write_read
    ubfx r0, r5, #0x10, #8
    bl spi1_write_read
    ubfx r0, r5, #8, #8
    bl spi1_write_read
    uxtb r0, r5
    bl spi1_write_read
    add r6, r4

    @ 0x800322E
loc_800322E:
    cmp r4, r6
    beq.n loc_800323E
    movs r0, #0xa9
    bl spi1_write_read
    strb r0, [r4], #1
    b.n loc_800322E

    @ 0x800323E
loc_800323E:
    bl spiflash_disable_cs
    mov.w r0, #0x1000
    movs r1, #0
    bl rcc_set_apb2_enable
    pop {r4, r5, r6, pc}
