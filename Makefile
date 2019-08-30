#TOOL INPUT
BOOT=src/boot/boot.asm
KERNEL=src/kernel/kernel.c
KERNEL_ENTRY=src/kernel/kernel_entry.asm
INCLUDE=include/
BIN=bin

#TOOLS
EMULATOR=qemu-system-x86_64
NASM = /usr/bin/nasm
CROSSCOMPILER= i386-elf-gcc
LINKER=i386-elf-ld

#TOOL OPTIONS
EFLAGS=-boot c 				        ### EMULATOR FLAG
FORMAT=bin 
CCFLAGS=-ffreestanding -c 			### CROSS COMPILER ==> To compile system-independent code
								
#TOOL OUTPUT
BOOT_SECT=bin/boot_sect.bin
MAIN_KERNEL=bin/kernel.bin
OS = bin/os_image.bin

###############################################################################

run:  $(OS)
	$(EMULATOR) -fda $<

$(OS): $(BOOT_SECT)  $(MAIN_KERNEL)
	cat $^ > $@

$(BOOT_SECT): $(BOOT)
	$(NASM) $< -f $(FORMAT) -o $@

$(MAIN_KERNEL): kernel_entry.o kernel.o
	$(LINKER) -o $@ -Ttext 0x1000 $^ --oformat binary

kernel.o: $(KERNEL)
	$(CROSSCOMPILER) $(CCFLAGS) $< -o $@

kernel_entry.o: $(KERNEL_ENTRY)
	$(NASM) $< -f elf -o  $@

