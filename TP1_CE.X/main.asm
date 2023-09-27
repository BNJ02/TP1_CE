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
	goto loop ; Va dans la boucle infinie

; Programme principal
	
; La boucle infinie
loop:
    ; Lecture de l'état de GP3
    btfsc GPIO, GP3   ; Vérifie si GP3 est à 0 (bit test skip if clear)
    bsf GPIO, GP0  
    bcf GPIO, GP0
    ; Saut vers le début de la boucle (while(1) infinie)
    goto loop

END