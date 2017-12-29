; Utility macros
#ifndef UTILITY_INC
#define UTILITY_INC

; Universal Constant Definitions
.DEF rCTEMP		= r0
.DEF rZERO		= r1

.DEF rTEMP3		= r23
.DEF rTEMP		= r24
.DEF rTEMP2		= r25

; Uses rTEMP to load an immediate into a low (r0-r15) register.
; @0 = register to load into
; @1 = value to load
; Cycles: 2
;
.MACRO _LDI
      ldi rTEMP, @1
      mov @0, rTEMP
.ENDM

; Uses rTEMP to compare a low (r0-r15) register with an immediate.
; @0 = register to compare
; @1 = value to compare against
; Cycles: 2
;
.MACRO _CPI
      mov rTEMP, @0
      cpi rTEMP, @1
.ENDM

; Various NOP slides.
.MACRO _NOP2
	nop
	nop
.ENDM

.MACRO _NOP4
	_NOP2
	_NOP2
.ENDM

.MACRO _NOP8
	_NOP4
	_NOP4
.ENDM

.MACRO _NOP16
	_NOP8
	_NOP8
.ENDM

.MACRO _NOP32
	_NOP16
	_NOP16
.ENDM

.MACRO _NOP64
	_NOP32
	_NOP32
.ENDM

.MACRO _NOP128
	_NOP64
	_NOP64
.ENDM

.MACRO _NOP256
	_NOP128
	_NOP128
.ENDM

; Jump using an offset in a jump table.
; @0 = address of jump table
; @1 = offset of jump address
.MACRO JUMP_TO
	ldi ZL, LOW(@0)
	ldi ZH, HIGH(@0)
	add ZL, @1
	adc ZH, rZERO
	ijmp
.ENDM

#endif
