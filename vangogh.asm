; Notes
; Large Figlet font is "basic"
; Small Figlet font is "banner"

.DEVICE ATmega1284P
.ORG 0x0000
	jmp RESET_vect				; 0
	jmp INT0_vect				; 1
	jmp INT1_vect				; 2
	jmp INT2_vect				; 3
	jmp PCINT0_vect				; 4
	jmp PCINT1_vect				; 5
	jmp PCINT2_vect				; 6
	jmp PCINT3_vect				; 7
	jmp WDT_vect				; 8
	jmp TIMER2_COMPA_vect		; 9
	jmp TIMER2_COMPB_vect		; 10
	jmp TIMER2_OVF_vect			; 11
	jmp TIMER1_CAPT_vect        ; 12
	jmp TIMER1_COMPA_vect		; 13
	jmp TIMER1_COMPB_vect		; 14
	jmp TIMER1_OVF_vect			; 15
	jmp TIMER0_COMPA_vect		; 16
	jmp TIMER0_COMPB_vect		; 17
	jmp TIMER0_OVF_vect			; 18
	jmp SPI_STC_vect			; 19
	jmp USART0_RX_vect			; 20
	jmp USART0_UDRE_vect		; 21
	jmp USART0_TX_vect			; 22
	jmp ANALOG_COMP_vect		; 23
	jmp ADC_vect				; 24
	jmp EE_READY_vect			; 25
	jmp TWI_vect				; 26
	jmp SPM_READY_vect			; 27
	jmp USART1_RX_vect			; 28
	jmp USART1_UDRE_vect		; 29
	jmp USART1_TX_vect			; 30
	jmp TIMER3_CAPT_vect		; 31
	jmp TIMER3_COMPA_vect		; 32
	jmp TIMER3_COMPB_vect		; 33
	jmp TIMER3_OVF_vect			; 34

RESET_vect:
	ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16
	sei
	jmp main 

#include "vangogh/constants.inc"
#include "vangogh/registers.inc"
#include "vangogh/vram.inc"
#include "shared/utilities.inc"

;d8888b. d88888b d88888b d888888b d8b   db d88888b .d8888.
;88  `8D 88'     88'       `88'   888o  88 88'     88'  YP
;88   88 88ooooo 88ooo      88    88V8o 88 88ooooo `8bo.
;88   88 88~~~~~ 88~~~      88    88 V8o88 88~~~~~   `Y8b.
;88  .8D 88.     88        .88.   88  V888 88.     db   8D
;Y8888D' Y88888P YP      Y888888P VP   V8P Y88888P `8888Y'

; Global macro definitions
; =========================================================
.DEF rLINECOUNTER	= r19
.DEF rSTATBITS		= r20
.DEF rCTRLBITS		= r21
.DEF rADDRDDR		= r22
.DEF rDATADDR		= r23

; === Timing Values =============================
      ; At 20MHz:
      ; clkIO with OC=0x04F6 gives us 15.7356412 kHz
      ; At 19.9044MHz:
      ; clkIO with OC=0x04BC gives us 15.7414674 kHz
      ; At 21.47727MHz:
      ; clkIO with OC=0x0554 gives us 15.7342637 kHz
      ; (NTSC color line rate is 15.734 kHz).
      ; At 28.63636MHz:
      ; clkIO with OC=0x071B gives us 15.7342637 kHz
.SET HSYNC_VALUE_HI		= 0x05
.SET HSYNC_VALUE_LO		= 0x54

;.88b  d88.  .d8b.   .o88b. d8888b.  .d88b.  .d8888.
;88'YbdP`88 d8' `8b d8P  Y8 88  `8D .8P  Y8. 88'  YP
;88  88  88 88ooo88 8P      88oobY' 88    88 `8bo.
;88  88  88 88~~~88 8b      88`8b   88    88   `Y8b.
;88  88  88 88   88 Y8b  d8 88 `88. `8b  d8' db   8D
;YP  YP  YP YP   YP  `Y88P' 88   YD  `Y88P'  `8888Y'

.MACRO VBLANK_ON ; 1 cycle
      andi rCTRLBITS, NOT_VBLANKBIT_MASK
.ENDM

.MACRO VBLANK_OFF ; 1 cycle
      ori rCTRLBITS, VBLANKBIT_MASK
.ENDM

.MACRO VDRAW_ON ; 1 cycle
      andi rCTRLBITS, NOT_VDRAWBIT_MASK
.ENDM

.MACRO VDRAW_OFF ; 1 cycle
      ori rCTRLBITS, VDRAWBIT_MASK
.ENDM

.MACRO DEBUG_ON  ; 1 cycle
      sbi CTL2PORT, DEBUGPIN
.ENDM

.MACRO DEBUG_OFF  ; 1 cycle
      cbi CTL2PORT, DEBUGPIN
.ENDM

.MACRO DAC_ENABLE  ; 1 cycle
      cbi CTL2PORT, DACENPIN
.ENDM

.MACRO DAC_DISABLE  ; 1 cycle
      sbi CTL2PORT, DACENPIN
.ENDM

.MACRO TOGGLE_SYNC_BIT  ; 2 cycles
      ldi rTEMP, SYNCBIT_MASK ; [1]
      eor rCTRLBITS, rTEMP    ; [1]
.ENDM

.MACRO IMMED_TOGGLE_SYNC_PIN ; 4 cycles
      in rTEMP, CTRLPORT            ; [1]
	  ldi rTEMP2, SYNCBIT_MASK      ; [1]
	  eor rTEMP, rTEMP2				; [1]
	  out CTRLPORT, rTEMP			; [1]
.ENDM

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
      ldi rTEMP2, 0
boot_wait_inner_loop:
      dec rTEMP2
      brne boot_wait_inner_loop
      dec rTEMP
      brne boot_wait_outer_loop
      ret

; Get debug lights into r0.
get_debug_lights:
      push XH
      push XL
      ldi XH, HIGH(debug_lights)
      ldi XL, LOW(debug_lights)
      ld r0, X
      pop XL
      pop XH
      ret

; Set debug lights from r0.
set_debug_lights:
      push XH
      push XL
      ldi XH, HIGH(debug_lights)
      ldi XL, LOW(debug_lights)
      st X, r0
      pop XL
      pop XH
      ret

; Turn on the "interrupt" debug bit.
set_interrupt_debug_bit:
      push XH
      push XL
      ldi XH, HIGH(debug_lights)
      ldi XL, LOW(debug_lights)
      ld rTEMP, X
      ori rTEMP, 0x40
      st X, rTEMP
      pop XL
      pop XH
      ret

; Turn off the "interrupt" debug bit.
clear_interrupt_debug_bit:
      push XH
      push XL
      ldi XH, HIGH(debug_lights)
      ldi XL, LOW(debug_lights)
      ld rTEMP, X
      andi rTEMP, 0xBF
      st X, rTEMP
      pop XL
      pop XH
      ret

; Turn on the "error" debug bit.
set_error_debug_bit:
      push XH
      push XL
      ldi XH, HIGH(debug_lights)
      ldi XL, LOW(debug_lights)
      ld r0, X
      ori rTEMP, 0x80
      st X, rTEMP
      pop XL
      pop XH
      ret

; Turn off the "error" debug bit.
clear_error_debug_bit:
      push XH
      push XL
      ldi XH, HIGH(debug_lights)
      ldi XL, LOW(debug_lights)
      ld r0, X
      andi rTEMP, 0x7F
      st X, r0
      pop XL
      pop XH
      ret

; Sets the debug output latch to the value in debug_lights.
latch_debug_lights:
      push r0
      rcall get_debug_lights
      in rTEMP, DATAPORT
      push rTEMP
      in rTEMP, DATADDR
      push rTEMP
      SET_DATA_OUTPUT
      out DATAPORT, r0
      DEBUG_ON
      DEBUG_OFF
      pop rTEMP
      out DATADDR, rTEMP
      pop rTEMP
      out DATAPORT, rTEMP
      pop r0
      ret

; Sets the debug output latch to a value specified by r0.
set_debug_latch:
      rcall set_debug_lights
      rcall latch_debug_lights
      ret

main:

;.d8888. d88888b d888888b db    db d8888b.
;88'  YP 88'     `~~88~~' 88    88 88  `8D
;`8bo.   88ooooo    88    88    88 88oodD'
;  `Y8b. 88~~~~~    88    88    88 88~~~
;db   8D 88.        88    88b  d88 88
;`8888Y' Y88888P    YP    ~Y8888P' 88

      ; Disable interrupts.
      cli

	  ; This should be unneeded but putting it here anyway: disable INT0 interrupt
      ;ldi rTEMP, 0
      ;sts EIMSK, rTEMP

      _LDI r0, 0x00
      rcall set_debug_latch

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
      ldi rTEMP, CTL2BIT_DDR_INIT
      out CTL2DDR, rTEMP
      ldi rTEMP, CTL2BIT_PORT_INIT
      out CTL2PORT, rTEMP

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
      sts TCCR1B, rTEMP

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
      sts OCR1AH, rTEMP
      ldi rTEMP, HSYNC_VALUE_LO
      sts OCR1AL, rTEMP

      ; Set interrupt on OC1A compare
      ldi rTEMP, (1 << OCIE1A)
      sts TIMSK1, rTEMP

      _LDI r0, 0x01
      rcall set_debug_latch

      ; === RAM configuration ================================================

      rcall boot_wait
      _LDI r0, 0x03
      rcall set_debug_latch

      call init_ppu_registers
      _LDI r0, 0x07
      rcall set_debug_latch

      ;call setup_palette
      _LDI r0, 0x0F
      rcall set_debug_latch

      call setup_vram
      _LDI r0, 0x1F
      rcall set_debug_latch

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

      rcall boot_wait
      _LDI r0, 0x3F
      rcall set_debug_latch

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

TIMER1_COMPA_vect:

      ; Start of front porch - 1.5 uS - 29 cycles
      ; Set control port lines as appropriate.
      out CTRLPORT, rCTRLBITS                   ; [029 -01 =028]

      ; Turn on "interrupt triggered" light.
      rcall set_interrupt_debug_bit
      rcall latch_debug_lights

      ; Finish up front porch
      _NOP16
	  _NOP4
	  _NOP2
	  nop                                       ; [028 -23 =005]

      IMMED_TOGGLE_SYNC_PIN                     ; [005 -05 =000]
      ; Start of sync tip - 4.7uS - 90 cycles

      sbrs rSTATBITS, STATBIT_DISP              ; [090 -03 =087]
      rjmp non_display_line                     ;

display_line:
      ; 87 cycles of HSYNC left
      mov rYPOS, rLINECOUNTER                   ; [087 -01 =086]
      mov rTEMP2, rCTRLBITS                     ; [086 -01 =085]

      ; Increment rLINECOUNTER by one.
      inc rLINECOUNTER                          ; [085 -01 =084]

      cpi rLINECOUNTER, 240                     ; [084 -01 =083]
                                                ; [     ==     ] [     !=     ]
      brne skip_setup_vblank                    ; [083 -01 =082] [083 -02 =081]

;d888888b d8b   db d888888b d888888b   d8888b. db       .d8b.  d8b   db db   dD
;  `88'   888o  88   `88'   `~~88~~'   88  `8D 88      d8' `8b 888o  88 88 ,8P'
;   88    88V8o 88    88       88      88oooY' 88      88ooo88 88V8o 88 88,8P
;   88    88 V8o88    88       88      88~~~b. 88      88~~~88 88 V8o88 88`8b
;  .88.   88  V888   .88.      88      88   8D 88booo. 88   88 88  V888 88 `88.
;Y888888P VP   V8P Y888888P    YP      Y8888P' Y88888P YP   YP VP   V8P YP   YD

setup_vblank:
      ; If result is 240:
      ;   - reset rLINECOUNTER to 0
      eor rLINECOUNTER, rLINECOUNTER            ; [082 -01 =081]
      ;   - clear rSTATBITS:DISP
      andi rSTATBITS, NOT_STATBIT_DISP_MASK     ; [081 -01 =080]
      ;   - toggle rSTATBITS:EVENFRAME
      ldi rTEMP, STATBIT_EVENFRAME_MASK         ; [080 -01 =079]
      eor rSTATBITS, rTEMP                      ; [079 -01 =078]
      ;   - turn on ~VBLANK control line
      VBLANK_ON                                 ; [078 -01 =077]
      ;   - turn off ~VDRAW control line
      VDRAW_OFF                                 ; [077 -01 =076]
      ;   - turn off OE/WE lines
      OE_AND_WE_OFF                             ; [076 -01 =075]
      rjmp after_setup_vblank                   ; [075 -02 =073]

skip_setup_vblank:
      _NOP8                                     ;                [081 -08 =073]

after_setup_vblank:

      ; 73 cycles of HSYNC left

      ; Finish the H-sync pulse here.
      ; This can be filled in with whatever calculations we care to do.
      _NOP64                                    ; [073 -068 =005]
	  _NOP4
      IMMED_TOGGLE_SYNC_PIN                     ; [005 -005 =000]

      ; Start of breezeway/colorburst/back porch = 4.7uS = 90 cycles
      _NOP64
	  _NOP16
	  _NOP8
	  _NOP2

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
      ; Load display mode from PPU register (7 cycles)
      LOAD_PPUREG   r0, PPUREG_MODE

      ; Ensure display mode only goes from 0 to 15 for now
      ldi rTEMP, 0x0F
      and r0, rTEMP

      ;_LDI r0, 1

      ; Load the jump address into Z but don't jump just yet
      ldi ZL, LOW(output_mode_jumptable)
      ldi ZH, HIGH(output_mode_jumptable)
      add ZL, r0
      adc ZH, rZERO

      ; Wait a bit longer because...reasons???
      ;_NOP 18

      ; Do the jump!
      ijmp

output_mode_jumptable:
      rjmp output_line_vram_direct_6      ; 0
      rjmp output_line_vram_direct_5      ; 1
      rjmp output_line_dummy              ; 2
      rjmp output_line_dummy              ; 3
      rjmp output_line_dummy              ; 4
      rjmp output_line_dummy              ; 5
      rjmp output_line_dummy              ; 6
      rjmp output_line_dummy              ; 7
      rjmp output_line_dummy              ; 8
      rjmp output_line_dummy              ; 9
      rjmp output_line_dummy              ; A
      rjmp output_line_dummy              ; B
      rjmp output_line_dummy              ; C
      rjmp output_line_dummy              ; D
      rjmp output_line_dummy              ; E
      rjmp output_line_dummy              ; F

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                                               ;
;    #    # #####    ##   #    #         #####  # #####  ######  ####  #####    ;
;    #    # #    #  #  #  ##  ##         #    # # #    # #      #    #   #      ;
;    #    # #    # #    # # ## #         #    # # #    # #####  #        #      ;
;    #    # #####  ###### #    #         #    # # #####  #      #        #      ;
;     #  #  #   #  #    # #    #         #    # # #   #  #      #    #   #      ;
;      ##   #    # #    # #    #         #####  # #    # ######  ####    #      ;
;                                #######                                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

output_line_vram_direct_6:
      ; Start Left Border
      ldi rTEMP, 0x00
      out DATAPORT, rTEMP
      SET_DATA_OUTPUT

      ; Clear X position.
      eor rXPOS, rXPOS

      ; Set HAL to Y position.
      mov r0, rYPOS
      call set_hi_addr_latch

      ; Set address port to X position.
      out ADDRPORT, rXPOS

      ; Set max X position
      _LDI rXMAX, 150

      ; End Left Border
      ;_NOP 3
      SET_DATA_INPUT

      ; Set VRAM0 address enable.
      ADDRESS_VRAM0
      OE_ON
      DAC_ENABLE

pixel_loop_6:
      ; Cyc/Pixel Num/Line
      ; ========= ========
      ;         6      232
      ;         5      270
      ;         4      340
      out ADDRPORT, rXPOS
      inc rXPOS
      cp rXPOS, rXMAX
      brne pixel_loop_6

      DAC_DISABLE
      OE_OFF
      ADDRESS_VDU

      rjmp end_line

output_line_vram_direct_5:
      ; Start Left Border
      ldi rTEMP, 0x00
      out DATAPORT, rTEMP
      SET_DATA_OUTPUT
      DAC_ENABLE

      ; Clear X position.
      eor rXPOS, rXPOS

      ; Set HAL to Y position.
      mov r0, rYPOS
      call set_hi_addr_latch

      ; Set address port to X position.
      out ADDRPORT, rXPOS

      ; Set max X position
      _LDI rXMAX, 255

      ; End Left Border
      ;_NOP 40
      SET_DATA_INPUT

      ; Set VRAM0 address enable.
      ADDRESS_VRAM0
      OE_ON

pixel_loop_5:
      out ADDRPORT, rXPOS
      inc rXPOS
      cp rXPOS, rXMAX
      brne pixel_loop_5

      DAC_DISABLE
      OE_OFF
      ADDRESS_VDU

      rjmp end_line

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                         ;
;    #####  #    # #    # #    # #   #    ;
;    #    # #    # ##  ## ##  ##  # #     ;
;    #    # #    # # ## # # ## #   #      ;
;    #    # #    # #    # #    #   #      ;
;    #    # #    # #    # #    #   #      ;
;    #####   ####  #    # #    #   #      ;
;                                         ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

output_line_dummy:
      rjmp end_line

;d8888b. d88888b d8b   db d8888b. d88888b d8888b. d888888b d8b   db  d888b
;88  `8D 88'     888o  88 88  `8D 88'     88  `8D   `88'   888o  88 88' Y8b
;88oobY' 88ooooo 88V8o 88 88   88 88ooooo 88oobY'    88    88V8o 88 88
;88`8b   88~~~~~ 88 V8o88 88   88 88~~~~~ 88`8b      88    88 V8o88 88  ooo
;88 `88. 88.     88  V888 88  .8D 88.     88 `88.   .88.   88  V888 88. ~8~
;88   YD Y88888P VP   V8P Y8888D' Y88888P 88   YD Y888888P VP   V8P  Y888P

compose_frame:
      rjmp end_line                             ; [2]
; === Test Code ===============================================================

      ; Clear X position.
      _LDI rXPOS, 4
      ;eor rXPOS, rXPOS

      ; Set high address latch to Y position.
      mov r0, rYPOS
      call set_hi_addr_latch

copy_loop:
      dec rXPOS

      ; Set address port to X position.
      out ADDRPORT, rXPOS

      ; Copy VRAM value into FBRAM.
      ADDRESS_VRAM1
      READ_DATA_INTO rTEMP
      ADDRESS_VRAM0
      WRITE_DATA_FROM rTEMP

      _CPI rXPOS, 0
      brne copy_loop

      ADDRESS_VDU

; =============================================================================
      SET_DATA_INPUT
      rjmp end_line                             ; [2]

;d8888b. db       .d8b.  d8b   db db   dD d888888b d8b   db  d888b
;88  `8D 88      d8' `8b 888o  88 88 ,8P'   `88'   888o  88 88' Y8b
;88oooY' 88      88ooo88 88V8o 88 88,8P      88    88V8o 88 88
;88~~~b. 88      88~~~88 88 V8o88 88`8b      88    88 V8o88 88  ooo
;88   8D 88booo. 88   88 88  V888 88 `88.   .88.   88  V888 88. ~8~
;Y8888P' Y88888P YP   YP VP   V8P YP   YD Y888888P VP   V8P  Y888P

non_display_line:
      ; 87 cycles of HSYNC left

      ; Of the 22 OR 23 non-display lines:
      ; 00-01: Bottom border lines
      ; 02-04: Pre-render blanking lines
      ; 05-07: VSYNC lines
      ; 08-21: Post-render blanking lines
      ; 22: Post-render blanking line on ODD frames only

      ; Load the jump address into Z but don't jump just yet
      ldi ZL, LOW(non_display_line_table)       ; [087 -01 =086]
      ldi ZH, HIGH(non_display_line_table)      ; [086 -01 =085]
      add ZL, rLINECOUNTER                      ; [085 -01 =084]
      adc ZH, rZERO                             ; [084 -01 =083]
      ; TEMPORARY

      ; If this is line 04, toggle SYNC for the next line.
      cpi rLINECOUNTER, 4                       ; [083 -01 =082]
                                                ; [     ==     ] [     !=     ]
      brne skip_set_vsync                       ; [082 -01 =081] [082 -02 =080]
set_vsync:
      TOGGLE_SYNC_BIT                           ; [081 -03 =078]
      rjmp after_set_vsync                      ; [078 -02 =076]
skip_set_vsync:
      _NOP4                                     ;                [080 -04 =076]
after_set_vsync:

      ; If this is line 07, toggle SYNC for the next line.
      cpi rLINECOUNTER, 7                       ; [076 -01 =075]
                                                ; [     ==     ] [     !=     ]
      brne skip_clear_vsync                     ; [075 -01 =074] [075 -02 =073]
clear_vsync:
      TOGGLE_SYNC_BIT                           ; [074 -03 =071]
      rjmp after_clear_vsync                    ; [071 -02 =069]
skip_clear_vsync:
      _NOP4                                     ;                [073 -04 =069]
after_clear_vsync:

      ; Increment rLINECOUNTER by one.
      inc rLINECOUNTER                          ; [069 -01 =068]

      ; Load 22 into the temp register.
      ldi rTEMP, 22                             ; [068 -01 =067]

      ; If rSTATBITS:EVENFRAME is clear, add 1 to the temp register.
      sbrs rSTATBITS, STATBIT_EVENFRAME         ; [067 -02 =065]
      inc rTEMP

      ; If line counter is equal to temp register:
      ;   - reset to 0
      ;   - set rSTATBITS:DISP for next line
      ;   - set ~VBLANK control line
      ;   - set DATA lines to input (we ONLY do output when writing)
      ;   - set ADDR/CTL2 lines to outputs
      ;   - clear ~OE, ~WE bits
      ;   - clear ~VDRAW control line if rSTATBITS:EVENFRAME is clear
      cp rLINECOUNTER, rTEMP                    ; [065 -01 =064]
                                                ; [     ==     ] [     !=     ]
      brne skip_setup_display                   ; [064 -01 =063] [064 -02 =062]

;d888888b d8b   db d888888b d888888b   d8888b. d888888b .d8888. d8888b.
;  `88'   888o  88   `88'   `~~88~~'   88  `8D   `88'   88'  YP 88  `8D
;   88    88V8o 88    88       88      88   88    88    `8bo.   88oodD'
;   88    88 V8o88    88       88      88   88    88      `Y8b. 88~~~
;  .88.   88  V888   .88.      88      88  .8D   .88.   db   8D 88
;Y888888P VP   V8P Y888888P    YP      Y8888D' Y888888P `8888Y' 88

setup_display:
      eor rLINECOUNTER, rLINECOUNTER            ; [063 -01 =062]
      ori rSTATBITS, STATBIT_DISP_MASK          ; [062 -01 =061]
      ori rCTRLBITS, VBLANKBIT_MASK             ; [061 -01 =060]
      ldi rADDRDDR, ADDRBIT_DDR_OUTPUT          ; [060 -01 =059]
      ldi rDATADDR, DATABIT_DDR_INPUT           ; [059 -01 =058]
      OE_AND_WE_OFF                             ; [058 -02 =056]
      sbrs rSTATBITS, STATBIT_EVENFRAME         ; [056 -02 =054]
      andi rCTRLBITS, NOT_VDRAWBIT_MASK
      rjmp after_setup_display                  ; [054 -02 =052]
skip_setup_display:
      _NOP8                                     ; [062 -10 =052]
	  _NOP2
after_setup_display:

      ; Finish the H-sync pulse here.
      ; This can be filled in with whatever calculations we care to do.
	  _NOP32									; [052 -47 =005]
	  _NOP8
	  _NOP4
	  _NOP2
	  nop
      IMMED_TOGGLE_SYNC_PIN                     ; [005 -05 =000]

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
      rjmp post_render_blanking_line      ; 22 (for odd frames)

      ; +4 cycles after HSYNC here (for whichever branch is taken)
bottom_border_line:
pre_render_blanking_line:
vsync_line:
post_render_blanking_line:

      rjmp end_line                       ; [2]

end_line:
      ; Turn off "interrupt triggered" light.
      call clear_interrupt_debug_bit
      call latch_debug_lights

      reti

INT0_vect:
      call set_error_debug_bit
      call latch_debug_lights
      call clear_error_debug_bit
      call latch_debug_lights
      ;push rTEMP
      ;ldi rTEMP, 0
      ;sts _SFR_MEM_ADDR(EIMSK), rTEMP
      ;pop rTEMP
      reti

      _LDI r0, 1
      rjmp finish_interrupt

INT1_vect:
      _LDI r0, 2
      rjmp finish_interrupt

INT2_vect:
      _LDI r0, 3
      rjmp finish_interrupt

PCINT0_vect:
      _LDI r0, 4
      rjmp finish_interrupt

PCINT1_vect:
      _LDI r0, 5
      rjmp finish_interrupt

PCINT2_vect:
      _LDI r0, 6
      rjmp finish_interrupt

PCINT3_vect:
      _LDI r0, 7
      rjmp finish_interrupt

WDT_vect:
      _LDI r0, 8
      rjmp finish_interrupt

TIMER2_COMPA_vect:
      _LDI r0, 9
      rjmp finish_interrupt

TIMER2_COMPB_vect:
      _LDI r0, 10
      rjmp finish_interrupt

TIMER2_OVF_vect:
      _LDI r0, 11
      rjmp finish_interrupt

TIMER1_CAPT_vect:
      _LDI r0, 12
      rjmp finish_interrupt

TIMER1_COMPB_vect:
      _LDI r0, 14
      rjmp finish_interrupt

TIMER1_OVF_vect:
      _LDI r0, 15
      rjmp finish_interrupt

TIMER0_COMPA_vect:
      _LDI r0, 16
      rjmp finish_interrupt

TIMER0_COMPB_vect:
      _LDI r0, 17
      rjmp finish_interrupt

TIMER0_OVF_vect:
      _LDI r0, 18
      rjmp finish_interrupt

SPI_STC_vect:
      _LDI r0, 19
      rjmp finish_interrupt

USART0_RX_vect:
      _LDI r0, 20
      rjmp finish_interrupt

USART0_UDRE_vect:
      _LDI r0, 21
      rjmp finish_interrupt

USART0_TX_vect:
      _LDI r0, 22
      rjmp finish_interrupt

ANALOG_COMP_vect:
      _LDI r0, 23
      rjmp finish_interrupt

ADC_vect:
      _LDI r0, 24
      rjmp finish_interrupt

EE_READY_vect:
      _LDI r0, 25
      rjmp finish_interrupt

TWI_vect:
      _LDI r0, 26
      rjmp finish_interrupt

SPM_READY_vect:
      _LDI r0, 27
      rjmp finish_interrupt

USART1_RX_vect:
      _LDI r0, 28
      rjmp finish_interrupt

USART1_UDRE_vect:
      _LDI r0, 29
      rjmp finish_interrupt

USART1_TX_vect:
      _LDI r0, 30
      rjmp finish_interrupt

TIMER3_CAPT_vect:
      _LDI r0, 31
      rjmp finish_interrupt

TIMER3_COMPA_vect:
      _LDI r0, 32
      rjmp finish_interrupt

TIMER3_COMPB_vect:
      _LDI r0, 33
      rjmp finish_interrupt

TIMER3_OVF_vect:
      _LDI r0, 34
      rjmp finish_interrupt

__vector_default:
      _LDI r0, 0

finish_interrupt:
      call set_debug_lights
      call set_error_debug_bit
      call latch_debug_lights
;      reti

endless:
      rjmp endless

.DSEG

; Debug byte.
debug_lights:
      .byte 0x00
