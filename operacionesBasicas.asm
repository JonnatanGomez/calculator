Data segment
    label1 DB "Selecciona una operacion $"
    label2 DB "1.- Suma $"
    label3 DB "2.- Resta $"
    label4 DB "3.- Multiplicacion $"
    label5 DB "4.- Division $"
    label6 DB "5.- Salir $"
    label7 DB "Ingrese una opcion $"
    label8 DB "Ingrese numero     $"
    label9 DB "El resultado es $"
    label10 DB "error no divisible entre 0 $"
    label11 DB "`cociente  $"
    label12 DB "residuo $"
    resultado DB 0
    cociente  DB    0
    residuo   DB    0
    numero    DB    0
    signox     DB    0
    r2      DB    ?
    ac      DB    0
   
Data ends

pila segment stack
        
    DW 256 DUP (?)

pila ends
    
code segment

menu proc far
    
    assume cs:code,ds:data,ss:pila
    push ds
    xor ax,ax
    push ax
    mov ax,data
    mov ds,ax
    xor dx,dx
    
    ;interlineado
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h
    ;interlineado
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h          
    ;imprime seleccion de menu 
    mov ah,09h
    mov dx,offset label1
    int 21h
    
    ;interlineado
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h
    
    mov ah,09h
    mov dx,offset label2
    int 21h
    
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h
    
    mov ah,09h
    mov dx,offset label3
    int 21h
    
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h
    
    mov ah,09h
    mov dx,offset label4
    int 21h
    
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h
        
    mov ah,09h
    mov dx,offset label5
    int 21h
    
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h
    
    mov ah,09h
    mov dx,offset label6
    int 21h
    
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h
    
    mov ah,09h
    mov dx,offset label7
    int 21h
        
    ;lee teclado
    mov ah,01h
    int 21h
     
    ;ajunstando el teclado
    xor ah,ah
    sub al,30h
    mov cx,2
    ;verificando opcion
    
    cmp al,1
    jz suma ;se dirige al metodo suma
    
    cmp al,2
    jz resta ;se dirige al metodo resta
                                       
    cmp al,3
    jz mult ;se dirige al metodo multiplik
    
    cmp al,4
    jz divi ;se dirige al metodo dividir
    
    cmp al,5
    jz fin
    
suma: 
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h            
    mov ah,09h
    mov dx,offset label8
    int 21h
    
    ;lee teclado
    mov ah,01h
    int 21h
    
    ;verificando si es negativo
    cmp al,2dh
    je signo
       
    ;ajusta teclado
    sub al,30h
    add resultado,al 
    jmp return1
    

signo:
    mov ah,01h
    int 21h
    sub al,30h
    neg al
    add resultado,al
    je return1
 
return1: loop suma
         

imp1:
    cmp resultado,00
    jl imp2
    ;interlineado
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h
    mov AH,09H
    mov DX,OFFSET label9
    int 21H
    jmp imprime
        
       
imp2: 
    neg resultado 
    ;interlineado
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h
        
    mov AH,09H
    mov DX,OFFSET label9
    int 21H
    mov ah,02h        
    mov dl,'-'        
    int 21h
    jmp imprime
       
imprime:

               
        MOV AH,0
        MOV AL,resultado
        MOV CL,10
        DIV CL
        
        ADD AL,30H
        ADD AH,30H; CONVIRTIENDO A DECIMAL
        MOV BL,AH
        
        MOV DL,AL
        MOV AH,02H;IMPRIME LA DECENA
        INT 21H
        
        MOV DL,BL
        MOV AH,02H
        INT 21H;IMPRIME LA UNIDAD
        mov cx,2
        jmp menu
resta:
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h            
    mov ah,09h
    mov dx,offset label8
    int 21h
    
    ;lee teclado
    mov ah,01h
    int 21h
    
    ;verificando si es negativo
    cmp al,2dh
    je signor
      
    ;ajusta teclado
    sub al,30h
    cmp cx,2
    je etiqueta1
    sub resultado,al 
    jmp return2
etiqueta1: mov resultado,al
            jmp return2    
signor:
    mov ah,01h
    int 21h
    sub al,30h
    neg al
    cmp cx,2
    je etiqueta1
    sub resultado,al
    je return2

return2: loop resta
    jmp imp1    
             
mult:
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h            
    mov ah,09h
    mov dx,offset label8
    int 21h
    
    ;lee teclado
    mov ah,01h
    int 21h
    
    ;verificando si es negativo
    cmp al,2dh
    je signom
    sub al,30h
    cmp cx,2
    je etiqueta2
    mov ah,0
    mul resultado
    jmp return3
etiqueta2:
    mov resultado,al
    jmp return3
signom:
    mov ah,01h
    int 21h
    sub al,30h
    neg al
    cmp cx,2
    je etiqueta2
    mov ah,0
    mul resultado
    jmp return3
return3:loop mult
        mov resultado,al
        jmp imp1    

mov signox,0    
divi:
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h            
    mov ah,09h
    mov dx,offset label8
    int 21h
    
    ;lee teclado
    mov ah,01h
    int 21h
    
    ;verificando si es negativo
    cmp al,2dh
    je signod
    
    sub al,30h
    cmp cx,2
    je etiqueta3
    cmp al,0
    je falla
    mov ah,0
    mov numero,al
    mov al,resultado
    div numero 
    jmp return4

etiqueta3:
    mov resultado,al
    jmp return4
signod:
    mov ah,01
    int 21h
    sub al,30h
    inc signox
    cmp cx,2
    je etiqueta3
    mov ah,0
    mov numero,al
    mov al,resultado
    div numero
    jmp return4

return4:loop divi
    mov cociente,al
    mov residuo,ah
    mov resultado,al
    jmp imp3
falla: 
    mov ah,9
    mov dx, offset label10
    int 21h
    jmp divi
imp3:
    
    
    mov ah,02h
    mov dl,10
    int 21h
    mov ah,02h
    mov dl,13
    int 21h
    mov AH,09H
    mov DX,OFFSET label9
    int 21H
    jmp imprimedivi
        
       

    
imprimedivi:
       MOV AL,resultado
              
       MOV CH,30H
       ADD AL,CH
       ADD AH,CH
       MOV BL,AH  
       
      
       MOV AH,9
       MOV DX,OFFSET label11
       INT 21H      
       
       cmp signox,1
       jz cambio
       jmp termina
       
cambio:
       mov dl,"-"
       mov ah,02h
       int 21h        
       mov signox,0

termina:
       MOV DX,0
       ADD cociente,30H
       MOV DL,cociente
       MOV AH,02H ;IMPRIME EL COCIENTE
       INT 21H
               
               
       MOV AH,9
       MOV DX,OFFSET label12
       INT 21H
       
       MOV DX,0
       ADD residuo,30H
       MOV DL,residuo 
       MOV AH,02H ;IMPRIME EL RESIDUO
       INT 21H
       
       jmp menu  
fin:     ret     
menu endp
code ends
end menu