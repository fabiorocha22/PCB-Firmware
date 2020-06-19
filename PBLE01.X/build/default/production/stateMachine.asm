;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4520
	radix	dec


;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global	_smInit
	global	_getPeriodo
	global	_smLoop
	global	_changeEvento

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_varInit
	extern	_getState
	extern	_setState
	extern	_getTime
	extern	_setTime
	extern	_getMult
	extern	_setMult
	extern	_getAlarmLevel
	extern	_setAlarmLevel
	extern	_getLanguage
	extern	_setLanguage
	extern	_getSenhaStatus
	extern	_enableSenha
	extern	_getSenha_i
	extern	_getSenha_try
	extern	_getTestResult
	extern	_setTestResult
	extern	_testSenha
	extern	_setSenha
	extern	_eventRead
	extern	_outputPrint
	extern	_rtcGetMinutes
	extern	_rtcGetHours
	extern	_rtcGetDate
	extern	_rtcGetMonth
	extern	_rtcGetYear
	extern	_rtcPutMinutes
	extern	_rtcPutHours
	extern	_rtcPutDate
	extern	_rtcPutMonth
	extern	_rtcPutYear
	extern	__mulint
	extern	__divsint
	extern	__modsint

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1

udata_stateMachine_0	udata
_senha	res	1

udata_stateMachine_1	udata
_hora	res	1

udata_stateMachine_2	udata
_min	res	1

udata_stateMachine_3	udata
_dia	res	1

udata_stateMachine_4	udata
_mes	res	1

udata_stateMachine_5	udata
_ano	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_stateMachine__smLoop	code
_smLoop:
;	.line	56; stateMachine.c	void smLoop(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
;	.line	60; stateMachine.c	evento = eventRead();
	CALL	_eventRead
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
;	.line	61; stateMachine.c	changeEvento(evento); //atribui um valor para cara evento(usado pela senha))
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_changeEvento
	MOVF	POSTINC1, F
;	.line	63; stateMachine.c	switch (getState()) {
	CALL	_getState
	MOVWF	r0x01
	MOVLW	0x22
	SUBWF	r0x01, W
	BTFSC	STATUS, 0
	GOTO	_00535_DS_
	CLRF	PCLATH
	CLRF	PCLATU
	RLCF	r0x01, W
	RLCF	PCLATH, F
	RLCF	WREG, W
	RLCF	PCLATH, F
	ANDLW	0xfc
	ADDLW	LOW(_01007_DS_)
	MOVWF	POSTDEC1
	MOVLW	HIGH(_01007_DS_)
	ADDWFC	PCLATH, F
	MOVLW	UPPER(_01007_DS_)
	ADDWFC	PCLATU, F
	MOVF	PREINC1, W
	MOVWF	PCL
_01007_DS_:
	GOTO	_00190_DS_
	GOTO	_00193_DS_
	GOTO	_00199_DS_
	GOTO	_00209_DS_
	GOTO	_00218_DS_
	GOTO	_00232_DS_
	GOTO	_00246_DS_
	GOTO	_00260_DS_
	GOTO	_00274_DS_
	GOTO	_00283_DS_
	GOTO	_00294_DS_
	GOTO	_00305_DS_
	GOTO	_00318_DS_
	GOTO	_00328_DS_
	GOTO	_00335_DS_
	GOTO	_00345_DS_
	GOTO	_00354_DS_
	GOTO	_00367_DS_
	GOTO	_00382_DS_
	GOTO	_00395_DS_
	GOTO	_00404_DS_
	GOTO	_00419_DS_
	GOTO	_00434_DS_
	GOTO	_00449_DS_
	GOTO	_00459_DS_
	GOTO	_00468_DS_
	GOTO	_00473_DS_
	GOTO	_00488_DS_
	GOTO	_00497_DS_
	GOTO	_00502_DS_
	GOTO	_00511_DS_
	GOTO	_00520_DS_
	GOTO	_00530_DS_
	GOTO	_00487_DS_
_00190_DS_:
;	.line	65; stateMachine.c	hora = rtcGetHours();
	CALL	_rtcGetHours
	BANKSEL	_hora
	MOVWF	_hora, B
;	.line	66; stateMachine.c	min = rtcGetMinutes();
	CALL	_rtcGetMinutes
	BANKSEL	_min
	MOVWF	_min, B
;	.line	67; stateMachine.c	dia = rtcGetDate();
	CALL	_rtcGetDate
	BANKSEL	_dia
	MOVWF	_dia, B
;	.line	68; stateMachine.c	mes = rtcGetMonth();
	CALL	_rtcGetMonth
	BANKSEL	_mes
	MOVWF	_mes, B
;	.line	69; stateMachine.c	ano = rtcGetYear();
	CALL	_rtcGetYear
	BANKSEL	_ano
	MOVWF	_ano, B
;	.line	71; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01009_DS_
	GOTO	_00535_DS_
_01009_DS_:
;	.line	72; stateMachine.c	setState(SECURITY_CONFIG);
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	75; stateMachine.c	break;
	GOTO	_00535_DS_
_00193_DS_:
;	.line	82; stateMachine.c	if(getSenha_try() == 3){
	CALL	_getSenha_try
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	r0x01, W
	XORLW	0x03
	BNZ	_01010_DS_
	MOVF	r0x02, W
	BZ	_01011_DS_
_01010_DS_:
	BRA	_00195_DS_
_01011_DS_:
;	.line	83; stateMachine.c	setState(STATE_OP);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00195_DS_:
;	.line	85; stateMachine.c	if (!getSenhaStatus() || testSenha(senha) == 1) {
	CALL	_getSenhaStatus
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	r0x01, W
	IORWF	r0x02, W
	BZ	_00196_DS_
	BANKSEL	_senha
	MOVF	_senha, W, B
	MOVWF	POSTDEC1
	CALL	_testSenha
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	r0x01, W
	XORLW	0x01
	BNZ	_01012_DS_
	MOVF	r0x02, W
	BZ	_00196_DS_
_01012_DS_:
	GOTO	_00535_DS_
_00196_DS_:
;	.line	86; stateMachine.c	outputPrint(getState(), getLanguage());
	CALL	_getState
	MOVWF	r0x01
	CLRF	r0x02
	CALL	_getLanguage
	MOVWF	r0x03
	CLRF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_outputPrint
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	87; stateMachine.c	setState(STATE_ALARME);    
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	90; stateMachine.c	break;    
	GOTO	_00535_DS_
_00199_DS_:
;	.line	94; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00201_DS_
;	.line	95; stateMachine.c	setState(CONFIG_ALARME);
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00201_DS_:
;	.line	97; stateMachine.c	if (evento == EV_LEFT || evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00202_DS_
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00203_DS_
_00202_DS_:
;	.line	98; stateMachine.c	setState(STATE_OP);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00203_DS_:
;	.line	100; stateMachine.c	if (evento == EV_DOWN) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00206_DS_
;	.line	101; stateMachine.c	setState(STATE_IDIOMA);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00206_DS_:
;	.line	103; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BTFSS	STATUS, 2
	GOTO	_00535_DS_
;	.line	104; stateMachine.c	setState(STATE_RESET);
	MOVLW	0x1f
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	106; stateMachine.c	break;       
	GOTO	_00535_DS_
_00209_DS_:
;	.line	110; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00211_DS_
;	.line	111; stateMachine.c	setState(ALARME_ALTO_DEC);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00211_DS_:
;	.line	113; stateMachine.c	if (evento == EV_LEFT || evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00212_DS_
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00213_DS_
_00212_DS_:
;	.line	114; stateMachine.c	setState(STATE_ALARME);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00213_DS_:
;	.line	116; stateMachine.c	if (evento == EV_DOWN || evento == EV_UP) {
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_00215_DS_
	MOVF	r0x00, W
	BTFSS	STATUS, 2
	GOTO	_00535_DS_
_00215_DS_:
;	.line	117; stateMachine.c	setState(STATE_TEMPO);
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	119; stateMachine.c	break;
	GOTO	_00535_DS_
_00218_DS_:
;	.line	123; stateMachine.c	if (evento == EV_UP && getAlarmLevel(2)<=90) {
	MOVF	r0x00, W
	BNZ	_00220_DS_
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_01030_DS_
	MOVLW	0x5b
	SUBWF	r0x01, W
_01030_DS_:
	BC	_00220_DS_
;	.line	124; stateMachine.c	setAlarmLevel(getAlarmLevel(2) + 10, 2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVLW	0x0a
	ADDWF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setAlarmLevel
	MOVLW	0x04
	ADDWF	FSR1L, F
_00220_DS_:
;	.line	126; stateMachine.c	if (evento == EV_DOWN && getAlarmLevel(2)>=10  && (getAlarmLevel(1)+10) < getAlarmLevel(2)) {
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_01032_DS_
	BRA	_00223_DS_
_01032_DS_:
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_01033_DS_
	MOVLW	0x0a
	SUBWF	r0x01, W
_01033_DS_:
	BTFSS	STATUS, 0
	BRA	_00223_DS_
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVLW	0x0a
	ADDWF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x04, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_01034_DS_
	MOVF	r0x03, W
	SUBWF	r0x01, W
_01034_DS_:
	BC	_00223_DS_
;	.line	127; stateMachine.c	setAlarmLevel(getAlarmLevel(2) - 10, 2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVLW	0xf6
	ADDWF	r0x01, F
	BTFSS	STATUS, 0
	DECF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setAlarmLevel
	MOVLW	0x04
	ADDWF	FSR1L, F
_00223_DS_:
;	.line	130; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00227_DS_
;	.line	131; stateMachine.c	setState(ALARME_ALTO_UNI);
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00227_DS_:
;	.line	134; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00229_DS_
;	.line	135; stateMachine.c	setState(ALARME_BAIXO_UNI);
	MOVLW	0x07
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00229_DS_:
;	.line	137; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01040_DS_
	GOTO	_00535_DS_
_01040_DS_:
;	.line	138; stateMachine.c	setState(CONFIG_ALARME);
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	140; stateMachine.c	break;
	GOTO	_00535_DS_
_00232_DS_:
;	.line	144; stateMachine.c	if (evento == EV_UP && getAlarmLevel(2)<100) {
	MOVF	r0x00, W
	BNZ	_00234_DS_
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_01041_DS_
	MOVLW	0x64
	SUBWF	r0x01, W
_01041_DS_:
	BC	_00234_DS_
;	.line	145; stateMachine.c	setAlarmLevel(getAlarmLevel(2) + 1, 2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setAlarmLevel
	MOVLW	0x04
	ADDWF	FSR1L, F
_00234_DS_:
;	.line	147; stateMachine.c	if (evento == EV_DOWN && getAlarmLevel(2)>0 && getAlarmLevel(1)<getAlarmLevel(2)) {
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_01043_DS_
	BRA	_00237_DS_
_01043_DS_:
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_01044_DS_
	MOVLW	0x01
	SUBWF	r0x01, W
_01044_DS_:
	BNC	_00237_DS_
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x04, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_01045_DS_
	MOVF	r0x03, W
	SUBWF	r0x01, W
_01045_DS_:
	BC	_00237_DS_
;	.line	148; stateMachine.c	setAlarmLevel(getAlarmLevel(2) - 1, 2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setAlarmLevel
	MOVLW	0x04
	ADDWF	FSR1L, F
_00237_DS_:
;	.line	151; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00241_DS_
;	.line	152; stateMachine.c	setState(ALARME_BAIXO_DEC);
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00241_DS_:
;	.line	154; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00243_DS_
;	.line	155; stateMachine.c	setState(ALARME_ALTO_DEC);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00243_DS_:
;	.line	157; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01051_DS_
	GOTO	_00535_DS_
_01051_DS_:
;	.line	158; stateMachine.c	setState(CONFIG_ALARME);
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	160; stateMachine.c	break;
	GOTO	_00535_DS_
_00246_DS_:
;	.line	164; stateMachine.c	if (evento == EV_UP && getAlarmLevel(1)<=90 && getAlarmLevel(1) <(getAlarmLevel(2)-10)) {
	MOVF	r0x00, W
	BTFSS	STATUS, 2
	BRA	_00248_DS_
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_01052_DS_
	MOVLW	0x5b
	SUBWF	r0x01, W
_01052_DS_:
	BTFSC	STATUS, 0
	BRA	_00248_DS_
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVLW	0xf6
	ADDWF	r0x03, F
	BTFSS	STATUS, 0
	DECF	r0x04, F
	MOVF	r0x02, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x04, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_01053_DS_
	MOVF	r0x03, W
	SUBWF	r0x01, W
_01053_DS_:
	BC	_00248_DS_
;	.line	165; stateMachine.c	setAlarmLevel(getAlarmLevel(1) + 10, 1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVLW	0x0a
	ADDWF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setAlarmLevel
	MOVLW	0x04
	ADDWF	FSR1L, F
_00248_DS_:
;	.line	167; stateMachine.c	if (evento == EV_DOWN && getAlarmLevel(1)>=10) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00252_DS_
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_01056_DS_
	MOVLW	0x0a
	SUBWF	r0x01, W
_01056_DS_:
	BNC	_00252_DS_
;	.line	168; stateMachine.c	setAlarmLevel(getAlarmLevel(1) - 10, 1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVLW	0xf6
	ADDWF	r0x01, F
	BTFSS	STATUS, 0
	DECF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setAlarmLevel
	MOVLW	0x04
	ADDWF	FSR1L, F
_00252_DS_:
;	.line	171; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00255_DS_
;	.line	172; stateMachine.c	setState(ALARME_BAIXO_UNI);
	MOVLW	0x07
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00255_DS_:
;	.line	174; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00257_DS_
;	.line	175; stateMachine.c	setState(ALARME_ALTO_UNI);
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00257_DS_:
;	.line	177; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01062_DS_
	GOTO	_00535_DS_
_01062_DS_:
;	.line	178; stateMachine.c	setState(CONFIG_ALARME);
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	180; stateMachine.c	break;
	GOTO	_00535_DS_
_00260_DS_:
;	.line	184; stateMachine.c	if (evento == EV_UP && getAlarmLevel(1)<100 && getAlarmLevel(1) <getAlarmLevel(2)) {
	MOVF	r0x00, W
	BTFSS	STATUS, 2
	BRA	_00262_DS_
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_01063_DS_
	MOVLW	0x64
	SUBWF	r0x01, W
_01063_DS_:
	BC	_00262_DS_
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x03
	MOVFF	PRODL, r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	MOVWF	PRODL
	MOVF	r0x04, W
	ADDLW	0x80
	SUBWF	PRODL, W
	BNZ	_01064_DS_
	MOVF	r0x03, W
	SUBWF	r0x01, W
_01064_DS_:
	BC	_00262_DS_
;	.line	185; stateMachine.c	setAlarmLevel(getAlarmLevel(1) + 1, 1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setAlarmLevel
	MOVLW	0x04
	ADDWF	FSR1L, F
_00262_DS_:
;	.line	187; stateMachine.c	if (evento == EV_DOWN && getAlarmLevel(1)>0) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00266_DS_
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_01067_DS_
	MOVLW	0x01
	SUBWF	r0x01, W
_01067_DS_:
	BNC	_00266_DS_
;	.line	188; stateMachine.c	setAlarmLevel(getAlarmLevel(1) - 1, 1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setAlarmLevel
	MOVLW	0x04
	ADDWF	FSR1L, F
_00266_DS_:
;	.line	191; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00269_DS_
;	.line	192; stateMachine.c	setState(ALARME_ALTO_DEC);
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00269_DS_:
;	.line	194; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00271_DS_
;	.line	195; stateMachine.c	setState(ALARME_BAIXO_DEC);
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00271_DS_:
;	.line	197; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01073_DS_
	GOTO	_00535_DS_
_01073_DS_:
;	.line	198; stateMachine.c	setState(CONFIG_ALARME);
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	200; stateMachine.c	break;            
	GOTO	_00535_DS_
_00274_DS_:
;	.line	204; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00276_DS_
;	.line	205; stateMachine.c	setState(CONFIG_TEMPO_DEC);
	MOVLW	0x09
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00276_DS_:
;	.line	207; stateMachine.c	if (evento == EV_LEFT || evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00277_DS_
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00278_DS_
_00277_DS_:
;	.line	208; stateMachine.c	setState(STATE_ALARME);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00278_DS_:
;	.line	210; stateMachine.c	if (evento == EV_DOWN || evento == EV_UP) {
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_00280_DS_
	MOVF	r0x00, W
	BTFSS	STATUS, 2
	GOTO	_00535_DS_
_00280_DS_:
;	.line	211; stateMachine.c	setState(CONFIG_ALARME);
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	213; stateMachine.c	break;
	GOTO	_00535_DS_
_00283_DS_:
;	.line	216; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BNZ	_00285_DS_
;	.line	217; stateMachine.c	setTime(getTime() + 10);
	CALL	_getTime
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x0a
	ADDWF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setTime
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00285_DS_:
;	.line	219; stateMachine.c	if (evento == EV_DOWN) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00287_DS_
;	.line	220; stateMachine.c	setTime(getTime() - 10);
	CALL	_getTime
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0xf6
	ADDWF	r0x01, F
	BTFSS	STATUS, 0
	DECF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setTime
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00287_DS_:
;	.line	223; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00289_DS_
;	.line	224; stateMachine.c	setState(CONFIG_TEMPO_UNI);
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00289_DS_:
;	.line	226; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00291_DS_
;	.line	227; stateMachine.c	setState(CONFIG_TEMPO_MULT);
	MOVLW	0x0b
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00291_DS_:
;	.line	229; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01089_DS_
	GOTO	_00535_DS_
_01089_DS_:
;	.line	230; stateMachine.c	setState(STATE_TEMPO);
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	232; stateMachine.c	break;
	GOTO	_00535_DS_
_00294_DS_:
;	.line	236; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BNZ	_00296_DS_
;	.line	237; stateMachine.c	setTime(getTime() + 1);
	CALL	_getTime
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setTime
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00296_DS_:
;	.line	239; stateMachine.c	if (evento == EV_DOWN) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00298_DS_
;	.line	240; stateMachine.c	setTime(getTime() - 1);
	CALL	_getTime
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setTime
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00298_DS_:
;	.line	243; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00300_DS_
;	.line	244; stateMachine.c	setState(CONFIG_TEMPO_MULT);
	MOVLW	0x0b
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00300_DS_:
;	.line	246; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00302_DS_
;	.line	247; stateMachine.c	setState(CONFIG_TEMPO_DEC);
	MOVLW	0x09
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00302_DS_:
;	.line	249; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01097_DS_
	GOTO	_00535_DS_
_01097_DS_:
;	.line	250; stateMachine.c	setState(STATE_TEMPO);
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	252; stateMachine.c	break;
	GOTO	_00535_DS_
_00305_DS_:
;	.line	256; stateMachine.c	if (evento == EV_UP && getMult() <= 10000) {
	MOVF	r0x00, W
	BNZ	_00307_DS_
	CALL	_getMult
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x59
	BNZ	_01098_DS_
	MOVLW	0x11
	SUBWF	r0x01, W
_01098_DS_:
	BC	_00307_DS_
;	.line	257; stateMachine.c	setMult(getMult()*10); //criar funções de get e set do multiplicador
	CALL	_getMult
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setMult
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00307_DS_:
;	.line	259; stateMachine.c	if (evento == EV_DOWN && getMult() >= 0) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00310_DS_
	CALL	_getMult
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	BSF	STATUS, 0
	BTFSS	r0x02, 7
	BCF	STATUS, 0
	BC	_00310_DS_
;	.line	260; stateMachine.c	setMult(getMult()/10);
	CALL	_getMult
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0a
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setMult
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00310_DS_:
;	.line	263; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00313_DS_
;	.line	264; stateMachine.c	setState(CONFIG_TEMPO_DEC);
	MOVLW	0x09
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00313_DS_:
;	.line	266; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00315_DS_
;	.line	267; stateMachine.c	setState(CONFIG_TEMPO_UNI);
	MOVLW	0x0a
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00315_DS_:
;	.line	269; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01106_DS_
	GOTO	_00535_DS_
_01106_DS_:
;	.line	270; stateMachine.c	setState(STATE_TEMPO);
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	272; stateMachine.c	break;
	GOTO	_00535_DS_
_00318_DS_:
;	.line	276; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BNZ	_00320_DS_
;	.line	277; stateMachine.c	setState(STATE_ALARME);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00320_DS_:
;	.line	279; stateMachine.c	if (evento == EV_DOWN) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00322_DS_
;	.line	280; stateMachine.c	setState(STATE_PERIODO);
	MOVLW	0x0e
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00322_DS_:
;	.line	282; stateMachine.c	if (evento == EV_RIGHT || evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x03
	BZ	_00323_DS_
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00324_DS_
_00323_DS_:
;	.line	283; stateMachine.c	setState(STATE_OP);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00324_DS_:
;	.line	285; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01114_DS_
	GOTO	_00535_DS_
_01114_DS_:
;	.line	286; stateMachine.c	setState(CONFIG_IDIOMA);
	MOVLW	0x0d
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	288; stateMachine.c	break;
	GOTO	_00535_DS_
_00328_DS_:
;	.line	292; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BNZ	_00330_DS_
;	.line	293; stateMachine.c	setLanguage(getLanguage() + 1);
	CALL	_getLanguage
	MOVWF	r0x01
	INCF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setLanguage
	MOVF	POSTINC1, F
_00330_DS_:
;	.line	295; stateMachine.c	if (evento == EV_DOWN) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00332_DS_
;	.line	296; stateMachine.c	setLanguage(getLanguage() - 1);
	CALL	_getLanguage
	MOVWF	r0x01
	DECF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_setLanguage
	MOVF	POSTINC1, F
_00332_DS_:
;	.line	299; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01118_DS_
	GOTO	_00535_DS_
_01118_DS_:
;	.line	300; stateMachine.c	setState(STATE_IDIOMA);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	302; stateMachine.c	break;
	GOTO	_00535_DS_
_00335_DS_:
;	.line	306; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BNZ	_00337_DS_
;	.line	307; stateMachine.c	setState(STATE_IDIOMA);
	MOVLW	0x0c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00337_DS_:
;	.line	309; stateMachine.c	if (evento == EV_DOWN) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00339_DS_
;	.line	310; stateMachine.c	setState(STATE_SECURITY);
	MOVLW	0x17
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00339_DS_:
;	.line	312; stateMachine.c	if (evento == EV_RIGHT || evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x03
	BZ	_00340_DS_
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00341_DS_
_00340_DS_:
;	.line	313; stateMachine.c	setState(STATE_OP);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00341_DS_:
;	.line	315; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01126_DS_
	GOTO	_00535_DS_
_01126_DS_:
;	.line	316; stateMachine.c	setState(STATE_DATA);
	MOVLW	0x0f
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	318; stateMachine.c	break;
	GOTO	_00535_DS_
_00345_DS_:
;	.line	322; stateMachine.c	if (evento == EV_UP || evento == EV_DOWN) {
	MOVF	r0x00, W
	BZ	_00346_DS_
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00347_DS_
_00346_DS_:
;	.line	323; stateMachine.c	setState(STATE_HORA);
	MOVLW	0x13
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00347_DS_:
;	.line	325; stateMachine.c	if (evento == EV_LEFT || evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00349_DS_
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00350_DS_
_00349_DS_:
;	.line	326; stateMachine.c	setState(STATE_PERIODO);
	MOVLW	0x0e
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00350_DS_:
;	.line	328; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01134_DS_
	GOTO	_00535_DS_
_01134_DS_:
;	.line	329; stateMachine.c	setState(CONFIG_DATA_D);
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	331; stateMachine.c	break;
	GOTO	_00535_DS_
_00354_DS_:
;	.line	335; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BNZ	_00356_DS_
;	.line	336; stateMachine.c	dia = (dia +1)%31;
	MOVFF	_dia, r0x01
	CLRF	r0x02
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x1f
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	BANKSEL	_dia
	MOVWF	_dia, B
_00356_DS_:
;	.line	338; stateMachine.c	if (evento == EV_DOWN) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00360_DS_
;	.line	339; stateMachine.c	dia = (dia -1)%32;
	MOVFF	_dia, r0x01
	CLRF	r0x02
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	BANKSEL	_dia
	MOVWF	_dia, B
	BANKSEL	_dia
;	.line	340; stateMachine.c	if(dia == 0){
	MOVF	_dia, W, B
	BNZ	_00360_DS_
;	.line	341; stateMachine.c	dia = 31;
	MOVLW	0x1f
	BANKSEL	_dia
	MOVWF	_dia, B
_00360_DS_:
;	.line	345; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00362_DS_
_01138_DS_:
	BANKSEL	_dia
;	.line	346; stateMachine.c	rtcPutDate(dia);
	MOVF	_dia, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutDate
	MOVF	POSTINC1, F
;	.line	347; stateMachine.c	setState(CONFIG_DATA_M);
	MOVLW	0x11
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00362_DS_:
;	.line	349; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00364_DS_
_01140_DS_:
	BANKSEL	_dia
;	.line	350; stateMachine.c	rtcPutDate(dia);
	MOVF	_dia, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutDate
	MOVF	POSTINC1, F
;	.line	351; stateMachine.c	setState(CONFIG_DATA_A);
	MOVLW	0x12
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00364_DS_:
;	.line	353; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01142_DS_
	GOTO	_00535_DS_
_01142_DS_:
	BANKSEL	_dia
;	.line	354; stateMachine.c	rtcPutDate(dia);
	MOVF	_dia, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutDate
	MOVF	POSTINC1, F
;	.line	355; stateMachine.c	setState(STATE_DATA);
	MOVLW	0x0f
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	357; stateMachine.c	break;
	GOTO	_00535_DS_
_00367_DS_:
;	.line	361; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BNZ	_00371_DS_
;	.line	362; stateMachine.c	mes = (mes+1)%13;
	MOVFF	_mes, r0x01
	CLRF	r0x02
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0d
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	BANKSEL	_mes
	MOVWF	_mes, B
	BANKSEL	_mes
;	.line	363; stateMachine.c	if(mes==0){
	MOVF	_mes, W, B
	BNZ	_00371_DS_
;	.line	364; stateMachine.c	mes=1;
	MOVLW	0x01
	BANKSEL	_mes
	MOVWF	_mes, B
_00371_DS_:
;	.line	367; stateMachine.c	if (evento == EV_DOWN) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00375_DS_
;	.line	368; stateMachine.c	mes = (mes-1)%13;
	MOVFF	_mes, r0x01
	CLRF	r0x02
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x0d
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	BANKSEL	_mes
	MOVWF	_mes, B
	BANKSEL	_mes
;	.line	369; stateMachine.c	if(mes == 0){
	MOVF	_mes, W, B
	BNZ	_00375_DS_
;	.line	370; stateMachine.c	mes=12;
	MOVLW	0x0c
	BANKSEL	_mes
	MOVWF	_mes, B
_00375_DS_:
;	.line	375; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00377_DS_
_01146_DS_:
	BANKSEL	_mes
;	.line	376; stateMachine.c	rtcPutMonth(mes);
	MOVF	_mes, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutMonth
	MOVF	POSTINC1, F
;	.line	377; stateMachine.c	setState(CONFIG_DATA_A);
	MOVLW	0x12
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00377_DS_:
;	.line	379; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00379_DS_
_01148_DS_:
	BANKSEL	_mes
;	.line	380; stateMachine.c	rtcPutMonth(mes);
	MOVF	_mes, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutMonth
	MOVF	POSTINC1, F
;	.line	381; stateMachine.c	setState(CONFIG_DATA_D);
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00379_DS_:
;	.line	383; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01150_DS_
	GOTO	_00535_DS_
_01150_DS_:
	BANKSEL	_mes
;	.line	384; stateMachine.c	rtcPutMonth(mes);
	MOVF	_mes, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutMonth
	MOVF	POSTINC1, F
;	.line	385; stateMachine.c	setState(STATE_DATA);
	MOVLW	0x0f
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	387; stateMachine.c	break;    
	GOTO	_00535_DS_
_00382_DS_:
;	.line	391; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BNZ	_00384_DS_
;	.line	392; stateMachine.c	ano = (ano+1)%100;
	MOVFF	_ano, r0x01
	CLRF	r0x02
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	BANKSEL	_ano
	MOVWF	_ano, B
_00384_DS_:
;	.line	395; stateMachine.c	if (evento == EV_DOWN) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00388_DS_
;	.line	396; stateMachine.c	ano = (ano-1)%100;
	MOVFF	_ano, r0x01
	CLRF	r0x02
	MOVLW	0xff
	ADDWF	r0x01, F
	ADDWFC	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x64
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	BANKSEL	_ano
	MOVWF	_ano, B
	BANKSEL	_ano
;	.line	397; stateMachine.c	if(ano == 255){
	MOVF	_ano, W, B
	XORLW	0xff
	BNZ	_00388_DS_
;	.line	398; stateMachine.c	ano = 99;
	MOVLW	0x63
	BANKSEL	_ano
	MOVWF	_ano, B
_00388_DS_:
;	.line	402; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00390_DS_
_01156_DS_:
	BANKSEL	_ano
;	.line	403; stateMachine.c	rtcPutYear(ano);
	MOVF	_ano, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutYear
	MOVF	POSTINC1, F
;	.line	404; stateMachine.c	setState(CONFIG_DATA_D);
	MOVLW	0x10
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00390_DS_:
;	.line	406; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00392_DS_
_01158_DS_:
	BANKSEL	_ano
;	.line	407; stateMachine.c	rtcPutYear(ano);
	MOVF	_ano, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutYear
	MOVF	POSTINC1, F
;	.line	408; stateMachine.c	setState(CONFIG_DATA_M);
	MOVLW	0x11
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00392_DS_:
;	.line	410; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01160_DS_
	GOTO	_00535_DS_
_01160_DS_:
	BANKSEL	_ano
;	.line	411; stateMachine.c	rtcPutYear(ano);
	MOVF	_ano, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutYear
	MOVF	POSTINC1, F
;	.line	412; stateMachine.c	setState(STATE_DATA);
	MOVLW	0x0f
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	414; stateMachine.c	break;
	GOTO	_00535_DS_
_00395_DS_:
;	.line	419; stateMachine.c	if (evento == EV_UP || evento == EV_DOWN) {
	MOVF	r0x00, W
	BZ	_00396_DS_
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00397_DS_
_00396_DS_:
;	.line	420; stateMachine.c	setState(STATE_DATA);
	MOVLW	0x0f
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00397_DS_:
;	.line	423; stateMachine.c	if (evento == EV_RIGHT || evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x03
	BZ	_00399_DS_
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00400_DS_
_00399_DS_:
;	.line	424; stateMachine.c	setState(STATE_PERIODO);
	MOVLW	0x0e
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00400_DS_:
;	.line	427; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01168_DS_
	GOTO	_00535_DS_
_01168_DS_:
;	.line	428; stateMachine.c	setState(CONFIG_HORA);
	MOVLW	0x14
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	430; stateMachine.c	break;
	GOTO	_00535_DS_
_00404_DS_:
;	.line	434; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BNZ	_00406_DS_
;	.line	435; stateMachine.c	hora = (hora + 1)%24;
	MOVFF	_hora, r0x01
	CLRF	r0x02
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x18
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	BANKSEL	_hora
	MOVWF	_hora, B
_00406_DS_:
;	.line	437; stateMachine.c	if (evento == EV_DOWN && hora !=0) {
	CLRF	r0x01
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_01170_DS_
	INCF	r0x01, F
_01170_DS_:
	MOVF	r0x01, W
	BZ	_00408_DS_
	BANKSEL	_hora
	MOVF	_hora, W, B
	BZ	_00408_DS_
;	.line	438; stateMachine.c	hora = (hora - 1)%24;
	MOVFF	_hora, r0x02
	CLRF	r0x03
	MOVLW	0xff
	ADDWF	r0x02, F
	ADDWFC	r0x03, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x18
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	BANKSEL	_hora
	MOVWF	_hora, B
_00408_DS_:
;	.line	441; stateMachine.c	if (evento == EV_DOWN && hora == 0) {
	MOVF	r0x01, W
	BZ	_00411_DS_
	BANKSEL	_hora
	MOVF	_hora, W, B
	BNZ	_00411_DS_
;	.line	442; stateMachine.c	hora = 23;
	MOVLW	0x17
	BANKSEL	_hora
	MOVWF	_hora, B
_00411_DS_:
;	.line	446; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00414_DS_
_01172_DS_:
	BANKSEL	_hora
;	.line	447; stateMachine.c	rtcPutHours(hora);
	MOVF	_hora, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutHours
	MOVF	POSTINC1, F
;	.line	448; stateMachine.c	setState(CONFIG_MINUTOS_DEC);
	MOVLW	0x15
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00414_DS_:
;	.line	450; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00416_DS_
_01174_DS_:
	BANKSEL	_hora
;	.line	451; stateMachine.c	rtcPutHours(hora);
	MOVF	_hora, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutHours
	MOVF	POSTINC1, F
;	.line	452; stateMachine.c	setState(CONFIG_MINUTOS_UNI);
	MOVLW	0x16
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00416_DS_:
;	.line	454; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01176_DS_
	GOTO	_00535_DS_
_01176_DS_:
	BANKSEL	_hora
;	.line	455; stateMachine.c	rtcPutHours(hora);                
	MOVF	_hora, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutHours
	MOVF	POSTINC1, F
;	.line	456; stateMachine.c	setState(STATE_HORA);
	MOVLW	0x13
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	458; stateMachine.c	break;
	GOTO	_00535_DS_
_00419_DS_:
;	.line	463; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BNZ	_00421_DS_
;	.line	464; stateMachine.c	min = (min+10)%60;
	MOVFF	_min, r0x01
	CLRF	r0x02
	MOVLW	0x0a
	ADDWF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	BANKSEL	_min
	MOVWF	_min, B
_00421_DS_:
;	.line	466; stateMachine.c	if (evento == EV_DOWN && min>=10) {
	CLRF	r0x01
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_01178_DS_
	INCF	r0x01, F
_01178_DS_:
	MOVF	r0x01, W
	BZ	_00423_DS_
	MOVLW	0x0a
	BANKSEL	_min
	SUBWF	_min, W, B
	BNC	_00423_DS_
;	.line	467; stateMachine.c	min = (min-10)%60;
	MOVFF	_min, r0x02
	CLRF	r0x03
	MOVLW	0xf6
	ADDWF	r0x02, F
	BTFSS	STATUS, 0
	DECF	r0x03, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	BANKSEL	_min
	MOVWF	_min, B
_00423_DS_:
;	.line	469; stateMachine.c	if (evento == EV_DOWN && min == 0){
	MOVF	r0x01, W
	BZ	_00426_DS_
	BANKSEL	_min
	MOVF	_min, W, B
	BNZ	_00426_DS_
;	.line	470; stateMachine.c	min = 50;
	MOVLW	0x32
	BANKSEL	_min
	MOVWF	_min, B
_00426_DS_:
;	.line	474; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00429_DS_
_01181_DS_:
	BANKSEL	_min
;	.line	475; stateMachine.c	rtcPutMinutes(min);
	MOVF	_min, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutMinutes
	MOVF	POSTINC1, F
;	.line	476; stateMachine.c	setState(CONFIG_MINUTOS_UNI);
	MOVLW	0x16
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00429_DS_:
;	.line	478; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00431_DS_
_01183_DS_:
	BANKSEL	_min
;	.line	479; stateMachine.c	rtcPutMinutes(min);
	MOVF	_min, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutMinutes
	MOVF	POSTINC1, F
;	.line	480; stateMachine.c	setState(CONFIG_HORA);
	MOVLW	0x14
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00431_DS_:
;	.line	482; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01185_DS_
	GOTO	_00535_DS_
_01185_DS_:
	BANKSEL	_min
;	.line	483; stateMachine.c	rtcPutMinutes(min);
	MOVF	_min, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutMinutes
	MOVF	POSTINC1, F
;	.line	484; stateMachine.c	setState(STATE_HORA);
	MOVLW	0x13
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	486; stateMachine.c	break;
	GOTO	_00535_DS_
_00434_DS_:
;	.line	490; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BNZ	_00436_DS_
;	.line	491; stateMachine.c	min = (min+1)%60;
	MOVFF	_min, r0x01
	CLRF	r0x02
	INFSNZ	r0x01, F
	INCF	r0x02, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	BANKSEL	_min
	MOVWF	_min, B
_00436_DS_:
;	.line	493; stateMachine.c	if (evento == EV_DOWN && min>=1) {
	CLRF	r0x01
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_01187_DS_
	INCF	r0x01, F
_01187_DS_:
	MOVF	r0x01, W
	BZ	_00438_DS_
	MOVLW	0x01
	BANKSEL	_min
	SUBWF	_min, W, B
	BNC	_00438_DS_
;	.line	494; stateMachine.c	min = (min-1)%60;
	MOVFF	_min, r0x02
	CLRF	r0x03
	MOVLW	0xff
	ADDWF	r0x02, F
	ADDWFC	r0x03, F
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x3c
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	CALL	__modsint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	BANKSEL	_min
	MOVWF	_min, B
_00438_DS_:
;	.line	496; stateMachine.c	if (evento == EV_DOWN && min == 0){
	MOVF	r0x01, W
	BZ	_00441_DS_
	BANKSEL	_min
	MOVF	_min, W, B
	BNZ	_00441_DS_
;	.line	497; stateMachine.c	min = 59;
	MOVLW	0x3b
	BANKSEL	_min
	MOVWF	_min, B
_00441_DS_:
;	.line	500; stateMachine.c	if (evento == EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00444_DS_
_01190_DS_:
	BANKSEL	_min
;	.line	501; stateMachine.c	rtcPutMinutes(min);
	MOVF	_min, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutMinutes
	MOVF	POSTINC1, F
;	.line	502; stateMachine.c	setState(CONFIG_HORA);
	MOVLW	0x14
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00444_DS_:
;	.line	504; stateMachine.c	if (evento == EV_LEFT) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00446_DS_
_01192_DS_:
	BANKSEL	_min
;	.line	505; stateMachine.c	rtcPutMinutes(min);
	MOVF	_min, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutMinutes
	MOVF	POSTINC1, F
;	.line	506; stateMachine.c	setState(CONFIG_MINUTOS_DEC);
	MOVLW	0x15
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00446_DS_:
;	.line	508; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_01194_DS_
	BRA	_00535_DS_
_01194_DS_:
	BANKSEL	_min
;	.line	509; stateMachine.c	rtcPutMinutes(min);
	MOVF	_min, W, B
	MOVWF	POSTDEC1
	CALL	_rtcPutMinutes
	MOVF	POSTINC1, F
;	.line	510; stateMachine.c	setState(STATE_HORA);
	MOVLW	0x13
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	512; stateMachine.c	break;
	BRA	_00535_DS_
_00449_DS_:
;	.line	516; stateMachine.c	if (evento == EV_UP) {
	MOVF	r0x00, W
	BNZ	_00451_DS_
;	.line	517; stateMachine.c	setState(STATE_PERIODO);
	MOVLW	0x0e
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00451_DS_:
;	.line	519; stateMachine.c	if (evento == EV_DOWN) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00453_DS_
;	.line	520; stateMachine.c	setState(STATE_RESET);
	MOVLW	0x1f
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00453_DS_:
;	.line	522; stateMachine.c	if (evento == EV_ENTER) {
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00455_DS_
;	.line	523; stateMachine.c	setState(CONFIG_SENHA);
	MOVLW	0x18
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00455_DS_:
;	.line	525; stateMachine.c	if (evento == EV_LEFT || evento ==  EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00456_DS_
	MOVF	r0x00, W
	XORLW	0x03
	BZ	_00456_DS_
	BRA	_00535_DS_
_00456_DS_:
;	.line	526; stateMachine.c	setState(STATE_OP);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	528; stateMachine.c	break;
	BRA	_00535_DS_
_00459_DS_:
;	.line	532; stateMachine.c	if (evento == EV_UP || evento == EV_DOWN) {
	MOVF	r0x00, W
	BZ	_00460_DS_
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00461_DS_
_00460_DS_:
;	.line	533; stateMachine.c	setState(CONFIG_HABILITA);
	MOVLW	0x1b
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00461_DS_:
;	.line	535; stateMachine.c	if (evento == EV_ENTER){
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00464_DS_
;	.line	536; stateMachine.c	setState(SECURITY_SENHA);                
	MOVLW	0x19
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00464_DS_:
;	.line	538; stateMachine.c	if (evento == EV_LEFT || evento ==  EV_RIGHT) {
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00465_DS_
	MOVF	r0x00, W
	XORLW	0x03
	BZ	_00465_DS_
	BRA	_00535_DS_
_00465_DS_:
;	.line	539; stateMachine.c	setState(STATE_SECURITY);
	MOVLW	0x17
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	541; stateMachine.c	break;
	BRA	_00535_DS_
_00468_DS_:
;	.line	547; stateMachine.c	if(getSenha_try() ==  3){
	CALL	_getSenha_try
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	r0x01, W
	XORLW	0x03
	BNZ	_01211_DS_
	MOVF	r0x02, W
	BZ	_01212_DS_
_01211_DS_:
	BRA	_00470_DS_
_01212_DS_:
;	.line	548; stateMachine.c	setState(CONFIG_SENHA);
	MOVLW	0x18
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00470_DS_:
	BANKSEL	_senha
;	.line	550; stateMachine.c	if (testSenha(senha) == 1){
	MOVF	_senha, W, B
	MOVWF	POSTDEC1
	CALL	_testSenha
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	r0x01, W
	XORLW	0x01
	BNZ	_01213_DS_
	MOVF	r0x02, W
	BZ	_01214_DS_
_01213_DS_:
	BRA	_00535_DS_
_01214_DS_:
;	.line	551; stateMachine.c	setState(NOVA_SENHA);
	MOVLW	0x1a
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	552; stateMachine.c	setTestResult(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setTestResult
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	555; stateMachine.c	break;
	BRA	_00535_DS_
_00473_DS_:
;	.line	559; stateMachine.c	if ((evento == EV_UP || evento == EV_DOWN || evento == EV_RIGHT || evento == EV_LEFT || evento == EV_ENTER)  && !getTestResult()) {
	MOVF	r0x00, W
	BZ	_00486_DS_
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_00486_DS_
	MOVF	r0x00, W
	XORLW	0x03
	BZ	_00486_DS_
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00486_DS_
	MOVF	r0x00, W
	XORLW	0x04
	BZ	_00486_DS_
	BRA	_00535_DS_
_00486_DS_:
	CALL	_getTestResult
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	r0x01, W
	IORWF	r0x02, W
	BTFSS	STATUS, 2
	BRA	_00535_DS_
	BANKSEL	_senha
;	.line	560; stateMachine.c	if(setSenha(senha) != 0 || getSenha_i()==5){
	MOVF	_senha, W, B
	MOVWF	POSTDEC1
	CALL	_setSenha
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	r0x01, W
	IORWF	r0x02, W
	BNZ	_00477_DS_
	CALL	_getSenha_i
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	r0x01, W
	XORLW	0x05
	BNZ	_01223_DS_
	MOVF	r0x02, W
	BZ	_00477_DS_
_01223_DS_:
	BRA	_00535_DS_
_00477_DS_:
;	.line	561; stateMachine.c	if(getSenha_i()==5){
	CALL	_getSenha_i
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	r0x01, W
	XORLW	0x05
	BNZ	_01225_DS_
	MOVF	r0x02, W
	BZ	_01226_DS_
_01225_DS_:
	BRA	_00475_DS_
_01226_DS_:
;	.line	562; stateMachine.c	setState(AGUARDO);
	MOVLW	0x21
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
	BRA	_00535_DS_
_00475_DS_:
;	.line	564; stateMachine.c	outputPrint(getState(), getLanguage());
	CALL	_getState
	MOVWF	r0x01
	CLRF	r0x02
	CALL	_getLanguage
	MOVWF	r0x03
	CLRF	r0x04
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	CALL	_outputPrint
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	565; stateMachine.c	setState(CONFIG_SENHA);
	MOVLW	0x18
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	570; stateMachine.c	break;
	BRA	_00535_DS_
_00487_DS_:
;	.line	573; stateMachine.c	setState(NOVA_SENHA);
	MOVLW	0x1a
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	574; stateMachine.c	break;
	BRA	_00535_DS_
_00488_DS_:
;	.line	579; stateMachine.c	if (evento == EV_ENTER){
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00490_DS_
;	.line	580; stateMachine.c	setState(SECURITY_HABILITA);
	MOVLW	0x1c
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00490_DS_:
;	.line	582; stateMachine.c	if(evento == EV_UP || evento == EV_DOWN){
	MOVF	r0x00, W
	BZ	_00491_DS_
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00492_DS_
_00491_DS_:
;	.line	583; stateMachine.c	setState(CONFIG_SENHA);
	MOVLW	0x18
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00492_DS_:
;	.line	585; stateMachine.c	if(evento == EV_RIGHT || evento == EV_LEFT){
	MOVF	r0x00, W
	XORLW	0x03
	BZ	_00494_DS_
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00494_DS_
	BRA	_00535_DS_
_00494_DS_:
;	.line	586; stateMachine.c	setState(STATE_SECURITY);
	MOVLW	0x17
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	588; stateMachine.c	break;
	BRA	_00535_DS_
_00497_DS_:
;	.line	595; stateMachine.c	if(getSenha_try() ==  3){
	CALL	_getSenha_try
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	r0x01, W
	XORLW	0x03
	BNZ	_01235_DS_
	MOVF	r0x02, W
	BZ	_01236_DS_
_01235_DS_:
	BRA	_00499_DS_
_01236_DS_:
;	.line	596; stateMachine.c	setState(CONFIG_HABILITA);
	MOVLW	0x1b
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00499_DS_:
	BANKSEL	_senha
;	.line	598; stateMachine.c	if (testSenha(senha) == 1) {
	MOVF	_senha, W, B
	MOVWF	POSTDEC1
	CALL	_testSenha
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVF	POSTINC1, F
	MOVF	r0x01, W
	XORLW	0x01
	BNZ	_01237_DS_
	MOVF	r0x02, W
	BZ	_01238_DS_
_01237_DS_:
	BRA	_00535_DS_
_01238_DS_:
;	.line	599; stateMachine.c	setState(HABILITA_SENHA);    
	MOVLW	0x1d
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	602; stateMachine.c	break;
	BRA	_00535_DS_
_00502_DS_:
;	.line	605; stateMachine.c	if(evento == EV_ENTER){
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00504_DS_
;	.line	606; stateMachine.c	enableSenha(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_enableSenha
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	607; stateMachine.c	setState(CONFIG_HABILITA);
	MOVLW	0x1b
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00504_DS_:
;	.line	609; stateMachine.c	if(evento == EV_UP || evento == EV_DOWN){
	MOVF	r0x00, W
	BZ	_00505_DS_
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00506_DS_
_00505_DS_:
;	.line	610; stateMachine.c	setState(DESABILITA_SENHA);
	MOVLW	0x1e
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00506_DS_:
;	.line	612; stateMachine.c	if(evento == EV_RIGHT || evento == EV_LEFT){
	MOVF	r0x00, W
	XORLW	0x03
	BZ	_00508_DS_
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00508_DS_
	BRA	_00535_DS_
_00508_DS_:
;	.line	613; stateMachine.c	setState(CONFIG_HABILITA);
	MOVLW	0x1b
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	615; stateMachine.c	break;
	BRA	_00535_DS_
_00511_DS_:
;	.line	618; stateMachine.c	if(evento == EV_ENTER){
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00513_DS_
;	.line	619; stateMachine.c	enableSenha(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_enableSenha
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	620; stateMachine.c	setState(CONFIG_HABILITA);
	MOVLW	0x1b
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00513_DS_:
;	.line	623; stateMachine.c	if(evento == EV_UP || evento == EV_DOWN){
	MOVF	r0x00, W
	BZ	_00514_DS_
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00515_DS_
_00514_DS_:
;	.line	624; stateMachine.c	setState(HABILITA_SENHA);
	MOVLW	0x1d
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00515_DS_:
;	.line	626; stateMachine.c	if(evento == EV_RIGHT || evento == EV_LEFT){
	MOVF	r0x00, W
	XORLW	0x03
	BZ	_00517_DS_
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00517_DS_
	BRA	_00535_DS_
_00517_DS_:
;	.line	627; stateMachine.c	setState(CONFIG_HABILITA);
	MOVLW	0x1b
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	629; stateMachine.c	break;
	BRA	_00535_DS_
_00520_DS_:
;	.line	633; stateMachine.c	if(evento == EV_ENTER){
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00522_DS_
;	.line	634; stateMachine.c	setTestResult(0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setTestResult
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	635; stateMachine.c	setState(SECURITY_RESET);
	MOVLW	0x20
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00522_DS_:
;	.line	637; stateMachine.c	if(evento == EV_UP){
	MOVF	r0x00, W
	BNZ	_00524_DS_
;	.line	638; stateMachine.c	setState(STATE_SECURITY);
	MOVLW	0x17
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00524_DS_:
;	.line	640; stateMachine.c	if(evento == EV_DOWN){
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00526_DS_
;	.line	641; stateMachine.c	setState(STATE_ALARME);
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00526_DS_:
;	.line	643; stateMachine.c	if(evento == EV_RIGHT || evento == EV_LEFT){
	MOVF	r0x00, W
	XORLW	0x03
	BZ	_00527_DS_
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00527_DS_
	BRA	_00535_DS_
_00527_DS_:
;	.line	644; stateMachine.c	setState(STATE_OP);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
;	.line	646; stateMachine.c	break;
	BRA	_00535_DS_
_00530_DS_:
;	.line	654; stateMachine.c	if(getSenha_try() == 3){
	CALL	_getSenha_try
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_01263_DS_
	MOVF	r0x01, W
	BZ	_01264_DS_
_01263_DS_:
	BRA	_00532_DS_
_01264_DS_:
;	.line	655; stateMachine.c	setState(STATE_RESET);
	MOVLW	0x1f
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00532_DS_:
	BANKSEL	_senha
;	.line	658; stateMachine.c	if (testSenha(senha) == 1) {
	MOVF	_senha, W, B
	MOVWF	POSTDEC1
	CALL	_testSenha
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	POSTINC1, F
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_01265_DS_
	MOVF	r0x01, W
	BZ	_01266_DS_
_01265_DS_:
	BRA	_00535_DS_
_01266_DS_:
;	.line	659; stateMachine.c	outputPrint(getState(), getLanguage());
	CALL	_getState
	MOVWF	r0x00
	CLRF	r0x01
	CALL	_getLanguage
	MOVWF	r0x02
	CLRF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_outputPrint
	MOVLW	0x04
	ADDWF	FSR1L, F
;	.line	660; stateMachine.c	varInit();
	CALL	_varInit
;	.line	661; stateMachine.c	setState(STATE_OP);    
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
_00535_DS_:
;	.line	665; stateMachine.c	outputPrint(getState(), getLanguage());
	CALL	_getState
	MOVWF	r0x00
	CLRF	r0x01
	CALL	_getLanguage
	MOVWF	r0x02
	CLRF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_outputPrint
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_stateMachine__getPeriodo	code
_getPeriodo:
;	.line	37; stateMachine.c	char getPeriodo(int x){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	38; stateMachine.c	if(x==1){
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00176_DS_
	MOVF	r0x01, W
	BZ	_00177_DS_
_00176_DS_:
	BRA	_00150_DS_
_00177_DS_:
	BANKSEL	_hora
;	.line	39; stateMachine.c	return hora;
	MOVF	_hora, W, B
	BRA	_00159_DS_
_00150_DS_:
;	.line	41; stateMachine.c	if(x==2){
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00178_DS_
	MOVF	r0x01, W
	BZ	_00179_DS_
_00178_DS_:
	BRA	_00152_DS_
_00179_DS_:
	BANKSEL	_min
;	.line	42; stateMachine.c	return min;
	MOVF	_min, W, B
	BRA	_00159_DS_
_00152_DS_:
;	.line	44; stateMachine.c	if(x==3){
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00180_DS_
	MOVF	r0x01, W
	BZ	_00181_DS_
_00180_DS_:
	BRA	_00154_DS_
_00181_DS_:
	BANKSEL	_dia
;	.line	45; stateMachine.c	return dia;
	MOVF	_dia, W, B
	BRA	_00159_DS_
_00154_DS_:
;	.line	47; stateMachine.c	if(x==4){
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00182_DS_
	MOVF	r0x01, W
	BZ	_00183_DS_
_00182_DS_:
	BRA	_00156_DS_
_00183_DS_:
	BANKSEL	_mes
;	.line	48; stateMachine.c	return mes;
	MOVF	_mes, W, B
	BRA	_00159_DS_
_00156_DS_:
;	.line	50; stateMachine.c	if(x==5){
	MOVF	r0x00, W
	XORLW	0x05
	BNZ	_00184_DS_
	MOVF	r0x01, W
	BZ	_00185_DS_
_00184_DS_:
	BRA	_00159_DS_
_00185_DS_:
	BANKSEL	_ano
;	.line	51; stateMachine.c	return ano;
	MOVF	_ano, W, B
_00159_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_stateMachine__changeEvento	code
_changeEvento:
;	.line	19; stateMachine.c	void changeEvento(unsigned char evento){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	BANKSEL	_senha
;	.line	20; stateMachine.c	senha = 0;
	CLRF	_senha, B
;	.line	21; stateMachine.c	if(evento == EV_LEFT){
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00111_DS_
;	.line	22; stateMachine.c	senha = 1;        
	MOVLW	0x01
	BANKSEL	_senha
	MOVWF	_senha, B
_00111_DS_:
;	.line	24; stateMachine.c	if(evento == EV_DOWN){
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00113_DS_
;	.line	25; stateMachine.c	senha = 2;
	MOVLW	0x02
	BANKSEL	_senha
	MOVWF	_senha, B
_00113_DS_:
;	.line	27; stateMachine.c	if(evento == EV_RIGHT){
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00115_DS_
;	.line	28; stateMachine.c	senha = 3;
	MOVLW	0x03
	BANKSEL	_senha
	MOVWF	_senha, B
_00115_DS_:
;	.line	30; stateMachine.c	if(evento == EV_UP){
	MOVF	r0x00, W
	BNZ	_00117_DS_
;	.line	31; stateMachine.c	senha = 4;
	MOVLW	0x04
	BANKSEL	_senha
	MOVWF	_senha, B
_00117_DS_:
;	.line	33; stateMachine.c	if(evento == EV_ENTER){
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00120_DS_
;	.line	34; stateMachine.c	senha = 5; 
	MOVLW	0x05
	BANKSEL	_senha
	MOVWF	_senha, B
_00120_DS_:
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_stateMachine__smInit	code
_smInit:
;	.line	16; stateMachine.c	void smInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	17; stateMachine.c	setState(STATE_OP);
	MOVLW	0x00
	MOVWF	POSTDEC1
	CALL	_setState
	MOVF	POSTINC1, F
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 5272 (0x1498) bytes ( 4.02%)
;           	 2636 (0x0a4c) words
; udata size:	    6 (0x0006) bytes ( 0.47%)
; access size:	    5 (0x0005) bytes


	end
