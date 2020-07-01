.thumb
.syntax unified
.section .text.asm,"ax",%progbits


    @ 0x800106C
    .global sub_800106C
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
