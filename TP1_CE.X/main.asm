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
    movlw 0
    movwf var1
    ; Mettre � 0 (LOW) GP0
    bcf GPIO, GP0
    goto loop ; Va dans la boucle infinie

; Programme principal
	
; La boucle infinie
loop:
    ; Lecture de l'�tat de GP3
    btfss GPIO, GP3   ; V�rifie si GP3 est � 1 (bit test skip if set)
    goto gp3_is_clear   ; Saute � "gp3_is_clear" si GP3 est � 0 (LOW)

    ; Saut vers le d�but de la boucle infinie
    goto loop

; Si appui sur BP
gp3_is_clear:
    ; Changement de valeur pour var1 ("not var1")
    btfss var1, 0
    movlw 0
    btfsc var1, 1
    movlw 1
    movwf var1
    
    ; Charge la valeur 100 (en d�cimal) dans WREG (pour 100ms)
    movlw 100
    ; Stocke la valeur de WREG � l'adresse m�moire temp0 (0x11h)
    movwf temp0
    ; Charge la valeur 250 (en d�cimal) dans WREG (pour la ms)
    movlw 250
    ; Stocke la valeur de WREG aussi � l'adresse m�moire temp1 (0x12h)
    movwf temp1
    ; Attend 100ms
    goto timer_100ms
    
    btfss var1, 0
    ; Mettre � 0 (LOW) GP0
    bcf GPIO, GP0
    
    btfsc var1, 1
    ; Mettre � 1 (HIGH) GP0
    bsf GPIO, GP0
    
    
timer_100ms:
    nop
    nop
    nop
    ; D�cr�mente la variable temp1
    decfsz temp1, 1
    ; Si temp1 n'est pas encore � z�ro, retourne � la boucle
    goto timer_100ms
    ; D�cr�mente la variable temp0
    decfsz temp0, 1
    ; Si temp0 n'est pas encore � z�ro, retourne � la boucle
    goto timer_100ms
END