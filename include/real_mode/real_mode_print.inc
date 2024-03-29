;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Real_Mode_Print:
    pusha

Real_Mode_Print_Char:
    mov al, [bx] 
    or al, al
    jz Real_Mode_Done
    mov ah, 0x0e
    int 0x10 
    add bx, 1
    jmp Real_Mode_Print_Char

Real_Mode_Done:
    mov ah, 0x0e
    mov al, 0x0a                ;;; Newline char
    int 0x10
    mov al, 0x0d                ;;; Carriage return
    int 0x10
    popa
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Bios_Print_Hex:
    pusha
    mov cx, 0

Hex_Loop:
    cmp cx, 4 
    je End
    mov ax, dx 
    and ax, 0x000f 
    add al, 0x30 
    cmp al, 0x39 
    jle Position
    add al, 7 

Position:
    mov bx, hex_number + 5 
    sub bx, cx  
    mov [bx], al
    ror dx, 4 
    add cx, 1
    jmp Hex_Loop

End:
    mov bx, hex_number
    call Real_Mode_Print

    popa
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

hex_number   db '0x0000',0
