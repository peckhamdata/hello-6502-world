#if PLATFORM_VIC20
    .var screen = $1e00
    *=$1100
#endif

#if PLATFORM_C64
    .var screen = $0400
    BasicUpstart2(start)
#endif

#if PLATFORM_ATARI
    .var screen = $2114
    .var sdlstl = $0230 // SET DISPLAY LIST ADRESS
    *= $a000

// ***STARTING ADRESS OF THE DISPLAY LIST IN RAM***
            lda #$00    
            sta sdlstl
            lda #$20
            sta sdlstl+1

// ;***load the display list in ram***
            ldx #$00
listl:      lda dlist,x 
            sta $2000,x
            inx
            cpx #33
            bne listl

#endif

start:      ldx #$00
loop:       lda message,x
            sta screen,x
            inx
            cpx msg_len
            beq exit
            jmp loop

exit:       jmp exit

msg_len:    .byte $0c

message:    
            #if PLATFORM_ATARI
                // This is a hack to get round the fact that
                // the text directive uses Commodore encoding
                // TODO: make it less hacky - define a KickAss function?
                .byte $68, $65, $6c, $6c, $6f, $00, $77, $6f, $72, $6c, $64, $01
            #else
                .text "hello world!"
            #endif

#if PLATFORM_ATARI

dlist:      .byte 112 // Blank 8 lines
            .byte 112 // Blank 8 lines
            .byte 112 // Blank 8 lines
            // DTA 64+7,$00,$21
            .byte 64+2
            .byte $14,$21
            .byte 2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2
            .byte 65 // Jump and wait for vertical blank
            .byte $20,$94 
#endif
