; PPU constants
#ifndef CONSTANTS_INC
#define CONSTANTS_INC

.EQU ADDRDDR   = DDRA
.EQU ADDRPORT  = PORTA
.EQU DATADDR   = DDRC
.EQU DATAPORT  = PORTC
.EQU CTRLDDR   = DDRD
.EQU CTRLPORT  = PORTD
.EQU CTL2DDR   = DDRB
.EQU CTL2PORT  = PORTB

.EQU STATBIT_DISP                =     7   ; Current line is a display line
.EQU STATBIT_HSYNC               =     6   ; LOW indicates HSYNC active
.EQU STATBIT_VSYNC               =     5   ; LOW indicates VSYNC active
.EQU STATBIT_EVENFRAME           =     0   ; Current frame is an even frame
.EQU STATBIT_DISP_MASK           = (0b10000000)
.EQU STATBIT_EVENFRAME_MASK      = (0b00000001)
.EQU NOT_STATBIT_DISP_MASK       = (0b01111111)
.EQU NOT_STATBIT_EVENFRAME_MASK  = (0b11111110)

; === Bitmasks for Address Port =================
.EQU ADDRBIT_PORT_INIT           = (0b11111111) ; testing, normally (0b00000000)
.EQU ADDRBIT_DDR_INPUT           = (0b00000000)
.EQU ADDRBIT_DDR_OUTPUT          = (0b11111111)
.EQU ADDRBIT_DDR_INIT            = ADDRBIT_DDR_OUTPUT

; === Bitmasks for Data/High Address Port =======
.EQU DATABIT_PORT_INIT           = (0b11111111)
.EQU DATABIT_DDR_INPUT           = (0b00000000)
.EQU DATABIT_DDR_OUTPUT          = (0b11111111)
.EQU DATABIT_DDR_INIT            = DATABIT_DDR_INPUT

; === Bitmasks for Control Port =================
.EQU CTRLBIT_PORT_INIT           = (0b00100000)
.EQU CTRLBIT_DDR_INPUT           = (0b00000000)
.EQU CTRLBIT_DDR_OUTPUT          = (0b11111111)
.EQU CTRLBIT_DDR_INIT            = CTRLBIT_DDR_OUTPUT

.EQU CTRLBIT_MASK                = (0b11111111)
.EQU SYNCBIT_MASK                = (0b10000000)
.EQU HALLATBIT_MASK              = (0b01000000)
.EQU CPUDISBIT_MASK              = (0b00100000)
.EQU VBLANKBIT_MASK              = (0b00010000)
.EQU VDRAWBIT_MASK               = (0b00001000)
.EQU EXTRAADDR_MASK              = (0b00000111)
.EQU NOT_SYNCBIT_MASK            = (0b01111111)
.EQU NOT_HALLATBIT_MASK          = (0b10111111)
.EQU NOT_CPUDISBIT_MASK          = (0b11011111)
.EQU NOT_VBLANKBIT_MASK          = (0b11101111)
.EQU NOT_VDRAWBIT_MASK           = (0b11110111)
.EQU NOT_EXTRAADDR_MASK          = (0b11111000)

.EQU SYNCPIN    = 7
.EQU HALLATPIN  = 6
.EQU CPUDISPIN  = 5
.EQU VBLANKPIN  = 4
.EQU VDRAWPIN   = 3
.EQU A18PIN     = 2
.EQU A17PIN     = 1
.EQU A16PIN     = 0

; === Bitmasks for Control Port 2 ===============
.EQU CTL2BIT_PORT_INIT           = (0b11110111)
.EQU CTL2BIT_DDR_INIT            = (0b00011111)

.EQU CTL2BIT_MASK                = (0b00001111)
.EQU ENABLEBIT_MASK              = (0b00000101)
.EQU DACENBIT_MASK               = (0b00010000)
.EQU DEBUGBIT_MASK               = (0b00001000)
.EQU OEBIT_MASK                  = (0b00000100)
.EQU CLOCKBIT_MASK               = (0b00000010)
.EQU WEBIT_MASK                  = (0b00000001)

.EQU NOT_ENABLEBIT_MASK          = (0b11111001)
.EQU NOT_DACENBIT_MASK           = (0b11101111)
.EQU NOT_DEBUGBIT_MASK           = (0b11110111)
.EQU NOT_OEBIT_MASK              = (0b11111011)
.EQU NOT_CLOCKBIT_MASK           = (0b11111101)
.EQU NOT_WEBIT_MASK              = (0b11111110)

.EQU DACENPIN                    = 4
.EQU DEBUGPIN                    = 3
.EQU OEPIN                       = 2
.EQU CLOCKPIN                    = 1
.EQU WEPIN                       = 0

#endif
