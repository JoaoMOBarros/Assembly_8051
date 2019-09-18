	org	0
	sjmp	prog

charg:	mov	tmod, #00100101b
	mov	scon, #01000000b
	setb	ren
	mov	th1, #0fah
	mov	tl1, #0fah
	setb	tr1

atraso:	djnz	r0, $
	djnz	r1, $-5
	djnz	r2, $-9
	djnz	r3, $-13
	mov	r0, #061h
	djnz	r0, $
	nop
	ret

sub1:	mov	th0, #0h
	mov	tl0, #0h
	setb	tr0
	mov	r3, #002h
	mov	r2, #0adh
	mov	r1, #007h
	mov	r0, #0bch
	nop
	acall	atraso
	clr	tr0
	mov	sbuf, th1
	jnb	ti, $
	mov	sbuf, tl1
	jnb	ti, $
	sjmp	sub1

prog:	acall	charg
	acall	sub1

	end