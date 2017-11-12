#include "avr/io.h"

; Global macro definitions
; =========================================================
#define rZERO     r0
#define rTEMP     r16

#define rDISPLINE       r17
#define rNONDISPLINE    r18
#define rSTATBITS       r19
#define rCTRLBITS       r20

#define STATBIT_DISP                      7   ; Current line is a display line
#define STATBIT_EVENFRAME                 0   ; Current frame is an even frame
#define STATBIT_DISP_MASK           (0b10000000)
#define STATBIT_EVENFRAME_MASK      (0b00000001)
#define NOT_STATBIT_DISP_MASK       (0b01111111)
#define NOT_STATBIT_EVENFRAME_MASK  (0b11111110)

#define CTRLDDR   _SFR_IO_ADDR(DDRD)
#define CTRLPORT  _SFR_IO_ADDR(PORTD)

#define CTRLBIT_MASK                (0b00000111)
#define SYNCBIT_MASK                (0b00000011)
#define VSYNCBIT_MASK               (0b00000001)
#define HSYNCBIT_MASK               (0b00000010)
#define VIDEOBIT_MASK               (0b00000100)
#define NOT_VSYNCBIT_MASK           (0b11111110)
#define NOT_HSYNCBIT_MASK           (0b11111101)
#define NOT_VIDEOBIT_MASK           (0b11111011)
#define HSYNCPIN  1
#define VIDEOPIN  2

.macro VIDEO_ON  ; 2 cycles
      cbi CTRLPORT, VIDEOPIN
.endm

.macro VIDEO_OFF  ; 2 cycles
      sbi CTRLPORT, VIDEOPIN
.endm

.macro HSYNC_OFF  ; 2 cycles
      cbi CTRLPORT, HSYNCPIN
.endm

.global main
main:
      ; Disable interrupts.
      cli

      ; Set Timer 0 to toggle OC0A and clear on compare match.
      ldi rTEMP, (1 << COM0A0) | (1 << WGM01)
      sts _SFR_MEM_ADDR(TCCR0A), rTEMP

      ; Set OC1A to toggle on each output compare.
      ;ldi rTEMP, (1 << COM1A0)
      ;sts _SFR_MEM_ADDR(TCCR1A), rTEMP

      ; Set Timer 0 clock source to clkIO.
      ldi rTEMP, (1 << CS00)
      sts _SFR_MEM_ADDR(TCCR0B), rTEMP

      ; Set Timer 1 to clkIO and to clear on timer match.
      ldi rTEMP, (1 << WGM02) | (1 << CS10)
      sts _SFR_MEM_ADDR(TCCR1B), rTEMP

      ; Set OC0A pin to output.
      sbi _SFR_IO_ADDR(DDRB), 3

      ; Set control pins to output.
      ldi rTEMP, 0xff ; CTRLBIT_MASK
      out CTRLDDR, rTEMP

      ; Set output compare value for OC0A
      ldi rTEMP, 0x00
      sts _SFR_MEM_ADDR(OCR0A), rTEMP

      ; Set output compare value for OC1A

      ; At 20MHz:
      ; clkIO with OC=0x04F6 gives us 15.7356412 kHz
      ; At 21.47727MHz:
      ; clkIO with OC=0x0554 gives us 15.7342637 kHz
      ; (NTSC color line rate is 15.734 kHz).
      ; At 28.63636MHz:
      ; clkIO with OC=0x071B gives us 15.7342637 kHz
      ldi rTEMP, 0x07
      sts _SFR_MEM_ADDR(OCR1AH), rTEMP
      ldi rTEMP, 0x1B
      sts _SFR_MEM_ADDR(OCR1AL), rTEMP

      ; Set interrupt on OC1A compare
      ldi rTEMP, (1 << OCIE1A)
      sts _SFR_MEM_ADDR(TIMSK1), rTEMP

      ; Set up counters for line tracking.
      eor rDISPLINE, rDISPLINE
      eor rNONDISPLINE, rNONDISPLINE
      eor rSTATBITS, rSTATBITS

      ; Set up control bits register.
      ldi rCTRLBITS, (HSYNCBIT_MASK | VIDEOBIT_MASK)

      ; Enable interrupts.
      sei

loop:
      rjmp loop

.global TIMER1_COMPA_vect
TIMER1_COMPA_vect:
      out CTRLPORT, rCTRLBITS                   ; [1] -- start of HSYNC

      ; +1 cycles into HSYNC here
      sbrs rSTATBITS, STATBIT_DISP              ; [3] for this and below line
        rjmp non_display_line                   ;

display_line:
      ; +4 cycles into HSYNC here

      ; Increment rDISPLINE by one.
      inc rDISPLINE                             ; [1]

      ; If result is 240, reset to 0, clear rSTATBITS:DISP, and toggle
      ; rSTATBITS:EVENFRAME for next line.
      cpi rDISPLINE, 240                        ; [1]
      brne skip_start_nondisplay_lines          ; [1] if ==, [2] if !=
      eor rDISPLINE, rDISPLINE                  ; [1] if ==
      andi rSTATBITS, NOT_STATBIT_DISP_MASK     ; [1] if ==
      ldi rTEMP, STATBIT_EVENFRAME_MASK         ; [1] if ==
      eor rSTATBITS, rTEMP                      ; [1] if ==
      rjmp after_start_nondisplay_lines         ; [2] if ==
skip_start_nondisplay_lines:
      nop                                       ; [1] if != (timing match)
      nop                                       ; [1] if != (timing match)
      nop                                       ; [1] if != (timing match)
      nop                                       ; [1] if != (timing match)
      nop                                       ; [1] if != (timing match)
after_start_nondisplay_lines:

      ; +13 cycles into HSYNC HERE

      ; Finish the H-sync pulse here.
      ; This can be filled in with whatever calculations we care to do.
.rept 123
      nop                                       ; 13+[123]+1 cycles --> 4.8uS H-sync
.endr
      HSYNC_OFF                                 ; [2] -- HSYNC ends in the middle

      ; continue rendering here if a display line
      ; +1 cycles after HSYNC here

.rept 135
      nop                                       ; 1+[135]+1 cycles --> 4.8uS front porch
.endr


; Test of video output
; ------------------------------------------------------
.rept 100
      nop
.endr

      mov rTEMP, rDISPLINE
delay_loop_for_testing:
      dec rTEMP
      brne delay_loop_for_testing

      sbrs rSTATBITS, STATBIT_EVENFRAME         ; [3] for this and below line
      VIDEO_ON                                  ; [2] -- video starts in the middle

.rept 200
      nop
.endr
      VIDEO_OFF
; ------------------------------------------------------

      rjmp end_line                             ; [2]

non_display_line:
      ; +4 cycles into HSYNC here

      ; Of the 22 non-display lines:
      ; 00-01: Bottom border lines
      ; 02-04: Pre-render blanking lines
      ; 05-07: VSYNC lines
      ; 08-21: Post-render blanking lines

      ; Load the jump address into Z but don't jump just yet
      ldi ZL, lo8(non_display_line_table)       ; [1]
      ldi ZH, hi8(non_display_line_table)       ; [1]
      add ZL, rNONDISPLINE                      ; [1]
      adc ZH, rZERO                             ; [1]
      ; TEMPORARY

      ; If this is line 04, set VSYNC for the next line.
      cpi rNONDISPLINE, 4                       ; [1]
      brne skip_set_vsync                       ; [1] if ==, [2] if !=
      ori rCTRLBITS, VSYNCBIT_MASK              ; [1] if ==
skip_set_vsync:

      ; If this is line 07, clear VSYNC for the next line.
      cpi rNONDISPLINE, 7                       ; [1]
      brne skip_clear_vsync                     ; [1] if ==, [2] if !=
      andi rCTRLBITS, NOT_VSYNCBIT_MASK         ; [1] if ==
skip_clear_vsync:

      ; Increment rNONDISPLINE by one.
      inc rNONDISPLINE                          ; [1]

      ; If result is 22, reset to 0 and set rSTATBITS:DISP for next line.
      cpi rNONDISPLINE, 22                      ; [1]
      brne skip_start_display_lines             ; [1] if ==, [2] if !=
      eor rNONDISPLINE, rNONDISPLINE            ; [1] if ==
      ori rSTATBITS, STATBIT_DISP_MASK          ; [1] if ==
      rjmp after_start_display_lines            ; [2] if ==
skip_start_display_lines:
      nop                                       ; [1] if != (timing match)
      nop                                       ; [1] if != (timing match)
      nop                                       ; [1] if != (timing match)
after_start_display_lines:

      ; +17 cycles into HSYNC here

      ; Finish the H-sync pulse here.
      ; This can be filled in with whatever calculations we care to do.
.rept 129
      nop                                 ; 17+[129]+1 cycles --> 4.8uS H-sync
.endr
      HSYNC_OFF                           ; [2] -- HSYNC ends in the middle

      ; continue here if not a display line
      rjmp end_line ; -- TEMPORARY
      nop

      ; Jump based on exactly which line this is
      ijmp                                      ; [2]

non_display_line_table:                         ; [2] for one of below jumps
      rjmp bottom_border_line             ; 0
      rjmp bottom_border_line             ; 1
      rjmp pre_render_blanking_line       ; 2
      rjmp pre_render_blanking_line       ; 3
      rjmp pre_render_blanking_line       ; 4
      rjmp vsync_line                     ; 5
      rjmp vsync_line                     ; 6
      rjmp vsync_line                     ; 7
      rjmp post_render_blanking_line      ; 8
      rjmp post_render_blanking_line      ; 9
      rjmp post_render_blanking_line      ; 10
      rjmp post_render_blanking_line      ; 11
      rjmp post_render_blanking_line      ; 12
      rjmp post_render_blanking_line      ; 13
      rjmp post_render_blanking_line      ; 14
      rjmp post_render_blanking_line      ; 15
      rjmp post_render_blanking_line      ; 16
      rjmp post_render_blanking_line      ; 17
      rjmp post_render_blanking_line      ; 18
      rjmp post_render_blanking_line      ; 19
      rjmp post_render_blanking_line      ; 20
      rjmp post_render_blanking_line      ; 21

      ; +5 cycles after HSYNC here (for whichever branch is taken)
bottom_border_line:
pre_render_blanking_line:
vsync_line:
post_render_blanking_line:

      rjmp end_line                       ; [2]

end_line:
      reti

.global __vector_default
__vector_default:
      reti
