;Calcula el valor aproximado de PI
;Utiliza las series Gregory-Leibniz, para lograrlo.

;Objetivo: Calcular PI
;Entradas: -------
;Salidas: el valor aproximado de PI, con presicion de decimales

section .bss

denominador resw 1
numerador resw 1
PI resq 1

section .data

section .text
	global _start
_start:
	mov word [denominador],1
	mov word [numerador],4
	fild word [denominador] ;carga el nuevo denominador
	fidivr word [numerador]	;divide el numerador entre el 
								;denominador y lo guarda en el tope actual 
								;de la pila
	xor eax,eax				;Limpia el registro eax para alternar entre
								;suma y resta
								;0x00 -> resta || 0xFF -> suma
	xor ecx,ecx				;Limpia el ecx para llevar un contador de
								;la cantidad de series que se realizan
	
incremento:
	mov ebx,denominador		;copia direccion de denominador en ebx
	add word [ebx],2		;suma 2 al valor de denominador
actualizar:	
	fild word [denominador] ;carga el nuevo denominador
	fidivr word [numerador]	;divide el numerador entre el 
								;denominador y lo guarda en el tope actual 
								;de la pila
							
	cmp eax,0x00			;decide si lo que sigue es una suma
	jne suma					;o una resta
resta:
	fsubp ST1,ST0			;resta el valor del tope de la pila y lo 
								;almacena en el valor anterior al tope
								;y hace un pop a la pila
	xor eax,0xFF			;Cambia el valor del eax a 0xFF
	jmp continuar
suma:
	faddp ST1,ST0			;suma el valor del tope de la pila y lo 
								;almacena en el valor anterior al tope
								;y hace un pop a la pila
	xor eax,0xFF			;Cambia el valor del eax a 0x00
	inc ecx					;Incrementa el contador
	
continuar:
	cmp ecx,1000
	jne incremento
	
imprimir:
	fst qword [PI]

salir:
	mov ebx,0
	mov eax,1
	int 0x80
	
