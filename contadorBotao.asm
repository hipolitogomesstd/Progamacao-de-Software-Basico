.nolist
.include "m328Pdef.inc"
.list
.equ LED_0 = PB0
.equ LED_1 = PB1
.equ LED_2 = PB2
.equ LED_3 = PB3

.equ BOT_INC = PB4
.equ BOT_DEC = PB5

.def AUX = R16 
.def CONT = R18

.ORG 0x000 ; endereço de inicio

Inicializacoes:
	LDI AUX, 0b00001111 ; configura as saidas dos leds, sendo 0 a entrada e 1 a saida
	OUT DDRB,AUX
	
	LDI AUX, 0b00110000 ; configura os botoes
	OUT PORTB,AUX
	
	CLR CONT ;contador comeca do 0
	
	
Principal:
	OUT PORTB, CONT ; print contador
	
	SBIC PINB,BOT_INC ; chama a funcao para incrementar
	RJMP Decrementa ; caso contrario, pula para decrementar
	
	RCALL ATRASO
	RCALL SoltarBotao_inc
	
	INC CONT
	CPI CONT,16
	BRNE Principal
	CLR CONT
	RJMP Principal

Decrementa:
	SBIC PINB,BOT_DEC
	RJMP Principal
	
	;caso nao decrementar
	RCALL Atraso
	RCALL SoltarBotao_dec
	
	CPI CONT, 0
	BRNE Dec_Simples
	LDI CONT, 16
	RJMP Principal
	
Dec_Simples:
	DEC CONT
	RJMP Principal

SoltarBotao_inc:
	SBIS PINB,BOT_INC
	RJMP SoltarBotao_inc
	RET

SoltarBotao_dec:
	SBIS PINB,BOT_DEC
	RJMP SoltarBotao_dec
	RET

Atraso:
	LDI R19,50
	RET
Atraso_loop:
	DEC R19
	BRNE Atraso2
	RET
