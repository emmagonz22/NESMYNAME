.export Main
.segment "Code"

.proc Main
    ; Bitwise operators
    ; AND -> & (^)
    ;   Instruction and
    ;       Use the accumulator and a given value to do the operation
    ;           Ex: and #$AF
    ; OR  -> | (V)
    ;   Instruction ora(Bitwise or with acumulator) 
    ;       
    ; XOR -> ^ (O+)
    ;   Instruction eor(Bitwise exclusive or)

    ; Bit can be used in different ways
    ;   You can use a 8 bit number as a complete number or as 2 numbers 11001100(204) or 1100(12) 1100(12)
    ; Bitmask 10001000 -> TFFFTFFF

    ; Jumping player
    lda #%00000100
    and $40
    beq no_double_jump ;-> branch if equal using Zero flag

    has_double_jump:
        ;

    no_double_jump:
        ;

    lda #%01000000
    ora $40
    sta $40

    active_super_power:
        ;

    lda #%10111011
    and $40
    sta $40

    ;Task have an idea of a way to use the PowerUp for an specific case

    rts ; -> exit subroutine

.endproc