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
	;mov eax,[denominador]
	;add eax,2

	mov ebx,[denominador]
pausa:
	cmp eax,13
	jnz _start

salir:
	mov ebx,0
	mov eax,1
	int 0x80
	
