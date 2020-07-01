.include "constants.s"

.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x8000BFC
    .thumb_func
sub_8000BFC:
    movs r3, #0
    sub sp, #8
    str r3, [sp, #4]
    ldr r3, [pc, #0x34]
    ldr r2, [r3, #0xc]
    lsls r2, r2, #0x19
    bmi.n loc_8000C32
    mov.w r2, #-1
    str r2, [r3, #0xc]

    @ 0x8000C10
loc_8000C10:
    ldr r3, [pc, #0x24]
    ldr r2, [r3, #0xc]
    ldr r1, [sp, #4]
    and r2, r2, #0x40
    adds r1, #1
    str r1, [sp, #4]
    ldr r1, [sp, #4]
    cmp.w r1, #0x10000
    beq.n loc_8000C2A
    cmp r2, #0
    beq.n loc_8000C10

    @ 0x8000C2A
loc_8000C2A:
    ldr r0, [r3, #0xc]
    ubfx r0, r0, #6, #1
    b.n loc_8000C34

    @ 0x8000C32
loc_8000C32:
    movs r0, #1

    @ 0x8000C34
loc_8000C34:
    add sp, #8
    bx lr

    @ 0x8000C38
_8000C38:
    .4byte 0x40002800

    @ 0x8000C3C
    .thumb_func
sub_8000C3C:
    ldr r3, [pc, #8]
    ldr r2, [r3, #0xc]
    bic r2, r2, #0x80
    str r2, [r3, #0xc]
    bx lr

    @ 0x8000C48
_8000C48:
    .4byte 0x40002800

    @ 0x8000C4C
    .global sub_8000C4C
    .thumb_func
sub_8000C4C:
    push {r3, r4, r5, lr}
    ldr r4, [pc, #0x3c]
    movs r3, #0xca
    str r3, [r4, #0x24]
    movs r3, #0x53
    str r3, [r4, #0x24]
    mov r5, r0
    bl sub_8000BFC
    cbz R0, loc_8000C84
    ldr r3, [r4, #8]
    bic r3, r3, #0x40
    str r3, [r4, #8]
    ldr r2, [r4, #8]
    ldr r3, [r5]
    orrs r3, r2
    str r3, [r4, #8]
    ldr r3, [r5, #8]
    str r3, [r4, #0x10]
    ldr r3, [r4, #0x10]
    ldr r2, [r5, #4]
    orr.w r3, r3, r2, lsl #16
    str r3, [r4, #0x10]
    bl sub_8000C3C
    movs r0, #1

    @ 0x8000C84
loc_8000C84:
    ldr r3, [pc, #4]
    movs r2, #0xff
    str r2, [r3, #0x24]
    pop {r3, r4, r5, pc}

    @ 0x8000C8C
_8000C8C:
    .4byte 0x40002800

    @ 0x8000C90
    .global sub_8000C90
    .thumb_func
sub_8000C90:
    movs r3, #0
    sub sp, #8
    str r3, [sp, #4]
    ldr r3, [pc, #0x38]
    movs r2, #0xca
    str r2, [r3, #0x24]
    movs r2, #0x53
    str r2, [r3, #0x24]
    ldr r2, [r3, #0xc]
    bic r2, r2, #0xa0
    str r2, [r3, #0xc]

    @ 0x8000CA8
loc_8000CA8:
    ldr r3, [pc, #0x24]
    ldr r2, [r3, #0xc]
    ldr r1, [sp, #4]
    and r2, r2, #0x20
    adds r1, #1
    str r1, [sp, #4]
    ldr r1, [sp, #4]
    cmp.w r1, #0x8000
    beq.n loc_8000CC2
    cmp r2, #0
    beq.n loc_8000CA8

    @ 0x8000CC2
loc_8000CC2:
    ldr r0, [r3, #0xc]
    movs r2, #0xff
    ubfx r0, r0, #5, #1
    str r2, [r3, #0x24]
    add sp, #8
    bx lr

    @ 0x8000CD0
_8000CD0:
    .4byte 0x40002800

    @ 0x8000CD4
    .global sub_8000CD4
    .thumb_func
sub_8000CD4:
    ldr r2, [pc, #0x88]
    push.w {r4, r5, r6, r7, r8, lr}
    ldrb r3, [r1]
    mov r4, r1
    ldrb r7, [r1, #1]
    ldrb r6, [r1, #2]
    ldr r2, [r2, #8]
    cbnz R0, loc_8000CF0
    ands r2, r2, #0x40
    bne.n loc_8000D38
    strb r2, [r1, #3]
    b.n loc_8000D38

    @ 0x8000CF0
loc_8000CF0:
    ands r2, r2, #0x40
    bne.n loc_8000CF8
    strb r2, [r1, #3]

    @ 0x8000CF8
loc_8000CF8:
    lsls r7, r7, #8
    orr.w r3, r7, r3, lsl #16
    ldrb r5, [r4, #3]
    orrs r6, r3
    orr.w r5, r6, r5, lsl #16

    @ 0x8000D06
loc_8000D06:
    ldr r4, [pc, #0x58]
    movs r3, #0xca
    str r3, [r4, #0x24]
    movs r3, #0x53
    str r3, [r4, #0x24]
    bl sub_8000BFC
    cbz R0, loc_8000D2E
    and r0, r5, #0x7f7f7f7f
    bic r0, r0, #0x7f000000
    str r0, [r4]
    bl sub_8000C3C
    bl sub_8000C90
    adds r0, #0
    it ne
    movne r0, #1

    @ 0x8000D2E
loc_8000D2E:
    ldr r3, [pc, #0x30]
    movs r2, #0xff
    str r2, [r3, #0x24]
    pop.w {r4, r5, r6, r7, r8, pc}

    @ 0x8000D38
loc_8000D38:
    mov r0, r3
    bl conv_to_bcd
    mov r8, r0
    mov r0, r7
    bl conv_to_bcd
    mov r7, r0
    mov r0, r6
    bl conv_to_bcd
    ldrb r5, [r4, #3]
    orr.w r0, r0, r5, lsl #16
    orr.w r5, r0, r8, lsl #16
    orr.w r5, r5, r7, lsl #8
    b.n loc_8000D06
    .align 2

    @ 0x8000D60
_8000D60:
    .4byte 0x40002800

    @ 0x8000D64
    .global sub_8000D64
    .thumb_func
sub_8000D64:
    ldr r3, [pc, #0x3c]
    push {r4, r5, r6, lr}
    ldr r3, [r3]
    mov r4, r1
    ubfx r2, r3, #0x10, #6
    ubfx r6, r3, #8, #7
    and r5, r3, #0x7f
    and r3, r3, #0x400000
    lsrs r3, r3, #0x10
    strb r2, [r1]
    strb r6, [r1, #1]
    strb r5, [r1, #2]
    strb r3, [r1, #3]
    cbnz R0, loc_8000DA0
    mov r0, r2
    bl conv_from_bcd
    strb r0, [r4]
    mov r0, r6
    bl conv_from_bcd
    strb r0, [r4, #1]
    mov r0, r5
    bl conv_from_bcd
    strb r0, [r4, #2]

    @ 0x8000DA0
loc_8000DA0:
    pop {r4, r5, r6, pc}
    .align 2

    @ 0x8000DA4
_8000DA4:
    .4byte 0x40002800

    @ 0x8000DA8
    .global sub_8000DA8
    .thumb_func
sub_8000DA8:
    push.w {r4, r5, r6, r7, r8, lr}
    mov r4, r1
    ldrb r3, [r1, #1]
    ldrb r2, [r1, #3]
    ldrb r7, [r1, #2]
    ldrb r6, [r1]
    cbnz R0, loc_8000E18
    lsls r1, r3, #0x1b
    bpl.n loc_8000DC4
    bic r3, r3, #0x10
    adds r3, #0xa
    strb r3, [r4, #1]

    @ 0x8000DC4
loc_8000DC4:
    mov r0, r2
    bl conv_to_bcd
    mov r8, r0
    ldrb r0, [r4, #1]
    bl conv_to_bcd
    mov r4, r0
    mov r0, r7
    bl conv_to_bcd
    orr.w r0, r0, r6, lsl #13
    orr.w r5, r0, r8, lsl #16
    orr.w r5, r5, r4, lsl #8

    @ 0x8000DE6
loc_8000DE6:
    ldr r4, [pc, #0x40]
    movs r3, #0xca
    str r3, [r4, #0x24]
    movs r3, #0x53
    str r3, [r4, #0x24]
    bl sub_8000BFC
    cbz R0, loc_8000E0E
    bic r3, r5, #0xff000000
    bic r3, r3, #0xc0
    str r3, [r4, #4]
    bl sub_8000C3C
    bl sub_8000C90
    adds r0, #0
    it ne
    movne r0, #1

    @ 0x8000E0E
loc_8000E0E:
    ldr r3, [pc, #0x18]
    movs r2, #0xff
    str r2, [r3, #0x24]
    pop.w {r4, r5, r6, r7, r8, pc}

    @ 0x8000E18
loc_8000E18:
    lsls r5, r3, #8
    orr.w r5, r5, r2, lsl #16
    orrs r5, r7
    orr.w r5, r5, r6, lsl #13
    b.n loc_8000DE6
    .align 2

    @ 0x8000E28
_8000E28:
    .4byte 0x40002800

    @ 0x8000E2C
    .global sub_8000E2C
    .thumb_func
sub_8000E2C:
    ldr r3, [pc, #0x38]
    push {r4, r5, r6, lr}
    ldr r3, [r3, #4]
    mov r4, r1
    ubfx r2, r3, #0x10, #8
    ubfx r6, r3, #8, #5
    and r5, r3, #0x3f
    ubfx r3, r3, #0xd, #3
    strb r2, [r1, #3]
    strb r6, [r1, #1]
    strb r5, [r1, #2]
    strb r3, [r1]
    cbnz R0, loc_8000E66
    mov r0, r2
    bl conv_from_bcd
    strb r0, [r4, #3]
    mov r0, r6
    bl conv_from_bcd
    strb r0, [r4, #1]
    mov r0, r5
    bl conv_from_bcd
    strb r0, [r4, #2]

    @ 0x8000E66
loc_8000E66:
    pop {r4, r5, r6, pc}

    @ 0x8000E68
_8000E68:
    .4byte 0x40002800

    @ 0x8000E6C
    .global sub_8000E6C
    .thumb_func
sub_8000E6C:
    ldr r3, [pc, #0x20]
    ldr r2, [r3, #8]
    bic r2, r2, #0x800
    bic r2, r2, #8
    cbz R1, loc_8000E7E
    orr r2, r2, #0x800

    @ 0x8000E7E
loc_8000E7E:
    orrs r0, r2
    movs r2, #0xca
    str r2, [r3, #0x24]
    movs r2, #0x53
    str r2, [r3, #0x24]
    movs r2, #0xff
    str r0, [r3, #8]
    str r2, [r3, #0x24]
    bx lr

    @ 0x8000E90
_8000E90:
    .4byte 0x40002800

    @ 0x8000E94
    .global rtc_backup_set
    .thumb_func
rtc_backup_set:
    sub sp, #8
    movs r3, #0
    str r3, [sp, #4]
    ldr R3, _8000EB0
    str r3, [sp, #4]
    ldr r3, [sp, #4]
    add.w r0, r3, r0, lsl #2
    str r0, [sp, #4]
    ldr r3, [sp, #4]
    str r1, [r3]
    add sp, #8
    bx lr
    .align 2

    @ 0x8000EB0
_8000EB0:
    .4byte RTC_BASE+80

    @ 0x8000EB4
    .global rtc_backup_get
    .thumb_func
rtc_backup_get:
    sub sp, #8
    movs r3, #0
    str r3, [sp, #4]
    ldr r3, [pc, #0x14]
    str r3, [sp, #4]
    ldr r3, [sp, #4]
    add.w r0, r3, r0, lsl #2
    str r0, [sp, #4]
    ldr r3, [sp, #4]
    ldr r0, [r3]
    add sp, #8
    bx lr
    .align 2

    @ 0x8000ED0
_8000ED0:
    .4byte 0x40002850

    @ 0x8000ED4
    .global sub_8000ED4
    .thumb_func
sub_8000ED4:
    ldr r3, [pc, #0x10]
    ldr r2, [r3, #0x40]
    bic r2, r2, #0x20000
    str r2, [r3, #0x40]
    ldr r2, [r3, #0x40]
    orrs r0, r2
    str r0, [r3, #0x40]
    bx lr
    .align 2

    @ 0x8000EE8
_8000EE8:
    .4byte 0x40002800

    @ 0x8000EEC
    .global sub_8000EEC
    .thumb_func
sub_8000EEC:
    ldr r3, [pc, #0x34]
    movs r2, #0xca
    str r2, [r3, #0x24]
    movs r2, #0x53
    str r2, [r3, #0x24]
    bic r2, r0, #4
    and r0, r0, #4
    cbz R1, loc_8000F0C
    ldr r1, [r3, #8]
    orrs r2, r1
    str r2, [r3, #8]
    ldr r2, [r3, #0x40]
    orrs r0, r2
    b.n loc_8000F1A

    @ 0x8000F0C
loc_8000F0C:
    ldr r1, [r3, #8]
    bic.w r2, r1, r2
    str r2, [r3, #8]
    ldr r2, [r3, #0x40]
    bic.w r0, r2, r0

    @ 0x8000F1A
loc_8000F1A:
    str r0, [r3, #0x40]
    ldr r3, [pc, #4]
    movs r2, #0xff
    str r2, [r3, #0x24]
    bx lr

    @ 0x8000F24
_8000F24:
    .4byte 0x40002800

    @ 0x8000F28
    .global sub_8000F28
    .thumb_func
sub_8000F28:
    ldr r3, [pc, #0x14]
    ldr r3, [r3, #0xc]
    bic r3, r3, #0x88
    lsls r3, r3, #0x12
    lsrs r3, r3, #0x12
    tst r3, r0
    ite eq
    moveq r0, #0
    movne r0, #1
    bx lr
    .align 2

    @ 0x8000F40
_8000F40:
    .4byte 0x40002800

    @ 0x8000F44
    .global sub_8000F44
    .thumb_func
sub_8000F44:
    ldr r3, [pc, #0x14]
    uxth r0, r0
    ldr r2, [r3, #0xc]
    orr r0, r0, #0x80
    and r2, r2, #0x80
    orn r2, r2, r0
    str r2, [r3, #0xc]
    bx lr
    .align 2

    @ 0x8000F5C
_8000F5C:
    .4byte 0x40002800
