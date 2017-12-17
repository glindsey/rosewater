; PPU VRAM access
#pragma once
#include "vangogh_constants.inc"
#include "utilities.inc"

#define rYPOS           r12
#define rXMAX           r13
#define rXPOS2          r14
#define rXPOS           r15

.text

.macro OE_ON  ; 1 cycle
      cbi CTL2PORT, OEPIN
.endm

.macro OE_OFF  ; 1 cycle
      sbi CTL2PORT, OEPIN
.endm

.macro WE_ON  ; 1 cycle
      cbi CTL2PORT, WEPIN
.endm

.macro WE_OFF  ; 1 cycle
      sbi CTL2PORT, WEPIN
.endm

.macro OE_AND_WE_OFF  ; 2 cycles
      sbi CTL2PORT, OEPIN
      sbi CTL2PORT, WEPIN
.endm

.macro ADDRESS_VDU
      cbi CTRLPORT, A18PIN
      cbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN
.endm

.macro ADDRESS_VRAM0
      cbi CTRLPORT, A18PIN
      sbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN
.endm

.macro ADDRESS_VRAM1
      sbi CTRLPORT, A18PIN
      cbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN
.endm

.macro ADDRESS_PALRAM
      sbi CTRLPORT, A18PIN
      sbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN
.endm

; Sets data port to be an input.
.macro SET_DATA_INPUT
      ldi rTEMP, DATABIT_DDR_INPUT
      out DATADDR, rTEMP
.endm

; Sets data port to be an output.
.macro SET_DATA_OUTPUT
      ldi rTEMP, DATABIT_DDR_OUTPUT
      out DATADDR, rTEMP
.endm

; Reads from the data port into a high (r16-r31) register.
.macro READ_DATA_INTO reg:req
      SET_DATA_INPUT
      OE_ON
      nop
      in \reg, DATAPORT
      OE_OFF
.endm

; Writes to the data port from a high (r16-r31) register.
.macro WRITE_DATA_FROM reg:req
      SET_DATA_OUTPUT
      out DATAPORT, \reg
      WE_ON
      nop
      WE_OFF
.endm

; Sets the high address latch to the value in r0.
;
; Inputs:
;     r0     Contains the value to set high address latch to
; Outputs:
;     none
; Clobbers:
;     rTEMP, rTEMP2, rTEMP3
;
.global set_hi_addr_latch
set_hi_addr_latch:
      in rTEMP, DATADDR
      in rTEMP2, DATAPORT
      ldi rTEMP3, DATABIT_DDR_OUTPUT
      out DATADDR, rTEMP3
      out DATAPORT, r0
      sbi CTRLPORT, HALLATPIN
      nop
      cbi CTRLPORT, HALLATPIN
      out DATAPORT, rTEMP2
      out DATADDR, rTEMP
      ret

.global setup_palette
setup_palette:
      ; Right now palette RAM high address is forced to 00.

      ; Set data lines to outputs.
      ldi rTEMP, DATABIT_DDR_OUTPUT
      out DATADDR, rTEMP

      ; Turn VDRAW off (by setting it high).
      ; It probably already is, but let's do it anyway.
      sbi CTRLPORT, VDRAWPIN

      ADDRESS_PALRAM

      ; Set high address latch to 0x80 (for high bytes).
      _LDI r0, 0x80
      call set_hi_addr_latch

      ; Loop through low addresses and set data = address for now.
      ldi rTEMP, 0
      ;ldi rTEMP2, 255

palette_set_loop_low:
      dec rTEMP
      out ADDRPORT, rTEMP
      mov rTEMP2, rTEMP
      out DATAPORT, rTEMP2
      WE_ON
      _NOP 4
      WE_OFF
      cpi rTEMP, 0
      brne palette_set_loop_low

      ; Set high address latch to 0x00 (for low bytes).
      _LDI r0, 0x00
      call set_hi_addr_latch

      ; Loop through low addresses and set data = address for now.
      ldi rTEMP, 0
      ;ldi rTEMP2, 255

palette_set_loop_high:
      dec rTEMP
      out ADDRPORT, rTEMP
      mov rTEMP2, rTEMP
      out DATAPORT, rTEMP2
      WE_ON
      _NOP 4
      WE_OFF
      cpi rTEMP, 0
      brne palette_set_loop_high

      ; Reset data lines back to inputs with pullups enabled.
      ldi rTEMP, DATABIT_DDR_INPUT
      out DATADDR, rTEMP
      ldi rTEMP, DATABIT_PORT_INIT
      out DATAPORT, rTEMP

      ADDRESS_VDU

      ret

; Sets up VRAM with a test tartan pattern.
setup_vram:
      ; Set data lines to outputs.
      ldi rTEMP, DATABIT_DDR_OUTPUT
      out DATADDR, rTEMP

      ADDRESS_VRAM0

      ; Loop through high addresses, 255 to 0.
      _LDI rYPOS, 0

vram_set_loop_y:
      dec rYPOS

      ; Set high address latch to Y position.
      mov r0, rYPOS
      call set_hi_addr_latch

      ; Loop through low addresses and set data lines to make a tartan.
      ; = (xpos + ypos) >> 3 for now.
      _LDI rXPOS, 0

vram_set_loop_x:
      dec rXPOS
      out ADDRPORT, rXPOS
      mov rTEMP, rXPOS
      lsl rTEMP
      andi rTEMP, 0xF8
      mov rTEMP2, rYPOS
      lsr rTEMP2
      lsr rTEMP2
      lsr rTEMP2
      andi rTEMP2, 0x07
      or rTEMP2, rTEMP
      out DATAPORT, rTEMP2
      WE_ON
      _NOP 4
      WE_OFF
      _CPI rXPOS, 0
      brne vram_set_loop_x

      _CPI rYPOS, 0
      brne vram_set_loop_y

      ; Reset data lines back to inputs with pullups enabled.
      ldi rTEMP, DATABIT_DDR_INPUT
      out DATADDR, rTEMP
      ldi rTEMP, DATABIT_PORT_INIT
      out DATAPORT, rTEMP

      ADDRESS_VDU

      ret


; Zeroes out all VRAM -- both chips.
.global clear_vram
clear_vram:
      ; Set data lines to outputs.
      ldi rTEMP, DATABIT_DDR_OUTPUT
      out DATADDR, rTEMP

      ADDRESS_VRAM0
      rcall zero_loop
      ADDRESS_VRAM1
      rcall zero_loop

      ret

; Zeroing loop called by clear_vram.
zero_loop:

      ; Loop through high addresses, 255 to 0.
      _LDI rYPOS, 0

clear_loop_y:
      dec rYPOS

      ; Set high address latch to Y position.
      mov r0, rYPOS
      call set_hi_addr_latch

      _LDI rXPOS, 0

clear_loop_x:
      dec rXPOS
      out ADDRPORT, rXPOS
      ldi rTEMP2, 0
      out DATAPORT, rTEMP2
      WE_ON
      _NOP 4
      WE_OFF
      _CPI rXPOS, 0
      brne clear_loop_x

      _CPI rYPOS, 0
      brne clear_loop_y

      ; Reset data lines back to inputs with pullups enabled.
      ldi rTEMP, DATABIT_DDR_INPUT
      out DATADDR, rTEMP
      ldi rTEMP, DATABIT_PORT_INIT
      out DATAPORT, rTEMP

      ADDRESS_VDU

      ret
