.nolist
.include "m328Pdef.inc"
.list

.def UNIDADE = R16
.def DEZENA = R17
.def LED = R18

.def AUX = R19

.equ display1 = PC1
.equ display2 = PC0

.ORG 0x000

Inicio:
    ; Configura PORTB como saída (displays de 7 segmentos)
    LDI AUX, 0b01111111
    OUT DDRB, AUX

    ; Configura PC0 e PC1 como saída, e passa novamente para 0x00000000
    LDI AUX, 0b00000011
    OUT DDRC, AUX
    
    ; limpa os contadores para começar do 0
    CLR UNIDADE
    CLR DEZENA

Principal:
    ; chama a funçao de contar 
    RCALL ContadorSegundo
    ; chama a funçao de incrementar os segundo
    RCALL IncSegundo
    ;pula para o contador novamente
    RJMP Principal
    
RotinaUnidade:
    ;carrega o auxliar com a saida do botao pc0
    LDI AUX, 0b00000010
    ;avisa que a saida de aux é portaC
    OUT PORTC, AUX
    ;carrega ZL com o bit menos significativo da tabela
    LDI ZL, LOW(Tabela*2)
    ;carrega o bit mais significativo em ZH
    LDI ZH, HIGH(Tabela*2)

    ;adiciona o valor de ZL em UNIDADE
    ADD ZL, UNIDADE
    ;carrega aux com o valor 0
    LDI AUX, 0
    ;adiciona o carry de aux em ZH
    ADC ZH, AUX
    ;carrega o valor de Z da memoria em LED
    LPM LED, Z
    
    ;printa em portB o valor do led
    OUT PORTB, LED
    RET
    
RotinaDezena:
    ;carrega o valor de PC1 
    LDI AUX, 0b00000001
    ;printa o valor de aux em portC
    OUT PORTC, AUX

    ;carrega o o bit menos signficativo da tabela em ZL
    LDI ZL, LOW(Tabela*2)
    ;carrega o bit mais significativo da tabela em ZH
    LDI ZH, HIGH(Tabela*2)

    ;adciona o valor de ZL em DEZENA
    ADD ZL, DEZENA
    ;carrega o AUX com o valor 0
    LDI AUX, 0
    ;adiciona o carry de aux em ZH
    ADC ZH, AUX
    ;carrega o valor do ponteiro Z do para o led
    LPM LED, Z

    OUT PORTB, LED
    RET

IncSegundo:
    ;incrementa um na UNIDADE
    INC UNIDADE 
    ;compara se unidade não é 10
    CPI UNIDADE, 10 
    ;se unidade for diferente 10 chama pular
    BRNE Pular
    ;se for igual limpa o valor de UNIDADE
    CLR UNIDADE 

    ;incrementa um na DEZENA
    INC DEZENA 
    ;compara se o valor da DEZENA é 6
    CPI DEZENA, 6
    ;se não for igual chama a função pular
    BRNE Pular
    ;se for igual limpa o valor da DEZENA
    CLR DEZENA
    RET 

Pular:
    RET

;atraso para o multiplexador, define a quantidade vezes que ele pisca
Atraso:
    LDI R20, 250
Atraso2:
    LDI R21, 255

Loop:
    DEC R21
    BRNE Loop
    DEC R20
    BRNE Atraso2
    RET  

;Contador para de 1 segundo 
ContadorSegundo:
    LDI R22, 80
LoopContador:
    RCALL RotinaUnidade
    RCALL Atraso

    RCALL RotinaDezena
    RCALL Atraso

    DEC R22
    BRNE LoopContador
    RET
    

Tabela:
    .DB 0b00111111, 0b00000110  ; 0, 1
    .DB 0b01011011, 0b01001111  ; 2, 3
    .DB 0b01100110, 0b01101101  ; 4, 5
    .DB 0b01111101, 0b00000111  ; 6, 7
    .DB 0b01111111, 0b01101111  ; 8, 9
