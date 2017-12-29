.DEVICE ATmega644A

; INT2 = PB2

; Register definitions
.DEF    rTEMP       = r0
.DEF    rZERO       = r1
.DEF    rFF         = r2

; Port Definitions
.EQU    PORT_IN     = PORTC
.EQU    DDR_IN      = DDRC
.EQU    PORT_OUT    = PORTA
.EQU    DDR_OUT     = DDRA
.EQU    PORT_CTRL   = PORTD
.EQU    DDR_CTRL    = DDRD

; Control pins (PORTD)
.EQU    CTRL_PIN_RD_BUF_SEL     = 0
.EQU    CTRL_PIN_WR_BUF_SEL     = 1
.EQU    CTRL_PIN_WRITE_INC      = 2     ; INT0 = PD2
.EQU    CTRL_PIN_READ_ENABLE    = 3     ; INT1 = PD3
.EQU    CTRL_PIN_RD_RESET       = 4
.EQU    CTRL_PIN_WR_RESET       = 5

.CSEG
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
    eor r1, r1
    eor r2, r2
    dec r2
    sei
    jmp main 
    
main:
    ; Disable interrupts.
    cli

    ; Set input/output/control ports up.

    out PORT_IN, rFF
    out DDR_IN, rZERO
    out PORT_OUT, rZERO
    out DDR_OUT, rFF
    out PORT_CTRL, rFF
    out DDR_CTRL, rZERO

    ; Initialize X, Y registers.
    ldi XH, HIGH(fifo_buffer_a)
    ldi XL, LOW(fifo_buffer_a)
    ldi YH, HIGH(fifo_buffer_b)
    ldi YL, LOW(fifo_buffer_b)

    ; Enable interrupts.
    sei

loop:
    rjmp loop

INT0_vect:
    ; Write into FIFO and increment write pointer.
    in rTEMP, PORT_IN
    st X+, rTEMP
    ; Just to be on the safe side, mask off XH to stop buffer overruns.
    andi XH, 0x07
    reti

INT1_vect:
    ; Increment read pointer and read from FIFO.
    reti

PCINT3_vect:
    ; Process pin change interrupt.
    reti

INT2_vect:
PCINT0_vect:
PCINT1_vect:
PCINT2_vect:
WDT_vect:
TIMER2_COMPA_vect:
TIMER2_COMPB_vect:
TIMER2_OVF_vect:
TIMER1_CAPT_vect:
TIMER1_COMPA_vect:
TIMER1_COMPB_vect:
TIMER1_OVF_vect:
TIMER0_COMPA_vect:
TIMER0_COMPB_vect:
TIMER0_OVF_vect:
SPI_STC_vect:
USART0_RX_vect:
USART0_UDRE_vect:
USART0_TX_vect:
ANALOG_COMP_vect:
ADC_vect:
EE_READY_vect:
TWI_vect:
SPM_READY_vect:
USART1_RX_vect:
USART1_UDRE_vect:
USART1_TX_vect:
TIMER3_CAPT_vect:
TIMER3_COMPA_vect:
TIMER3_COMPB_vect:
TIMER3_OVF_vect:
    reti

.DSEG

.ORG 0x0400         ; 0000 0100 0000 0000 to 0000 0101 1111 1111
fifo_buffer_A:
.BYTE 512

.ORG 0x0600         ; 0000 0110 0000 0000 to 0000 0111 1111 1111
fifo_buffer_B:
.BYTE 512
                    ; 0000 0111