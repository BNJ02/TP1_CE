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
temp0 equ 11h
temp1 equ 12h
temp2 equ 13h

; Start
    ORG 0X000

    movwf OSCCAL
    goto main

    ORG 0X020

; Set up
main:	
    movlw 0CFh
    option
    movlw 0F1h
    tris GPIO
    goto loop ; Va dans la boucle infinie

; Programme principal
; La boucle infinie
loop:
    ; Détection de mouvement ?
    btfss GPIO, GP0   ; Skip la prochaine instruction si un mouvement est détecté
    goto loop
    
    ; Allume la LED et le buzzer
    bcf GPIO, GP1; led
    bsf GPIO, GP2 ; buzzer
    
    ; Attend 2s
    movlw 20
    movwf temp2
    call timer_2s
    
    ; Eteind le buzzer
    bcf GPIO, GP2 ; buzzer
    
    ; Détecte s'il n'y a plus de mouvement
    TAG:
    btfsc GPIO, GP0
    goto TAG
    
    ; Eteind la LED
    bsf GPIO, GP1
          
    ; Saut vers le début de la boucle infinie
    goto loop 
    
timer_2s:
    movlw 250
    movwf temp0
    movlw 100
    movwf temp1
    timer_100ms:
	nop
	nop
	nop
	; Décrémente la variable temp1
	decfsz temp0, 1
	; Si temp1 n'est pas encore à zéro, retourne à la boucle
	goto timer_100ms
	; Décrémente la variable temp0
	decfsz temp1, 1
	; Si temp0 n'est pas encore à zéro, retourne à la boucle
	goto timer_100ms    
    ; Décrémente la variable temp2
    decfsz temp2, 1
    goto timer_2s
    retlw 0

END