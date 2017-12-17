; PPU constants
#pragma once

#define rZERO           r1

#define rTEMP           r16
#define rTEMP2          r17
#define rTEMP3          r18

#define ADDRDDR   _SFR_IO_ADDR(DDRA)
#define ADDRPORT  _SFR_IO_ADDR(PORTA)
#define DATADDR   _SFR_IO_ADDR(DDRC)
#define DATAPORT  _SFR_IO_ADDR(PORTC)
#define CTRLDDR   _SFR_IO_ADDR(DDRD)
#define CTRLPORT  _SFR_IO_ADDR(PORTD)
#define CTL2DDR   _SFR_IO_ADDR(DDRB)
#define CTL2PORT  _SFR_IO_ADDR(PORTB)

#define STATBIT_DISP                      7   ; Current line is a display line
#define STATBIT_HSYNC                     6   ; LOW indicates HSYNC active
#define STATBIT_VSYNC                     5   ; LOW indicates VSYNC active
#define STATBIT_EVENFRAME                 0   ; Current frame is an even frame
#define STATBIT_DISP_MASK           (0b10000000)
#define STATBIT_EVENFRAME_MASK      (0b00000001)
#define NOT_STATBIT_DISP_MASK       (0b01111111)
#define NOT_STATBIT_EVENFRAME_MASK  (0b11111110)

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
#define CTRLBIT_PORT_INIT           (0b00111000)
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
#define CTL2BIT_PORT_INIT           (0b11110111)
#define CTL2BIT_DDR_INIT            (0b00011111)

#define CTL2BIT_MASK                (0b00001111)
#define ENABLEBIT_MASK              (0b00000101)
#define DACENBIT_MASK               (0b00010000)
#define DEBUGBIT_MASK               (0b00001000)
#define OEBIT_MASK                  (0b00000100)
#define CLOCKBIT_MASK               (0b00000010)
#define WEBIT_MASK                  (0b00000001)

#define NOT_ENABLEBIT_MASK          (0b11111001)
#define NOT_DACENBIT_MASK           (0b11101111)
#define NOT_DEBUGBIT_MASK           (0b11110111)
#define NOT_OEBIT_MASK              (0b11111011)
#define NOT_CLOCKBIT_MASK           (0b11111101)
#define NOT_WEBIT_MASK              (0b11111110)

#define DACENPIN                    4
#define DEBUGPIN                    3
#define OEPIN                       2
#define CLOCKPIN                    1
#define WEPIN                       0
