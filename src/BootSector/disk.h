;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; INT 0x13
;;;
;;; ah <- int 0x13 function. 0x02 = read
;;; al <- number of sectors to read (0x01 .. 0x80)
;;; cl <- sector (0x01 .. 0x11)
;;; 0x01 is our boot sector, 0x02 is the first 'available' sector
;;; ch <- cylinder (0x0 .. 0x3FF, upper 2 bits in 'cl')
;;; dl <- drive number. 
;;; dh <- head number (0x0 .. 0xF) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Disk_Load:
    pusha
    push dx

    mov ah, 0x02                
    mov al, dh                  
    mov cl, 0x02               
    mov ch, 0x00                
    mov dh, 0x00                
    int 0x13                     ;;; BIOS interrupt
    jc  Disk_Error               

    pop dx
    cmp al, dh                  
    jne Sectors_Error
    popa
    ret

Disk_Error:
    mov bx, msg_Disk_ERROR
    call Bios_Print
    mov dh, ah                  ;;; ah = Error code
    call Bios_Print_Hex        
    jmp Disk_Loop

Sectors_Error:
    mov bx, msg_Sector_ERROR
    call Bios_Print

Disk_Loop:
    jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; ERROR MESSAGES
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

msg_Disk_ERROR: db "Disk read error", 0
msg_Sector_ERROR: db "Incorrect number of sectors read", 0 
    
