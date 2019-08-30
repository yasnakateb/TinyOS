#TOOL INPUT
BOOT=src/boot/boot.asm
KERNEL=src/kernel/kernel.c
KERNEL_ENTRY=src/kernel/kernel_entry.asm
INCLUDE=include/
BIN=bin/
BUILD=build/

#TOOLS
EMULATOR=qemu-system-x86_64
NASM = /usr/bin/nasm
CROSSCOMPILER= i386-elf-gcc
LINKER=i386-elf-ld

#TOOL OPTIONS
EFLAGS=-boot c 						# EMULATOR FLAG
FORMAT=bin 
CCFLAGS=-ffreestanding -c 			# CROSS  COMPILER ==> To compile system-independent code
								
#TOOL OUTPUT
BOOT_SECT=bin/boot_sect.bin
MAIN_KERNEL=bin/kernel.bin
OS = bin/os_image.bin

###############################################################################

run: $(OS)
	$(EMULATOR) -fda $<

os_image.bin: $(BOOT_SECT)  $(MAIN_KERNEL)
	cat $^ > $(BIN)$@

boot_sect.bin: $(BOOT)
	$(NASM) $< -f $(FORMAT) -o $(BIN)/$@

kernel.bin: $(BUILD)/kernel_entry.o $(BUILD)/kernel.o
	$(LINKER) -o $(BIN)/$@ -Ttext 0x1000 $^ --oformat binary

kernel.o: $(KERNEL)
	$(CROSSCOMPILER) $(CCFLAGS) $< -o $(BUILD)/$@

kernel_entry.o: $(KERNEL_ENTRY)
	$(NASM) $< -f elf -o $(BUILD)/$@

