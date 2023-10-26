.export Main
.segment "Code"

; Address location:
;   From address $0000 - $07FF we have the RAM
;   From address $0800 - $0FFF we have the Mirror 1 
;   From address $1000 - $17FF we have the Mirror 2  
;   From address $1800 - $1FFF we have the Mirror 3  
;   From address $2000 - $401F we have the Special communication channel
;   From address $8000 onwards we have the game code
; Number format:
;   # -> Represent constant ot instant number
;   $ -> Hexadecimal value (base 16)
;   % -> Binary value (base 2)
;   None -> decimal or base 10
.proc Main
    ; Initializre X as 10
    ldx #10
    ; stx Store X Register Data into Memory
    stx $00
    stx $01
    ; Increment the Data at a Memory location
    inc $00
    ; Decrement the Data at a Memory location
    dec $01

    ; Store the value from Memory location and store in diferent memory location
    ldx $00     ; $00 -> $0300
    stx $0300 
    ldx $01     ; $01 -> $0301
    stx $0301 

    ; Addressing Modes:
    ;   Immediate Addresing:
    ;       ldx #10 -> using constant or immediate
    ;       cons: You won't be able to store a immediate value larger than a byte using this 6502
    ;   ZeroPage Addresing:
    ;       This works by providing a 8 byte instruction
    ;       Example:
    ;           ldx $2F
    ;       Operand:
    ;           Address or value over which to perform an operation
    ;       ZeroPage operates in address: $0000 - $00FF
    ;   Absolute Addressing:
    ;       This is denote by using a 4 digit Hexadecimal as operand
    ;       Allows to access the 4Kb of the sysyrm memory (This is a bit slower)
    ;   Implicit Addressing
    ;       This is use for any instruction that has already a address define
    ;       Example:
    ;           inx
    ;           iny

    ; Adding number (6502 operate in binary) 
    ; Since the number limit of 6502 is 256 bits you can increase this by putting more memory carrying away the number being able to operate on more than 8 bytes

    ; Initialize some RAM

    ldx #$B5
    stx $00
    ldx #$F5
    stx $01

    ; Add $00 and $01
    ; lda : Load data on accumulator register (Use for all arithmetic operations)
    lda $00 ; The accumulator is going to be #$B2
    ; clc : Clear carry (Clears the Processors Internal Carry Flag)
    clc ; This should be made to remove the carry from processor
    ; adc : Add with carry, adds the acumulator to a given memory value
    adc $01 ; $01 + A + C

    ; Store hte first byte of the result to $02
    ; sta : Store accumulator (A), store data in the accumulator Memory
    sta $02 ; Lower 8 bits of the result 

    ; Add the carry bit to zero and store it into $03
    lda #0 ; Set accumulator to 0
    adc #0 ; Add the carry    0
    sta $03 ; Upper 8 bits of the result 

    ;
    rts
.endproc