#include "avr/io.h"

.altmacro

;d8888b. d88888b d88888b d888888b d8b   db d88888b .d8888.
;88  `8D 88'     88'       `88'   888o  88 88'     88'  YP
;88   88 88ooooo 88ooo      88    88V8o 88 88ooooo `8bo.
;88   88 88~~~~~ 88~~~      88    88 V8o88 88~~~~~   `Y8b.
;88  .8D 88.     88        .88.   88  V888 88.     db   8D
;Y8888D' Y88888P YP      Y888888P VP   V8P Y88888P `8888Y'

; Global macro definitions
; =========================================================
#define rZERO           r0

#define rYPOS           r1
#define rXPOS           r2

#define rTEMP           r16
#define rTEMP2          r17

#define rLINECOUNTER    r19
#define rSTATBITS       r20
#define rCTRLBITS       r21
#define rADDRDDR        r22
#define rDATADDR        r23
#define rCTL2DDR        r24
#define rCTL2BITS       r25

#define STATBIT_DISP                      7   ; Current line is a display line
#define STATBIT_HSYNC                     6   ; LOW indicates HSYNC active
#define STATBIT_VSYNC                     5   ; LOW indicates VSYNC active
#define STATBIT_EVENFRAME                 0   ; Current frame is an even frame
#define STATBIT_DISP_MASK           (0b10000000)
#define STATBIT_EVENFRAME_MASK      (0b00000001)
#define NOT_STATBIT_DISP_MASK       (0b01111111)
#define NOT_STATBIT_EVENFRAME_MASK  (0b11111110)


#define ADDRDDR   _SFR_IO_ADDR(DDRA)
#define ADDRPORT  _SFR_IO_ADDR(PORTA)
#define DATADDR   _SFR_IO_ADDR(DDRC)
#define DATAPORT  _SFR_IO_ADDR(PORTC)
#define CTRLDDR   _SFR_IO_ADDR(DDRD)
#define CTRLPORT  _SFR_IO_ADDR(PORTD)
#define CTL2DDR   _SFR_IO_ADDR(DDRB)
#define CTL2PORT  _SFR_IO_ADDR(PORTB)

; === Bitmasks for Address Port =================
#define ADDRBIT_PORT_INIT           (0b11111111) ; testing, normally (0b00000000)
#define ADDRBIT_DDR_INPUT           (0b00000000)
#define ADDRBIT_DDR_OUTPUT          (0b11111111)
#define ADDRBIT_DDR_INIT            ADDRBIT_DDR_OUTPUT

; === Bitmasks for Data/High Address Port =======
#define DATABIT_PORT_INIT           (0b11111111)
#define DATABIT_DDR_INPUT           (0b00000000)
#define DATABIT_DDR_OUTPUT          (0b11111111)
#define DATABIT_DDR_INIT            DATABIT_DDR_INPUT

; === Bitmasks for Control Port =================
#define CTRLBIT_PORT_INIT           (0b10011000)
#define CTRLBIT_DDR_INPUT           (0b00000000)
#define CTRLBIT_DDR_OUTPUT          (0b11111111)
#define CTRLBIT_DDR_INIT            CTRLBIT_DDR_OUTPUT

#define CTRLBIT_MASK                (0b11111111)
#define SYNCBIT_MASK                (0b10000000)
#define HALLATBIT_MASK              (0b01000000)
#define CPUENBIT_MASK               (0b00100000)
#define VBLANKBIT_MASK              (0b00010000)
#define VDRAWBIT_MASK               (0b00001000)
#define EXTRAADDR_MASK              (0b00000111)
#define NOT_SYNCBIT_MASK            (0b01111111)
#define NOT_HALLATBIT_MASK          (0b10111111)
#define NOT_CPUENBIT_MASK           (0b11011111)
#define NOT_VBLANKBIT_MASK          (0b11101111)
#define NOT_VDRAWBIT_MASK           (0b11110111)
#define NOT_EXTRAADDR_MASK          (0b11111000)

#define SYNCPIN    7
#define HALLATPIN  6
#define CPUENPIN   5
#define VBLANKPIN  4
#define VDRAWPIN   3
#define A18PIN     2
#define A17PIN     1
#define A16PIN     0

; === Bitmasks for Control Port 2 ===============
#define CTL2BIT_PORT_INIT           (0b11111111)
#define CTL2BIT_DDR_INPUT           (0b00000000)
#define CTL2BIT_DDR_OUTPUT          (0b00001110)
#define CTL2BIT_DDR_INIT            CTL2BIT_DDR_OUTPUT

#define CTL2BIT_MASK                (0b00001111)
#define ENABLEBIT_MASK              (0b00000110)
#define DEBUGBIT_MASK               (0b00001000)
#define OEBIT_MASK                  (0b00000100)
#define WEBIT_MASK                  (0b00000010)

#define NOT_ENABLEBIT_MASK          (0b11111001)
#define NOT_DEBUGBIT_MASK           (0b11110111)
#define NOT_OEBIT_MASK              (0b11111011)
#define NOT_WEBIT_MASK              (0b11111101)

#define DEBUGPIN                    3
#define OEPIN                       2
#define WEPIN                       1

; === Timing Values =============================
      ; At 20MHz:
      ; clkIO with OC=0x04F6 gives us 15.7356412 kHz
      ; At 21.47727MHz:
      ; clkIO with OC=0x0554 gives us 15.7342637 kHz
      ; (NTSC color line rate is 15.734 kHz).
      ; At 28.63636MHz:
      ; clkIO with OC=0x071B gives us 15.7342637 kHz
#define HSYNC_VALUE_HI        0x07
#define HSYNC_VALUE_LO        0x1B

;.88b  d88.  .d8b.   .o88b. d8888b.  .d88b.  .d8888.
;88'YbdP`88 d8' `8b d8P  Y8 88  `8D .8P  Y8. 88'  YP
;88  88  88 88ooo88 8P      88oobY' 88    88 `8bo.
;88  88  88 88~~~88 8b      88`8b   88    88   `Y8b.
;88  88  88 88   88 Y8b  d8 88 `88. `8b  d8' db   8D
;YP  YP  YP YP   YP  `Y88P' 88   YD  `Y88P'  `8888Y'

.macro VBLANK_ON ; 1 cycle
      andi rCTRLBITS, NOT_VBLANKBIT_MASK
.endm

.macro VBLANK_OFF ; 1 cycle
      ori rCTRLBITS, VBLANKBIT_MASK
.endm

.macro VDRAW_ON ; 1 cycle
      andi rCTRLBITS, NOT_VDRAWBIT_MASK
.endm

.macro VDRAW_OFF ; 1 cycle
      ori rCTRLBITS, VDRAWBIT_MASK
.endm

.macro OE_ON  ; 1 cycle
      andi rCTL2BITS, NOT_OEBIT_MASK
.endm

.macro OE_OFF  ; 1 cycle
      ori rCTL2BITS, OEBIT_MASK
.endm

.macro DEBUG_ON  ; 1 cycle
      andi rCTL2BITS, NOT_DEBUGBIT_MASK
.endm

.macro DEBUG_OFF  ; 1 cycle
      ori rCTL2BITS, DEBUGBIT_MASK
.endm

.macro WE_ON  ; 1 cycle
      andi rCTL2BITS, NOT_WEBIT_MASK
.endm

.macro WE_OFF  ; 1 cycle
      ori rCTL2BITS, WEBIT_MASK
.endm

.macro OE_AND_WE_OFF  ; 1 cycle
      ori rCTL2BITS, ENABLEBIT_MASK
.endm

.macro TOGGLE_SYNC_BIT  ; 2 cycles
      ldi rTEMP, SYNCBIT_MASK ; [1]
      eor rCTRLBITS, rTEMP    ; [1]
.endm

.macro IMMED_TOGGLE_SYNC_PIN ; 5 cycles
      LOCAL is_set
      LOCAL done
      mov rTEMP, rCTRLBITS          ; [1]
      andi rTEMP, SYNCBIT_MASK      ; [1]
      brne is_set                   ; [1] if clear, [2] if set
      sbi CTRLPORT, SYNCPIN         ; [1] if clear
      rjmp done                     ; [1] if clear
is_set:
      cbi CTRLPORT, SYNCPIN         ; [1] if set
done:
.endm

;.d8888. db    db d8888b. d8888b.  .d88b.  db    db d888888b d888888b d8b   db d88888b .d8888.
;88'  YP 88    88 88  `8D 88  `8D .8P  Y8. 88    88 `~~88~~'   `88'   888o  88 88'     88'  YP
;`8bo.   88    88 88oooY' 88oobY' 88    88 88    88    88       88    88V8o 88 88ooooo `8bo.
;  `Y8b. 88    88 88~~~b. 88`8b   88    88 88    88    88       88    88 V8o88 88~~~~~   `Y8b.
;db   8D 88b  d88 88   8D 88 `88. `8b  d8' 88b  d88    88      .88.   88  V888 88.     db   8D
;`8888Y' ~Y8888P' Y8888P' 88   YD  `Y88P'  ~Y8888P'    YP    Y888888P VP   V8P Y88888P `8888Y'

boot_wait:
      ; A simple wait for RAM to stabilize before attempting writes.
      ldi rTEMP, 1
boot_wait_outer_loop:
      ldi rTEMP2, 8
boot_wait_inner_loop:
      dec rTEMP2
      brne boot_wait_inner_loop
      dec rTEMP
      brne boot_wait_outer_loop
      ret

debug_wiggle:
      ; Wiggle the debug pin a bit so I can see it on the scope.
      ldi rTEMP, 32
debug_loop:
      DEBUG_ON
      out CTL2PORT, rCTL2BITS
      nop
      nop
      nop
      DEBUG_OFF
      out CTL2PORT, rCTL2BITS
      nop
      nop
      nop
      dec rTEMP
      brne debug_loop
      ret

setup_palette:
      rcall debug_wiggle
      ; Turn on debug pin so I can figure out what's going on.
      DEBUG_ON
      out CTL2PORT, rCTL2BITS

      ; Right now palette RAM high address is forced to 00.

      ; Set data lines to outputs.
      ldi rTEMP, DATABIT_DDR_OUTPUT
      out DATADDR, rTEMP

      ; Turn VDRAW off (by setting it high).
      ; It probably already is, but let's do it anyway.
      sbi CTRLPORT, VDRAWPIN

      ; Set A18/A17/A16 to 110 to indicate PALRAM LOW enable.
      sbi CTRLPORT, A18PIN
      sbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN

      ; Loop through low addresses and set data = address for now.
      ldi rTEMP, 0
      ;ldi rTEMP2, 255

palette_set_loop_low:
      dec rTEMP
      out ADDRPORT, rTEMP
      mov rTEMP2, rTEMP
      out DATAPORT, rTEMP2
      WE_ON
      out CTL2PORT, rCTL2BITS
      nop
      nop
      nop
      nop
      WE_OFF
      out CTL2PORT, rCTL2BITS
      cpi rTEMP, 0
      brne palette_set_loop_low

      ; Set A18/A17/A16 to 111 to indicate PALRAM HIGH enable.
      sbi CTRLPORT, A18PIN
      sbi CTRLPORT, A17PIN
      sbi CTRLPORT, A16PIN

      ; Loop through low addresses and set data = address for now.
      ldi rTEMP, 0
      ;ldi rTEMP2, 255

palette_set_loop_high:
      dec rTEMP
      out ADDRPORT, rTEMP
      mov rTEMP2, rTEMP
      out DATAPORT, rTEMP2
      WE_ON
      out CTL2PORT, rCTL2BITS
      nop
      nop
      nop
      nop
      WE_OFF
      out CTL2PORT, rCTL2BITS
      cpi rTEMP, 0
      brne palette_set_loop_high

      ; Reset data lines back to inputs with pullups enabled.
      ldi rTEMP, DATABIT_DDR_INPUT
      out DATADDR, rTEMP
      ldi rTEMP, DATABIT_PORT_INIT
      out DATAPORT, rTEMP

      ; Reset A18/A17/A16 back to VDU addressing.
      cbi CTRLPORT, A18PIN
      cbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN

      ; Turn off debug pin.
      DEBUG_OFF
      out CTL2PORT, rCTL2BITS

      ret

setup_fbram:
      ; Set data lines to outputs.
      ldi rTEMP, DATABIT_DDR_OUTPUT
      out DATADDR, rTEMP

      ; Set A18/A17 to 10 to indicate FBRAM enable.
      sbi CTRLPORT, A18PIN
      cbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN

      ; Loop through low addresses and set data = address for now.
      ldi rTEMP, 0
      ldi rTEMP2, 255

fbram_set_loop:
      dec rTEMP
      out ADDRPORT, rTEMP
      mov rTEMP2, rTEMP
      lsr rTEMP2
      lsr rTEMP2
      lsr rTEMP2
      out DATAPORT, rTEMP2
      WE_ON
      out CTL2PORT, rCTL2BITS
.rept 1
      nop
      nop
      nop
      nop
.endr
      WE_OFF
      out CTL2PORT, rCTL2BITS
      cpi rTEMP, 0
      brne fbram_set_loop

      ; Reset data lines back to inputs with pullups enabled.
      ldi rTEMP, DATABIT_DDR_INPUT
      out DATADDR, rTEMP
      ldi rTEMP, DATABIT_PORT_INIT
      out DATAPORT, rTEMP

      ; Reset A18/A17/A16 back to VDU addressing.
      cbi CTRLPORT, A18PIN
      cbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN

      ret



.global main
main:

;.d8888. d88888b d888888b db    db d8888b.
;88'  YP 88'     `~~88~~' 88    88 88  `8D
;`8bo.   88ooooo    88    88    88 88oodD'
;  `Y8b. 88~~~~~    88    88    88 88~~~
;db   8D 88.        88    88b  d88 88
;`8888Y' Y88888P    YP    ~Y8888P' 88

      ; Disable interrupts.
      cli

      ; === I/O Ports ========================================================

      ; Set up address port pins.
      ldi rADDRDDR, ADDRBIT_DDR_INIT
      out ADDRDDR, rADDRDDR
      ldi rTEMP, ADDRBIT_PORT_INIT
      out ADDRPORT, rTEMP

      ; Set up data port pins.
      ldi rDATADDR, DATABIT_DDR_INIT
      out DATADDR, rDATADDR
      ldi rTEMP, DATABIT_PORT_INIT
      out DATAPORT, rTEMP

      ; Set up control port 1 pins.
      ldi rTEMP, CTRLBIT_DDR_INIT
      out CTRLDDR, rTEMP
      ldi rTEMP, CTRLBIT_PORT_INIT
      out CTRLPORT, rTEMP

      ; Set up control port 2 pins.
      ldi rCTL2DDR, CTL2BIT_DDR_INIT
      out CTL2DDR, rCTL2DDR
      ldi rCTL2BITS, CTL2BIT_PORT_INIT
      out CTL2PORT, rCTL2BITS

      ; === Timers ===========================================================

      ; Set Timer 0 to toggle OC0A and clear on compare match.
      ;ldi rTEMP, (1 << COM0A0) | (1 << WGM01)
      ;sts _SFR_MEM_ADDR(TCCR0A), rTEMP

      ; Set OC1A to toggle on each output compare.
      ;ldi rTEMP, (1 << COM1A0)
      ;sts _SFR_MEM_ADDR(TCCR1A), rTEMP

      ; Set Timer 0 clock source to clkIO.
      ;ldi rTEMP, (1 << CS00)
      ;sts _SFR_MEM_ADDR(TCCR0B), rTEMP

      ; Set Timer 1 to clkIO and to clear on timer match.
      ldi rTEMP, (1 << WGM02) | (1 << CS10)
      sts _SFR_MEM_ADDR(TCCR1B), rTEMP

      ; Set output compare value for OC0A
      ; 0x00 outputs a clock at half the AVR's frequency
      ;ldi rTEMP, 0x00
      ;sts _SFR_MEM_ADDR(OCR0A), rTEMP

      ; Set output compare value for OC1A

      ; At 20MHz:
      ; clkIO with OC=0x04F6 gives us 15.7356412 kHz
      ; At 21.47727MHz:
      ; clkIO with OC=0x0554 gives us 15.7342637 kHz
      ; (NTSC color line rate is 15.734 kHz).
      ; At 28.63636MHz:
      ; clkIO with OC=0x071B gives us 15.7342637 kHz
      ldi rTEMP, HSYNC_VALUE_HI
      sts _SFR_MEM_ADDR(OCR1AH), rTEMP
      ldi rTEMP, HSYNC_VALUE_LO
      sts _SFR_MEM_ADDR(OCR1AL), rTEMP

      ; Set interrupt on OC1A compare
      ldi rTEMP, (1 << OCIE1A)
      sts _SFR_MEM_ADDR(TIMSK1), rTEMP

      ; === RAM configuration ================================================

      rcall boot_wait
      rcall setup_palette
      rcall setup_fbram

      ; === Registers ========================================================
      ; Set up registers for line tracking.
      eor rLINECOUNTER, rLINECOUNTER
      eor rSTATBITS, rSTATBITS

      ; Set up control bits register.
      ldi rCTRLBITS, CTRLBIT_PORT_INIT

      ; EOR control bits register with SYNC bit, as the first thing the
      ; interrupt line should do is pull SYNC low.
      ldi rTEMP, SYNCBIT_MASK
      eor rCTRLBITS, rTEMP

      ; Enable interrupts.
      sei

loop:
      rjmp loop

;db   db .d8888. db    db d8b   db  .o88b.   d888888b .d8888. d8888b.
;88   88 88'  YP `8b  d8' 888o  88 d8P  Y8     `88'   88'  YP 88  `8D
;88ooo88 `8bo.    `8bd8'  88V8o 88 8P           88    `8bo.   88oobY'
;88~~~88   `Y8b.    88    88 V8o88 8b           88      `Y8b. 88`8b
;88   88 db   8D    88    88  V888 Y8b  d8     .88.   db   8D 88 `88.
;YP   YP `8888Y'    YP    VP   V8P  `Y88P'   Y888888P `8888Y' 88   YD

.global TIMER1_COMPA_vect
TIMER1_COMPA_vect:
      out CTRLPORT, rCTRLBITS                   ; [1] -- start of HSYNC
      out ADDRDDR, rADDRDDR                     ; [1]
      out DATADDR, rDATADDR                     ; [1]
      out CTL2DDR, rCTL2DDR                     ; [1]
      out CTL2PORT, rCTL2BITS                   ; [1]

      ; +5 cycles into HSYNC here
      sbrs rSTATBITS, STATBIT_DISP              ; [3] for this and below line
        rjmp non_display_line                   ;

display_line:
      ; +8 cycles into HSYNC here
      mov rYPOS, rLINECOUNTER                   ; [1]
      mov rTEMP2, rCTRLBITS                     ; [1]

      ; Increment rLINECOUNTER by one.
      inc rLINECOUNTER                          ; [1]

      cpi rLINECOUNTER, 240                     ; [1]
      brne skip_setup_blanking_period          ; [1] if ==, [2] if !=

;d888888b d8b   db d888888b d888888b   d8888b. db       .d8b.  d8b   db db   dD
;  `88'   888o  88   `88'   `~~88~~'   88  `8D 88      d8' `8b 888o  88 88 ,8P'
;   88    88V8o 88    88       88      88oooY' 88      88ooo88 88V8o 88 88,8P
;   88    88 V8o88    88       88      88~~~b. 88      88~~~88 88 V8o88 88`8b
;  .88.   88  V888   .88.      88      88   8D 88booo. 88   88 88  V888 88 `88.
;Y888888P VP   V8P Y888888P    YP      Y8888P' Y88888P YP   YP VP   V8P YP   YD

setup_blanking_period:
      ; If result is 240:
      ;   - reset rLINECOUNTER to 0
      eor rLINECOUNTER, rLINECOUNTER            ; [1] if ==
      ;   - clear rSTATBITS:DISP
      andi rSTATBITS, NOT_STATBIT_DISP_MASK     ; [1] if ==
      ;   - toggle rSTATBITS:EVENFRAME
      ldi rTEMP, STATBIT_EVENFRAME_MASK         ; [1] if ==
      eor rSTATBITS, rTEMP                      ; [1] if ==
      ;   - turn on ~VBLANK control line
      VBLANK_ON                                 ; [1] if ==
      ;   - turn off ~VDRAW control line
      VDRAW_OFF                                 ; [1] if ==
      ;   - turn off OE/WE lines
      OE_AND_WE_OFF                             ; [1] if ==
      rjmp after_setup_blanking_period          ; [2] if ==

skip_setup_blanking_period:
.rept 8
      nop                                       ; [8] if != (timing match)
.endr
after_setup_blanking_period:

      ; +22 cycles into HSYNC HERE

      ; Finish the H-sync pulse here.
      ; This can be filled in with whatever calculations we care to do.
.rept 112
      nop                                       ; 22+[112]+3 cycles --> 4.8uS H-sync
.endr
      IMMED_TOGGLE_SYNC_PIN                     ; [5]
      ;TOGGLE_SYNC_BIT                           ; [2]
      ;out CTRLPORT, rCTRLBITS                   ; [1]
      ;TOGGLE_SYNC_BIT
      ; +0 cycles after HSYNC here

.rept 137
      nop                                       ; 0+[137] cycles --> 4.8uS front porch
.endr

      ; continue rendering here if a display line

; Test of video output
; ------------------------------------------------------

; check if this is a draw frame
      sbrc rTEMP2, VDRAWPIN
      jmp compose_frame

; .d88b.  db    db d888888b d8888b. db    db d888888b
;.8P  Y8. 88    88 `~~88~~' 88  `8D 88    88 `~~88~~'
;88    88 88    88    88    88oodD' 88    88    88
;88    88 88    88    88    88~~~   88    88    88
;`8b  d8' 88b  d88    88    88      88b  d88    88
; `Y88P'  ~Y8888P'    YP    88      ~Y8888P'    YP

output_frame:

; Wait a little while
.rept 92
      nop
.endr

      eor rXPOS, rXPOS
      out DATAPORT, rYPOS
      out ADDRPORT, rXPOS
      sbi CTRLPORT, A18PIN
      cbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN
      nop
      nop
      nop
      nop
      OE_ON
      out CTL2PORT, rCTL2BITS

pixel_loop:
.rept 256
      out ADDRPORT, rXPOS
      inc rXPOS
      nop
      nop
      nop
.endr
      ;brne pixel_loop

      OE_OFF
      cbi CTRLPORT, A18PIN
      cbi CTRLPORT, A17PIN
      cbi CTRLPORT, A16PIN
      out CTL2PORT, rCTL2BITS

; ------------------------------------------------------
      rjmp end_line                             ; [2]

;d8888b. d88888b d8b   db d8888b. d88888b d8888b. d888888b d8b   db  d888b
;88  `8D 88'     888o  88 88  `8D 88'     88  `8D   `88'   888o  88 88' Y8b
;88oobY' 88ooooo 88V8o 88 88   88 88ooooo 88oobY'    88    88V8o 88 88
;88`8b   88~~~~~ 88 V8o88 88   88 88~~~~~ 88`8b      88    88 V8o88 88  ooo
;88 `88. 88.     88  V888 88  .8D 88.     88 `88.   .88.   88  V888 88. ~8~
;88   YD Y88888P VP   V8P Y8888D' Y88888P 88   YD Y888888P VP   V8P  Y888P

compose_frame:
      rjmp end_line                             ; [2]

;d8888b. db       .d8b.  d8b   db db   dD d888888b d8b   db  d888b
;88  `8D 88      d8' `8b 888o  88 88 ,8P'   `88'   888o  88 88' Y8b
;88oooY' 88      88ooo88 88V8o 88 88,8P      88    88V8o 88 88
;88~~~b. 88      88~~~88 88 V8o88 88`8b      88    88 V8o88 88  ooo
;88   8D 88booo. 88   88 88  V888 88 `88.   .88.   88  V888 88. ~8~
;Y8888P' Y88888P YP   YP VP   V8P YP   YD Y888888P VP   V8P  Y888P

non_display_line:
      ; +8 cycles into HSYNC here

      ; Of the 22 non-display lines:
      ; 00-01: Bottom border lines
      ; 02-04: Pre-render blanking lines
      ; 05-07: VSYNC lines
      ; 08-21: Post-render blanking lines

      ; Load the jump address into Z but don't jump just yet
      ldi ZL, lo8(non_display_line_table)       ; [1]
      ldi ZH, hi8(non_display_line_table)       ; [1]
      add ZL, rLINECOUNTER                      ; [1]
      adc ZH, rZERO                             ; [1]
      ; TEMPORARY

      ; If this is line 04, toggle SYNC for the next line.
      cpi rLINECOUNTER, 4                       ; [1]
      brne skip_set_vsync                       ; [1] if ==, [2] if !=
set_vsync:
      TOGGLE_SYNC_BIT                           ; [3] if ==
      rjmp after_set_vsync                      ; [2] if ==
skip_set_vsync:
      nop                                       ; [3] to even out timing
      nop
      nop
after_set_vsync:

      ; If this is line 07, toggle SYNC for the next line.
      cpi rLINECOUNTER, 7                       ; [1]
      brne skip_clear_vsync                     ; [1] if ==, [2] if !=
clear_vsync:
      TOGGLE_SYNC_BIT                           ; [3] if ==
      rjmp after_clear_vsync                    ; [2] if ==
skip_clear_vsync:
      nop                                       ; [3] to even out timing
      nop
      nop
after_clear_vsync:

      ; Increment rLINECOUNTER by one.
      inc rLINECOUNTER                          ; [1]

      ; +27 cycles into HSYNC here

      ; If result is 22:
      ;   - reset to 0
      ;   - set rSTATBITS:DISP for next line
      ;   - set ~VBLANK control line
      ;   - set DATA lines to input (we ONLY do output when writing)
      ;   - set ADDR/CTL2 lines to outputs
      ;   - clear ~OE, ~WE bits
      ;   - clear ~VDRAW control line if rSTATBITS:EVENFRAME is clear
      cpi rLINECOUNTER, 22                      ; [1]
      brne skip_start_display_lines             ; [1] if ==, [2] if !=

;d888888b d8b   db d888888b d888888b   d8888b. d888888b .d8888. d8888b.
;  `88'   888o  88   `88'   `~~88~~'   88  `8D   `88'   88'  YP 88  `8D
;   88    88V8o 88    88       88      88   88    88    `8bo.   88oodD'
;   88    88 V8o88    88       88      88   88    88      `Y8b. 88~~~
;  .88.   88  V888   .88.      88      88  .8D   .88.   db   8D 88
;Y888888P VP   V8P Y888888P    YP      Y8888D' Y888888P `8888Y' 88

start_display_lines:
      eor rLINECOUNTER, rLINECOUNTER            ; [1] if ==
      ori rSTATBITS, STATBIT_DISP_MASK          ; [1] if ==
      ori rCTRLBITS, VBLANKBIT_MASK             ; [1] if ==
      ldi rADDRDDR, ADDRBIT_DDR_OUTPUT          ; [1] if ==
      ldi rDATADDR, DATABIT_DDR_INPUT           ; [1] if ==
      ldi rCTL2DDR, CTL2BIT_DDR_OUTPUT          ; [1] if ==
      OE_AND_WE_OFF                             ; [1] if ==
      sbrs rSTATBITS, STATBIT_EVENFRAME         ; [2] for this and below
      andi rCTRLBITS, NOT_VDRAWBIT_MASK
      rjmp after_start_display_lines            ; [2] if ==
skip_start_display_lines:
.rept 8
      nop                                       ; [8] if != (timing match)
.endr
after_start_display_lines:

      ; +35 cycles into HSYNC here

      ; Finish the H-sync pulse here.
      ; This can be filled in with whatever calculations we care to do.
.rept 109
      nop                                 ; 34+[109]+3 cycles --> 4.8uS H-sync
.endr
      IMMED_TOGGLE_SYNC_PIN                     ; [5]
      ;TOGGLE_SYNC_BIT                           ; [2]
      ;out CTRLPORT, rCTRLBITS                   ; [1]
      ;TOGGLE_SYNC_BIT                           ; [2]

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

      ; +4 cycles after HSYNC here (for whichever branch is taken)
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
