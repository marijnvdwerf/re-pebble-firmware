.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x8000868
    .global flash_unlock
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
    .global flash_set_lock
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
    .global flash_set_sr
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
    .global sub_80008A0
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
    .align 2

    @ 0x80008D0
_80008D0:
    .4byte 0x40023C00

    @ 0x80008D4
    .global sub_80008D4
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
    .align 2

    @ 0x8000940
_8000940:
    .4byte 0x40023C00

    @ 0x8000944
    .global sub_8000944
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
