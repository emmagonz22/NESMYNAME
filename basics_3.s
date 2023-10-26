.export Main
.segment "Code"

.proc Main
    ; Program Counter - Keeps track of the address of the instructions
    ; Processor Status - Holds flag 
    ;   There are a few flags one of them is the carry flag for arithmetic operations
    ;   The Negative flag this is use for comprarision if A < Memory then this is equal to A - Memory if the result is negative the result is true
    ;   The Zero flag is use for equal comparision A = Memory -> 7 - 7 It will return true (1) if equal to 0
    ;   Carry flag is use for >= 


    ; Branch instructions

    ; Initialize Health, Damage, and the Return Value
    lda #25
    sta $00
    lda #30
    sta $01
    lda #0
    sta $02

    ; Check if Damage >= Health
    lda $01
    cmp $00
    bcc not_lethal ; -> Branch if carry clear (if carry is 0)

    ; Set address $01 to "1" to indicate the player has died
    lda #1
    sta $01

    ; Branch to this label when damage isn't lethal
    not_lethal:
        rts ; -> exit subroutine

.endproc