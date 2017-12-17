; Utility macros
#pragma once

; Universal Constant Definitions
#define rCTEMP          r0
#define rZERO           r1

#define rTEMP           r16
#define rTEMP2          r17
#define rTEMP3          r18

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

.macro JUMP_TO table, offset
ldi ZL, lo8(\table)
ldi ZH, hi8(\table)
add ZL, \offset
adc ZH, rZERO
ijmp
.endm
