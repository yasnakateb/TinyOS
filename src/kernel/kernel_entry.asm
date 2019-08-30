[bits 32]						;;; In  protected  mode 
														
[extern main] 					;;; Referencing  the  external  symbol  ’main ’
call main 						;;; Invoke  main() in our C kernel
jmp $
