.nolist
.include "m328Pdef.inc"
.list

.def CONT = R20
.def CONT_1 = R21

.ORG 0x000

Inicio:
    LDI R16, 0b11111111
    LDI R17, 0b11111111
    OUT DDRD, R16
    OUT DDRD, R17
    CLR CONT
    CLR CONT_1

Principal:
    LDI ZL, LOW(Tabela*2) ; pega a parte mais significativa
    LDI ZH, HIGH(Tabela*2) ; menos signficativa

    ADD ZL, CONT
    LDI R17, 0 
    LDI R17, CONT_1
 
    ADC ZH, R17 ; verifica se dá carry


    LPM R16, Z ; carrega o valor de z em R16
    OUT PORTD, R16

    RCALL Atraso  

    INC CONT
    CPI CONT, 1  ; verifica se é 10
    BRNE Principal

    INC CONT_1
    CPI CONT_1, 10
    BRNE Principal

    CLR CONT ; limpa o contador se for igual a 10
    CLR CONT_1 
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
    .DB 0b01011011, 0b01001110  ; 2, 3
    .DB 0b01100110, 0b01101101  ; 4, 5
    .DB 0b01111101, 0b00000111  ; 6, 7
    .DB 0b01111111, 0b01101111  ; 8, 9
