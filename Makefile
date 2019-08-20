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
BOOTSECTOR=bin/boot.bin


###############################################################################
run: 
	$(EMULATOR) $(BOOTSECTOR) $(EFLAGS)

$(BOOTSECTOR):
	$(NASM) -i $(INCLUDE) -f $(FORMAT) $(SRC) -o $(BIN)/$@
