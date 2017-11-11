#include "avr/io.h"

; Global macro definitions
; =========================================================
#define rZERO     r0
#define rTEMP     r31

#define VSYNCDDR  _SFR_IO_ADDR(DDRD)
#define VSYNCPORT _SFR_IO_ADDR(PORTD)
#define VSYNCPIN  0
#define HSYNCDDR  _SFR_IO_ADDR(DDRD)
#define HSYNCPORT _SFR_IO_ADDR(PORTD)
#define HSYNCPIN  1

.global main
main:
      ; Disable interrupts.
      cli

      ; Set OC1A to toggle on each output compare.
      ldi r31, (1 << COM1A0)
      sts _SFR_MEM_ADDR(TCCR1A), r31

      ; Set Timer 1 to clkIO and to clear on timer match.
      ldi r31, (1 << WGM02) | (1 << CS10)
      sts _SFR_MEM_ADDR(TCCR1B), r31

      ; Set PD5 (OC1A pin), PD1 to output.
      sbi _SFR_IO_ADDR(DDRD), 5
      sbi HSYNCDDR, HSYNCPIN

      ; Set output compare value for OC1A
      ; At 21.47727MHz:
      ; clkIO/8 with an OC value of 0xAEF4 gets as close to 29.97002997 Hz as
      ; possible (actual rate is 29.970068 Hz).

      ; clkIO with OC=0x0554 gives us 15.7342637 kHz
      ; (NTSC color line rate is 15.734 kHz).
      ldi r31, 0x05
      sts _SFR_MEM_ADDR(OCR1AH), r31
      ldi r31, 0x54
      sts _SFR_MEM_ADDR(OCR1AL), r31

      ; Set interrupt on OC1A compare
      ldi r31, (1 << OCIE1A)
      sts _SFR_MEM_ADDR(TIMSK1), r31

      ; Enable interrupts.
      sei

loop:
      rjmp loop

.global TIMER1_COMPA_vect
TIMER1_COMPA_vect:
      sbi HSYNCPORT, HSYNCPIN       ; 2 cycles
.rept 99
      nop                           ; 99 cycles --> 4.7uS H-sync
.endr
      cbi HSYNCPORT, HSYNCPIN       ; 2 cycles
      reti

.global __vector_default
__vector_default:
      reti
