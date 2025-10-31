.nolist
.include "m328Pdef.inc"
.list

.def UNIDADE = R17
.def DEZENA= R16
.ORG 0x00

Inicio:
    LDI R18, 0b00111111
    OUT DDRD R18

    CLR CONTADOR
    CLR DEZENA

Principal:
    LDI ZL, LOW(Tabela*2)
    LDI ZH, HIGH(Tabela*2)

    OUT UNIDADE, R18
    OUT DEZENA, R18

Atraso:
    LDI R19, 255
Atraso_1:
    LDI R20, 255
Atraso_2:
    LDI R21, 255

Atraso_loop:
    DEC R21
    BRNE Atraso_loop
    DEC R20
    BRNE Atraso_2
    DEC R19
    Atraso_1
    RET


Tabela:
    .DB 0b00111111, 0b00000110  ; 0, 1
    .DB 0b01011011, 0b01001111  ; 2, 3
    .DB 0b01100110, 0b01101101  ; 4, 5
    .DB 0b01111101, 0b00000111  ; 6, 7
    .DB 0b01111111, 0b01101111  ; 8, 9