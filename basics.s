.export Main
.segment "CODE"

; Main procedure of the game
.proc Main
    ; Set x and y to 5, # means hexadecimal
    ; ld stand for load 
    ldx #5
    ldy #5

    ; Increment x and y twice
    ; Increasing X
    inx ; 5 + 1 + 1
    inx ; 5 + 1 + 1 

    ; Increasing Y
    iny ; 5 + 1 + 1
    iny ; 5 + 1 + 1

    ; Decreament X once
    dex ; 5 + 1 + 1 - 1 = 6 

    ; Decrease Y twice
    dey ; 5 + 1 + 1 - 1 = 6 
    dey ; 5 + 1 + 1 - 1 - 1 = 5 

    rts
.endproc
