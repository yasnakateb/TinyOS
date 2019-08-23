[bits 16]
                                
Switch_To_Protected_Mode:
    cli                         ;;; Disable interrupts
    lgdt [GDT_Descriptor]       ;;; Load the GDT descriptor
    mov eax, cr0                ;;; The CPU control register ==> cr0
    or eax, 0x1                 ;;; Set 32-bit mode bit in cr0
    mov cr0, eax
    jmp CODE_SEGMENT:Protected_Mode     

[bits 32]

Protected_Mode: 
    mov ax, DATA_SEGMENT        ;;; Update the segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000            ;;; Update the stack right at the top of the free space
    mov esp, ebp

    call BEGIN_Protected_Mode     

