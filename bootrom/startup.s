.section .isr_vector

    .global g_pfnVectors
  .type  g_pfnVectors, %object
  .size  g_pfnVectors, .-g_pfnVectors
g_pfnVectors:
    .4byte 0x20012048
    .4byte _entry
    .4byte fault_entry
    .4byte fault_entry
    .4byte fault_entry
    .4byte fault_entry
    .4byte fault_entry
    .4byte 0x0
    .4byte 0x0
    .4byte 0x0
    .4byte 0x0
    .4byte fault_entry
    .4byte fault_entry
    .4byte 0x0
    .4byte fault_entry
    .4byte fault_entry
    .4byte 0x139C
    .4byte 0x1
