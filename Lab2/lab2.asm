;Calcula el valor aproximado de PI
;Utiliza las series Gregory-Leibniz, para lograrlo.

;Objetivo: Calcular PI
;Entradas: -------
;Salidas: el valor aproximado de PI, con presicion de decimales
;%include "dumpRegs.asm"

extern printf

section .bss

denominador resq 1
numerador resw 1
PI: resb 8

section .data

;PI: dt 0x00
;len: db $-PI
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
	jmp continuar
suma:
	faddp ST1,ST0				;suma el valor del tope de la pila y lo 
									;almacena en el valor anterior al tope
									;y hace un pop a la pila
	xor eax,0xFF				;Cambia el valor del eax a 0x00
	inc ecx						;Incrementa el contador
	
continuar:
	cmp ecx,50000000
	;cmp ecx,16384
	je imprimir
	jmp incremento

imprimir:
	push PI
	fst dword [PI]
	push dword [PI+4]
	push dword [PI]
	
	mov edx,2
	mov ecx,[PI]
	
	mov ebx,1
	mov eax,4
	int 0x80
	
pausa:
	mov edx,16
	mov ecx,10
	mov ebx,1
	mov eax,4
	int 0x80

salir:
	mov ebx,0
	mov eax,1
	int 0x80
	
