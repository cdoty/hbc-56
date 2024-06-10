RAMStart			equ	$0200				; Ram start address
RAMSize				equ	$7D00				; Ram size, excluding space reserved for stack
VDPBase				equ	$7F10				; VDP data base port 
VDPReadBase			equ	VDPBase				; VDP control base port
WriteOffset			equ	1					; Difference between read and write ports for each base port
SystemSprites		equ	32					; Maximum system sprites
JoystickPort1		equ	$7F82				; Joystick port 1
JoystickPort2		equ	JoystickPort1 + 1	; Joystick port 2
InterruptIOPort		equ	$7FDF				; Interrupt IO port
KeyboardIOPort		equ	$7F80				; Keyboard IO port
