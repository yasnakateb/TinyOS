    ;;;Boot sector loaded by BIOS is 512 bytes
    ;;;The code in the boot sector of the disk is loaded by the BIOS at 0000:7c00
    ;;;Machine starts in Real Mode     
[org 0x7c00]


start:
    xor ax, ax
    mov ds, ax
    cld
 
    mov si, message
    call Bios_Print
    mov si, msg_read_from_disk
    call Bios_Print


%include 'print.h'

hang:                           ;;; Infinite loop
    jmp hang

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    message   db 'Have fun, you guys', 13, 10, 0
    msg_read_from_disk db 'Reading data from a disk in order to run the kernel', 13, 10, 0

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    times 510-($-$$) db 0       ;;; Fill with 510 zeros
    db 0x55
    db 0xAA
    
