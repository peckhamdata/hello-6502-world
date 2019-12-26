.var screen = $0400

:BasicUpstart2(start)

start:		ldx #$00
loop:		lda message,x
		beq exit
		sta screen,x
		inx
		jmp loop

exit:		rts

message:	.text "hello world!"
		.byte $00
