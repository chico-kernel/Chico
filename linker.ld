OUTPUT_FORMAT("binary")
ENTRY(kernel_main)

SECTIONS {
    . = 0x7E00;

    .text ALIGN(4) :
    {
        *(.text)
    }

    .data ALIGN(4) :
    {
        *(.data)
    }

    .bss ALIGN(4) :
    {
        *(.bss)
    }

    /DISCARD/ :
    {
        *(.eh_frame)
        *(.comment)
    }
}
