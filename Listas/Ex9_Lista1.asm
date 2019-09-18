	org	0			
	sjmp	prog			


	org	0003h			
	sjmp	ext0			

	org	000bh			; posição de memória para quando a interrupção do overflow no timer 0 é ativada
	sjmp	tim0			; tratamento da interrupção do overflow no timer 0

	org	0013h			
	sjmp	ext1		

	org	01bh			
	sjmp	tim1			

prog:
	setb ex0			;habilita a interrupcao externa no port int0
	setb px0			;define a prioridade da ex0 como alta
	setb ex1			;habilita a interrupcao externa no port int1
	clr  px1			;define a prioridade da ex1 como baixa
	setb et0			;habilita a interrupcao externa do timer 0
	setb pt0			;define a prioridade da et0 como alta
	setb et1			;habilita a interrupcao externa do timer 1
	clr  pt1			;define a prioridade da ex1 como baixa
	setb ea				;habilita as interrupcoes

	mov tmod, #11h			;habilita tanto o timer 0 quanto o 1 no modo 1

	mov th0, #0d8h			;inicializa th0 e tl0 para contar 10 ms
	mov tl0, #0efh

	mov th1, #015h			;inicializa th1 e tl1 para contar 60 ms
	mov tl1, #09fh

	setb tr0			;dispara o timer 0
	setb tr1			;dispara o timer 1

	sjmp $				;loop do programa

ext0:	clr ea
	mov dptr, #5000h
	movx a, @dptr
	mov r0, p1
	mov p1, a
	mov a, r0
	movx @dptr, a
	setb ea
	reti

ext1:	clr ea
	mov dptr, #5000h
	movx a, @dptr
	mov 7fh, a
	setb ea
	reti

tim0:	clr ea
	clr tr0
	mov a, 7fh
	mov dptr, #5200h
	movx @dptr, a
	mov th0, #0d8h
	mov tl0, #0efh
	setb tr0
	setb ea
	reti

tim1:	clr ea
	clr tr1
	mov dptr, #5200h
	movx a, @dptr
	mov dptr, #5000h
	movx @dptr, a
	mov th1, #015h
	mov tl1, #09fh
	setb tr1
	setb ea
	reti
	end