.balign 0x10

.global tilemap_882_cgafont
tilemap_882_cgafont:

;           .d88b.  db    db  .d88b.   .d88b.
; C8888D   .8P  88. `8b  d8' .8P  88. .8P  88.   C8888D
;          88  d'88  `8bd8'  88  d'88 88  d'88
; C8888D   88 d' 88  .dPYb.  88 d' 88 88 d' 88   C8888D
;          `88  d8' .8P  Y8. `88  d8' `88  d8'
;           `Y88P'  YP    YP  `Y88P'   `Y88P'

.byte 0b00000000  ; 0x00
.byte 0b00000000  ; NUL
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b01111110  ; 0x01
.byte 0b10000001  ; Open Smiley
.byte 0b10100101
.byte 0b10000001
.byte 0b10111101
.byte 0b10011001
.byte 0b10000001
.byte 0b01111110

.byte 0b01111110  ; 0x02
.byte 0b11111111  ; Closed Smiley
.byte 0b11011011
.byte 0b11111111
.byte 0b11000011
.byte 0b11100111
.byte 0b11111111
.byte 0b01111110

.byte 0b01101100  ; 0x03
.byte 0b11111110  ; Heart
.byte 0b11111110
.byte 0b11111110
.byte 0b11111100
.byte 0b00111000
.byte 0b00010000
.byte 0b00000000

.byte 0b00010000  ; 0x04
.byte 0b00111000  ; Diamond
.byte 0b01111100
.byte 0b11111110
.byte 0b01111100
.byte 0b00111000
.byte 0b00010000
.byte 0b00000000

.byte 0b00111000  ; 0x05
.byte 0b01111100  ; Club
.byte 0b00111000
.byte 0b11111111
.byte 0b11111111
.byte 0b11010011
.byte 0b00010000
.byte 0b00111000

.byte 0b00010000  ; 0x06
.byte 0b00010000  ; Spade
.byte 0b00111000
.byte 0b01111100
.byte 0b11111110
.byte 0b01111100
.byte 0b00010000
.byte 0b00111000

.byte 0b00000000  ; 0x07
.byte 0b00000000  ; Dot
.byte 0b00011000
.byte 0b00111100
.byte 0b00111100
.byte 0b00011000
.byte 0b00000000
.byte 0b00000000

.byte 0b11111111  ; 0x08
.byte 0b11111111  ; Inverted Dot
.byte 0b11100111
.byte 0b11000011
.byte 0b11000011
.byte 0b11100111
.byte 0b11111111
.byte 0b11111111

.byte 0b00000000  ; 0x09
.byte 0b00111100  ; Ring
.byte 0b01100110
.byte 0b01000010
.byte 0b01000010
.byte 0b01100110
.byte 0b00111100
.byte 0b00000000

.byte 0b11111111  ; 0x0A
.byte 0b11000011  ; Inverted Ring
.byte 0b10011001
.byte 0b10111101
.byte 0b10111101
.byte 0b10011001
.byte 0b11000011
.byte 0b11111111

.byte 0b00001111  ; 0x0B
.byte 0b00000111  ; Male
.byte 0b00001111
.byte 0b01111101
.byte 0b11001100
.byte 0b11001100
.byte 0b11001100
.byte 0b01111000

.byte 0b01111110  ; 0x0C
.byte 0b11000011  ; Female
.byte 0b11000011
.byte 0b11000011
.byte 0b01111110
.byte 0b00011000
.byte 0b11111111
.byte 0b00011000

.byte 0b00111111  ; 0x0D
.byte 0b00110011  ; Music Note
.byte 0b00111111
.byte 0b00110000
.byte 0b00110000
.byte 0b01110000
.byte 0b11110000
.byte 0b11100000

.byte 0b01111111  ; 0x0E
.byte 0b01100011  ; Two Music Notes
.byte 0b01111111
.byte 0b01100011
.byte 0b01100011
.byte 0b01100111
.byte 0b11100110
.byte 0b11000000

.byte 0b00011000  ; 0x0F
.byte 0b11011011  ; Snowflake
.byte 0b00111100
.byte 0b11100111
.byte 0b11100111
.byte 0b00111100
.byte 0b11011011
.byte 0b00011000

;           .d88b.  db    db  db  .d88b.
; C8888D   .8P  88. `8b  d8' o88 .8P  88.   C8888D
;          88  d'88  `8bd8'   88 88  d'88
; C8888D   88 d' 88  .dPYb.   88 88 d' 88   C8888D
;          `88  d8' .8P  Y8.  88 `88  d8'
;           `Y88P'  YP    YP  VP  `Y88P'

.byte 0b00000000  ; 0x10
.byte 0b00000000  ; Big Right Arrow
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x11
.byte 0b00000000  ; Big Left Arrow
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x12
.byte 0b00000000  ; Double-Sided Vertical Arrow
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x13
.byte 0b00000000  ; Double Exclamation
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x14
.byte 0b00000000  ; Pilcrow Symbol
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x15
.byte 0b00000000  ; Section Symbol
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x16
.byte 0b00000000  ; Thick Underscore
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x17
.byte 0b00000000  ; Underlined Double-Sided Arrow
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x18
.byte 0b00000000  ; Up Arrow
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x19
.byte 0b00000000  ; Down Arrow
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x1A
.byte 0b00000000  ; Right Arrow
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x1B
.byte 0b00000000  ; Left Arrow
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x1C
.byte 0b00000000  ; Left lower half bracket
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x1D
.byte 0b00000000  ; Double-Sided Arrow
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x1E
.byte 0b00000000  ; Thick Up Arrow
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x1F
.byte 0b00000000  ; Thick Down Arrow
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db .d888b.  .d88b.
; C8888D   .8P  88. `8b  d8' VP  `8D .8P  88.   C8888D
;          88  d'88  `8bd8'     odD' 88  d'88
; C8888D   88 d' 88  .dPYb.   .88'   88 d' 88   C8888D
;          `88  d8' .8P  Y8. j88.    `88  d8'
;           `Y88P'  YP    YP 888888D  `Y88P'

.byte 0b00000000  ; 0x20
.byte 0b00000000  ; Space
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x21
.byte 0b00000000  ; !
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x22
.byte 0b00000000  ; "
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x23
.byte 0b00000000  ; #
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x24
.byte 0b00000000  ; $
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x25
.byte 0b00000000  ; %
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x26
.byte 0b00000000  ; &
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x27
.byte 0b00000000  ; '
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x28
.byte 0b00000000  ; (
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x29
.byte 0b00000000  ; )
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x2A
.byte 0b00000000  ; *
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x2B
.byte 0b00000000  ; +
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x2C
.byte 0b00000000  ; ,
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x2D
.byte 0b00000000  ; -
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x2E
.byte 0b00000000  ; .
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x2F
.byte 0b00000000  ; /
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db d8888b.  .d88b.
; C8888D   .8P  88. `8b  d8' VP  `8D .8P  88.   C8888D
;          88  d'88  `8bd8'    oooY' 88  d'88
; C8888D   88 d' 88  .dPYb.    ~~~b. 88 d' 88   C8888D
;          `88  d8' .8P  Y8. db   8D `88  d8'
;           `Y88P'  YP    YP Y8888P'  `Y88P'

.byte 0b00000000  ; 0x30
.byte 0b00000000  ; 0
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x31
.byte 0b00000000  ; 1
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x32
.byte 0b00000000  ; 2
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x33
.byte 0b00000000  ; 3
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x34
.byte 0b00000000  ; 4
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x35
.byte 0b00000000  ; 5
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x36
.byte 0b00000000  ; 6
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x37
.byte 0b00000000  ; 7
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x38
.byte 0b00000000  ; 8
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x39
.byte 0b00000000  ; 9
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x3A
.byte 0b00000000  ; :
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x3B
.byte 0b00000000  ; ;
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x3C
.byte 0b00000000  ; <
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x3D
.byte 0b00000000  ; =
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x3E
.byte 0b00000000  ; >
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x3F
.byte 0b00000000  ; ?
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db   j88D   .d88b.
; C8888D   .8P  88. `8b  d8'  j8~88  .8P  88.   C8888D
;          88  d'88  `8bd8'  j8' 88  88  d'88
; C8888D   88 d' 88  .dPYb.  V88888D 88 d' 88   C8888D
;          `88  d8' .8P  Y8.     88  `88  d8'
;           `Y88P'  YP    YP     VP   `Y88P'

.byte 0b00000000  ; 0x40
.byte 0b00000000  ; @
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x41
.byte 0b00000000  ; A
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x42
.byte 0b00000000  ; B
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x43
.byte 0b00000000  ; C
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x44
.byte 0b00000000  ; D
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x45
.byte 0b00000000  ; E
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x46
.byte 0b00000000  ; F
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x47
.byte 0b00000000  ; G
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x48
.byte 0b00000000  ; H
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x49
.byte 0b00000000  ; I
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x4A
.byte 0b00000000  ; J
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x4B
.byte 0b00000000  ; K
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x4C
.byte 0b00000000  ; L
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x4D
.byte 0b00000000  ; M
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x4E
.byte 0b00000000  ; N
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x4F
.byte 0b00000000  ; O
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db   ooooo  .d88b.
; C8888D   .8P  88. `8b  d8'  8P~~~~ .8P  88.   C8888D
;          88  d'88  `8bd8'  dP      88  d'88
; C8888D   88 d' 88  .dPYb.  V8888b. 88 d' 88   C8888D
;          `88  d8' .8P  Y8.     `8D `88  d8'
;           `Y88P'  YP    YP 88oobY'  `Y88P'

.byte 0b00000000  ; 0x50
.byte 0b00000000  ; P
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x51
.byte 0b00000000  ; Q
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x52
.byte 0b00000000  ; R
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x53
.byte 0b00000000  ; S
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x54
.byte 0b00000000  ; T
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x55
.byte 0b00000000  ; U
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x56
.byte 0b00000000  ; V
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x57
.byte 0b00000000  ; W
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x58
.byte 0b00000000  ; X
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x59
.byte 0b00000000  ; Y
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x5A
.byte 0b00000000  ; Z
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x5B
.byte 0b00000000  ; [
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x5C
.byte 0b00000000  ; backslash
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x5D
.byte 0b00000000  ; ]
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x5E
.byte 0b00000000  ; ^
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x5F
.byte 0b00000000  ; _
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db    dD    .d88b.
; C8888D   .8P  88. `8b  d8'   d8'   .8P  88.   C8888D
;          88  d'88  `8bd8'   d8'    88  d'88
; C8888D   88 d' 88  .dPYb.  d8888b. 88 d' 88   C8888D
;          `88  d8' .8P  Y8. 88' `8D `88  d8'
;           `Y88P'  YP    YP `8888P   `Y88P'

.byte 0b00000000  ; 0x60
.byte 0b00000000  ; `
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x61
.byte 0b00000000  ; a
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x62
.byte 0b00000000  ; b
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x63
.byte 0b00000000  ; c
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x64
.byte 0b00000000  ; d
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x65
.byte 0b00000000  ; e
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x66
.byte 0b00000000  ; f
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x67
.byte 0b00000000  ; g
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x68
.byte 0b00000000  ; h
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x69
.byte 0b00000000  ; i
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x6A
.byte 0b00000000  ; j
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x6B
.byte 0b00000000  ; k
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x6C
.byte 0b00000000  ; l
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x6D
.byte 0b00000000  ; m
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x6E
.byte 0b00000000  ; n
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x6F
.byte 0b00000000  ; o
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db d88888D  .d88b.
; C8888D   .8P  88. `8b  d8' VP  d8' .8P  88.   C8888D
;          88  d'88  `8bd8'     d8'  88  d'88
; C8888D   88 d' 88  .dPYb.    d8'   88 d' 88   C8888D
;          `88  d8' .8P  Y8.  d8'    `88  d8'
;           `Y88P'  YP    YP d8'      `Y88P'

.byte 0b00000000  ; 0x70
.byte 0b00000000  ; p
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x71
.byte 0b00000000  ; q
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x72
.byte 0b00000000  ; r
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x73
.byte 0b00000000  ; s
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x74
.byte 0b00000000  ; t
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x75
.byte 0b00000000  ; u
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x76
.byte 0b00000000  ; v
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x77
.byte 0b00000000  ; w
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x78
.byte 0b00000000  ; x
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x79
.byte 0b00000000  ; y
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x7A
.byte 0b00000000  ; z
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x7B
.byte 0b00000000  ; {
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x7C
.byte 0b00000000  ; |
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x7D
.byte 0b00000000  ; }
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x7E
.byte 0b00000000  ; ~
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x7F
.byte 0b00000000  ; DEL
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db .d888b.  .d88b.
; C8888D   .8P  88. `8b  d8' 88   8D .8P  88.   C8888D
;          88  d'88  `8bd8'  `VoooY' 88  d'88
; C8888D   88 d' 88  .dPYb.  .d~~~b. 88 d' 88   C8888D
;          `88  d8' .8P  Y8. 88   8D `88  d8'
;           `Y88P'  YP    YP `Y888P'  `Y88P'

.byte 0b00000000  ; 0x80
.byte 0b00000000  ; C cedilla
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x81
.byte 0b00000000  ; u umlaut
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x82
.byte 0b00000000  ; e accent
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x83
.byte 0b00000000  ; a circumflex
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x84
.byte 0b00000000  ; a umlaut
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x85
.byte 0b00000000  ; a grave
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x86
.byte 0b00000000  ; a circle
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x87
.byte 0b00000000  ; c cedilla
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x88
.byte 0b00000000  ; e circumflex
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x89
.byte 0b00000000  ; e umlaut
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x8A
.byte 0b00000000  ; e grave
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x8B
.byte 0b00000000  ; i umlaut
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x8C
.byte 0b00000000  ; i circumflex
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x8D
.byte 0b00000000  ; i grave
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x8E
.byte 0b00000000  ; A umlaut
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x8F
.byte 0b00000000  ; A circle
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db .d888b.  .d88b.
; C8888D   .8P  88. `8b  d8' 88' `8D .8P  88.   C8888D
;          88  d'88  `8bd8'  `V8o88' 88  d'88
; C8888D   88 d' 88  .dPYb.     d8'  88 d' 88   C8888D
;          `88  d8' .8P  Y8.   d8'   `88  d8'
;           `Y88P'  YP    YP  d8'     `Y88P'

.byte 0b00000000  ; 0x90
.byte 0b00000000  ; E accent
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x91
.byte 0b00000000  ; ae
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x92
.byte 0b00000000  ; AE
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x93
.byte 0b00000000  ; o circumflex
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x94
.byte 0b00000000  ; o umlaut
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x95
.byte 0b00000000  ; o grave
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x96
.byte 0b00000000  ; u circumflex
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x97
.byte 0b00000000  ; u grave
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x98
.byte 0b00000000  ; y umlaut
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x99
.byte 0b00000000  ; O umlaut
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x9A
.byte 0b00000000  ; U umlaut
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x9B
.byte 0b00000000  ; cents
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x9C
.byte 0b00000000  ; pounds
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x9D
.byte 0b00000000  ; yen
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x9E
.byte 0b00000000  ; peseta
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0x9F
.byte 0b00000000  ; florin
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db  .d8b.   .d88b.
; C8888D   .8P  88. `8b  d8' d8' `8b .8P  88.   C8888D
;          88  d'88  `8bd8'  88ooo88 88  d'88
; C8888D   88 d' 88  .dPYb.  88~~~88 88 d' 88   C8888D
;          `88  d8' .8P  Y8. 88   88 `88  d8'
;           `Y88P'  YP    YP YP   YP  `Y88P'

.byte 0b00000000  ; 0xA0
.byte 0b00000000  ; a accent
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xA1
.byte 0b00000000  ; i accent
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xA2
.byte 0b00000000  ; o accent
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xA3
.byte 0b00000000  ; u accent
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xA4
.byte 0b00000000  ; n tilde
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xA5
.byte 0b00000000  ; N tilde
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xA6
.byte 0b00000000  ; a superscript
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xA7
.byte 0b00000000  ; o superscript
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xA8
.byte 0b00000000  ; inverted question mark
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xA9
.byte 0b00000000  ; left upper half bracket
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xAA
.byte 0b00000000  ; right upper half bracket
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xAB
.byte 0b00000000  ; 1/2 sign
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xAC
.byte 0b00000000  ; 1/4 sign
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xAD
.byte 0b00000000  ; inverted exclamation point
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xAE
.byte 0b00000000  ; left double-angle bracket
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xAF
.byte 0b00000000  ; right double-angle bracket
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db d8888b.  .d88b.
; C8888D   .8P  88. `8b  d8' 88  `8D .8P  88.   C8888D
;          88  d'88  `8bd8'  88oooY' 88  d'88
; C8888D   88 d' 88  .dPYb.  88~~~b. 88 d' 88   C8888D
;          `88  d8' .8P  Y8. 88   8D `88  d8'
;           `Y88P'  YP    YP Y8888P'  `Y88P'

.byte 0b00000000  ; 0xB0
.byte 0b00000000  ; light shading
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xB1
.byte 0b00000000  ; medium shading
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xB2
.byte 0b00000000  ; dark shading
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xB3
.byte 0b00000000  ; NS single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xB4
.byte 0b00000000  ; NSW single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xB5
.byte 0b00000000  ; NS single, W double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xB6
.byte 0b00000000  ; NS double, W single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xB7
.byte 0b00000000  ; W single, S double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xB8
.byte 0b00000000  ; W double, S single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xB9
.byte 0b00000000  ; NSW double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xBA
.byte 0b00000000  ; NS double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xBB
.byte 0b00000000  ; SW double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xBC
.byte 0b00000000  ; NW double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xBD
.byte 0b00000000  ; N double, W single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xBE
.byte 0b00000000  ; N single, W double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xBF
.byte 0b00000000  ; SW single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db  .o88b.  .d88b.
; C8888D   .8P  88. `8b  d8' d8P  Y8 .8P  88.   C8888D
;          88  d'88  `8bd8'  8P      88  d'88
; C8888D   88 d' 88  .dPYb.  8b      88 d' 88   C8888D
;          `88  d8' .8P  Y8. Y8b  d8 `88  d8'
;           `Y88P'  YP    YP  `Y88P'  `Y88P'

.byte 0b00000000  ; 0xC0
.byte 0b00000000  ; NE single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xC1
.byte 0b00000000  ; NEW single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xC2
.byte 0b00000000  ; SEW single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xC3
.byte 0b00000000  ; NES single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xC4
.byte 0b00000000  ; EW single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xC5
.byte 0b00000000  ; NESW single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xC6
.byte 0b00000000  ; NS single, E double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xC7
.byte 0b00000000  ; NS double, E single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xC8
.byte 0b00000000  ; NE double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xC9
.byte 0b00000000  ; SE double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xCA
.byte 0b00000000  ; NEW double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xCB
.byte 0b00000000  ; ESW double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xCC
.byte 0b00000000  ; NES double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xCD
.byte 0b00000000  ; EW double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xCE
.byte 0b00000000  ; NESW double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xCF
.byte 0b00000000  ; EW double, N single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db d8888b.  .d88b.
; C8888D   .8P  88. `8b  d8' 88  `8D .8P  88.   C8888D
;          88  d'88  `8bd8'  88   88 88  d'88
; C8888D   88 d' 88  .dPYb.  88   88 88 d' 88   C8888D
;          `88  d8' .8P  Y8. 88  .8D `88  d8'
;           `Y88P'  YP    YP Y8888D'  `Y88P'

.byte 0b00000000  ; 0xD0
.byte 0b00000000  ; EW single, N double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xD1
.byte 0b00000000  ; EW double, S single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xD2
.byte 0b00000000  ; EW single, S double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xD3
.byte 0b00000000  ; N double, E single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xD4
.byte 0b00000000  ; N single, E double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xD5
.byte 0b00000000  ; S single, E double
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xD6
.byte 0b00000000  ; S double, E single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xD7
.byte 0b00000000  ; EW double, N single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xD8
.byte 0b00000000  ; EW double, NS single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xD9
.byte 0b00000000  ; NW single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xDA
.byte 0b00000000  ; SE single
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xDB
.byte 0b00000000  ; full block
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xDC
.byte 0b00000000  ; bottom half block
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xDD
.byte 0b00000000  ; left half block
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xDE
.byte 0b00000000  ; right half block
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xDF
.byte 0b00000000  ; top half block
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db d88888b  .d88b.
; C8888D   .8P  88. `8b  d8' 88'     .8P  88.   C8888D
;          88  d'88  `8bd8'  88ooooo 88  d'88
; C8888D   88 d' 88  .dPYb.  88~~~~~ 88 d' 88   C8888D
;          `88  d8' .8P  Y8. 88.     `88  d8'
;           `Y88P'  YP    YP Y88888P  `Y88P'

.byte 0b00000000  ; 0xE0
.byte 0b00000000  ; lowercase alpha
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xE1
.byte 0b00000000  ; capital beta
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xE2
.byte 0b00000000  ; capital gamma
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xE3
.byte 0b00000000  ; pi
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xE4
.byte 0b00000000  ; capital sigma
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xE5
.byte 0b00000000  ; lowercase sigma
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xE6
.byte 0b00000000  ; lowercase mu
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xE7
.byte 0b00000000  ; lowercase tau
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xE8
.byte 0b00000000  ; capital psi
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xE9
.byte 0b00000000  ; capital phi
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xEA
.byte 0b00000000  ; capital omega
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xEB
.byte 0b00000000  ; lowercase delta
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xEC
.byte 0b00000000  ; lemniscate
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xED
.byte 0b00000000  ; null set
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xEE
.byte 0b00000000  ; member of
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xEF
.byte 0b00000000  ; the arch thing whose name I forgot
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

;           .d88b.  db    db d88888b  .d88b.
; C8888D   .8P  88. `8b  d8' 88'     .8P  88.   C8888D
;          88  d'88  `8bd8'  88ooo   88  d'88
; C8888D   88 d' 88  .dPYb.  88~~~   88 d' 88   C8888D
;          `88  d8' .8P  Y8. 88      `88  d8'
;           `Y88P'  YP    YP YP       `Y88P'

.byte 0b00000000  ; 0xF0
.byte 0b00000000  ; equivalency
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xF1
.byte 0b00000000  ; plus/minus
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xF2
.byte 0b00000000  ; greater than or equal to
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xF3
.byte 0b00000000  ; less than or equal to
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xF4
.byte 0b00000000  ; upper integral sign
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xF5
.byte 0b00000000  ; lower integral sign
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xF6
.byte 0b00000000  ; divided by
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xF7
.byte 0b00000000  ; congruent to
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xF8
.byte 0b00000000  ; degrees symbol
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xF9
.byte 0b00000000  ; middle dot
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xFA
.byte 0b00000000  ; smaller middle dot
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xFB
.byte 0b00000000  ; check / square root
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xFC
.byte 0b00000000  ; n superscript
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xFD
.byte 0b00000000  ; 2 superscript
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b00000000  ; 0xFE
.byte 0b00000000  ; square
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000
.byte 0b00000000

.byte 0b11111111  ; 0xFF
.byte 0b11111111  ; empty
.byte 0b11111111
.byte 0b11111111
.byte 0b11111111
.byte 0b11111111
.byte 0b11111111
.byte 0b11111111
