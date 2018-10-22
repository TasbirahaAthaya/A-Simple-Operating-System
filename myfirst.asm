BITS 16

start:
	mov ax, 07C0h		; Set up 4K stack space after this bootloader
	add ax, 288		; (4096 + 512) / 16 bytes per paragraph
	mov ss, ax
	mov sp, 4096

	mov ax, 07C0h		; Set data segment to where we're loaded
	mov ds, ax


	mov si, text_enter	; Put string position into SI
	call print_string	; Call our string-printing routine
        
        mov ah,00h	;newline	
	int 16h 

	mov al,0Ah
	mov ah,0eh
	int 10h 

	mov al,0dh
	mov ah,0eh
	int 10h
        
       

        mov ah,00h		
        int 16h 	;it takes input from the keystroke and (1st input)                 
        mov ah,0eh
        mov dl,al
        mov cl,al
        sub cl,48
        int 10h 
        
       mov ah,00h	;newline	
	int 16h 

	mov al,0Ah
	mov ah,0eh
	int 10h 

	mov al,0dh
	mov ah,0eh
	int 10h
	

  
 
        
        mov ah,00h		
        int 16h 	;it takes input from the keystroke and (2nd input)                 
        mov ah,0eh
        mov dl,al
        mov bl,al
        sub bl,48
        int 10h

        mov ah,00h	;newline	
	int 16h 

	mov al,0Ah
	mov ah,0eh
	int 10h 

	mov al,0dh
	mov ah,0eh
	int 10h
       
  

      
	
       mov si, text_add	; Put string position into SI
	call print_string
       
        mov al,cl     ; add
        add al,bl
        add al,48
         mov dl,al
        mov ah,0eh
        int 10h
        
        mov ah,00h	;newline	
	int 16h 

	mov al,0Ah
	mov ah,0eh
	int 10h 

	mov al,0dh
	mov ah,0eh
	int 10h
   

 

        mov si, text_sub	; Put string position into SI
	call print_string
        
        mov al,cl   ;sub 
        sub al,bl
        add al,48
        mov dl,al
        mov ah,0eh
        int 10h
        

	jmp $			; Jump here - infinite loop!


	text_string db 'This is my cool new OS!', 0
        text_enter db 'enter two number:1st one must be greater', 0
        text_add db 'Addition operation:', 0
         text_sub db 'subtract operation:', 0
         




        ;in1 db 0
        ;in2 db 0


print_string:			; Routine: output string in SI to screen
	mov ah, 0Eh		; int 10h 'print char' function

.repeat:
	lodsb			; Get character from string
	cmp al, 0
	je .done		; If char is zero, end of string
	int 10h			; Otherwise, print it
	jmp .repeat

.done:
	ret


	times 510-($-$$) db 0	; Pad remainder of boot sector with 0s
	dw 0xAA55		; The standard PC boot signature
