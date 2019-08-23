;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; BOOT SECTOR
;;; Boot sector loaded by BIOS is 512 bytes
;;; The code in the boot sector of the disk is loaded by the BIOS at 0000:7c00
;;; Machine starts in Real Mode. Then it switches from 16-bit real mode 
;;; into 32-bit protected mode.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[org 0x7c00]

start:
    mov bp, 0x9000                      
    mov sp, bp


    jmp $


%include 'real_mode/real_mode_print.inc'
%include 'protected_mode/32_bit_print.inc'
%include 'protected_mode/switch.inc'
%include 'protected_mode/gdt.inc'


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MESSAGES
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    msg_Real_Mode db "Real mode", 0
    msg_Protected_Mode db "Protected mode", 0   
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; SECTORS
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    times 510-($-$$) db 0       ;;; Fill with 510 zeros
    db 0x55
    db 0xAA                     ;;; Boot sector
    times 256 dw 0xaebe         ;;; Sector 2 
    times 256 dw 0xcede         ;;; Sector 3 


  

    
