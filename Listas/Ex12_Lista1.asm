

	org	0			
par	equ	30h			
impar	equ	31h			
	sjmp	prog			



prog:
	mov	scon, #40h		; programar a interface serial (seta como modo 1)
	mov	tmod, #20h		; programar o timer 1 (seta como modo 2)
	mov	dptr, #tab		; aponta para o primeiro valor de tab, que está na memória de programa
	clr	a			; limpa o conteúdo em a
	mov	r0, #0h			
	mov	r1, #0h			
	mov	r2, #09d		
loop:
	movc	a, @a+dptr		
	inc	dptr			
	clr	par			
	clr	impar			

	acall	imparoupar		; chama sub-rotina para determinar se é par ou ímpar, com o retorno nas flags

	cjne	r2, #0d, nacabo		; verifica se as iterações não acabaram. se acabaram, continua. se não, pula.
	sjmp	acabo			; se acabou, pula para a label acabo

nacabo:
	dec	r2			
	jb	par, loopar		
	jb	impar, loopimpar	

loopar:
	acall	parserial		; chama sub-rotina para a interface serial de quando o número é par
	mov	p1, a			; copia o valor de a para p1, como pede o enunciado
	clr	a			; limpa o valor de a para a próxima iteração
	sjmp	loop			; retoma o loop

loopimpar:
	acall	imparserial		; chama sub-rotina para a interface serial de quando o número é ímpar
	mov	p2, a			; copia o valor de a para p2, como pede o enunciado
	clr	a			; limpa o valor de a para a próxima iteração
	sjmp	loop			; retoma o loop

acabo:
	mov	dptr, #2030h		; insere o endereço da memória externa no registrador dptr
	mov	a, r0			; move o número de números pares em a para ser inserido em dptr (endereço 2030h)
	movx	@dptr, a		; insere o número de números pares no endereço 2030h, apontador por dptr
	mov	dptr, #2031h		; mesmo procedimento para o número de números impares, mas na posição 2031h
	mov	a, r1
	movx	@dptr, a

	sjmp	$			; fim do programa

imparoupar:
	mov	b, #2d			; carrega o valor 2 decimal em b
	div	ab			; divide a por b (ou seja, por 2). em a fica a parte inteira e em b fica o resto
	mov	a, #0d			; move o valor 0 para a
	cjne	a, b, resultimpar	; se a e b são zero, o valor é par. caso contrário, é ímpar

resultpar:
	setb	par			; a flag par é setada, ou seja, o número é par
	clr	impar			; a flag impar é dada clear, ou seja, o número não é ímpar
	inc	r0			; incrementa o número de números pares, que está no registrador r0
	sjmp	cont			; continua o programa

resultimpar:
	setb	impar			; a flag impar é setada, ou seja, o número é impar
	clr	par			; a flag par é dada clear, ou seja, o número não é par
	inc	r1			; incrementa o número de números ímpares, que está no registrador r1

cont:
	ret				; retorna da chamada da sub-rotina


parserial:
	mov	th1, #253		; configuração do timer para determinar
	mov	tl1, #253		; o baud rate para números pares
	sjmp	fimserial		; continua o procedimento da interface


imparserial:
	mov	th1, #250		; configuração do timer para determinar
	mov	tl1, #250		; o baud rate para números impares

fimserial:
	setb	tr1			; liga o timer para fazer a interface serial

	mov	sbuf, a			; move o valor de a para o buffer serial
	jnb	ti, $			; espera até que seja carregado o valor de a no buffer serial
					; ou seja, enquanto o valor do bit de interrupção ti for 0, mantém no mesmo lugar
					; quando o bit ti recebe 1, significa que a interface serial foi concluída
	clr	ti			; permite que haja interfaces seriais futuras, pois o bit foi zerado
	ret				; retorna para o programa principal


tab:	db	030d, 128d, 201d, 83d, 12d, 112d, 210d, 43d, 2d, 91d

	end