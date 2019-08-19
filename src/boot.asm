    ;;;Boot sector loaded by BIOS is 512 bytes
    ;;;The code in the boot sector of the disk is loaded by the BIOS at 0000:7c00
    ;;;Machine starts in Real Mode     
[org 0x7c00]

%include "bios.h"

hang:                           ;;; Infinite loop
    jmp hang
    
    times 510-($-$$) db 0       ;;; Fill with 510 zeros
    db 0x55
    db 0xAA
    
