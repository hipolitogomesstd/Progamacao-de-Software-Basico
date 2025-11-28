.nolist
.include "m328Pdef.inc"
.list

.equ Botao = PC0
.equ Display =PORTB
.def Contador = R16
.def AUX = R17

.ORG 0x0000

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
    LDI R19,2
Volta:
    DEC R17
    BRNE volta
    DEC R18
    BRNE volta
    DEC R19
    BRNE volta
    RET
Decodifica:
    LDI ZH, HIGH(Tabela<<1)
    LDI ZL, LOW(Tabela<<1)
    ADD ZL, Contador
    LDI R17, 0
    ADC ZH, R17

    LPM R21, Z
    OUT Display, R21
    RET
Tabela:
    .db 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D