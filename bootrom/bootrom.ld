OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm",
	      "elf32-littlearm")
OUTPUT_ARCH(arm)

MEMORY
{
  FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 0x8000
  RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 524288
}

SECTIONS
{
    .text :
    {
        KEEP(*(.isr_vector)) /* Startup code */
        *(.text.*)
        *(.rodata*)

	    . = ALIGN(4);
   	 _etext = .;
	    /* This is used by the startup in order to initialize the .data secion */
   	 _sidata = _etext;
    } >FLASH

    .data  : AT ( _sidata )
        {
    	    . = ALIGN(4);
            /* This is used by the startup in order to initialize the .data secion */
            _sdata = . ;

            *(.data)
            *(.data.*)

    	    . = ALIGN(4);
    	    /* This is used by the startup in order to initialize the .data secion */
       	 _edata = . ;
        } >RAM

        /DISCARD/ :
            {
             *(*)
             }
}
