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
    btfss GPIO, GP3   ; Vérifie si GP3 est à 1 (bit test skip if set)
    goto gp3_is_clear   ; Saute à "gp3_is_clear" si GP3 est à 0 (LOW)

    ; Mettre à 0 (LOW) GP0
    bcf GPIO, GP0
    
    ; Saut vers le début de la boucle infinie
    goto loop

gp3_is_clear:
    ; Mettre à 1 (HIGH) GP0
    bsf GPIO, GP0
    ; Charge la valeur 250 (en décimal) dans WREG
    movlw 250
    ; Stocke la valeur de WREG à l'adresse mémoire temp0 (0x11h)
    movwf temp0
    ; Stocke la valeur de WREG aussi à l'adresse mémoire temp1 (0x12h)
    movwf temp1
    ; Attend 250ms
    goto timer_250ms
    
timer_250ms:
    nop
    nop
    nop
    ; Décrémente la variable temp1
    decfsz temp1, 1
    ; Si temp1 n'est pas encore à zéro, retourne à la boucle
    goto timer_250ms
    ; Décrémente la variable temp0
    decfsz temp0, 1
    ; Si temp0 n'est pas encore à zéro, retourne à la boucle
    goto timer_250ms

END