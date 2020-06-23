
    @ 0x8000000
_8000000:
    .4byte 0x20012048
    .4byte _entry + 1
    .4byte fault_entry + 1
    .4byte fault_entry + 1
    .4byte fault_entry + 1
    .4byte fault_entry + 1
    .4byte fault_entry + 1
    .4byte 0x0
    .4byte 0x0
    .4byte 0x0
    .4byte 0x0
    .4byte fault_entry + 1
    .4byte fault_entry + 1
    .4byte 0x0
    .4byte fault_entry + 1
    .4byte fault_entry + 1
    .4byte 0x139C
    .4byte 0x1

    @ 0x8000048
    .thumb_func
memcpy:
    push {r4, lr}
    movs r3, #0

    @ 0x800004C
loc_800004C:
    cmp r3, r2
    beq.n loc_8000058
    ldrb r4, [r1, r3]
    strb r4, [r0, r3]
    adds r3, #1
    b.n loc_800004C

    @ 0x8000058
loc_8000058:
    pop {r4, pc}

    @ 0x800005A
    .thumb_func
memset:
    add r2, r0
    mov r3, r0

    @ 0x800005E
loc_800005E:
    cmp r3, r2
    beq.n loc_8000068
    strb r1, [r3], #1
    b.n loc_800005E

    @ 0x8000068
loc_8000068:
    bx lr

    @ 0x800006A
    .thumb_func
sub_800006A:
    push {r4, lr}
    uxtb r1, r1
    add r2, r0

    @ 0x8000070
loc_8000070:
    cmp r0, r2
    beq.n loc_8000082
    mov r3, r0
    ldrb r4, [r3]
    adds r0, #1
    cmp r4, r1
    bne.n loc_8000070
    mov r0, r3
    pop {r4, pc}

    @ 0x8000082
loc_8000082:
    movs r0, #0
    pop {r4, pc}
    push {r3, r4, r5, lr}
    mov r4, r0
    mov r5, r1
    bl strlen
    mov r1, r5
    add r0, r4
    bl strcpy
    mov r0, r4
    pop {r3, r4, r5, pc}
    push {r3, r4, r5, lr}
    mov r4, r0
    mov r5, r1
    bl strlen
    mov r1, r5
    adds r2, r0, #1
    mov r0, r4
    bl sub_800006A
    pop {r3, r4, r5, pc}
    push {r3, r4, r5, lr}
    mov r4, r0
    mov r5, r1
    bl strlen
    mov r1, r5
    adds r2, r0, #1
    mov r0, r4
    bl memcmp
    pop {r3, r4, r5, pc}

    @ 0x80000C8
    .thumb_func
strcpy:
    push {r3, r4, r5, lr}
    mov r5, r0
    mov r0, r1
    mov r4, r1
    bl strlen
    mov r1, r4
    adds r2, r0, #1
    mov r0, r5
    bl memcpy
    pop {r3, r4, r5, pc}

    @ 0x80000E0
    .thumb_func
strlen:
    movs r3, #0

    @ 0x80000E2
loc_80000E2:
    ldrb r2, [r0, r3]
    cbz R2, loc_80000EA
    adds r3, #1
    b.n loc_80000E2

    @ 0x80000EA
loc_80000EA:
    mov r0, r3
    bx lr
    movs r3, #0

    @ 0x80000F0
loc_80000F0:
    ldrb r2, [r0, r3]
    cbz R2, loc_80000FC
    cmp r3, r1
    beq.n loc_80000FC
    adds r3, #1
    b.n loc_80000F0

    @ 0x80000FC
loc_80000FC:
    mov r0, r3
    bx lr
    push {r4, r5, lr}
    movs r3, #0

    @ 0x8000104
loc_8000104:
    ldrb r4, [r0, r3]
    cbz R4, loc_8000118
    subs r2, r1, #1

    @ 0x800010A
loc_800010A:
    ldrb r5, [r2, #1]!
    cbz R5, loc_8000118
    cmp r4, r5
    bne.n loc_800010A
    adds r3, #1
    b.n loc_8000104

    @ 0x8000118
loc_8000118:
    mov r0, r3
    pop {r4, r5, pc}
    push {r4, r5, lr}
    mvn r4, #0x80000000
    sub sp, #0x14
    movs r5, #0
    strd r4, r5, [sp]
    mov.w r4, #-0x80000000
    mov.w r5, #-1
    strd r4, r5, [sp, #8]
    movs r3, #1
    bl sub_8002CC0
    add sp, #0x14
    pop {r4, r5, pc}
    push {r0, r1, r2, r3, r4, lr}
    mvn r2, #0x80000000
    movs r3, #0
    strd r2, r3, [sp]
    movs r1, #0
    mov.w r2, #-0x80000000
    mov.w r3, #-1
    strd r2, r3, [sp, #8]
    movs r2, #0xa
    mov r3, r1
    bl sub_8002CC0
    add sp, #0x14
    ldr pc, [sp], #4
    push {r0, r1, r2, r3, r4, lr}
    mvn r2, #0x80000000
    movs r3, #0
    strd r2, r3, [sp]
    movs r1, #0
    mov.w r2, #-0x80000000
    mov.w r3, #-1
    strd r2, r3, [sp, #8]
    movs r2, #0xa
    mov r3, r1
    bl sub_8002CC0
    add sp, #0x14
    ldr pc, [sp], #4
    movs r0, #0
    bx lr

    @ 0x8000194
loc_8000194:
    b.n loc_8000194
    push {r3, r4, r5, r6, r7, lr}
    mov r5, r0
    mov r0, r1
    mov r6, r1
    bl strlen
    mov r7, r0

    @ 0x80001A4
loc_80001A4:
    mov r4, r5
    ldrb r3, [r4]
    adds r5, #1
    cbz R3, loc_80001BE
    mov r0, r4
    mov r1, r6
    mov r2, r7
    bl strncmp
    cmp r0, #0
    bne.n loc_80001A4
    mov r0, r4
    pop {r3, r4, r5, r6, r7, pc}

    @ 0x80001BE
loc_80001BE:
    mov r0, r3
    pop {r3, r4, r5, r6, r7, pc}
    push {r4, r5, lr}
    movs r3, #0

    @ 0x80001C6
loc_80001C6:
    ldrb r4, [r0, r3]
    cbz R4, loc_80001DC
    subs r2, r1, #1

    @ 0x80001CC
loc_80001CC:
    ldrb r5, [r2, #1]!
    cbz R5, loc_80001D8
    cmp r4, r5
    bne.n loc_80001CC
    b.n loc_80001DC

    @ 0x80001D8
loc_80001D8:
    adds r3, #1
    b.n loc_80001C6

    @ 0x80001DC
loc_80001DC:
    mov r0, r3
    pop {r4, r5, pc}
    push {r3, r4, r5, r6, r7, lr}
    mov r5, r0
    mov r0, r1
    mov r6, r2
    mov r7, r1
    bl strlen
    adds r0, #1
    cmp r0, r6
    ite lo
    movlo r4, r0
    movhs r4, r6
    mov r1, r7
    mov r0, r5
    mov r2, r4
    bl memcpy
    cmp r6, r4
    bls.n loc_8000210
    adds r0, r5, r4
    movs r1, #0
    subs r2, r6, r4
    bl memset

    @ 0x8000210
loc_8000210:
    mov r0, r5
    pop {r3, r4, r5, r6, r7, pc}

    @ 0x8000214
    .thumb_func
strncmp:
    push {r4, r5, r6, lr}
    mov r5, r2
    mov r4, r0
    mov r6, r1
    bl strlen
    adds r2, r0, #1
    mov r1, r6
    mov r0, r4
    cmp r2, r5
    it hs
    movhs r2, r5
    bl memcmp
    pop {r4, r5, r6, pc}
    push {r3, r4, r5, lr}
    mov r4, r0
    uxtb r5, r1
    bl strlen
    adds r3, r4, r0

    @ 0x800023E
loc_800023E:
    mov r0, r3
    ldrb r2, [r0]
    subs r3, #1
    cmp r2, r5
    beq.n loc_8000250
    rsb.w r0, r4, #1
    adds r0, r0, r3
    bne.n loc_800023E

    @ 0x8000250
loc_8000250:
    pop {r3, r4, r5, pc}
    push {r3, r4, r5, r6, r7, lr}
    mov r6, r1
    mov r4, r0
    mov r7, r2
    bl strlen
    adds r5, r4, r0
    mov r0, r6
    bl strlen
    cmp r0, r7
    it lo
    movlo r7, r0
    mov r1, r6
    mov r0, r5
    mov r2, r7
    bl memcpy
    movs r3, #0
    strb r3, [r5, r7]
    mov r0, r4
    pop {r3, r4, r5, r6, r7, pc}
    cmp r0, r1
    push {r4, lr}
    bhi.n loc_8000294
    movs r3, #0

    @ 0x8000286
loc_8000286:
    cmp r3, r2
    beq.n loc_8000292
    ldrb r4, [r1, r3]
    strb r4, [r0, r3]
    adds r3, #1
    b.n loc_8000286

    @ 0x8000292
loc_8000292:
    pop {r4, pc}

    @ 0x8000294
loc_8000294:
    adds.w r2, r2, #-1
    blo.n loc_80002A0
    ldrb r3, [r1, r2]
    strb r3, [r0, r2]
    b.n loc_8000294

    @ 0x80002A0
loc_80002A0:
    pop {r4, pc}

    @ 0x80002A2
    .thumb_func
memcmp:
    push {r4, r5, lr}
    movs r3, #0

    @ 0x80002A6
loc_80002A6:
    cmp r3, r2
    beq.n loc_80002B8
    ldrb r5, [r0, r3]
    ldrb r4, [r1, r3]
    adds r3, #1
    subs r4, r5, r4
    beq.n loc_80002A6
    mov r0, r4
    pop {r4, r5, pc}

    @ 0x80002B8
loc_80002B8:
    movs r0, #0
    pop {r4, r5, pc}

    @ 0x80002BC
    .thumb_func
sub_80002BC:
    push.w {r4, r5, r6, r7, r8, sb, sl, fp, lr}
    mov r7, r1
    sub sp, #0x3c
    movs r1, #0
    adds r4, r2, #1
    str r1, [sp, #0x34]
    ldrb r2, [r2]
    mov r8, r0
    cbz R0, loc_80002D6
    cbz R7, loc_80002D8
    strb r1, [r0]
    b.n loc_80002D8

    @ 0x80002D6
loc_80002D6:
    mov r7, r0

    @ 0x80002D8
loc_80002D8:
    movs r1, #0
    mov.w sb, #-1
    mov r6, r1
    mov r5, r1
    mov sl, r1
    mov fp, r1

    @ 0x80002E6
loc_80002E6:
    cmp r2, #0
    beq.w loc_80006FC

    @ 0x80002EC
def_80002F0:
    cmp r1, #6
    bhi.n def_80002F0
    tbb [pc, r1]

    @ 0x80002F4
jpt_80002F0:
    .byte 0x4
    .byte 0x18
    .byte 0x34
    .byte 0x59
    .byte 0x60
    .byte 0x90
    .byte 0xCA
    .align 1

    @ 0x80002FC
loc_80002FC:
    cmp r2, #0x25
    beq.n loc_8000314
    ldr.w ip, [sp, #0x34]
    add.w r0, ip, #1
    cmp r0, r7
    it lo
    strblo.w r2, [r8, ip]
    str r0, [sp, #0x34]
    b.n loc_8000384

    @ 0x8000314
loc_8000314:
    movs r6, #0
    movs r1, #1
    mov.w sb, #-1
    mov r5, r6
    mov sl, r6
    mov fp, r6
    b.n loc_8000384

    @ 0x8000324
loc_8000324:
    cmp r2, #0x2b
    beq.n loc_8000350
    bhi.n loc_800033A
    cmp r2, #0x20
    beq.n loc_8000356
    cmp r2, #0x23
    bne.w loc_80006EC
    orr r5, r5, #8
    b.n loc_8000384

    @ 0x800033A
loc_800033A:
    cmp r2, #0x2d
    beq.n loc_800034A
    cmp r2, #0x30
    bne.w loc_80006EC
    orr r5, r5, #0x10
    b.n loc_8000384

    @ 0x800034A
loc_800034A:
    orr r5, r5, #1
    b.n loc_8000384

    @ 0x8000350
loc_8000350:
    orr r5, r5, #2
    b.n loc_8000384

    @ 0x8000356
loc_8000356:
    orr r5, r5, #4
    b.n loc_8000384

    @ 0x800035C
loc_800035C:
    ldr r0, [pc, #0x2a8]
    ldrb r0, [r0, r2]
    lsls r0, r0, #0x1d
    bpl.n loc_800038A
    subs r2, #0x30
    uxtb r2, r2
    mvn r0, #0x80000000
    subs r0, r0, r2
    mov.w ip, #0xa
    sdiv r0, r0, ip
    cmp r6, r0
    ble.n loc_8000380

    @ 0x800037A
loc_800037A:
    mov.w r0, #-1
    b.n loc_8000724

    @ 0x8000380
loc_8000380:
    mla r6, ip, r6, r2

    @ 0x8000384
loc_8000384:
    ldrb r2, [r4]
    adds r4, #1
    b.n loc_80002E6

    @ 0x800038A
loc_800038A:
    cmp r2, #0x2a
    bne.w loc_80006F0
    ldr r6, [r3]
    adds r1, r3, #4
    cmp r6, #0
    ldrb r2, [r4]
    itt lt
    orrlt r5, r5, #1
    rsblt r6, r6, #0
    mov r3, r1
    adds r4, #1
    b.n loc_80006F0

    @ 0x80003A6
loc_80003A6:
    cmp r2, #0x2e
    bne.w loc_80006F4
    ldrb r2, [r4]
    movs r1, #4
    adds r4, #1
    b.n loc_80002E6

    @ 0x80003B4
loc_80003B4:
    ldr r0, [pc, #0x250]
    cmp.w sb, #-1
    ldrb.w ip, [r0, r2]
    it eq
    moveq.w sb, #0
    tst.w ip, #4
    beq.n loc_80003E6
    subs r2, #0x30
    uxtb r2, r2
    mvn r0, #0x80000000
    subs r0, r0, r2
    mov.w ip, #0xa
    sdiv r0, r0, ip
    cmp sb, r0
    bgt.n loc_800037A
    mla sb, ip, sb, r2
    b.n loc_8000384

    @ 0x80003E6
loc_80003E6:
    cmp r2, #0x2a
    bne.n loc_80003FA
    ldr r2, [r3]
    adds r4, #1
    bic.w sb, r2, r2, asr #31
    adds r3, #4
    ldrb r2, [r4, #-0x1]
    b.n loc_80006F4

    @ 0x80003FA
loc_80003FA:
    cmp r2, #0x2d
    bne.w loc_80006F4

    @ 0x8000400
loc_8000400:
    ldrb r2, [r4], #1
    ldrb r1, [r0, r2]
    and r1, r1, #4
    and sb, r1, #0xff
    cmp r1, #0
    bne.n loc_8000400
    b.n loc_80006F4

    @ 0x8000414
loc_8000414:
    cmp r2, #0x6c
    beq.n loc_8000460
    bhi.n loc_8000430
    cmp r2, #0x68
    beq.n loc_8000444
    cmp r2, #0x6a
    bne.w loc_80006F8
    ldrb r2, [r4]
    movs r1, #6
    adds r4, #1
    mov.w sl, #8
    b.n loc_80002E6

    @ 0x8000430
loc_8000430:
    cmp r2, #0x74
    beq.n loc_800047C
    cmp r2, #0x7a
    bne.w loc_80006F8
    ldrb r2, [r4]
    mov.w sl, #6
    adds r4, #1
    b.n loc_80006F8

    @ 0x8000444
loc_8000444:
    ldrb r2, [r4]
    cmp r2, #0x68
    beq.n loc_8000454
    adds r4, #1
    movs r1, #6
    mov.w sl, #2
    b.n loc_80002E6

    @ 0x8000454
loc_8000454:
    ldrb r2, [r4, #1]
    movs r1, #6
    adds r4, #2
    mov.w sl, #1
    b.n loc_80002E6

    @ 0x8000460
loc_8000460:
    ldrb r2, [r4]
    cmp r2, #0x6c
    beq.n loc_8000470
    adds r4, #1
    movs r1, #6
    mov.w sl, #3
    b.n loc_80002E6

    @ 0x8000470
loc_8000470:
    ldrb r2, [r4, #1]
    movs r1, #6
    adds r4, #2
    mov.w sl, #4
    b.n loc_80002E6

    @ 0x800047C
loc_800047C:
    ldrb r2, [r4]
    movs r1, #6
    adds r4, #1
    mov.w sl, #7
    b.n loc_80002E6

    @ 0x8000488
loc_8000488:
    cmp r2, #0x6e
    beq.w loc_80006A0
    bhi.n loc_80004AC
    cmp r2, #0x63
    beq.n loc_80004FC
    bhi.n loc_80004A2
    cmp r2, #0x58
    bne.w loc_80006D6
    orr r5, r5, #0x40
    b.n loc_8000718

    @ 0x80004A2
loc_80004A2:
    cmp r2, #0x64
    beq.n loc_8000500
    cmp r2, #0x69
    beq.n loc_8000500
    b.n loc_80006D6

    @ 0x80004AC
loc_80004AC:
    cmp r2, #0x73
    beq.w loc_80005D8
    bhi.n loc_80004F0
    cmp r2, #0x6f
    beq.n loc_8000540
    cmp r2, #0x70
    bne.w loc_80006D6
    ldr r2, [r3]
    add.w ip, r3, #4
    movs r3, #0
    strd r2, r3, [sp]
    orr r5, r5, #0x88
    movs r3, #0x10
    str r3, [sp, #8]
    str r6, [sp, #0xc]
    str.w sb, [sp, #0x10]
    str r5, [sp, #0x14]
    mov r0, r8
    add r1, sp, #0x34
    mov r2, r7
    str.w ip, [sp, #0x20]
    bl sub_8002DC0
    ldr.w ip, [sp, #0x20]
    mov r3, ip
    b.n loc_80006E4

    @ 0x80004F0
loc_80004F0:
    cmp r2, #0x75
    beq.n loc_800054A
    cmp r2, #0x78
    beq.w loc_8000718
    b.n loc_80006D6

    @ 0x80004FC
loc_80004FC:
    ldr r1, [sp, #0x34]
    b.n loc_80005BC

    @ 0x8000500
loc_8000500:
    add.w r2, sl, #-1
    cmp r2, #7
    bhi.n def_8000508
    tbb [pc, r2]

    @ 0x800050C
jpt_8000508:
    .byte 0x4
    .byte 0x7
    .byte 0x12
    .byte 0xA
    .byte 0x12
    .byte 0x12
    .byte 0x12
    .byte 0xA

    @ 0x8000514
loc_8000514:
    ldrsb.w r0, [r3]
    b.n loc_8000532

    @ 0x800051A
loc_800051A:
    ldrsh.w r0, [r3]
    b.n loc_8000532

    @ 0x8000520
loc_8000520:
    adds r3, #7
    bic r2, r3, #7
    add.w r3, r2, #8
    ldrd r0, r1, [r2]
    b.n loc_8000536

    @ 0x8000530
def_8000508:
    ldr r0, [r3]

    @ 0x8000532
loc_8000532:
    asrs r1, r0, #0x1f
    adds r3, #4

    @ 0x8000536
loc_8000536:
    movs r2, #0xa
    strd r0, r1, [sp]
    str r2, [sp, #8]
    b.n loc_8000592

    @ 0x8000540
loc_8000540:
    cmp.w fp, #0
    beq.w loc_800071E
    b.n loc_8000554

    @ 0x800054A
loc_800054A:
    cmp.w fp, #0
    bne.n loc_8000554
    mov.w fp, #0xa

    @ 0x8000554
loc_8000554:
    add.w r2, sl, #-1
    orr r5, r5, #0x80
    cmp r2, #7
    bhi.n def_8000560
    tbb [pc, r2]

    @ 0x8000564
jpt_8000560:
    .byte 0x4
    .byte 0x6
    .byte 0x10
    .byte 0x8
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x8

    @ 0x800056C
loc_800056C:
    ldrb r0, [r3]
    b.n loc_8000586

    @ 0x8000570
loc_8000570:
    ldrh r0, [r3]
    b.n loc_8000586

    @ 0x8000574
loc_8000574:
    adds r3, #7
    bic r2, r3, #7
    add.w r3, r2, #8
    ldrd r0, r1, [r2]
    b.n loc_800058A

    @ 0x8000584
def_8000560:
    ldr r0, [r3]

    @ 0x8000586
loc_8000586:
    movs r1, #0
    adds r3, #4

    @ 0x800058A
loc_800058A:
    strd r0, r1, [sp]
    str.w fp, [sp, #8]

    @ 0x8000592
loc_8000592:
    str r6, [sp, #0xc]
    str.w sb, [sp, #0x10]
    str r5, [sp, #0x14]
    mov r0, r8
    add r1, sp, #0x34
    mov r2, r7
    str r3, [sp, #0x20]
    bl sub_8002DC0
    ldr r3, [sp, #0x20]
    b.n loc_80006E4

    @ 0x80005AA
loc_80005AA:
    cmp r2, r7
    bhs.n loc_80005B8
    add.w r1, r8, r2
    movs r0, #0x20
    strb r0, [r1, #-0x1]

    @ 0x80005B8
loc_80005B8:
    subs r6, #1
    mov r1, r2

    @ 0x80005BC
loc_80005BC:
    cmp r6, #1
    add.w r2, r1, #1
    bgt.n loc_80005AA
    adds r0, r3, #4
    ldr r3, [r3]
    cmp r2, r7
    str r1, [sp, #0x34]
    it lo
    strblo.w r3, [r8, r1]
    str r2, [sp, #0x34]
    mov r3, r0
    b.n loc_80006E4

    @ 0x80005D8
loc_80005D8:
    adds r0, r3, #4
    str r0, [sp, #0x2c]
    subs.w r0, sb, #-1
    rsbs r1, r0, #0
    ldr r2, [r3]
    adcs r1, r0
    str r1, [sp, #0x24]
    cbnz R2, loc_80005EC
    ldr r2, [pc, #0x20]

    @ 0x80005EC
loc_80005EC:
    movs r3, #0

    @ 0x80005EE
loc_80005EE:
    ldrb r1, [r2, r3]
    cbnz R1, loc_8000600

    @ 0x80005F2
loc_80005F2:
    subs r3, r6, r3
    lsls r1, r5, #0x1f
    bic.w r3, r3, r3, asr #31
    bpl.n loc_8000616
    rsbs r3, r3, #0
    b.n loc_8000616

    @ 0x8000600
loc_8000600:
    ldr r0, [sp, #0x24]
    cbz R0, loc_8000610

    @ 0x8000604
loc_8000604:
    adds r3, #1
    b.n loc_80005EE

    @ 0x8000608
_8000608:
    .4byte 0x800124C

    @ 0x800060C
_800060C:
    .4byte aNull

    @ 0x8000610
loc_8000610:
    cmp r3, sb
    blt.n loc_8000604
    b.n loc_80005F2

    @ 0x8000616
loc_8000616:
    ldr r1, [sp, #0x34]
    str r1, [sp, #0x1c]

    @ 0x800061A
loc_800061A:
    ldr r0, [sp, #0x1c]
    add r0, r3
    subs r0, r0, r1
    cmp r0, #0
    ble.n loc_8000638
    adds r1, #1
    cmp r1, r7
    bhs.n loc_800061A
    add.w r0, r8, r1
    mov.w ip, #0x20
    strb ip, [r0, #-0x1]
    b.n loc_800061A

    @ 0x8000638
loc_8000638:
    ldr r0, [sp, #0x1c]
    bic.w r1, r3, r3, asr #31
    subs r2, #1
    subs r3, r3, r1
    add r1, r0
    str r2, [sp, #0x28]
    str r1, [sp, #0x34]
    mov r2, sb

    @ 0x800064A
loc_800064A:
    ldr r0, [sp, #0x28]
    ldrb r1, [r0, #1]!
    str r0, [sp, #0x28]
    cbz R1, loc_8000678
    ldr r0, [sp, #0x24]
    cbz R0, loc_800066C

    @ 0x8000658
loc_8000658:
    ldr.w ip, [sp, #0x34]
    add.w r0, ip, #1
    cmp r0, r7
    it lo
    strblo.w r1, [r8, ip]
    str r0, [sp, #0x34]
    b.n loc_800064A

    @ 0x800066C
loc_800066C:
    cmp r2, #0
    add.w r0, r2, #-1
    ble.n loc_8000678
    mov r2, r0
    b.n loc_8000658

    @ 0x8000678
loc_8000678:
    ldr r1, [sp, #0x34]
    mov r2, r3

    @ 0x800067C
loc_800067C:
    cbz R2, loc_8000698
    adds r0, r1, #1
    subs r0, r0, r3
    add r0, r2
    cmp r0, r7
    bhs.n loc_8000694
    subs r0, r1, r3
    add r0, r8
    mov.w ip, #0x20
    strb.w ip, [r0, r2]

    @ 0x8000694
loc_8000694:
    adds r2, #1
    b.n loc_800067C

    @ 0x8000698
loc_8000698:
    subs r3, r1, r3
    str r3, [sp, #0x34]
    ldr r3, [sp, #0x2c]
    b.n loc_80006E4

    @ 0x80006A0
loc_80006A0:
    add.w r0, sl, #-1
    ldr r2, [sp, #0x34]
    adds r1, r3, #4
    cmp r0, #7
    bhi.n def_80006AC
    tbb [pc, r0]

    @ 0x80006B0
jpt_80006AC:
    .byte 0x4
    .byte 0x7
    .byte 0xF
    .byte 0xA
    .byte 0xF
    .byte 0xF
    .byte 0xF
    .byte 0xA

    @ 0x80006B8
loc_80006B8:
    ldr r3, [r3]
    strb r2, [r3]
    b.n loc_80006D2

    @ 0x80006BE
loc_80006BE:
    ldr r3, [r3]
    strh r2, [r3]
    b.n loc_80006D2

    @ 0x80006C4
loc_80006C4:
    ldr r0, [r3]
    movs r3, #0
    strd r2, r3, [r0]
    b.n loc_80006D2

    @ 0x80006CE
def_80006AC:
    ldr r3, [r3]
    str r2, [r3]

    @ 0x80006D2
loc_80006D2:
    mov r3, r1
    b.n loc_80006E4

    @ 0x80006D6
loc_80006D6:
    ldr r0, [sp, #0x34]
    adds r1, r0, #1
    cmp r1, r7
    it lo
    strblo.w r2, [r8, r0]
    str r1, [sp, #0x34]

    @ 0x80006E4
loc_80006E4:
    ldrb r2, [r4]
    movs r1, #0
    adds r4, #1
    b.n loc_80002E6

    @ 0x80006EC
loc_80006EC:
    movs r1, #2
    b.n loc_80002E6

    @ 0x80006F0
loc_80006F0:
    movs r1, #3
    b.n loc_80002E6

    @ 0x80006F4
loc_80006F4:
    movs r1, #5
    b.n loc_80002E6

    @ 0x80006F8
loc_80006F8:
    movs r1, #6
    b.n loc_80002E6

    @ 0x80006FC
loc_80006FC:
    ldr r0, [sp, #0x34]
    cmp r0, r7
    bhs.n loc_8000708
    strb.w r2, [r8, r0]
    b.n loc_8000710

    @ 0x8000708
loc_8000708:
    cbz R7, loc_8000710
    add r7, r8
    strb r2, [r7, #-0x1]

    @ 0x8000710
loc_8000710:
    ldr r3, [pc, #0x18]
    cmp r0, r3
    bls.n loc_8000724
    b.n loc_800037A

    @ 0x8000718
loc_8000718:
    mov.w fp, #0x10
    b.n loc_8000554

    @ 0x800071E
loc_800071E:
    mov.w fp, #8
    b.n loc_8000554

    @ 0x8000724
loc_8000724:
    add sp, #0x3c
    pop.w {r4, r5, r6, r7, r8, sb, sl, fp, pc}
    .align 2

    @ 0x800072C
_800072C:
    .4byte 0x7FFFFFFE
    push {r2, r3}
    push {r0, r1, r2, lr}
    add r3, sp, #0x10
    ldr r2, [r3], #4
    str r3, [sp, #4]
    bl sub_80002BC
    add sp, #0xc
    ldr lr, [sp], #4
    add sp, #8
    bx lr

    @ 0x800074A
    .thumb_func
sub_800074A:
    push {r4, lr}
    mov r4, r1
    mov r3, r2
    mvn r1, #0x80000000
    mov r2, r4
    bl sub_80002BC
    pop {r4, pc}
    push {r1, r2, r3}
    push {r0, r1, lr}
    add r2, sp, #0xc
    ldr r1, [r2], #4
    str r2, [sp, #4]
    bl sub_800074A
    add sp, #8
    ldr lr, [sp], #4
    add sp, #0xc
    bx lr
    movs r0, #0
    bx lr
    .2byte 0xFFFF

    @ 0x800077C
    .thumb_func
rcc_set_csr_rmvf:
    ldr r3, [pc, #8]
    ldr r2, [r3, #0x74]
    orr r2, r2, #0x1000000
    str r2, [r3, #0x74]
    bx lr

    @ 0x8000788
_8000788:
    .4byte 0x40023800

    @ 0x800078C
    .thumb_func
timer_enable:
    ldrh r3, [r0]
    cbz R1, loc_8000798
    uxth r3, r3
    orr r3, r3, #1
    b.n loc_80007A0

    @ 0x8000798
loc_8000798:
    bic r3, r3, #1
    lsls r3, r3, #0x10
    lsrs r3, r3, #0x10

    @ 0x80007A0
loc_80007A0:
    strh r3, [r0]
    bx lr
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF
    .4byte 0xFFFFFFFF

    @ 0x8000810
    .thumb_func
sub_8000810:
    ldr r3, [pc, #4]
    movs r2, #1
    str r2, [r3, #8]
    bx lr

    @ 0x8000818
_8000818:
    .4byte 0x40023000

    @ 0x800081C
    .thumb_func
sub_800081C:
    ldr r3, [pc, #4]
    str r0, [r3]
    ldr r0, [r3]
    bx lr

    @ 0x8000824
_8000824:
    .4byte 0x40023000

    @ 0x8000828
    .thumb_func
sub_8000828:
    add.w r1, r0, r1, lsl #2

    @ 0x800082C
loc_800082C:
    cmp r0, r1
    ldr r3, [pc, #0x10]
    beq.n loc_800083A
    ldr r2, [r0], #4
    str r2, [r3]
    b.n loc_800082C

    @ 0x800083A
loc_800083A:
    ldr r0, [r3]
    bx lr
    .align 4

    @ 0x8000840
_8000840:
    .4byte 0x40023000

    @ 0x8000844
    .thumb_func
sub_8000844:
    ldr r3, [pc, #4]
    ldr r0, [r3]
    bx lr
    .align 2

    @ 0x800084C
_800084C:
    .4byte 0x40023000

    @ 0x8000850
    .thumb_func
sub_8000850:
    ldr r3, [pc, #0x10]
    ldr r2, [r3, #8]
    cbz R1, loc_800085A
    orrs r0, r2
    b.n loc_800085E

    @ 0x800085A
loc_800085A:
    bic.w r0, r2, r0

    @ 0x800085E
loc_800085E:
    str r0, [r3, #8]
    bx lr
    .align 2

    @ 0x8000864
_8000864:
    .4byte 0xE0042000

    @ 0x8000868
    .thumb_func
flash_unlock:
    ldr r3, [pc, #0x10]
    ldr r2, [r3, #0x10]
    cmp r2, #0
    bge.n loc_800087A
    ldr r2, [pc, #0xc]
    str r2, [r3, #4]
    add.w r2, r2, #-0x77777778
    str r2, [r3, #4]

    @ 0x800087A
loc_800087A:
    bx lr

    @ 0x800087C
_800087C:
    .4byte 0x40023C00

    @ 0x8000880
_8000880:
    .4byte 0x45670123

    @ 0x8000884
    .thumb_func
flash_set_lock:
    ldr r3, [pc, #8]
    ldr r2, [r3, #0x10]
    orr r2, r2, #0x80000000
    str r2, [r3, #0x10]
    bx lr

    @ 0x8000890
_8000890:
    .4byte 0x40023C00

    @ 0x8000894
    .thumb_func
flash_set_sr:
    ldr r3, [pc, #4]
    str r0, [r3, #0xc]
    bx lr
    .align 2

    @ 0x800089C
_800089C:
    .4byte 0x40023C00

    @ 0x80008A0
    .thumb_func
sub_80008A0:
    ldr r3, [pc, #0x2c]
    ldr r2, [r3, #0xc]
    lsls r1, r2, #0xf
    bmi.n loc_80008C2
    ldr r2, [r3, #0xc]
    lsls r2, r2, #0x1b
    bmi.n loc_80008C6
    ldr r2, [r3, #0xc]
    tst.w r2, #0xef
    bne.n loc_80008CA
    ldr r3, [r3, #0xc]
    lsls r3, r3, #0x1e
    ite mi
    movmi r0, #7
    movpl r0, #8
    bx lr

    @ 0x80008C2
loc_80008C2:
    movs r0, #1
    bx lr

    @ 0x80008C6
loc_80008C6:
    movs r0, #5
    bx lr

    @ 0x80008CA
loc_80008CA:
    movs r0, #6
    bx lr
    .align 4

    @ 0x80008D0
_80008D0:
    .4byte 0x40023C00

    @ 0x80008D4
    .thumb_func
sub_80008D4:
    push {r4, r5, r6, lr}
    mov r6, r0
    cbz R1, loc_80008E8
    cmp r1, #1
    beq.n loc_80008EC
    cmp r1, #2
    bne.n loc_80008F2
    mov.w r5, #0x200
    b.n loc_80008F6

    @ 0x80008E8
loc_80008E8:
    mov r5, r1
    b.n loc_80008F6

    @ 0x80008EC
loc_80008EC:
    mov.w r5, #0x100
    b.n loc_80008F6

    @ 0x80008F2
loc_80008F2:
    mov.w r5, #0x300

    @ 0x80008F6
loc_80008F6:
    bl sub_800106C
    cmp r0, #8
    bne.n loc_800093C
    ldr r4, [pc, #0x40]
    ldr r3, [r4, #0x10]
    bic r3, r3, #0x300
    str r3, [r4, #0x10]
    ldr r3, [r4, #0x10]
    orrs r5, r3
    str r5, [r4, #0x10]
    ldr r3, [r4, #0x10]
    bic r3, r3, #0xf8
    str r3, [r4, #0x10]
    ldr r3, [r4, #0x10]
    orr r3, r3, #2
    orrs r6, r3
    str r6, [r4, #0x10]
    ldr r3, [r4, #0x10]
    orr r3, r3, #0x10000
    str r3, [r4, #0x10]
    bl sub_800106C
    ldr r3, [r4, #0x10]
    bic r3, r3, #2
    str r3, [r4, #0x10]
    ldr r3, [r4, #0x10]
    bic r3, r3, #0xf8
    str r3, [r4, #0x10]

    @ 0x800093C
loc_800093C:
    pop {r4, r5, r6, pc}
    .align 4

    @ 0x8000940
_8000940:
    .4byte 0x40023C00

    @ 0x8000944
    .thumb_func
sub_8000944:
    push {r4, r5, r6, lr}
    mov r5, r0
    mov r6, r1
    bl sub_800106C
    cmp r0, #8
    bne.n loc_8000976
    ldr r4, [pc, #0x24]
    ldr r3, [r4, #0x10]
    bic r3, r3, #0x300
    str r3, [r4, #0x10]
    ldr r3, [r4, #0x10]
    str r3, [r4, #0x10]
    ldr r3, [r4, #0x10]
    orr r3, r3, #1
    str r3, [r4, #0x10]
    strb r6, [r5]
    bl sub_800106C
    ldr r3, [r4, #0x10]
    bic r3, r3, #1
    str r3, [r4, #0x10]

    @ 0x8000976
loc_8000976:
    pop {r4, r5, r6, pc}

    @ 0x8000978
_8000978:
    .4byte 0x40023C00

    @ 0x800097C
    .thumb_func
sub_800097C:
    ldr r3, [pc, #4]
    str r0, [r3]
    bx lr
    .align 2

    @ 0x8000984
_8000984:
    .4byte 0x40003000

    @ 0x8000988
    .thumb_func
sub_8000988:
    ldr r3, [pc, #4]
    str r0, [r3, #4]
    bx lr
    .align 4

    @ 0x8000990
_8000990:
    .4byte 0x40003000

    @ 0x8000994
    .thumb_func
sub_8000994:
    ldr r3, [pc, #4]
    str r0, [r3, #8]
    bx lr
    .align 2

    @ 0x800099C
_800099C:
    .4byte 0x40003000

    @ 0x80009A0
    .thumb_func
sub_80009A0:
    ldr r3, [pc, #8]
    movw r2, #0xaaaa
    str r2, [r3]
    bx lr
    .align 2

    @ 0x80009AC
_80009AC:
    .4byte 0x40003000

    @ 0x80009B0
    .thumb_func
sub_80009B0:
    ldr r3, [pc, #8]
    movw r2, #0xcccc
    str r2, [r3]
    bx lr
    .align 2

    @ 0x80009BC
_80009BC:
    .4byte 0x40003000

    @ 0x80009C0
    .thumb_func
sub_80009C0:
    ldr r3, [pc, #4]
    str r0, [r3]
    bx lr
    .align 2

    @ 0x80009C8
_80009C8:
    .4byte 0x420E0020

    @ 0x80009CC
    .thumb_func
sub_80009CC:
    ldr r3, [pc, #4]
    str r0, [r3]
    bx lr
    .align 2

    @ 0x80009D4
_80009D4:
    .4byte 0x420E00A0

    @ 0x80009D8
    .thumb_func
sub_80009D8:
    ldr r3, [pc, #0xc]
    ldr r3, [r3, #4]
    tst r0, r3
    ite eq
    moveq r0, #0
    movne r0, #1
    bx lr
    .align 2

    @ 0x80009E8
_80009E8:
    .4byte 0x40007000

    @ 0x80009EC
    .thumb_func
sub_80009EC:
    ldr r3, [pc, #8]
    ldr r2, [r3]
    orr.w r0, r2, r0, lsl #2
    str r0, [r3]
    bx lr

    @ 0x80009F8
_80009F8:
    .4byte 0x40007000

    @ 0x80009FC
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
    .thumb_func
sub_8000B08:
    ldr r3, [pc, #4]
    str r0, [r3]
    bx lr
    .align 4

    @ 0x8000B10
_8000B10:
    .4byte 0x42470E3C

    @ 0x8000B14
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
    .align 4

    @ 0x8000B40
_8000B40:
    .4byte 0x40023800

    @ 0x8000B44
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
    .align 4

    @ 0x8000B70
_8000B70:
    .4byte 0x40023800

    @ 0x8000B74
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
    .align 4

    @ 0x8000BA0
_8000BA0:
    .4byte 0x40023800

    @ 0x8000BA4
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
    .align 4

    @ 0x8000BD0
_8000BD0:
    .4byte 0x40023800

    @ 0x8000BD4
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
    .align 4

    @ 0x8000D60
_8000D60:
    .4byte 0x40002800

    @ 0x8000D64
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
    .align 4

    @ 0x8000EB0
_8000EB0:
    .4byte RTC_BASE+80

    @ 0x8000EB4
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
    .align 4

    @ 0x8000ED0
_8000ED0:
    .4byte 0x40002850

    @ 0x8000ED4
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
    .align 4

    @ 0x8000F40
_8000F40:
    .4byte 0x40002800

    @ 0x8000F44
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

    @ 0x8000F60
    .thumb_func
spi_toggle_reset:
    push {r3, lr}
    ldr R3, _8000FB0
    cmp r0, r3
    bne.n loc_8000F7E
    mov.w r0, #0x1000
    movs r1, #1
    bl rcc_set_apb2_reset
    mov.w r0, #0x1000
    movs r1, #0
    bl rcc_set_apb2_reset
    pop {r3, pc}

    @ 0x8000F7E
loc_8000F7E:
    ldr R3, _8000FB4
    cmp r0, r3
    bne.n loc_8000F94
    mov.w r0, #0x4000
    movs r1, #1
    bl rcc_set_apb1_reset
    mov.w r0, #0x4000
    b.n loc_8000FA8

    @ 0x8000F94
loc_8000F94:
    ldr R3, _8000FB8
    cmp r0, r3
    bne.n loc_8000FAE
    mov.w r0, #0x8000
    movs r1, #1
    bl rcc_set_apb1_reset
    mov.w r0, #0x8000

    @ 0x8000FA8
loc_8000FA8:
    movs r1, #0
    bl rcc_set_apb1_reset

    @ 0x8000FAE
loc_8000FAE:
    pop {r3, pc}

    @ 0x8000FB0
_8000FB0:
    .4byte SPI1_BASE

    @ 0x8000FB4
_8000FB4:
    .4byte SPI2_BASE

    @ 0x8000FB8
_8000FB8:
    .4byte SPI3_BASE

    @ 0x8000FBC
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

    @ 0x800106C
    .thumb_func
sub_800106C:
    push {r0, r1, r2, lr}
    movs r3, #8
    strb.w r3, [sp, #7]

    @ 0x8001074
loc_8001074:
    bl sub_80008A0
    strb.w r0, [sp, #7]
    ldrb.w r3, [sp, #7]
    cmp r3, #1
    beq.n loc_8001074
    ldrb.w r0, [sp, #7]
    add sp, #0xc
    ldr pc, [sp], #4

    @ 0x800108E
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
    .thumb_func
gpio_read:
    ldr r3, [r0, #0x10]
    tst r1, r3
    ite eq
    moveq r0, #0
    movne r0, #1
    bx lr

    @ 0x800112C
    .thumb_func
gpio_set:
    strh r1, [r0, #0x18]
    bx lr

    @ 0x8001130
    .thumb_func
gpio_clr:
    strh r1, [r0, #0x1a]
    bx lr

    @ 0x8001134
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

    @ 0x8001162
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
    .thumb_func
conv_from_bcd:
    lsrs r3, r0, #4
    add.w r3, r3, r3, lsl #2
    and r0, r0, #0xf
    add.w r0, r0, r3, lsl #1
    uxtb r0, r0
    bx lr

    @ 0x800118E
    .thumb_func
sub_800118E:
    movs r1, #0
    movs r2, #0x7f
    movs r3, #0xff
    stm.w r0, {r1, r2, r3}
    bx lr

    @ 0x800119A
    .thumb_func
sub_800119A:
    movs r3, #0
    strb r3, [r0, #3]
    strb r3, [r0]
    strb r3, [r0, #1]
    strb r3, [r0, #2]
    bx lr

    @ 0x80011A6
    .thumb_func
sub_80011A6:
    movs r3, #1
    strb r3, [r0]
    strb r3, [r0, #2]
    strb r3, [r0, #1]
    movs r3, #0
    strb r3, [r0, #3]
    bx lr

    @ 0x80011B4
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
    .thumb_func
spi_read_dr:
    ldrh r0, [r0, #0xc]
    uxth r0, r0
    bx lr

    @ 0x8001210
    .thumb_func
spi_write_dr:
    strh r1, [r0, #0xc]
    bx lr

    @ 0x8001214
    .thumb_func
spi_get_sr_mask:
    ldrh r3, [r0, #8]
    tst r1, r3
    ite eq
    moveq r0, #0
    movne r0, #1
    bx lr

    @ 0x8001220
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
    .thumb_func
uart_putdr:
    ubfx r1, r1, #0, #9
    strh r1, [r0, #4]
    bx lr

    @ 0x8001240
    .thumb_func
uart_srtest:
    ldrh r3, [r0]
    tst r1, r3
    ite eq
    moveq r0, #0
    movne r0, #1
    bx lr

    @ 0x800124C
aH:
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x28
    .byte 0x28
    .byte 0x28
    .byte 0x28
    .byte 0x28
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x20
    .byte 0x48
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x04
    .byte 0x04
    .byte 0x04
    .byte 0x04
    .byte 0x04
    .byte 0x04
    .byte 0x04
    .byte 0x04
    .byte 0x04
    .byte 0x04
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x81
    .byte 0x81
    .byte 0x81
    .byte 0x81
    .byte 0x81
    .byte 0x81
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x01
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x82
    .byte 0x82
    .byte 0x82
    .byte 0x82
    .byte 0x82
    .byte 0x82
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x02
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x10
    .byte 0x20
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00

    @ 0x800134C
    .thumb_func
sub_800134C:
    cbnz R3, loc_8001362
    cbnz R2, loc_8001362
    cmp r1, #0
    it eq
    cmpeq r0, #0
    beq.n loc_800135E
    mov.w r1, #-1
    mov r0, r1

    @ 0x800135E
loc_800135E:
    b.w loc_80013D8

    @ 0x8001362
loc_8001362:
    sub sp, #8
    mov ip, sp
    push.w {ip, lr}
    bl sub_80013A8
    ldr.w lr, [sp, #4]
    add sp, #8
    pop {r2, r3}
    bx lr
    push.w {r4, r5, r6, r8, sb, sl, fp, lr}
    ldr r6, [sp, #0x20]
    mov r4, r2
    mov r5, r3
    mov r8, r0
    mov sb, r1
    bl sub_80013DC
    mul r3, r4, r1
    umull sl, fp, r4, r0
    mla r2, r0, r5, r3
    add fp, r2
    subs.w r8, r8, sl
    sbc.w sb, sb, fp
    strd r8, sb, [r6]
    pop.w {r4, r5, r6, r8, sb, sl, fp, pc}

    @ 0x80013A8
    .thumb_func
sub_80013A8:
    push.w {r4, r5, r6, r8, sb, sl, fp, lr}
    ldr r6, [sp, #0x20]
    mov r4, r2
    mov r5, r3
    mov r8, r0
    mov sb, r1
    bl sub_800167C
    mul r5, r0, r5
    umull sl, fp, r0, r4
    mla r4, r4, r1, r5
    add fp, r4
    subs.w r8, r8, sl
    sbc.w sb, sb, fp
    strd r8, sb, [r6]
    pop.w {r4, r5, r6, r8, sb, sl, fp, pc}

    @ 0x80013D8
loc_80013D8:
    bx lr
    .align 2

    @ 0x80013DC
    .thumb_func
sub_80013DC:
    cmp r1, #0
    push.w {r4, r5, r6, r7, r8, sb, sl, fp}
    blt.w loc_8001528
    movs r4, #0

    @ 0x80013E8
loc_80013E8:
    cmp r3, #0
    blt.w loc_800151E

    @ 0x80013EE
loc_80013EE:
    mov r5, r2
    mov r6, r0
    mov r7, r1
    cmp r3, #0
    bne.n loc_8001478
    cmp r2, r1
    bls.n loc_80014AE
    clz r3, r2
    cbz R3, loc_8001416
    rsb.w r2, r3, #0x20
    lsl.w r7, r1, r3
    lsr.w r2, r0, r2
    lsls r5, r3
    lsl.w r6, r0, r3
    orrs r7, r2

    @ 0x8001416
loc_8001416:
    lsrs r1, r5, #0x10
    udiv r2, r7, r1
    mls r7, r1, r2, r7
    uxth r0, r5
    mul r3, r0, r2
    lsr.w ip, r6, #0x10
    orr.w r7, ip, r7, lsl #16
    cmp r3, r7
    bls.n loc_8001446
    adds r7, r7, r5
    add.w ip, r2, #-1
    bhs.w loc_8001646
    cmp r3, r7
    bls.w loc_8001646
    subs r2, #2
    add r7, r5

    @ 0x8001446
loc_8001446:
    subs r7, r7, r3
    udiv r3, r7, r1
    mls r1, r1, r3, r7
    mul r0, r0, r3
    uxth r6, r6
    orr.w r1, r6, r1, lsl #16
    cmp r0, r1
    bls.n loc_8001470
    adds r1, r1, r5
    add.w r7, r3, #-1
    bhs.w loc_800164A
    cmp r0, r1
    bls.w loc_800164A
    subs r3, #2

    @ 0x8001470
loc_8001470:
    orr.w r2, r3, r2, lsl #16
    movs r3, #0
    b.n loc_8001480

    @ 0x8001478
loc_8001478:
    cmp r3, r1
    bls.n loc_8001492
    movs r3, #0
    mov r2, r3

    @ 0x8001480
loc_8001480:
    mov r0, r2
    mov r1, r3
    cbz R4, loc_800148C
    rsbs r0, r0, #0
    sbc.w r1, r1, r1, lsl #1

    @ 0x800148C
loc_800148C:
    pop.w {r4, r5, r6, r7, r8, sb, sl, fp}
    bx lr

    @ 0x8001492
loc_8001492:
    clz r8, r3
    cmp.w r8, #0
    bne.w loc_80015AE
    cmp r3, r1
    blo.n loc_80014A8
    cmp r2, r0
    bhi.w loc_800166C

    @ 0x80014A8
loc_80014A8:
    movs r3, #0
    movs r2, #1
    b.n loc_8001480

    @ 0x80014AE
loc_80014AE:
    cbnz R2, loc_80014B6
    movs r3, #1
    udiv r5, r3, r2

    @ 0x80014B6
loc_80014B6:
    clz r2, r5
    cmp r2, #0
    bne.n loc_8001534
    subs r7, r7, r5
    lsrs r0, r5, #0x10
    uxth.w ip, r5
    movs r3, #1

    @ 0x80014C8
loc_80014C8:
    udiv r1, r7, r0
    mls r7, r0, r1, r7
    mul r2, ip, r1
    lsr.w r8, r6, #0x10
    orr.w r7, r8, r7, lsl #16
    cmp r2, r7
    bls.n loc_80014F0
    adds r7, r7, r5
    add.w r8, r1, #-1
    bhs.n loc_80014EE
    cmp r2, r7
    bhi.w loc_8001676

    @ 0x80014EE
loc_80014EE:
    mov r1, r8

    @ 0x80014F0
loc_80014F0:
    subs r7, r7, r2
    udiv r2, r7, r0
    mls r0, r0, r2, r7
    mul ip, ip, r2
    uxth r6, r6
    orr.w r0, r6, r0, lsl #16
    cmp ip, r0
    bls.n loc_8001518
    adds r0, r0, r5
    add.w r7, r2, #-1
    bhs.n loc_8001516
    cmp ip, r0
    bhi.w loc_8001672

    @ 0x8001516
loc_8001516:
    mov r2, r7

    @ 0x8001518
loc_8001518:
    orr.w r2, r2, r1, lsl #16
    b.n loc_8001480

    @ 0x800151E
loc_800151E:
    mvns r4, r4
    rsbs r2, r2, #0
    sbc.w r3, r3, r3, lsl #1
    b.n loc_80013EE

    @ 0x8001528
loc_8001528:
    rsbs r0, r0, #0
    sbc.w r1, r1, r1, lsl #1
    mov.w r4, #-1
    b.n loc_80013E8

    @ 0x8001534
loc_8001534:
    lsls r5, r2
    rsb.w sb, r2, #0x20
    lsr.w r1, r7, sb
    lsr.w sb, r6, sb
    lsls r7, r2
    lsrs r0, r5, #0x10
    udiv r8, r1, r0
    mls r1, r0, r8, r1
    uxth.w ip, r5
    mul r3, ip, r8
    orr.w sb, sb, r7
    lsr.w r7, sb, #0x10
    orr.w r1, r7, r1, lsl #16
    cmp r3, r1
    lsl.w r6, r6, r2
    bls.n loc_800157C
    adds r1, r1, r5
    add.w r2, r8, #-1
    bhs.n loc_8001668
    cmp r3, r1
    bls.n loc_8001668
    sub.w r8, r8, #2
    add r1, r5

    @ 0x800157C
loc_800157C:
    subs r1, r1, r3
    udiv r3, r1, r0
    mls r7, r0, r3, r1
    mul r2, ip, r3
    uxth.w sb, sb
    orr.w r7, sb, r7, lsl #16
    cmp r2, r7
    bls.n loc_80015A6
    adds r7, r7, r5
    add.w r1, r3, #-1
    bhs.n loc_8001660
    cmp r2, r7
    bls.n loc_8001660
    subs r3, #2
    add r7, r5

    @ 0x80015A6
loc_80015A6:
    subs r7, r7, r2
    orr.w r3, r3, r8, lsl #16
    b.n loc_80014C8

    @ 0x80015AE
loc_80015AE:
    rsb.w r2, r8, #0x20
    lsr.w r1, r5, r2
    lsl.w ip, r3, r8
    lsr.w r3, r7, r2
    lsr.w r2, r0, r2
    lsl.w r7, r7, r8
    orr.w ip, r1, ip
    lsr.w sb, ip, #0x10
    udiv r1, r3, sb
    mls r3, sb, r1, r3
    uxth.w sl, ip
    mul fp, sl, r1
    orrs r7, r2
    lsrs r2, r7, #0x10
    orr.w r3, r2, r3, lsl #16
    cmp fp, r3
    lsl.w r0, r5, r8
    bls.n loc_8001600
    adds.w r3, r3, ip
    add.w r2, r1, #-1
    bhs.n loc_8001664
    cmp fp, r3
    bls.n loc_8001664
    subs r1, #2
    add r3, ip

    @ 0x8001600
loc_8001600:
    rsb r3, fp, r3
    udiv r2, r3, sb
    mls r3, sb, r2, r3
    mul sl, sl, r2
    uxth r7, r7
    orr.w r7, r7, r3, lsl #16
    cmp sl, r7
    bls.n loc_800162C
    adds.w r7, r7, ip
    add.w r3, r2, #-1
    bhs.n loc_800165C
    cmp sl, r7
    bls.n loc_800165C
    subs r2, #2
    add r7, ip

    @ 0x800162C
loc_800162C:
    orr.w r5, r2, r1, lsl #16
    umull r0, r1, r5, r0
    rsb r7, sl, r7
    cmp r7, r1
    mov.w r3, #0
    blo.n loc_8001656
    beq.n loc_800164E

    @ 0x8001642
loc_8001642:
    mov r2, r5
    b.n loc_8001480

    @ 0x8001646
loc_8001646:
    mov r2, ip
    b.n loc_8001446

    @ 0x800164A
loc_800164A:
    mov r3, r7
    b.n loc_8001470

    @ 0x800164E
loc_800164E:
    lsl.w r6, r6, r8
    cmp r6, r0
    bhs.n loc_8001642

    @ 0x8001656
loc_8001656:
    subs r2, r5, #1
    movs r3, #0
    b.n loc_8001480

    @ 0x800165C
loc_800165C:
    mov r2, r3
    b.n loc_800162C

    @ 0x8001660
loc_8001660:
    mov r3, r1
    b.n loc_80015A6

    @ 0x8001664
loc_8001664:
    mov r1, r2
    b.n loc_8001600

    @ 0x8001668
loc_8001668:
    mov r8, r2
    b.n loc_800157C

    @ 0x800166C
loc_800166C:
    mov r3, r8
    mov r2, r8
    b.n loc_8001480

    @ 0x8001672
loc_8001672:
    subs r2, #2
    b.n loc_8001518

    @ 0x8001676
loc_8001676:
    subs r1, #2
    add r7, r5
    b.n loc_80014F0

    @ 0x800167C
    .thumb_func
sub_800167C:
    push.w {r4, r5, r6, r7, r8, sb, sl, fp}
    mov r4, r2
    mov r5, r0
    mov r6, r1
    cmp r3, #0
    bne.n loc_8001712
    cmp r2, r1
    bls.n loc_8001736
    clz r7, r2
    cbz R7, loc_80016AA
    rsb.w r6, r7, #0x20
    lsr.w r6, r0, r6
    lsl.w r3, r1, r7
    lsl.w r4, r2, r7
    lsl.w r5, r0, r7
    orrs r6, r3

    @ 0x80016AA
loc_80016AA:
    lsrs r1, r4, #0x10
    udiv r2, r6, r1
    mls r6, r1, r2, r6
    uxth r0, r4
    mul r3, r0, r2
    lsrs r7, r5, #0x10
    orr.w r6, r7, r6, lsl #16
    cmp r3, r6
    bls.n loc_80016D8
    adds r6, r6, r4
    add.w r7, r2, #-1
    bhs.w loc_80018C8
    cmp r3, r6
    bls.w loc_80018C8
    subs r2, #2
    add r6, r4

    @ 0x80016D8
loc_80016D8:
    subs r6, r6, r3
    udiv r3, r6, r1
    mls r1, r1, r3, r6
    mul r0, r0, r3
    uxth r5, r5
    orr.w r1, r5, r1, lsl #16
    cmp r0, r1
    bls.n loc_8001702
    adds r1, r1, r4
    add.w r6, r3, #-1
    bhs.w loc_80018CC
    cmp r0, r1
    bls.w loc_80018CC
    subs r3, #2

    @ 0x8001702
loc_8001702:
    orr.w r2, r3, r2, lsl #16
    movs r3, #0

    @ 0x8001708
loc_8001708:
    mov r0, r2
    mov r1, r3
    pop.w {r4, r5, r6, r7, r8, sb, sl, fp}
    bx lr

    @ 0x8001712
loc_8001712:
    cmp r3, r1
    bhi.n loc_80017B0
    clz r6, r3
    cmp r6, #0
    bne.n loc_80017BE
    cmp r3, r1
    blo.n loc_8001728
    cmp r2, r0
    bhi.w loc_80018E2

    @ 0x8001728
loc_8001728:
    pop.w {r4, r5, r6, r7, r8, sb, sl, fp}
    movs r3, #0
    movs r2, #1
    mov r0, r2
    mov r1, r3
    bx lr

    @ 0x8001736
loc_8001736:
    cbnz R2, loc_800173E
    movs r4, #1
    udiv r4, r4, r2

    @ 0x800173E
loc_800173E:
    clz r2, r4
    cmp r2, #0
    bne.w loc_800184C
    subs r1, r1, r4
    lsrs r6, r4, #0x10
    uxth r7, r4
    movs r3, #1

    @ 0x8001750
loc_8001750:
    udiv r0, r1, r6
    mls r1, r6, r0, r1
    mul r2, r7, r0
    lsr.w ip, r5, #0x10
    orr.w r1, ip, r1, lsl #16
    cmp r2, r1
    bls.n loc_8001778
    adds r1, r1, r4
    add.w ip, r0, #-1
    bhs.n loc_8001776
    cmp r2, r1
    bhi.w loc_8001906

    @ 0x8001776
loc_8001776:
    mov r0, ip

    @ 0x8001778
loc_8001778:
    subs r1, r1, r2
    udiv r2, r1, r6
    mls r1, r6, r2, r1
    mul r7, r7, r2
    uxth r5, r5
    orr.w r5, r5, r1, lsl #16
    cmp r7, r5
    bls.n loc_80017A2
    adds r4, r5, r4
    add.w r1, r2, #-1
    bhs.w loc_80018D0
    cmp r7, r4
    bls.w loc_80018D0
    subs r2, #2

    @ 0x80017A2
loc_80017A2:
    orr.w r2, r2, r0, lsl #16
    mov r0, r2
    mov r1, r3
    pop.w {r4, r5, r6, r7, r8, sb, sl, fp}
    bx lr

    @ 0x80017B0
loc_80017B0:
    movs r3, #0
    mov r2, r3
    mov r0, r2
    mov r1, r3
    pop.w {r4, r5, r6, r7, r8, sb, sl, fp}
    bx lr

    @ 0x80017BE
loc_80017BE:
    rsb.w r5, r6, #0x20
    lsr.w r7, r2, r5
    lsl.w r4, r3, r6
    lsr.w r3, r1, r5
    lsl.w fp, r1, r6
    lsr.w r5, r0, r5
    orrs r4, r7
    lsr.w r8, r4, #0x10
    udiv ip, r3, r8
    mls r3, r8, ip, r3
    uxth.w sb, r4
    mul sl, sb, ip
    orr.w fp, r5, fp
    lsr.w r5, fp, #0x10
    orr.w r3, r5, r3, lsl #16
    cmp sl, r3
    lsl.w r2, r2, r6
    bls.n loc_800180A
    adds r3, r3, r4
    add.w r5, ip, #-1
    blo.n loc_80018E8

    @ 0x8001808
loc_8001808:
    mov ip, r5

    @ 0x800180A
loc_800180A:
    rsb r3, sl, r3
    udiv r5, r3, r8
    mls r3, r8, r5, r3
    mul sb, sb, r5
    uxth.w fp, fp
    orr.w r7, fp, r3, lsl #16
    cmp sb, r7
    bls.n loc_8001830
    adds r7, r7, r4
    add.w r3, r5, #-1
    blo.n loc_80018F4

    @ 0x800182E
loc_800182E:
    mov r5, r3

    @ 0x8001830
loc_8001830:
    orr.w ip, r5, ip, lsl #16
    umull r2, r3, ip, r2
    rsb r7, sb, r7
    cmp r7, r3
    mov.w r5, #0
    blo.n loc_80018DA
    beq.n loc_80018D4

    @ 0x8001846
loc_8001846:
    mov r2, ip
    mov r3, r5
    b.n loc_8001708

    @ 0x800184C
loc_800184C:
    lsls r4, r2
    rsb.w sb, r2, #0x20
    lsr.w ip, r1, sb
    lsls r1, r2
    lsr.w sb, r0, sb
    lsrs r6, r4, #0x10
    udiv r8, ip, r6
    mls ip, r6, r8, ip
    uxth r7, r4
    mul r3, r7, r8
    orr.w sb, sb, r1
    lsr.w r1, sb, #0x10
    orr.w ip, r1, ip, lsl #16
    cmp r3, ip
    lsl.w r5, r0, r2
    bls.n loc_8001894
    adds.w ip, ip, r4
    add.w r2, r8, #-1
    bhs.n loc_8001902
    cmp r3, ip
    bls.n loc_8001902
    sub.w r8, r8, #2
    add ip, r4

    @ 0x8001894
loc_8001894:
    rsb ip, r3, ip
    udiv r3, ip, r6
    mls r1, r6, r3, ip
    mul r2, r7, r3
    uxth.w sb, sb
    orr.w r1, sb, r1, lsl #16
    cmp r2, r1
    bls.n loc_80018C0
    adds r1, r1, r4
    add.w r0, r3, #-1
    bhs.n loc_80018FE
    cmp r2, r1
    bls.n loc_80018FE
    subs r3, #2
    add r1, r4

    @ 0x80018C0
loc_80018C0:
    subs r1, r1, r2
    orr.w r3, r3, r8, lsl #16
    b.n loc_8001750

    @ 0x80018C8
loc_80018C8:
    mov r2, r7
    b.n loc_80016D8

    @ 0x80018CC
loc_80018CC:
    mov r3, r6
    b.n loc_8001702

    @ 0x80018D0
loc_80018D0:
    mov r2, r1
    b.n loc_80017A2

    @ 0x80018D4
loc_80018D4:
    lsls r0, r6
    cmp r0, r2
    bhs.n loc_8001846

    @ 0x80018DA
loc_80018DA:
    add.w r2, ip, #-1
    movs r3, #0
    b.n loc_8001708

    @ 0x80018E2
loc_80018E2:
    mov r3, r6
    mov r2, r6
    b.n loc_8001708

    @ 0x80018E8
loc_80018E8:
    cmp sl, r3
    bls.n loc_8001808
    sub.w ip, ip, #2
    add r3, r4
    b.n loc_800180A

    @ 0x80018F4
loc_80018F4:
    cmp sb, r7
    bls.n loc_800182E
    subs r5, #2
    add r7, r4
    b.n loc_8001830

    @ 0x80018FE
loc_80018FE:
    mov r3, r0
    b.n loc_80018C0

    @ 0x8001902
loc_8001902:
    mov r8, r2
    b.n loc_8001894

    @ 0x8001906
loc_8001906:
    subs r0, #2
    add r1, r4
    b.n loc_8001778

    @ 0x800190C
    .thumb_func
cortex_m3_system_reset:
    dsb sy
    ldr r2, [pc, #0x10]
    ldr r3, [pc, #0x14]
    ldr r1, [r2, #0xc]
    and r1, r1, #0x700
    orrs r3, r1
    str r3, [r2, #0xc]
    dsb sy

    @ 0x8001922
loc_8001922:
    b.n loc_8001922

    @ 0x8001924
_8001924:
    .4byte 0xE000ED00

    @ 0x8001928
_8001928:
    .4byte 0x5FA0004

    @ 0x800192C
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
    .align 4

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
    .align 4

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
    .4byte gpio_cfg

    @ 0x8001D54
_8001D54:
    .4byte 0x40003800

    @ 0x8001D58
_8001D58:
    .4byte _2000000C

    @ 0x8001D5C
    .thumb_func
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
    .align 4

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
    bl sub_8000810
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
    bl sub_8000828
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
    bl sub_8000810
    mov r1, r6
    mov r0, r5
    bl sub_8000828
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
    .align 4

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
    .4byte _20000000

    @ 0x8002CB0
_8002CB0:
    .4byte _20000020

    @ 0x8002CB4
_8002CB4:
    .4byte data_start

    @ 0x8002CB8
_8002CB8:
    .4byte _20000020

    @ 0x8002CBC
_8002CBC:
    .4byte _20010048

    @ 0x8002CC0
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

    @ 0x8002FEC
    .thumb_func
fault_entry:
    tst.w lr, #4
    ite eq
    mrseq r0, msp
    mrsne r0, psp
    b.w hardfault
    bx lr

    @ 0x8003000
    .thumb_func
sub_8003000:
    cmp r1, #3
    push {r4, r5, r6, lr}
    mov r5, r0
    mov r4, r1
    bls.n loc_8003018
    lsrs r6, r1, #2
    mov r1, r6
    bl sub_8000828
    lsls r6, r6, #2
    add r5, r6
    subs r4, r4, r6

    @ 0x8003018
loc_8003018:
    cbnz R4, loc_8003020
    bl sub_8000844
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
    bl sub_800081C
    pop {r4, r5, r6, pc}

    @ 0x8003036
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
    .thumb_func
putnewline:
    push {r3, lr}
    movs r0, #0xd
    bl putchar
    movs r0, #0xa
    bl putchar
    pop {r3, pc}

    @ 0x800317A
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
    .thumb_func
putsnl:
    push {r3, lr}
    bl puts
    bl putnewline
    pop {r3, pc}

    @ 0x8003198
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

    .byte 0x00, 0x00

    .data

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
a0123456789ab_0:
    .asciz "0123456789ABCDEF"

    @ 0x8003FB8
a0123456789abcd:
    .asciz "0123456789abcdef"

    @ 0x8003FC9
aNull:
    .asciz "(null)"

    @ 0x8003FD0
_8003FD0:
    .4byte 0x0
    .byte 0x01
    .byte 0x2
    .byte 0x3
    .byte 0x4
    .4byte 0x4030201
    .4byte 0x9080706

    @ 0x8003FE0
data_start:
    .byte 0xFF
    .byte 0xFF
    .byte 0xFF
    .byte 0xFF
    .byte 0x0
    .byte 0xA0
    .byte 0x0
    .byte 0x0
    .byte 0x2
    .byte 0x2
    .byte 0x0
    .byte 0x0
    .byte 0x00
    .byte 0xC0
    .byte 0x04
    .byte 0x01
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .byte 0x00
    .4byte 0x2000000
    .4byte 0x10
    .4byte 0x7
