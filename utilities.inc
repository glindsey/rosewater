; Utility macros
#pragma once
#include "ppu_constants.inc"

; Uses rTEMP to load an immediate into a low (r0-r15) register.
; Cycles: 2
;
.macro _LDI reg:req, val:req
      ldi rTEMP, \val
      mov \reg, rTEMP
.endm

; Uses rTEMP to compare a low (r0-r15) register with an immediate.
; Cycles: 2
;
.macro _CPI reg:req, val:req
      mov rTEMP, \reg
      cpi rTEMP, \val
.endm

; Inserts a variable number of NOP statements.
.macro _NOP val:req
.rept val
      nop
.endr
.endm
