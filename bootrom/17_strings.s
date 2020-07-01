.thumb
.syntax unified
.section .text.asm

    @ 0x8002CC0
    .global sub_8002CC0
    .thumb_func
sub_8002CC0:
    push.w {r4, r5, r6, r7, r8, sb, sl, fp, lr}
    ldrd sl, fp, [sp, #0x24]
    mov r6, r1
    mov ip, r3

    @ 0x8002CCC
loc_8002CCC:
    ldrb r3, [r0]
    ldr r1, [pc, #0xec]
    mov r7, r0
    ldrb r1, [r1, r3]
    adds r0, #1
    lsls r5, r1, #0x1c
    bmi.n loc_8002CCC
    cmp r3, #0x2b
    beq.n loc_8002CEA
    cmp r3, #0x2d
    bne.n loc_8002CEC
    mov r7, r0
    mov.w r3, #-1
    b.n loc_8002CEE

    @ 0x8002CEA
loc_8002CEA:
    mov r7, r0

    @ 0x8002CEC
loc_8002CEC:
    movs r3, #1

    @ 0x8002CEE
loc_8002CEE:
    ldrb r1, [r7]
    cmp r1, #0x30
    bne.n loc_8002D12
    ldrb r1, [r7, #1]
    cmp r1, #0x78
    bne.n loc_8002D06
    bics r1, r2, #0x10
    bne.n loc_8002D08
    adds r7, #2
    movs r2, #0x10
    b.n loc_8002D16

    @ 0x8002D06
loc_8002D06:
    cbz R2, loc_8002D0C

    @ 0x8002D08
loc_8002D08:
    cmp r2, #8
    bne.n loc_8002D16

    @ 0x8002D0C
loc_8002D0C:
    adds r7, #1
    movs r2, #8
    b.n loc_8002D16

    @ 0x8002D12
loc_8002D12:
    cbnz R2, loc_8002D16
    movs r2, #0xa

    @ 0x8002D16
loc_8002D16:
    movs r0, #0
    movs r1, #0

    @ 0x8002D1A
loc_8002D1A:
    mov r8, r7
    ldrb r5, [r7], #1
    sub.w r4, r5, #0x30
    uxtb r4, r4
    cmp r4, #9
    bls.n loc_8002D46
    sub.w r4, r5, #0x41
    cmp r4, #0x19
    bhi.n loc_8002D38
    sub.w r4, r5, #0x37
    b.n loc_8002D44

    @ 0x8002D38
loc_8002D38:
    sub.w r4, r5, #0x61
    cmp r4, #0x19
    bhi.n loc_8002DA2
    sub.w r4, r5, #0x57

    @ 0x8002D44
loc_8002D44:
    uxtb r4, r4

    @ 0x8002D46
loc_8002D46:
    cmp r4, r2
    bge.n loc_8002DA2
    asr.w sb, r2, #0x1f
    mul r5, r0, sb
    mla r5, r2, r1, r5
    umull r0, r1, r0, r2
    uxtb r4, r4
    add r1, r5
    adds r0, r0, r4
    mov.w r5, #0
    adc.w r1, r1, r5
    cmp.w ip, #0
    beq.n loc_8002D1A
    cmp r3, #1
    bne.n loc_8002D80
    cmp sl, r0
    sbcs.w r4, fp, r1
    bge.n loc_8002D1A
    mov r0, sl
    mov r1, fp
    b.n loc_8002D1A

    @ 0x8002D80
loc_8002D80:
    adds r4, r3, #1
    bne.n loc_8002D1A
    ldrd r8, sb, [sp, #0x2c]
    rsbs r4, r0, #0
    sbc.w r5, r1, r1, lsl #1
    cmp r4, r8
    sbcs.w sb, r5, sb
    bge.n loc_8002D1A
    ldrd r0, r1, [sp, #0x2c]
    rsbs r0, r0, #0
    sbc.w r1, r1, r1, lsl #1
    b.n loc_8002D1A

    @ 0x8002DA2
loc_8002DA2:
    cbz R6, loc_8002DA8
    str.w r8, [r6]

    @ 0x8002DA8
loc_8002DA8:
    asrs r5, r3, #0x1f
    mul r2, r0, r5
    mla r2, r3, r1, r2
    umull r0, r1, r0, r3
    add r1, r2
    pop.w {r4, r5, r6, r7, r8, sb, sl, fp, pc}

    @ 0x8002DBC
_8002DBC:
    .4byte 0x800124C

    @ 0x8002DC0
    .global sub_8002DC0
    .thumb_func
sub_8002DC0:
    push.w {r4, r5, r6, r7, r8, sb, sl, fp, lr}
    sub sp, #0x44
    ldr r6, [sp, #0x7c]
    mov r4, r1
    lsls r1, r6, #0x18
    mov sb, r2
    mov r8, r0
    ldrd r2, r3, [sp, #0x68]
    ldr r5, [sp, #0x78]
    bpl.n loc_8002DE2
    strd r2, r3, [sp, #8]
    mov.w ip, #0
    b.n loc_8002E1A

    @ 0x8002DE2
loc_8002DE2:
    cmp r2, #0
    sbcs r7, r3, #0
    mov r0, r2
    mov r1, r3
    bge.n loc_8002DF4
    rsbs r0, r2, #0
    sbc.w r1, r3, r3, lsl #1

    @ 0x8002DF4
loc_8002DF4:
    cmp r2, #0
    sbcs sl, r3, #0
    strd r0, r1, [sp, #8]
    blt.n loc_8002E10
    lsls r7, r6, #0x1e
    bmi.n loc_8002E16
    ands ip, r6, #4
    beq.n loc_8002E1A
    mov.w ip, #0x20
    b.n loc_8002E1A

    @ 0x8002E10
loc_8002E10:
    mov.w ip, #0x2d
    b.n loc_8002E1A

    @ 0x8002E16
loc_8002E16:
    mov.w ip, #0x2b

    @ 0x8002E1A
loc_8002E1A:
    ands r7, r6, #0x40
    str r7, [sp, #0x20]
    ite ne
    ldrne r7, [pc, #0x1c0]
    ldreq R7, _8002FE8
    ldrd sl, fp, [sp, #8]
    str r7, [sp, #0x1c]
    movs r7, #0

    @ 0x8002E2E
loc_8002E2E:
    ldr r0, [sp, #0x70]
    adds r7, #1
    asrs r1, r0, #0x1f
    strd r0, r1, [sp, #0x10]
    ldrd r2, r3, [sp, #0x10]
    add r1, sp, #0x28
    add r1, r7
    str r1, [sp, #0x24]
    mov r0, sl
    mov r1, fp
    str.w ip, [sp, #4]
    bl sub_800134C
    ldr r0, [sp, #0x1c]
    ldr r1, [sp, #0x24]
    ldrb r3, [r0, r2]
    mov r0, sl
    strb r3, [r1, #-0x1]
    mov r1, fp
    ldrd r2, r3, [sp, #0x10]
    bl sub_800134C
    mov sl, r0
    mov fp, r1
    orrs.w r2, sl, fp
    ldr.w ip, [sp, #4]
    beq.n loc_8002E76
    cmp r7, #0x16
    bne.n loc_8002E2E

    @ 0x8002E76
loc_8002E76:
    ands r2, r6, #8
    mov r1, r7
    beq.n loc_8002EBA
    ldr r3, [sp, #0x70]
    cmp r3, #8
    beq.n loc_8002E8A
    cmp r3, #0x10
    beq.n loc_8002EA6
    b.n loc_8002EC4

    @ 0x8002E8A
loc_8002E8A:
    ldrd sl, fp, [sp, #8]
    cbnz R5, loc_8002E98
    orrs.w fp, sl, fp
    beq.n loc_8002EBE
    b.n loc_8002EA2

    @ 0x8002E98
loc_8002E98:
    orrs.w fp, sl, fp
    beq.n loc_8002EC4
    cmp r5, r7
    bgt.n loc_8002EC4

    @ 0x8002EA2
loc_8002EA2:
    adds r3, r7, #1
    b.n loc_8002EC6

    @ 0x8002EA6
loc_8002EA6:
    ldrd sl, fp, [sp, #8]
    orrs.w fp, sl, fp
    beq.n loc_8002EC4
    ldr r0, [sp, #0x20]
    mov r3, r5
    cbz R0, loc_8002ECA
    movs r2, #0x58
    b.n loc_8002ECC

    @ 0x8002EBA
loc_8002EBA:
    mov r3, r5
    b.n loc_8002ECC

    @ 0x8002EBE
loc_8002EBE:
    mov r2, r5
    movs r3, #1
    b.n loc_8002ECC

    @ 0x8002EC4
loc_8002EC4:
    mov r3, r5

    @ 0x8002EC6
loc_8002EC6:
    movs r2, #0
    b.n loc_8002ECC

    @ 0x8002ECA
loc_8002ECA:
    movs r2, #0x78

    @ 0x8002ECC
loc_8002ECC:
    adds.w fp, ip, #0
    ldr r0, [sp, #0x74]
    rsb sl, r7, r3
    it ne
    movne.w fp, #1
    cmp r3, r7
    it ge
    movge r7, r3
    subs r0, r0, r7
    bic.w sl, sl, sl, asr #31
    rsb r0, fp, r0
    cbz R2, loc_8002EF2
    movs r7, #2
    b.n loc_8002EF4

    @ 0x8002EF2
loc_8002EF2:
    mov r7, r2

    @ 0x8002EF4
loc_8002EF4:
    subs r7, r0, r7
    ands r0, r6, #1
    bic.w r7, r7, r7, asr #31
    beq.n loc_8002F04
    rsbs r7, r7, #0
    b.n loc_8002F10

    @ 0x8002F04
loc_8002F04:
    lsls r6, r6, #0x1b
    bpl.n loc_8002F10
    adds r5, #1
    itt eq
    addeq sl, r7
    moveq r7, r0

    @ 0x8002F10
loc_8002F10:
    mov r5, r7

    @ 0x8002F12
loc_8002F12:
    cmp r5, #0
    ble.n loc_8002F2E
    ldr r0, [r4]
    subs r5, #1
    adds r6, r0, #1
    cmp r6, sb
    itt lo
    movlo r6, #0x20
    strblo.w r6, [r8, r0]
    ldr r0, [r4]
    adds r0, #1
    str r0, [r4]
    b.n loc_8002F12

    @ 0x8002F2E
loc_8002F2E:
    bic.w r0, r7, r7, asr #31
    subs r7, r7, r0
    cmp.w fp, #0
    beq.n loc_8002F4C
    ldr r0, [r4]
    adds r5, r0, #1
    cmp r5, sb
    it lo
    strblo.w ip, [r8, r0]
    ldr r0, [r4]
    adds r0, #1
    str r0, [r4]

    @ 0x8002F4C
loc_8002F4C:
    cbz R2, loc_8002F72
    ldr r0, [r4]
    adds r5, r0, #1
    cmp r5, sb
    itt lo
    movlo r5, #0x30
    strblo.w r5, [r8, r0]
    ldr r5, [r4]
    adds r0, r5, #1
    adds r5, #2
    cmp r5, sb
    str r0, [r4]
    it lo
    strblo.w r2, [r8, r0]
    ldr r2, [r4]
    adds r2, #1
    str r2, [r4]

    @ 0x8002F72
loc_8002F72:
    cmp.w sl, #0
    beq.n loc_8002F92
    ldr r2, [r4]
    add.w sl, sl, #-1
    adds r0, r2, #1
    cmp r0, sb
    itt lo
    movlo r0, #0x30
    strblo.w r0, [r8, r2]
    ldr r2, [r4]
    adds r2, #1
    str r2, [r4]
    b.n loc_8002F72

    @ 0x8002F92
loc_8002F92:
    ldrd sl, fp, [sp, #8]
    orrs.w fp, sl, fp
    bne.n loc_8002FBE
    cbnz R3, loc_8002FBE
    mov r1, r3
    b.n loc_8002FBE

    @ 0x8002FA2
loc_8002FA2:
    ldr r3, [r4]
    subs r1, #1
    adds r2, r3, #1
    cmp r2, sb
    bhs.n loc_8002FB8
    add.w r5, r1, #0x28
    mov r0, sp
    ldrb r2, [r5, r0]
    strb.w r2, [r8, r3]

    @ 0x8002FB8
loc_8002FB8:
    ldr r3, [r4]
    adds r3, #1
    str r3, [r4]

    @ 0x8002FBE
loc_8002FBE:
    cmp r1, #0
    bne.n loc_8002FA2

    @ 0x8002FC2
loc_8002FC2:
    cbz R7, loc_8002FDC
    ldr r3, [r4]
    adds r7, #1
    adds r2, r3, #1
    cmp r2, sb
    itt lo
    movlo r2, #0x20
    strblo.w r2, [r8, r3]
    ldr r3, [r4]
    adds r3, #1
    str r3, [r4]
    b.n loc_8002FC2

    @ 0x8002FDC
loc_8002FDC:
    add sp, #0x44
    pop.w {r4, r5, r6, r7, r8, sb, sl, fp, pc}
    .align 2

    @ 0x8002FE4
_8002FE4:
    .4byte a0123456789ab_0

    @ 0x8002FE8
_8002FE8:
    .4byte a0123456789abcd
