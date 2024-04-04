.include "constants.inc"
.include "header.inc"

.segment "CODE"
.proc irq_handler
  RTI
.endproc

.proc nmi_handler
  LDA #$00
  STA OAMADDR
  LDA #$02
  STA OAMDMA
	LDA #$00
	STA $2005
	STA $2005
  RTI
.endproc

.import reset_handler

.export main
.proc main
  ; write a palette
  LDX PPUSTATUS
  LDX #$3f
  STX PPUADDR
  LDX #$00
  STX PPUADDR
load_palettes:
  LDA palettes,X
  STA PPUDATA
  INX
  CPX #$20
  BNE load_palettes

  ; write sprite data
  LDX #$00
load_sprites:
  LDA sprites,X
  STA $0200,X
  INX
  CPX #$C0
  BNE load_sprites

	; write nametables
	
	; blank wall
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$8A
	STA PPUADDR
	LDX #$00
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$0B
	STA PPUADDR
	LDX #$01
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$AA
	STA PPUADDR
	LDX #$10
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$AB
	STA PPUADDR
	LDX #$11
	STX PPUDATA

	; brick wall
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$80
	STA PPUADDR
	LDX #$02
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$81
	STA PPUADDR
	LDX #$03
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$A0
	STA PPUADDR
	LDX #$12
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$A1
	STA PPUADDR
	LDX #$13
	STX PPUDATA

	; brick wall 2
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$82
	STA PPUADDR
	LDX #$04
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$83
	STA PPUADDR
	LDX #$05
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$A2
	STA PPUADDR
	LDX #$14
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$A3
	STA PPUADDR
	LDX #$15
	STX PPUDATA

	; floor
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$84
	STA PPUADDR
	LDX #$06
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$85
	STA PPUADDR
	LDX #$07
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$A4
	STA PPUADDR
	LDX #$16
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$A5
	STA PPUADDR
	LDX #$17
	STX PPUDATA

	; Door
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$86
	STA PPUADDR
	LDX #$08
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$87
	STA PPUADDR
	LDX #$09
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$A6
	STA PPUADDR
	LDX #$18
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$A7
	STA PPUADDR
	LDX #$19
	STX PPUDATA

	; iron wall 
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$88
	STA PPUADDR
	LDX #$0A
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$89
	STA PPUADDR
	LDX #$0B
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$A8
	STA PPUADDR
	LDX #$1A
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$A9
	STA PPUADDR
	LDX #$1B
	STX PPUDATA

	; ice wall 
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$C4
	STA PPUADDR
	LDX #$0C
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$C5
	STA PPUADDR
	LDX #$0D
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$E4
	STA PPUADDR
	LDX #$1C
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$E5
	STA PPUADDR
	LDX #$1D
	STX PPUDATA

	; water  
	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$C6
	STA PPUADDR
	LDX #$0E
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$C7
	STA PPUADDR
	LDX #$0F
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$E6
	STA PPUADDR
	LDX #$1E
	STX PPUDATA

	LDA PPUSTATUS
	LDA #$20
	STA PPUADDR
	LDA #$E7
	STA PPUADDR
	LDX #$1F
	STX PPUDATA

vblankwait:       ; wait for another vblank before continuing
  BIT PPUSTATUS
  BPL vblankwait

  LDA #%10010000  ; turn on NMIs, sprites use first pattern table
  STA PPUCTRL
  LDA #%00011110  ; turn on screen
  STA PPUMASK

forever:
  JMP forever
.endproc

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "RODATA"
palettes:
.byte $0f, $12, $23, $27
.byte $0f, $2b, $3c, $39
.byte $0f, $0c, $07, $13
.byte $0f, $19, $09, $29

.byte $0f, $2d, $10, $15
.byte $0f, $19, $09, $29
.byte $0f, $19, $09, $29
.byte $0f, $19, $09, $29

sprites:
.byte $00, $00, $00, $00
.byte $00, $01, $00, $08
.byte $08, $10, $00, $00
.byte $08, $11, $00, $08

.byte $00, $02, $00, $10
.byte $00, $03, $00, $18
.byte $08, $12, $00, $10
.byte $08, $13, $00, $18

.byte $00, $04, $00, $20
.byte $00, $05, $00, $28
.byte $08, $14, $00, $20
.byte $08, $15, $00, $28

.byte $00, $06, $00, $30
.byte $00, $07, $00, $38
.byte $08, $16, $00, $30
.byte $08, $17, $00, $38

.byte $30, $08, $00, $00
.byte $30, $09, $00, $08
.byte $38, $18, $00, $00
.byte $38, $19, $00, $08

.byte $30, $0A, $00, $10
.byte $30, $0B, $00, $18
.byte $38, $1A, $00, $10
.byte $38, $1B, $00, $18
;===============================
.byte $10, $20, $00, $00
.byte $10, $21, $00, $08
.byte $18, $30, $00, $00
.byte $18, $31, $00, $08

.byte $10, $22, $00, $10
.byte $10, $23, $00, $18
.byte $18, $32, $00, $10
.byte $18, $33, $00, $18

.byte $10, $24, $00, $20
.byte $10, $25, $00, $28
.byte $18, $34, $00, $20
.byte $18, $35, $00, $28

.byte $10, $26, $00, $30
.byte $10, $27, $00, $38
.byte $18, $36, $00, $30
.byte $18, $37, $00, $38

.byte $40, $28, $00, $00
.byte $40, $29, $00, $08
.byte $48, $38, $00, $00
.byte $48, $39, $00, $08

.byte $40, $2A, $00, $10
.byte $40, $2B, $00, $18
.byte $48, $3A, $00, $10
.byte $48, $3B, $00, $18

.segment "CHR"
.incbin "starfield.chr"
