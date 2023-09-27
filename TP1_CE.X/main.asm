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
main:	movlw 0CFh
    option
    movlw 0F8h
    tris GPIO
    bsf GPIO, GP0

; Programme principal
; La boucle infinie
loop: 
led_on_pressed:
    btfsc GPIO, GP3 ; test de l'entrée 1
    goto led_on_pressed; Le bouton n'est pas appuyé
    bsf GPIO, GP0 ; le bouton est appuyé, on allume la led
    ; Charge la valeur 250 (en décimal) dans WREG
    movlw 10
    movwf temp2
    call timer_1s
    bsf GPIO, GP1
    movlw 10
    movwf temp2
    call timer_1s
    movlw 10
    movwf temp2
    call timer_1s
    bsf GPIO, GP2

led_on_released:
    btfss GPIO, GP3 ; test de l'entrée 1
    goto led_on_released ;Le bouton n'est pas relaché...
    ; Le bouton est relaché
        
led_off_pressed: 
    btfsc GPIO, GP3 ; test de l'entrée 1
    goto led_off_pressed; Le bouton n'est pas appuyé
    bcf GPIO, GP0 ; le bouton est appuyé, on eteint la led
    bcf GPIO, GP1
    bcf GPIO, GP2
    ; Charge la valeur 250 (en décimal) dans WREG
    movlw 250
    movwf temp0
    movlw 100
    movwf temp1
    call timer_100ms


led_off_released:
    btfss GPIO, GP3 ; test de l'entrée 1
    goto led_off_released ;Le bouton n'est pas relaché...
    ; Le bouton est relaché  
    goto loop

    
timer_100ms:
    nop
    nop
    nop
    ; Décrémente la variable temp1
    decfsz temp1, 1
    ; Si temp1 n'est pas encore à zéro, retourne à la boucle
    goto timer_100ms
    ; Décrémente la variable temp0
    decfsz temp0, 1
    ; Si temp0 n'est pas encore à zéro, retourne à la boucle
    goto timer_100ms
    retlw 0  
    
timer_1s:
    movlw 250
    movwf temp0
    movlw 100
    movwf temp1
    call timer_100ms
    ; Décrémente la variable temp2
    decfsz temp2, 1
    goto timer_1s
    retlw 0

END