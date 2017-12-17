; PPU Registers File - 0x00 to 0xFF
#pragma once
#include "vangogh_constants.inc"

.set PPUREG_MODE                   , 0

.set PPUREG_MODE_VRAM_DIRECT_6, 0
.set PPUREG_MODE_VRAM_DIRECT_5, 1

.text

; Loads data from a PPU register.
; Cycles: 7
; Inputs:
;   reg     CPU register to load into
;   ppureg  PPU register to load from (00 to FF)
; Outputs:
;   reg contains the requested data from ppureg
; Clobbers:
;   X (r26/r27), rTEMP
.macro LOAD_PPUREG reg, ppureg
ldi XL, lo8(ppu_registers)  ; [1]
ldi XH, hi8(ppu_registers)  ; [1]
ldi rTEMP, ppureg           ; [1]
add XL, rTEMP               ; [1]
adc XH, rZERO               ; [1]
ld reg, X                   ; [2]
.endm

; Saves data into a PPU register.
; Cycles:
; Inputs:
;   ppureg  PPU register to save into (00 to FF)
;   reg     CPU register to save from
.macro SAVE_PPUREG ppureg, reg
ldi XL, lo8(ppu_registers)  ; [1]
ldi XH, hi8(ppu_registers)  ; [1]
ldi rTEMP, ppureg           ; [1]
add XL, rTEMP               ; [1]
adc XH, rZERO               ; [1]
st X, reg                   ; [2]
.endm

.macro SAVE_PPUREG_IMM ppureg, val
ldi XL, lo8(ppu_registers)  ; [1]
ldi XH, hi8(ppu_registers)  ; [1]
ldi rTEMP, ppureg           ; [1]
ldi rTEMP2, val             ; [1]
add XL, rTEMP               ; [1]
adc XH, rZERO               ; [1]
st X, rTEMP2                ; [2]
.endm

; Loads the PPU register address into X.
; Outputs:
;   X contains the address of PPU register data
; Clobbers:
;   X (r26/r27)
.macro LOAD_PPUREG_ADDR
ldi XL, lo8(ppu_registers)
ldi XH, hi8(ppu_registers)
.endm

; Initializes the PPU registers to default values.
.global init_ppu_registers
init_ppu_registers:
        SAVE_PPUREG_IMM PPUREG_MODE, 0x0
        ret

.data

.global ppu_registers
ppu_registers:
.zero 256
