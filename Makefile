#TOOL INPUT
SRC=src/boot.asm
INCLUDE=include/
BIN=bin/

#TOOLS
EMULATOR=qemu-system-x86_64
NASM = /usr/bin/nasm

#TOOL OPTIONS
EFLAGS=-boot c 
FORMAT=bin 

#TOOL OUTPUT
BOOT=bin/boot.bin


###############################################################################
run: 
	$(EMULATOR) $(BOOT) $(EFLAGS)

$(BOOT):
	$(NASM) -i $(INCLUDE) -f $(FORMAT) $(SRC) -o $(BIN)/$@
