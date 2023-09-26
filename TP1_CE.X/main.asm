; Programme assembleur du TP1 de CE (Circuit Electronique), 26/09/2023, Adji TOURE & Benjamin Lepourtois
; PIC10F200
; LIST p=PIC10F200
#include p10f200.inc

__CONFIG _WDTE_OFF & _CP_OFF & _MCLRE_OFF

STATUS equ 03h
OSCCAL equ 05h
GPIO equ 06h
GP0 equ 00h
GP1 equ 01h
GP2 equ 02h
GP3 equ 03h
var1 equ 10h

; Start
	ORG 0X000

	movwf OSCCAL
	goto main

	ORG 0X020

; Set up
main:	movlw 0CFh
	option
	movlw 0F8h
	tris GPIO

; Programme principal
	
; Pour mettre à un (HIGH) le GP0
	bsf GPIO, GP0
; Pour mettre à zéro (LOW) le GP0
	;bcf GPIO, GP0
	


END