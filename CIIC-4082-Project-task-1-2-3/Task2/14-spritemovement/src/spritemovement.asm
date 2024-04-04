.include "constants.inc"
.include "header.inc"

.segment "ZEROPAGE"
player_x_forward: .res 1
player_y_forward: .res 1

player_y_left: .res 1
player_x_left: .res 1

player_y_right: .res 1
player_x_right: .res 1

player_y_backward: .res 1
player_x_backward: .res 1

;player_dir: .res 1
nmi_buffer: .res 1
tile_offset: .res 1
.exportzp player_x_forward, player_y_forward, player_x_left, player_y_left, player_x_right, player_y_right, player_x_backward, player_y_backward, nmi_buffer, tile_offset


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

  ; update tiles *after* DMA transfer
	; JSR update_player
  JSR tile_update
  JSR draw_player_forward
  JSR draw_player_left
  JSR draw_player_right
  JSR draw_player_backward

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


.proc draw_player_forward
  ; save registers
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

  LDA tile_offset
  CLC
  ADC #$06
  STA $0201

  LDA tile_offset
  CLC
  ADC #$07
  STA $0205

  LDA tile_offset
  CLC
  ADC #$16
  STA $0209

  LDA tile_offset
  CLC
  ADC #$17
  STA $020d

  ; write player ship tile attributes
  ; use palette 0
  LDA #$00
  STA $0202
  STA $0206
  STA $020a
  STA $020e

  ; store tile locations
  ; top left tile:
  LDA player_y_forward
  STA $0200
  LDA player_x_forward
  STA $0203

  ; top right tile (x + 8):
  LDA player_y_forward
  STA $0204
  LDA player_x_forward
  CLC
  ADC #$08
  STA $0207

  ; bottom left tile (y + 8):
  LDA player_y_forward
  CLC
  ADC #$08
  STA $0208
  LDA player_x_forward
  STA $020b

  ; bottom right tile (x + 8, y + 8)
  LDA player_y_forward
  CLC
  ADC #$08
  STA $020c
  LDA player_x_forward
  CLC
  ADC #$08
  STA $020f

  ; restore registers and return
  PLA
  TAY
  PLA
  TAX
  PLA
  PLP
  RTS
.endproc

.proc draw_player_left
  ; save registers
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

  LDA tile_offset
  CLC
  ADC #$00
  STA $0211

  LDA tile_offset
  CLC
  ADC #$01
  STA $0215

  LDA tile_offset
  CLC
  ADC #$10
  STA $0219

  LDA tile_offset
  CLC
  ADC #$11
  STA $021d

  ; write player ship tile attributes
  ; use palette 0
  LDA #$00
  STA $0212
  STA $0216
  STA $021a
  STA $021e

  ; store tile locations
  ; top left tile:
  LDA player_y_left
  STA $0210
  LDA player_x_left
  STA $0213

  ; top right tile (x + 8):
  LDA player_y_left
  STA $0214
  LDA player_x_left
  CLC
  ADC #$08
  STA $0217

  ; bottom left tile (y + 8):
  LDA player_y_left
  CLC
  ADC #$08
  STA $0218
  LDA player_x_left
  STA $021b

  ; bottom right tile (x + 8, y + 8)
  LDA player_y_left
  CLC
  ADC #$08
  STA $021c
  LDA player_x_left
  CLC
  ADC #$08
  STA $021f

  ; restore registers and return
  PLA
  TAY
  PLA
  TAX
  PLA
  PLP
  RTS
.endproc

.proc draw_player_right
  ; save registers
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

  LDA tile_offset
  CLC
  ADC #$20
  STA $0221

  LDA tile_offset
  CLC
  ADC #$21
  STA $0225

  LDA tile_offset
  CLC
  ADC #$30
  STA $0229

  LDA tile_offset
  CLC
  ADC #$31
  STA $022d

  ; write player ship tile attributes
  ; use palette 0
  LDA #$00
  STA $0222
  STA $0226
  STA $022a
  STA $022e

  ; store tile locations
  ; top left tile:
  LDA player_y_right
  STA $0220
  LDA player_x_right
  STA $0223

  ; top right tile (x + 8):
  LDA player_y_right
  STA $0224
  LDA player_x_right
  CLC
  ADC #$08
  STA $0227

  ; bottom left tile (y + 8):
  LDA player_y_right
  CLC
  ADC #$08
  STA $0228
  LDA player_x_right
  STA $022b

  ; bottom right tile (x + 8, y + 8)
  LDA player_y_right
  CLC
  ADC #$08
  STA $022c
  LDA player_x_right
  CLC
  ADC #$08
  STA $022f

  ; restore registers and return
  PLA
  TAY
  PLA
  TAX
  PLA
  PLP
  RTS
.endproc

.proc draw_player_backward
  ; save registers
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

  LDA tile_offset
  CLC
  ADC #$26
  STA $0231

  LDA tile_offset
  CLC
  ADC #$27
  STA $0235

  LDA tile_offset
  CLC
  ADC #$36
  STA $0239

  LDA tile_offset
  CLC
  ADC #$37
  STA $023d

  ; write player ship tile attributes
  ; use palette 0
  LDA #$00
  STA $0232
  STA $0236
  STA $023a
  STA $023e

  ; store tile locations
  ; top left tile:
  LDA player_y_backward
  STA $0230
  LDA player_x_backward
  STA $0233

  ; top right tile (x + 8):
  LDA player_y_backward
  STA $0234
  LDA player_x_backward
  CLC
  ADC #$08
  STA $0237

  ; bottom left tile (y + 8):
  LDA player_y_backward
  CLC
  ADC #$08
  STA $0238
  LDA player_x_backward
  STA $023b

  ; bottom right tile (x + 8, y + 8)
  LDA player_y_backward
  CLC
  ADC #$08
  STA $023c
  LDA player_x_backward
  CLC
  ADC #$08
  STA $023f

  ; restore registers and return
  PLA
  TAY
  PLA
  TAX
  PLA
  PLP
  RTS
.endproc

.proc tile_update

; save registers
  PHP
  PHA
  TXA
  PHA
  TYA
  PHA

  LDA nmi_buffer
  CLC 
  ADC #$01
  STA nmi_buffer


  LDA nmi_buffer
  CMP #$05
  BEQ next_frame

  
  JMP exit
  
  next_frame:
    LDA tile_offset
    CLC
    ADC #$02
    STA tile_offset

    LDA tile_offset
    CMP #$06
    BEQ reset
    LDA #$00
    STA nmi_buffer
    JMP exit


  reset:
    LDX #$00
    STX tile_offset
    STX nmi_buffer
    JMP exit

   ; restore registers and return
  exit:
    PLA
    TAY
    PLA
    TAX
    PLA
    PLP
    RTS



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

.segment "CHR"
.incbin "starfield.chr"
