.nolist
.include "m328Pdef.inc"
.list

.equ BOTAO = PB0
.equ DISPLAY = PORTD
.def AUX = R16

.org 0x000

Inicializacoes:
    LDI AUX, 0b11111110
    OUT DDRB, AUX
    LDI AUX, 0xFF
    OUT PORTB, AUX
    OUT DDRD, AUX
    OUT PORTD, AUX

Principal:
    SBIC PINB, BOTAO
    RJMP Principal

    CPI AUX, 0x0F
    BRNE Inc 
    LDI AUX, 0x00
    RJMP Decord

Inc:
    INC AUX

Decord:
    RCALL Decodifica
    RCALL Atraso

    RJMP Principal

Atraso:
    LDI R19, 16

volta:
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

    ADD ZL, AUX

    BRCC le_tab

    INC ZH

le_tab:
    LPM R0,Z
    OUT DISPLAY, R0
    RET

Tabela: .dw 0x063F, 0x4F5B, 0x6D66, 0x077D, 0x677F, 0x7C77, 0x5E39, 0x7179