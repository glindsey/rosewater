; PPU Registers File - 0x00 to 0xFF
#pragma once
#include "ppu_constants.inc"

.text

; Loads data from a PPU register.
; Inputs:
;   reg     CPU register to load into.
;   ppureg  PPU register to load (00 to FF)
; Outputs:
;   reg contains the requested data from ppureg
; Clobbers:
;   X (r26/r27), rTEMP
.macro LOAD_PPUREG_IMM reg, ppureg
ldi XL, lo8(ppu_registers)
ldi rTEMP, ppureg
add XL, rTEMP
ldi XH, hi8(ppu_registers)
ld reg, X
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

.data

.global ppu_registers
ppu_registers:
.rept 256
.byte 0x00
.endr
