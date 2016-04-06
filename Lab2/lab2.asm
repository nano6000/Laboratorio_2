;Calcula el valor aproximado de PI
;Utiliza las series Gregory-Leibniz, para lograrlo.

;Objetivo: Calcular PI
;Entradas: -------
;Salidas: el valor aproximado de PI, con presicion de decimales
bits 32
section .bss

denominador resq 1
numerador resw 1
PI resq 1

section .data

section .text
	global _start
_start:
	mov word [denominador],1
	mov word [numerador],4
	fild qword [denominador]	;carga el nuevo denominador
	fidivr word [numerador]		;divide el numerador entre el 
									;denominador y lo guarda en el tope actual 
									;de la pila
	xor eax,eax					;Limpia el registro eax para alternar entre
									;suma y resta
									;0x00 -> resta || 0xFF -> suma
	xor ecx,ecx					;Limpia el ecx para llevar un contador de
									;la cantidad de series que se realizan
	xor edx,edx					;Limpia el edx para llevar un contador auxiliar
									;de la cantidad de series que se realizan
									;para llevar valores
	
incremento:
	mov ebx,denominador			;copia direccion de denominador en ebx
	add dword [ebx],2			;suma 2 al valor de denominador
actualizar:	
	fild qword [denominador] 	;carga el nuevo denominador
	fidivr word [numerador]		;divide el numerador entre el 
									;denominador y lo guarda en el tope actual 
									;de la pila
							
	cmp eax,0x00				;decide si lo que sigue es una suma
	jne suma						;o una resta
resta:
	fsubp ST1,ST0				;resta el valor del tope de la pila y lo 
									;almacena en el valor anterior al tope
									;y hace un pop a la pila
	xor eax,0xFF				;Cambia el valor del eax a 0xFF
	jmp comprobar
suma:
	faddp ST1,ST0				;suma el valor del tope de la pila y lo 
									;almacena en el valor anterior al tope
									;y hace un pop a la pila
	xor eax,0xFF				;Cambia el valor del eax a 0x00
	inc ecx						;Incrementa el contador
	
comprobar:
	;cmp edx,16375
	;je aumentar_tope
continuar:
	cmp ecx,500000000
	;cmp ecx,16384
	je calcular
	jmp incremento

aumentar_tope:
	fincstp
	jmp continuar
	
calcular:
	;faddp ST1,ST0
	;faddp ST1,ST0
	;faddp ST1,ST0
	;fidiv word [numerador]
	fild qword [denominador]
imprimir:
	fst qword [PI]

salir:
	mov ebx,0
	mov eax,1
	int 0x80
	
