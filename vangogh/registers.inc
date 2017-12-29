; PPU Registers File - 0x00 to 0xFF
#ifndef REGISTERS_INC
#include "constants.inc"

.EQU PPUREG_MODE = 0

.EQU PPUREG_MODE_VRAM_DIRECT_6 = 0
.EQU PPUREG_MODE_VRAM_DIRECT_5 = 1
.EQU PPUREG_MODE_LINE_BUFFER   = 2

.CSEG

; Loads data from a PPU register.
; Cycles: 7
; Inputs:
;   @0	CPU register to load into
;   @1	PPU register to load from (00 to FF)
; Outputs:
;   @0 contains the requested data from ppureg
; Clobbers:
;   X (r26/r27), rTEMP
.MACRO LOAD_PPUREG
ldi XL, LOW(ppu_registers)  ; [1]
ldi XH, HIGH(ppu_registers) ; [1]
ldi rTEMP, @1               ; [1]
add XL, rTEMP               ; [1]
adc XH, rZERO               ; [1]
ld @0, X                    ; [2]
.ENDM

; Saves data into a PPU register.
; Cycles:
; Inputs:
;   @0	PPU register to save into (00 to FF)
;   @1	CPU register to save from
.MACRO SAVE_PPUREG
ldi XL, LOW(ppu_registers)  ; [1]
ldi XH, HIGH(ppu_registers) ; [1]
ldi rTEMP, @0               ; [1]
add XL, rTEMP               ; [1]
adc XH, rZERO               ; [1]
st X, @1                    ; [2]
.ENDM

.MACRO SAVE_PPUREG_IMM
ldi XL, LOW(ppu_registers)  ; [1]
ldi XH, HIGH(ppu_registers) ; [1]
ldi rTEMP, @0               ; [1]
ldi rTEMP2, @1              ; [1]
add XL, rTEMP               ; [1]
adc XH, rZERO               ; [1]
st X, rTEMP2                ; [2]
.ENDM

; Loads the PPU register address into X.
; Outputs:
;   X contains the address of PPU register data
; Clobbers:
;   X (r26/r27)
.MACRO LOAD_PPUREG_ADDR
ldi XL, LOW(ppu_registers)
ldi XH, HIGH(ppu_registers)
.ENDM

; Initializes the PPU registers to default values.
init_ppu_registers:
        SAVE_PPUREG_IMM PPUREG_MODE, PPUREG_MODE_LINE_BUFFER
        ret

.DSEG
.ORG 0x0100
ppu_registers:
.BYTE 256

#endif
