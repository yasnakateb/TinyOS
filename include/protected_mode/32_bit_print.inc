[bits 32]                       ;;; 32-bit protected mode 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; A simple font is already defined in the internal memory of the 
;;; VGA display device. Each character cell of the screen is represented 
;;; by two bytes in memory: 
;;; 1. The first byte is the ASCII code of the character to be displayed.
;;; 2. The second byte encodes the characters attributes, such as the 
;;;    foreground and background colour.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f         ;;; Foreground and background colour

Protected_Mode_Print:
    pusha
    mov edx, VIDEO_MEMORY

Protected_Mode_Print_Char:
    mov al, [ebx]               ;;; Address of our character
    mov ah, WHITE_ON_BLACK

    cmp al, 0 
    je Protected_Mode_Done

    mov [edx], ax               ;;; Store character + attribute in video memory
    add ebx, 1 
    add edx, 2                  ;;; Next video memory position

    jmp Protected_Mode_Print_Char

Protected_Mode_Done:
    popa
    ret