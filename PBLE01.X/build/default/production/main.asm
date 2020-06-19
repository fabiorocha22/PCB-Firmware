;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4520
	radix	dec
	CONFIG	MCLRE=ON
	CONFIG	OSC=HS
	CONFIG	WDT=OFF
	CONFIG	LVP=OFF
	CONFIG	DEBUG=OFF
	CONFIG	WDTPS=1


;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global	_main

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_timerWait
	extern	_timerReset
	extern	_timerInit
	extern	_lcdInit
	extern	_kpDebounce
	extern	_kpInit
	extern	_eventInit
	extern	_varInit
	extern	_getTime
	extern	_smLoop
	extern	_outputInit
	extern	_ht1380write
	extern	_rtcPutSeconds
	extern	_rtcPutMinutes
	extern	_rtcPutHours
	extern	_rtcPutDate
	extern	_rtcPutMonth
	extern	_rtcPutDay
	extern	_rtcPutYear
	extern	_rtcInit

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PRODL	equ	0xff3


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1

;--------------------------------------------------------
; interrupt vector
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_main__main	code
_main:
;	.line	17; main.c	kpInit();
	CALL	_kpInit
;	.line	18; main.c	lcdInit();
	CALL	_lcdInit
;	.line	19; main.c	timerInit();
	CALL	_timerInit
;	.line	20; main.c	varInit();
	CALL	_varInit
;	.line	21; main.c	eventInit();
	CALL	_eventInit
;	.line	22; main.c	outputInit();
	CALL	_outputInit
;	.line	23; main.c	rtcInit();
	CALL	_rtcInit
;	.line	25; main.c	ht1380write(7, 0); //liga relógio do RTC
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x07
	MOVWF	POSTDEC1
	CALL	_ht1380write
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	26; main.c	rtcPutSeconds(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_rtcPutSeconds
	MOVF	POSTINC1, F
;	.line	27; main.c	rtcPutMinutes(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_rtcPutMinutes
	MOVF	POSTINC1, F
;	.line	28; main.c	rtcPutHours(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_rtcPutHours
	MOVF	POSTINC1, F
;	.line	29; main.c	rtcPutDate(1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_rtcPutDate
	MOVF	POSTINC1, F
;	.line	30; main.c	rtcPutMonth(1);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_rtcPutMonth
	MOVF	POSTINC1, F
;	.line	31; main.c	rtcPutYear(17);
	MOVLW	0x11
	MOVWF	POSTDEC1
	CALL	_rtcPutYear
	MOVF	POSTINC1, F
;	.line	32; main.c	rtcPutDay(4);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_rtcPutDay
	MOVF	POSTINC1, F
_00106_DS_:
;	.line	35; main.c	timerReset(getTime());
	CALL	_getTime
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_timerReset
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	39; main.c	kpDebounce();
	CALL	_kpDebounce
;	.line	42; main.c	smLoop();
	CALL	_smLoop
;	.line	44; main.c	timerWait();
	CALL	_timerWait
	BRA	_00106_DS_
	RETURN	



; Statistics:
; code size:	  156 (0x009c) bytes ( 0.12%)
;           	   78 (0x004e) words
; udata size:	    0 (0x0000) bytes ( 0.00%)
; access size:	    2 (0x0002) bytes


	end
