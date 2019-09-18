	ong 	0000h	
	sjmp	main

	org     000bh 	;habilitando o endereço para timer0
	sjmp	timer_0

timer_0:	
	clr 	EA 	;desativando as interrupções
	cpl	p1.7	;inverte o siina através de seu complemento
	mov 	TH0, #D7h	;recomeçando o timer para meio ciclo de 1280 microseg
	mov 	TL0, #00h
	setb 	EA	;ativando as interrupções
	setb 	TR0	;começando o timer
	reti

main:
	clr	p1.7	;ativa a porta para começar em sinal baixo
	setb 	ET0	;habilita interupção do Timer 0
	mov 	TMOD, #00000000b ;ativando o modo 0 - 13bits
	mov 	TH0, #D7h	;começando o timer para meio ciclo de 1280 microseg
	mov 	TL0, #00h
	setb 	EA	;ativando as interrupções
	setb 	TR0	;começando o timer
	sjmp 	$

	end