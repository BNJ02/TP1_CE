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
    bsf GPIO, GP0

; Programme principal
; La boucle infinie
loop: 
led_on_pressed:
    btfsc GPIO, GP3 ; test de l'entr�e 1
    goto led_on_pressed; Le bouton n'est pas appuy�
    bsf GPIO, GP0 ; le bouton est appuy�, on allume la led

led_on_released:
    btfss GPIO, GP3 ; test de l'entr�e 1
    goto led_on_released ;Le bouton n'est pas relach�...
    ; Le bouton est relach�
    
led_off_pressed: 
    btfsc GPIO, GP3 ; test de l'entr�e 1
    goto led_off_pressed; Le bouton n'est pas appuy�
    bcf GPIO, GP0 ; le bouton est appuy�, on eteint la led

led_off_released:
    btfss GPIO, GP3 ; test de l'entr�e 1
    goto led_off_released ;Le bouton n'est pas relach�...
    ; Le bouton est relach�  
    goto loop
    
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