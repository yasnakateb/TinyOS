GDT_Start: 
                                ;;; The GDT starts with a null 8-byte
    dd 0x0 
    dd 0x0 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GDT for code segment. base = 0x00000000, length = 0xfffff
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GDT_Code: 
    dw 0xffff                   ;;; Segment length, bits 0-15
    dw 0x0                      ;;; Segment base, bits 0-15
    db 0x0                      ;;; Segment base, bits 16-23
    db 10011010b                ;;; Flags (8 bits)
    db 11001111b                ;;; Flags (4 bits) + segment length, bits 16-19
    db 0x0                      ;;; Segment base, bits 24-31

GDT_Data:
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

GDT_End:
                            
GDT_Descriptor:
    dw GDT_End - GDT_Start - 1  ;;; Size (16 bit)
    dd GDT_Start                ;;; Address (32 bit)

CODE_SEGMENT equ GDT_Code - GDT_Start
DATA_SEGMENT equ GDT_Data - GDT_Start
