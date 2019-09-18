	org 	0000h
	sjmp	main

	org	0003h
	sjmp 	int_0

	org	0013h
	sjmp	int_1

delay_500ms:
	mov 	r2, #10
loop2:
	mov 	r1, #10
loop1:	
	mov 	r0, #2
	djnz 	r0, $
	djnz 	r1, loop1
	djnz 	r2, loop2
	ret


int_0:
	clr  	EA
	clr	p2.6
	setb	p1.2

	acall  	delay_500ms

	clr 	p1.2
	clr	p2.7
	setb 	p2.6
	setb 	EA

	reti

int_1:
	clr 	p2.6
	setb 	p1.0

	acall  	delay_500ms

	setb 	24h.0
	setb 	EA

	reti


main:
	setb 	EX0
	setb 	EX1

	setb 	IT0
	setb 	IT1

	setb  	EA	

	mov 	a, #3h
	clr 	24h.0

estagio_inicio:
	
	setb 	p2.7
	setb 	p2.6
	clr 	p1.2
	clr 	p1.0

	jnb 	24h.0, $
	clr 	24h.0
	djnz a, estagio_inicio	

 	END
