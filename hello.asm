#if PLATFORM_VIC20
    .var screen = $1e00
    *=$1100
#else
    // Assume it's a C64
    .var screen = $0400
    BasicUpstart2(start)
#endif

start:      ldx #$00
loop:       lda message,x
            beq exit
            sta screen,x
            inx
            jmp loop

exit:       rts

message:    .text "hello world!"
            .byte $00
