.thumb
.syntax unified
.section .text.asm,"ax",%progbits

    .section .text.unaligned

    @ 0x800005A
    .global memset
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

.section .text.aligned

    @ 0x80000E0
    .global strlen
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
    .global memcmp
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
    .global rcc_set_csr_rmvf
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
    .global timer_enable
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
