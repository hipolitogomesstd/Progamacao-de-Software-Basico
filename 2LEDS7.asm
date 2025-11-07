.nolist
.include "m328Pdef.inc"
.list

.def UNIDADE = R17
.def DEZENA = R16
.def LED = R18

.def AUX = R22

.equ display1 = PC0
.equ display2 = PC1

.ORG 0x000

Inicio:
    ; Configura PORTB como saída (displays de 7 segmentos)
    LDI AUX, 0b11111111
    OUT DDRB, AUX
    
    ; Configura PC0 e PC1 como saída (seleção de display)
    LDI AUX, 0b00000011
    OUT DDRC, AUX
    
    ; Inicializa contadores
    CLR UNIDADE
    CLR DEZENA

Principal:

Dezena:
    
    
Atraso:
    LDI R19, 100
Atraso1:
    LDI R20, 255
Atraso2:
    LDI R21, 255

Loop:
    DEC R21
    BRNE Loop
    DEC R20
    BRNE Atraso2
    DEC R19
    BRNE Atraso1
    RET    ; 



Tabela:
    .DB 0b00111111, 0b00000110  ; 0, 1
    .DB 0b01011011, 0b01001111  ; 2, 3
    .DB 0b01100110, 0b01101101  ; 4, 5
    .DB 0b01111101, 0b00000111  ; 6, 7
    .DB 0b01111111, 0b01101111  ; 8, 9