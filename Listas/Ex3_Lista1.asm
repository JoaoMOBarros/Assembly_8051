	org 	0000h
	tag 	equ 30H
	smjp 	main

	org	000bh
	smjp	timer_0

timer_0:
	clr 	EA
	setb 	tag
	inc 	a 		;incrementa o acumulador em uma unidade
	mov 	TH0, #3Bh	;calculada para que 
	mov 	TL0, #05h
	setb 	EA
	reti

main:
	setb 	ET0
	mov 	TMOD, #01h
	mov 	TH0, #3Bh
	mov 	TL0, #05h
	mov 	a, #0h

loop_100:
	smjp 	delay_50ms
	cjne 	a,#100,loop_100 ;compara se o acumulador tem valor igual a 100, se nao pula para loop_100
	ajmp 	$


delay_50ms:
	
	setb 	EA
	setb 	TR0
	clr 	tag
	jnb 	tag, $
	ret

	end