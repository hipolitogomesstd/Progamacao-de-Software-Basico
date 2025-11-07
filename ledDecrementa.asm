.nolist
.include "m328Pdef.inc"
.list

.def Iterador = R16 ; percorre a tabela
.def aux = r20
.ORG 0x000
Inicializacoes:
    LDI Iterador, 0b01111111 ; informa a saida dos leds
    OUT DDRD, Iterador ; indica a saida
    LDI Iterador, 9
   

Principal:

    LDI ZL, LOW(Tabela*2) ; pega o bit menos significativo 
    LDI ZH, HIGH(Tabela*2) ; e mais significativo
    
    ADD ZL, Iterador ; adiciona o item de tal indice na tabela a ZL, o endereço final
    LDI aux, 0 ; inicializa o registrado auxiliar
    ADC ZH, aux ; adiciona com carry e evita de ter estouro de memoria

    LPM R21, Z ; le o valor de Z e envia para R21
    OUT PORTD, R21
    
    RCALL Atraso

    DEC Iterador
    CPI Iterador, 0
    BRNE Principal

    LDI Iterador, 9

    RJMP Principal

Atraso:
    LDI R17, 255
Atraso1:
    LDI R18, 255
Atraso2:
    LDI R19, 100

Loop:
    DEC R19
    BRNE Loop
    DEC R18
    BRNE Atraso2
    DEC R17
    BRNE Atraso1
    RET

Tabela:
    .DB 0b00111111, 0b00000110 ; 0 1
    .DB 0b01011011, 0b01001111 ; 2 3
    .DB 0b01100110, 0b01101101 ; 4 5
    .DB 0b01111101, 0b00000111 ; 6 7
    .DB 0b01111111, 0b01101111 ; 8 9
