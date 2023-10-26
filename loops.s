.export Main
.segment "Code"

.proc Main

    
  ; Initialize each monster's HP
  lda #100
  ldx #7
initialize_hp_loop:
  sta $0300, x
  dex
  bpl initialize_hp_loop

  ; Make a couple changes to test the logic
  lda #0
  sta $0301
  lda #15
  sta $0306

  ; Perform the multi-attack
  ldx #0
multi_attack_loop:
  lda $0300, x
  sec       ; Set carry
  sbc #50   ; Substract with carry
  bpl store_hp
  lda #0
store_hp:
  sta $0300, x
  inx
  cpx #8 ; -> compare with x
  bne multi_attack_loop

  ; Loop compete, return from subroutine
  rts

.endproc