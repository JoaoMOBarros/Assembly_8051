
	org	0		
	sjmp	prog			

prog:
	clr	p1.4			; começaremos com o bit p1.4 zerado, por default que o forfs escolheu
loop:
	jnb	p1.3, loop		; se o bit p1.3 for zero, ficamos na mesma. se o bit p1.3 for um, emitimos a onda
	acall	t50ms			; chamada para a sub-rotina da onda positiva, com delay de 50 ms
	acall	t50s			; chamada para a sub-rotina da onda negativa, com delay de 50 segundos
	sjmp	loop			; o loop é retomado

t50ms:
	; devemos contabilizar o total de ciclos do nosso timer. para até 113 ms, usamos dois registradores.
	setb	p1.4			; 1 ciclo
	mov	r1, #063h		; 1 ciclo
loopt50ms:
	mov	r0, #0fbh		; 1 ciclo
	djnz	r0, $			; 2 ciclos
	djnz	r1, loopt50ms		; 2 ciclos

	nop

	ret				; 2 ciclos

t50s:
	; mesma coisa que o delay de 50 ms, mas, nesse caso, como são 50 segundos, precisaremos de fucking 4 registradores.
	clr	p1.4			; 1 ciclo
	mov	r3, #50d		; 1 ciclo
loop50s0:
	mov	r2, #10d		; 1 ciclo
loop50s1:
	mov	r1, #230d		; 1 ciclo
loop50s2:
	mov	r0, #216d		; 1 ciclo
	djnz	r0, $			; 2 ciclos
	djnz	r1, loop50s2		; 2 ciclos
	djnz	r2, loop50s1		; 2 ciclos
	djnz	r3, loop50s0		; 2 ciclos

	ret				; 2 ciclos