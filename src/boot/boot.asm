;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; BOOT SECTOR
;;; Boot sector loaded by BIOS is 512 bytes
;;; The code in the boot sector of the disk is loaded by the BIOS at 
;;; 0000:7c00 Machine starts in Real Mode. Then it switches from 16-bit 
;;; real mode into 32-bit protected mode.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                
[org 0x7c00]
KERNEL_OFFSET  equ 0x1000       ;;; This is the  memory  offset  to which  we will  load  our  kernel

    mov [BOOT_DRIVE], dl        ;;; Stores boot  drive (INT 0x13)
    mov bp, 0x9000                      
    mov sp, bp

    mov bx, msg_Real_Mode
    call Real_Mode_Print

    call  Load_Kernel           ;;; Load kernel

    call Switch_To_Protected_Mode
    jmp $


%include 'include/real_mode/real_mode_print.inc'
%include 'include/protected_mode/32_bit_print.inc'
%include 'include/protected_mode/switch.inc'
%include 'include/protected_mode/gdt.inc'
%include 'include/real_mode/disk.inc'


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 16-bit Real Mode
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                
[bits  16]

Load_Kernel:
    mov bx, msg_Load_Kernel     ;;; Load kernel
    call Real_Mode_Print
    mov bx, KERNEL_OFFSET       ;;; Read from disk and store in 0x1000
    mov dh, 2                   ;;; Load  the  first 2 sectors 
    mov dl, [BOOT_DRIVE]        ;;; Drive number      
    call Disk_Load              ;;; INT 0x13
    ret




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; 32-bit Protected Mode
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                                
[bits 32]
Begin_Protected_Mode:           ;;; After the switch we will get here
    mov ebx, msg_Protected_Mode
    call Protected_Mode_Print
    call KERNEL_OFFSET          ;;; Give control to the kernel
    jmp $ 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; MESSAGES
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BOOT_DRIVE db 0 
    msg_Real_Mode db "Real mode", 0
    msg_Protected_Mode db "Protected mode", 0 
    msg_Load_Kernel db "Loading  kernel  into  memory.", 0  
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; SECTORS
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    times 510-($-$$) db 0       ;;; Fill with 510 zeros
    db 0x55
    db 0xAA                     ;;; Boot sector
    

  

    
