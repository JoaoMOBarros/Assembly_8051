	org 	0000h
	mov 	TMOD, #00000000b	;setando o modo de operação 0 - 13bits
	sjmp 	main

	org 	001bh    	; Configurando o endereço de interrupção
	sjmp 	timer_1


timer_1:
	clr 	EA		;desativando temporariamente as interrupções
	inc 	p1		;incrementando p1 em uma unidade
	mov     TH1,  #0ebh	;reestabelcendo a parte mais significativa do timer
	setb 	EA		;reativando as interrupções
	reti			;voltando para o rotina principal

main:
	setb 	EA
	setb 	ET1
	mov	p1, #0h
				; Como queremos que sejam contados 640 ciclos, como TL1 conta ate 32, devemos contar ate 20 em TH1 ---> 20*32 = 640
	mov 	TH1, #0ebh
	mov 	TL1, #000h

	setb 	TR1 ; ira começar a contar as 

	sjmp 	$

	END
