.nolist
.include "m328Pdef.inc"
.list
.equ Botao = PC0
.equ Display =PORTB
.def Contador = R16
.def AUX = R17

.ORG 0x000

Inicializacoes:
    LDI AUX, 0b11111110
    OUT DDRC, AUX
    LDI AUX, 0b11111111
    OUT PORTB, AUX
    OUT DDRB, AUX ; PORTD é a saida
    OUT PORTC, AUX ; desliga o display

Principal:
    SBIC PINC,Botao
    RJMP Principal
    CPI Contador, 6
    BRNE Incr 
    LDI Contador, 0
    RJMP Decod
Incr:
    INC Contador 
Decod:
    RCALL Decodifica
    RCALL Atraso

    RJMP Principal 
Atraso:
    LDI R19,1
Volta:
    DEC R17
    BRNE volta
    DEC R18
    BRNE volta
    DEC R19
    BRNE volta
    RET
Decodifica:
    LDI ZH, HIGH(Tabela*2)
    LDI ZL, LOW(Tabela*2)
    ADD ZL, Contador
    LDI R17, 0
    ADC ZH, R17

    LPM R21, Z
    OUT Display, R21
    RET
Tabela:
    .db 0b11110111, 0b11101110
    .db 0b11100110, 0b01101010
    .db 0b01000010, 0b00000000
