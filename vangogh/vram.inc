; PPU VRAM access
#ifndef VRAM_INC
#define VRAM_INC

#include "constants.inc"
#include "shared/utilities.inc"

.DEF rYPOS	= r12
.DEF rXMAX	= r13
.DEF rXPOS2	= r14
.DEF rXPOS	= r15

.CSEG

.MACRO OE_ON  ; 1 cycle
      cbi CTL2PORT, OEPIN
.ENDM

.MACRO OE_OFF  ; 1 cycle
      sbi CTL2PORT, OEPIN
.ENDM

.MACRO WE_ON  ; 1 cycle
      cbi CTL2PORT, WEPIN
.ENDM

.MACRO WE_OFF  ; 1 cycle
      sbi CTL2PORT, WEPIN
.ENDM

.MACRO OE_AND_WE_OFF  ; 2 cycles
      sbi CTL2PORT, OEPIN
      sbi CTL2PORT, WEPIN
.ENDM

.MACRO ADDRESS_VDU
      cbi CTRLPORT, A18PIN
      cbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN
.ENDM

.MACRO ADDRESS_VRAM0
      cbi CTRLPORT, A18PIN
      sbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN
.ENDM

.MACRO ADDRESS_VRAM1
      sbi CTRLPORT, A18PIN
      cbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN
.ENDM

.MACRO ADDRESS_PALRAM
      sbi CTRLPORT, A18PIN
      sbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN
.ENDM

; Sets data port to be an input.
.MACRO SET_DATA_INPUT
      ldi rTEMP, DATABIT_DDR_INPUT
      out DATADDR, rTEMP
.ENDM

; Sets data port to be an output.
.MACRO SET_DATA_OUTPUT
      ldi rTEMP, DATABIT_DDR_OUTPUT
      out DATADDR, rTEMP
.ENDM

; Reads from the data port into a high (r16-r31) register.
.MACRO READ_DATA_INTO
      SET_DATA_INPUT
      OE_ON
      nop
      in @0, DATAPORT
      OE_OFF
.ENDM

; Writes to the data port from a high (r16-r31) register.
.MACRO WRITE_DATA_FROM
      SET_DATA_OUTPUT
      out DATAPORT, @0
      WE_ON
      nop
      WE_OFF
.ENDM

; Sets the high address latch to the value in the specified register.
;
; Inputs:
;       @0     Register containing the value to set high address latch to
; Outputs:
;       none
; Clobbers:
;       rTEMP, rTEMP2, rTEMP3
; Timing:
;       9 cycles
.MACRO SET_HAL
    in rTEMP, DATADDR
    in rTEMP2, DATAPORT
    ldi rTEMP3, DATABIT_DDR_OUTPUT
    out DATADDR, rTEMP3
    out DATAPORT, @0
    sbi CTRLPORT, HALLATPIN
    cbi CTRLPORT, HALLATPIN
    out DATAPORT, rTEMP2
    out DATADDR, rTEMP
.ENDM

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
      ldi rTEMP, 0x80
      SET_HAL rTEMP

      ; Loop through low addresses and set data = address for now.
      ldi rTEMP, 0
      ;ldi rTEMP2, 255

palette_set_loop_low:
      dec rTEMP
      out ADDRPORT, rTEMP
      mov rTEMP2, rTEMP
      out DATAPORT, rTEMP2
      WE_ON
      _NOP4
      WE_OFF
      cpi rTEMP, 0
      brne palette_set_loop_low

      ; Set high address latch to 0x00 (for low bytes).
      ldi rTEMP, 0x00
      SET_HAL rTEMP

      ; Loop through low addresses and set data = address for now.
      ldi rTEMP, 0
      ;ldi rTEMP2, 255

palette_set_loop_high:
      dec rTEMP
      out ADDRPORT, rTEMP
      mov rTEMP2, rTEMP
      out DATAPORT, rTEMP2
      WE_ON
      _NOP4
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
      SET_HAL rYPOS

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
      _NOP4
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
      SET_HAL rYPOS

      _LDI rXPOS, 0

clear_loop_x:
      dec rXPOS
      out ADDRPORT, rXPOS
      ldi rTEMP2, 0
      out DATAPORT, rTEMP2
      WE_ON
      _NOP4
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

#endif
