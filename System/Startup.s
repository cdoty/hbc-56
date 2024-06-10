include "SystemDefines.inc"

ext	resetSound
ext	clearRam
ext	startupDelay
ext	setupLibrary
ext	enableExpandedRAM
ext setMode2
ext	clearVRAM
ext	setupInterrupt
ext main_

cseg

startup: public startup
	sei
	cld
	
	ldx		#$FF				; Set stack pointer
	txs

	jsr		resetSound			; Reset sound
	jsr		startupDelay		; Startup delay
;	jsr		clearRam			; Clear ram
	jsr		setupLibrary		; Setup library
	jsr		clearVRAM			; Clear VRAM
	jsr		setMode2			; Set mode 2
	
	jmp		main_
