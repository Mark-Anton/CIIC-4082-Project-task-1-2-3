.include "constants.inc"

.segment "ZEROPAGE"
.importzp player_x, player_y, nmi_buffer, tile_offset

.segment "CODE"
.import main
.export reset_handler
.proc reset_handler
  SEI
  CLD
  LDX #$40
  STX $4017
  LDX #$FF
  TXS
  INX
  STX $2000
  STX $2001
  STX $4010
  BIT $2002
vblankwait:
  BIT $2002
  BPL vblankwait

	LDX #$00
	LDA #$FF
clear_oam:
	STA $0200,X ; set sprite y-positions off the screen
	INX
	INX
	INX
	INX
	BNE clear_oam

	; initialize zero-page values
	LDA #$80
	STA player_x
	LDA #$a0
	STA player_y

  LDA #$00
  STA tile_offset
  STA nmi_buffer

vblankwait2:
  BIT $2002
  BPL vblankwait2
  JMP main
.endproc
