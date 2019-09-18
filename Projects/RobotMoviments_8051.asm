

	org	0			; início da memória (se houver um reset, o programa volta para cá)
	sjmp	prog			; primeiro, vai até o programa principal



	org	0003h			; posição de memória para quando a interrupção externa 0 é ativada
	sjmp	interrupt0		; tratamento da interrupção externa 0, que é quando um obstáculo é detectado


prog:
	setb	p1.0			
	setb	p1.2			
	setb	ex0			
	setb	it0			
	setb	ea		
	setb	p1.1			
	setb	p1.3			

	clr	p1.4			; convenção: p1.4 = 0 => próximo movimento será a direita
					;	     p1.4 = 1 => próximo movimento será a esquerda
	sjmp	$			; aguarda até que um obstáculo seja encontrado

interrupt0:
	clr	ea			
	clr	p1.1			; robô movimenta-se
	clr	p1.3			; para trás
	acall	delay2s			; espera 2 segundos para concluir o movimento
	jb	p1.4, esq		; vemos se o robô irá para a esquerda ou para a direita

dir:
	setb	p1.1			; robô movimenta-se
	clr	p1.3			; para a direita
	acall	delay2s			; espera 2 segundos para concluir o movimento
	setb	p1.4			; setamos p1.4 para que o próximo movimento seja para a esquerda
	sjmp	cont

esq:
	clr	p1.1			; robô movimenta-se
	setb	p1.3			; para a esquerda
	acall	delay2s			; espera 2 segundos para concluir o movimento
	clr	p1.4			; damos clear em p1.4 para que o próximo movimento seja para a direita

cont:
	setb	p1.1			; o robô movimenta-se para frente
	setb	p1.3			; até que se encontre outro obstáculo

	setb	ea			; reabilita as interrupções

	reti				; retorna da interrupção

delay2s:
	
	mov	r2, #18d		; 1 ciclo
loop1:
	mov	r1, #230d		; 1 ciclo
loop2:
	mov	r0, #240d		; 1 ciclo
	djnz	r0, $			; 2 ciclos
	djnz	r1, loop2		; 2 ciclos
	djnz	r2, loop1		; 2 ciclos

	ret				; 2 ciclos
