.nolist
.include "m328Pdef.inc"
.list 

.equ BotIncrementa = PC1
.equ BotDecrementa = PC0

.def Contador = R16
.def AuxiliarB = R17

.ORG 0x000

Inicializacoes:
    LDI Contador, 0b01111111
    OUT DDRD, Contador

    CLR AuxiliarB
    OUT DDRC, AuxIliarB

    LDI AuxiliarB, 0b00000011
    OUT PORTC, AuxiliarB

    CLR Contador
Principal:
    LDI ZL, Low(Tabela*2)
    LDI ZH, HIGH(Tabela*2)
    ADD ZL, Contador
    LDI R22, 0
    ADC ZH, R22

    LPM R23, Z
    OUT PORTD, R23


    SBIS PINC, BotIncrementa
    RJMP PrecionarDec
    RCALL Incrementar
    RCALL Atraso

    RJMP Principal

PrecionarDec:
    SBIS PINC, BotDecrementa
    RJMP Principal
    RCALL Decrementar
    RCALL Atraso
    RJMP Principal

Incrementar:
    INC Contador
    CPI Contador, 10
    BRNE IncFim
    CLR Contador
IncFim:
    RET

Decrementar:  
    DEC Contador
    CPI Contador, 255
    BRNE DecFim
    LDI Contador, 0x9
DecFim:
    RET

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
    RET

Tabela:
    .DB 0b00111111, 0b00000110 ; 0 1
    .DB 0b01011011, 0b01001111 ; 2 3
    .DB 0b01100110, 0b01101101 ; 4 5
    .DB 0b01111101, 0b00000111 ; 6 7
    .DB 0b01111111, 0b01101111 ; 8 9