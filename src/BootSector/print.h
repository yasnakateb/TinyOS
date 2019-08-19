;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Bios_Print:
    pusha
print_char:
    mov al, [si] 
    or al, al
    jz done
    mov ah, 0x0e
    int 0x10 
    add si, 1
    jmp print_char
done:
    popa
    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Bios_Print_Hex:
    pusha
    mov cx, 0

hex_loop:
    cmp cx, 4 
    je end
    mov ax, dx 
    and ax, 0x000f 
    add al, 0x30 
    cmp al, 0x39 
    jle position
    add al, 7 

position:
    
    mov bx, hex_number + 5 
    sub bx, cx  
    mov [bx], al
    ror dx, 4 
    add cx, 1
    jmp hex_loop

end:
    mov bx, hex_number
    call Bios_Print

    popa
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

hex_number   db '0x0000',0