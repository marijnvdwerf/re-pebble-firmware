OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm",
	      "elf32-littlearm")
OUTPUT_ARCH(arm)

MEMORY
{
  FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 0xFFFFFFFF
  RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 524288
}

SECTIONS
{
    . = 0x08000000;

    .text :
    {
        *(.text)
        *(.text.*)
        *(.rodata)
        *(.rodata*)
    } > FLASH
}
