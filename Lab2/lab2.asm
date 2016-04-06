;Calcula el valor aproximado de PI
;Utiliza las series Gregory-Leibniz, para lograrlo.

;Objetivo: Calcular PI
;Entradas: -------
;Salidas: el valor aproximado de PI, con presicion de decimales

section .bss

denominador resw 1
numerador resw 1

section .data

;denominador equ 1
;numerador equ 4

section .text
	;mov eax,1
	global _start
_start:
	mov word [denominador],1
	mov word [numerador],4
	fild word [denominador]
	fidivr word [numerador]
incremento:
	mov ebx,denominador	;copia direccion de denominador en ebx
	add word [ebx],2	;suma 2 al valor de denominador
actualizar:	
	fild word [denominador] ;carga el nuevo denominador
	fidivr word [numerador]	;divide el numerador entre el 
							;denominador y lo guarda en el tope actual 
							;de la pila
sumar:
	faddp ST1,ST0
	;fincstp
	
	jmp incremento

salir:
	mov ebx,0
	mov eax,1
	int 0x80
	
