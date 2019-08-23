;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; BOOT SECTOR
;;; Boot sector loaded by BIOS is 512 bytes
;;; The code in the boot sector of the disk is loaded by the BIOS at 0000:7c00
;;; Machine starts in Real Mode. Then it switches from 16-bit real mode 
;;; into 32-bit protected mode.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

[org 0x7c00]

start:
    xor ax, ax
    mov ds, ax
    cld
 
    mov bx, message
    call Bios_Print
    mov bx, msg_Read_From_Disk
    call Bios_Print
                                
    mov bp, 0x8000                      
    mov sp, bp

    mov bx, 0x9000              ;;; es:bx = 0x0000:0x9000 = 0x09000
    mov dh, 2                   ;;; Read 2 sectors
                                ;;; The bios sets 'dl' for our boot disk number
    call Disk_Load

    mov dx, [0x9000]            ;;; Retrieve the first loaded word, 0xaebe
    call Bios_Print_Hex

    mov dx, [0x9000 + 512]      ;;; First word from second loaded sector, 0xcede
    call Bios_Print_Hex

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
    
    message   db 'Have fun, you guys', 0
    msg_Read_From_Disk db 'Reading data from a disk in order to run the kernel', 0
    
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


  

    
