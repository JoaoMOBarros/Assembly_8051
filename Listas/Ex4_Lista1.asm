	org 	0000h
	sjmp	main

	org	0003h
	sjmp	int_0

	org	0013h
	sjmp	int_1

	org	001Bh
	sjmp	timer_1

int_0:
	clr 	EA
	mov	DPTR, #4000h 		;Carrega o endereço que voce deseja para DPTR
	movx 	a, @DPTR		;Acessa o valor de DPTR e manda para o acc
	mov	DPTR, #4200h		;Carrega o endereço que voce deseja para DPTR
	movx	@DPTR, a 		;Caarrega o valor de acc para o endereço apontado
	setb 	EA

	reti

int_1:
	clr 	EA
	mov 	DPTR, #4000h 		;Carrega o endereço que voce deseja para DPTR
	movx 	a, @DPTR		;Acessa o valor de DPTR e manda para o acc
	mov 	p1, a 			;move p1 o valor do acc
	setb 	EA

	reti

timer_1:

	mov 	a, p2
	mov 	DPTR, #4000h
	movx 	@DPTR, a

	reti
	

main:	
	
	setb 	EX0
	setb 	EX1
	setb 	ET1

	clr 	PT1
	setb 	PX0
	setb 	PX1

	mov 	TMOD, #0h
	mov 	TH1, #63h
	mov 	TL1, #00h


	setb 	TR0

	setb 	EA

	ajmp 	$

	END