OUTPUT_FORMAT("binary")
OUTPUT_ARCH("i386")

ENTRY(_main);
SECTIONS {
    . = 0;
    .bootsect : { *(.bootsect) }
}