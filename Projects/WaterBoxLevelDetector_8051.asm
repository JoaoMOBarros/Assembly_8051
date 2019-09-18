	org	0000h
	sjmp	main

	org	0003h
	sjmp	int_0

	org	000Bh
	sjmp 	timer_0 	;quando ele for ativado, metade do tempo ja tera passado

	org	0013h
	sjmp	int_1

timer_0:
	clr 	EA
	clr 	p1.0
	setb 	EA
	reti 



int_0:
	clr 	EA
	setb 	TR0 		;começa a contage do timer_0
	setb 	EA

	reti


int_1:
	
	clr 	EA
	clr 	p1.1		;fecha a torneira
	clr	TR0

	mov 	b, #2h
	mov 	a,TH0
	div 	ab
	mov 	b,#FFh
	subb 	b,a
	mov 	TH0,b
	 	

	mov 	b, #2h
	mov 	a,TL0
	div 	ab
	mov 	b,#FFh
	subb 	b,a
	mov 	TL0,b

	setb 	p1.0		;abre a vazao da agua
	setb 	EA

	reti
	 	

org:
	
	setb 	EX0		;Ativando interrupção externa 0
	setb 	EX1		;Ativando interrupção externa 1
	setb 	ET0		;Ativando interrupção timer0

	setb 	IT0		;Sensivel a borda de descida para interrupção 0
	setb 	IT1		;Sensivel a borda de descida para interrupção 1

	mov 	TMOD,#01h
	mov 	TH0, #00h
	mov 	TL0, #00h

	clr 	p1.0		;abertura do registro de entrada
	setb 	p1.1		;fechamnento do registro de vazao

	setb 	EA

	ajmp	$ 

	END	