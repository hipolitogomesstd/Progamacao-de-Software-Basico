.nolist
.include "m328Pdef.inc"
.list

.def CONT = R20

.ORG 0x000

Inicio:
    LDI R16, 0b11111111
    OUT DDRD, R16
    CLR CONT

Principal:
    LDI ZL, LOW(Tabela*2)
    LDI ZH, HIGH(Tabela*2)

    ADD ZL, CONT
    LDI R17, 0 
    ADC ZH, R17

    LPM R16,Z
    OUT PORTD, R16

    RCALL Atraso  

    INC CONT
    CPI CONT,10    
    BRNE Principal

    CLR CONT
    RJMP Principal

Atraso:
    LDI R18, 200

Atraso_ext:
    LDI R17, 255

Atraso_med:
    LDI R19, 255

Atraso_loop:
    DEC R19
    BRNE Atraso_loop
    DEC R17
    BRNE Atraso_med
    DEC R18 
    BRNE Atraso_ext
    RET


Tabela:
    .DB 0b00111111, 0b00000110  ; 0, 1
    .DB 0b01011011, 0b01001111  ; 2, 3
    .DB 0b01100110, 0b01101101  ; 4, 5
    .DB 0b01111101, 0b00000111  ; 6, 7
    .DB 0b01111111, 0b01101111  ; 8, 9