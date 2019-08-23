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

    mov bx, msg_Real_Mode
    call Real_Mode_Print

    call Switch_To_Protected_Mode
    jmp $


%include 'real_mode/real_mode_print.inc'
%include 'protected_mode/32_bit_print.inc'
%include 'protected_mode/switch.inc'
%include 'protected_mode/gdt.inc'


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 32-bit Protected Mode
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                                
[bits 32]
BEGIN_Protected_Mode:           ;;; After the switch we will get here
    mov ebx, msg_Protected_Mode
    call Protected_Mode_Print
    jmp $


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
    

  

    
