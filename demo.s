;; Emmanuel J. Gonzalez Morales 
;; Num estudiante: 802-19-6606

.segment "HEADER"
  ; .byte "NES", $1A      ; iNES header identifier
  .byte $4E, $45, $53, $1A
  .byte 2               ; 2x 16KB PRG code
  .byte 1               ; 1x  8KB CHR data
  .byte $01, $00        ; mapper 0, vertical mirroring

.segment "VECTORS"
  ;; When an NMI happens (once per frame if enabled) the label nmi:
  .addr nmi
  ;; When the processor first turns on or is reset, it will jump to the label reset:
  .addr reset
  ;; External interrupt IRQ (unused)
  .addr 0

; "nes" linker config requires a STARTUP section, even if it's empty
.segment "STARTUP"

; Main code segment for the program
.segment "CODE"

reset:
  sei		; disable IRQs
  cld		; disable decimal mode
  ldx #$40
  stx $4017	; disable APU frame IRQ
  ldx #$ff 	; Set up stack
  txs		;  .
  inx		; now X = 0
  stx $2000	; disable NMI
  stx $2001 	; disable rendering
  stx $4010 	; disable DMC IRQs

;; first wait for vblank to make sure PPU is ready
vblankwait1:
  bit $2002
  bpl vblankwait1

clear_memory:
  lda #$00
  sta $0000, x
  sta $0100, x
  sta $0200, x
  sta $0300, x
  sta $0400, x
  sta $0500, x
  sta $0600, x
  sta $0700, x
  inx
  bne clear_memory

;; second wait for vblank, PPU is ready after this
vblankwait2:
  bit $2002
  bpl vblankwait2

main:
load_palettes:
  lda $2002
  lda #$3f
  sta $2006
  lda #$00
  sta $2006
  ldx #$00
@loop:
  lda palettes, x
  sta $2007
  inx
  cpx #$20
  bne @loop

enable_rendering:
  lda #%10000000	; Enable NMI
  sta $2000
  lda #%00010000	; Enable Sprites
  sta $2001

forever:
  jmp forever

nmi:
  ldx #$00 	; Set SPR-RAM address to 0
  stx $2003
@loop:	lda nombre, x 	; Load my name into SPR-RAM
  sta $2004
  inx
  cpx #$48 ; Emmanuel Gonzalez (length=16) * 4 = 64 -> HEX $40
  bne @loop
  rti

nombre: 

  .byte $00, $00, $00, $00 	; Why do I need these here?
  .byte $00, $00, $00, $00
  ;     Y               X
  .byte $6c, $01, $00, $5c ; E <- Start name 
  .byte $6c, $04, $00, $66 ; M
  .byte $6c, $04, $00, $70 ; M
  .byte $6c, $05, $00, $7a ; A
  .byte $6c, $07, $01, $84 ; N
  .byte $6c, $06, $02, $8e ; U
  .byte $6c, $01, $00, $98 ; E
  .byte $6c, $02, $01, $a2 ; L
  
  .byte $78, $08, $02, $5c ; G <- Start surname 
  .byte $78, $03, $02, $66 ; O
  .byte $78, $07, $01, $70 ; N
  .byte $78, $09, $01, $7a ; Z
  .byte $78, $05, $00, $84 ; A
  .byte $78, $02, $01, $8e ; L
  .byte $78, $01, $00, $98 ; E
  .byte $78, $09, $01, $a2 ; Z
  ;     Y               X
palettes:
  ; Background Palette
  .byte $0f, $00, $00, $00
  .byte $0f, $00, $00, $00
  .byte $0f, $00, $00, $00
  .byte $0f, $00, $00, $00

  ; Sprite Palette
  .byte $0f, $2b, $31, $12
  .byte $0f, $25, $26, $08
  .byte $0f, $16, $29, $28
  .byte $0f, $00, $00, $00

; Character memory
.segment "CHARS"
  .byte %11000011	; H (00)
  .byte %11000011
  .byte %11000011
  .byte %11111111
  .byte %11111111
  .byte %11000011
  .byte %11000011
  .byte %11000011
  
  .byte %00000000	
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000

  .byte %11111111	; E (01)
  .byte %11000011
  .byte %10000001
  .byte %11111000
  .byte %11111000
  .byte %10000001
  .byte %11000011
  .byte %11111111
  ; $#
  .byte %11111111	
  .byte %11000011
  .byte %10000001
  .byte %11111000
  .byte %11111000
  .byte %10000001
  .byte %11000011
  .byte %11111111

  .byte %11100000	; L (02)
  .byte %11100000
  .byte %11000000
  .byte %11000000
  .byte %11000000
  .byte %11000000
  .byte %11111111
  .byte %11111111
  
  .byte %11100000	
  .byte %11100000
  .byte %11000000
  .byte %11000000
  .byte %11000000
  .byte %11000000
  .byte %11111111
  .byte %11111111

  .byte %01111110	; O (03)
  .byte %11100111
  .byte %11000011
  .byte %11000011
  .byte %11000011
  .byte %11000011
  .byte %11100111
  .byte %01111110
  .byte $00, $00, $00, $00, $00, $00, $00, $00

  .byte %00000000	; M (04)
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000

  .byte %01111110	
  .byte %11011011
  .byte %11011011
  .byte %11000011
  .byte %11000011
  .byte %11000011
  .byte %11000011
  .byte %10000001


  .byte %00011000	; A (05)
  .byte %00111100
  .byte %01100110
  .byte %01100110
  .byte %11111111
  .byte %11000011
  .byte %11000011
  .byte %11000011
  .byte $00, $00, $00, $00, $00, $00, $00, $00

  .byte %11000011	; U (06)
  .byte %11000011
  .byte %11000011
  .byte %11000011
  .byte %11000011
  .byte %11000011
  .byte %01100110
  .byte %00111100

  .byte %11000011	
  .byte %11000011
  .byte %11000011
  .byte %11000011
  .byte %11000011
  .byte %11000011
  .byte %01100110
  .byte %00111100

  .byte %00000000	; N (07)
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  
  .byte %10000001	
  .byte %11000011
  .byte %11100011
  .byte %11110011
  .byte %11011011
  .byte %11001111
  .byte %11000111
  .byte %11000001
  

  .byte %00000000	; G (08)
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000
  .byte %00000000

  .byte %00011111	
  .byte %00110000
  .byte %01100000
  .byte %11000000
  .byte %11001111
  .byte %11000011
  .byte %01100110
  .byte %00111100


  .byte %11111111	; Z (09)
  .byte %11111111
  .byte %00000110
  .byte %00011110
  .byte %00111100
  .byte %00110000
  .byte %11111111
  .byte %11111111
  .byte $00, $00, $00, $00, $00, $00, $00, $00
   
