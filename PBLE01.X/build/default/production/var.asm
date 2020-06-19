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
	global	_varInit
	global	_getState
	global	_setState
	global	_getTime
	global	_setTime
	global	_getMult
	global	_setMult
	global	_getAlarmLevel
	global	_setAlarmLevel
	global	_getLanguage
	global	_setLanguage
	global	_getSenhaStatus
	global	_enableSenha
	global	_getSenha_i
	global	_getSenha_try
	global	_getTestResult
	global	_setTestResult
	global	_testSenha
	global	_setSenha
	global	_delay40us
	global	_delay2ms

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	__mulint

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTINC0	equ	0xfee
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1

udata_var_0	udata
_state	res	1

udata_var_1	udata
_language	res	1

udata_var_2	udata
_time	res	2

udata_var_3	udata
_alarmLevel_H	res	2

udata_var_4	udata
_alarmLevel_L	res	2

udata_var_5	udata
_senha_enable	res	2

udata_var_6	udata
_senha_i	res	2

udata_var_7	udata
_senha_result	res	2

udata_var_8	udata
_senha_try	res	2

udata_var_9	udata
_multiplicador	res	2

udata_var_10	udata
_senha_save	res	10

udata_var_11	udata
_senha_count	res	10

udata_var_12	udata
_senha_new	res	10

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_var__setSenha	code
_setSenha:
;	.line	149; var.c	int setSenha(char senha){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	BANKSEL	_senha_try
;	.line	152; var.c	senha_try = 0;
	CLRF	_senha_try, B
	BANKSEL	(_senha_try + 1)
	CLRF	(_senha_try + 1), B
;	.line	153; var.c	if(senha != 0 && senha_i>4){
	MOVF	r0x00, W
	BZ	_00299_DS_
	BANKSEL	(_senha_i + 1)
	MOVF	(_senha_i + 1), W, B
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00347_DS_
	MOVLW	0x05
	BANKSEL	_senha_i
	SUBWF	_senha_i, W, B
_00347_DS_:
	BNC	_00299_DS_
	BANKSEL	_senha_i
;	.line	154; var.c	senha_count[senha_i - 5] = senha;
	MOVF	_senha_i, W, B
	MOVWF	r0x01
	MOVLW	0xfb
	ADDWF	r0x01, F
; ;multiply lit val:0x02 by variable r0x01 and store in r0x01
	MOVF	r0x01, W
	MULLW	0x02
	MOVF	PRODH, W
	BTFSC	r0x01, 7
	SUBLW	0x02
	MOVWF	r0x02
	MOVFF	PRODL, r0x01
	MOVLW	LOW(_senha_count)
	ADDWF	r0x01, F
	MOVLW	HIGH(_senha_count)
	ADDWFC	r0x02, F
	MOVFF	r0x00, r0x03
	CLRF	r0x04
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	r0x03, POSTINC0
	MOVFF	r0x04, INDF0
	BANKSEL	_senha_i
;	.line	155; var.c	senha_i++;
	INCFSZ	_senha_i, F, B
	BRA	_10298_DS_
	BANKSEL	(_senha_i + 1)
	INCF	(_senha_i + 1), F, B
_10298_DS_:
_00299_DS_:
;	.line	158; var.c	if(senha != 0 && senha_i<5 ){
	MOVF	r0x00, W
	BZ	_00302_DS_
	BANKSEL	(_senha_i + 1)
	MOVF	(_senha_i + 1), W, B
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00348_DS_
	MOVLW	0x05
	BANKSEL	_senha_i
	SUBWF	_senha_i, W, B
_00348_DS_:
	BC	_00302_DS_
	BANKSEL	(_senha_i + 1)
;	.line	159; var.c	senha_new[senha_i] = senha;
	MOVF	(_senha_i + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_senha_i
	MOVF	_senha_i, W, B
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_senha_new)
	ADDWF	r0x01, F
	MOVLW	HIGH(_senha_new)
	ADDWFC	r0x02, F
	CLRF	r0x03
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	r0x00, POSTINC0
	MOVFF	r0x03, INDF0
	BANKSEL	_senha_i
;	.line	160; var.c	senha_i++;
	INCFSZ	_senha_i, F, B
	BRA	_20299_DS_
	BANKSEL	(_senha_i + 1)
	INCF	(_senha_i + 1), F, B
_20299_DS_:
_00302_DS_:
	BANKSEL	_senha_result
;	.line	163; var.c	senha_result = 0;
	CLRF	_senha_result, B
	BANKSEL	(_senha_result + 1)
	CLRF	(_senha_result + 1), B
	BANKSEL	_senha_i
;	.line	164; var.c	if(senha_i==10){
	MOVF	_senha_i, W, B
	XORLW	0x0a
	BNZ	_00349_DS_
	BANKSEL	(_senha_i + 1)
	MOVF	(_senha_i + 1), W, B
	BZ	_00350_DS_
_00349_DS_:
	BRA	_00309_DS_
_00350_DS_:
	BANKSEL	_senha_i
;	.line	165; var.c	senha_i=0;
	CLRF	_senha_i, B
	BANKSEL	(_senha_i + 1)
	CLRF	(_senha_i + 1), B
;	.line	166; var.c	for(i=0;i<5;i++){
	CLRF	r0x00
	CLRF	r0x01
	CLRF	r0x02
_00310_DS_:
;	.line	167; var.c	if(senha_new[i] != senha_count[i]){
	MOVLW	LOW(_senha_new)
	ADDWF	r0x01, W
	MOVWF	r0x03
	MOVLW	HIGH(_senha_new)
	ADDWFC	r0x02, W
	MOVWF	r0x04
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	INDF0, r0x04
	MOVLW	LOW(_senha_count)
	ADDWF	r0x01, W
	MOVWF	r0x05
	MOVLW	HIGH(_senha_count)
	ADDWFC	r0x02, W
	MOVWF	r0x06
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x03, W
	XORWF	r0x05, W
	BNZ	_00352_DS_
	MOVF	r0x04, W
	XORWF	r0x06, W
	BZ	_00311_DS_
_00352_DS_:
	BANKSEL	_senha_result
;	.line	168; var.c	senha_result = 0;
	CLRF	_senha_result, B
	BANKSEL	(_senha_result + 1)
	CLRF	(_senha_result + 1), B
;	.line	169; var.c	senha_try++;
	MOVLW	0x01
	BANKSEL	_senha_try
	MOVWF	_senha_try, B
	BANKSEL	(_senha_try + 1)
	CLRF	(_senha_try + 1), B
;	.line	170; var.c	return 1;
	CLRF	PRODL
	MOVLW	0x01
	BRA	_00314_DS_
_00311_DS_:
;	.line	166; var.c	for(i=0;i<5;i++){
	MOVLW	0x02
	ADDWF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	INCF	r0x00, F
	MOVLW	0x05
	SUBWF	r0x00, W
	BNC	_00310_DS_
;	.line	174; var.c	for(i=0;i<5;i++){
	CLRF	r0x00
	CLRF	r0x01
	CLRF	r0x02
_00312_DS_:
;	.line	175; var.c	senha_save[i] = senha_new[i];
	MOVLW	LOW(_senha_save)
	ADDWF	r0x01, W
	MOVWF	r0x03
	MOVLW	HIGH(_senha_save)
	ADDWFC	r0x02, W
	MOVWF	r0x04
	MOVLW	LOW(_senha_new)
	ADDWF	r0x01, W
	MOVWF	r0x05
	MOVLW	HIGH(_senha_new)
	ADDWFC	r0x02, W
	MOVWF	r0x06
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	r0x05, POSTINC0
	MOVFF	r0x06, INDF0
;	.line	174; var.c	for(i=0;i<5;i++){
	MOVLW	0x02
	ADDWF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	INCF	r0x00, F
	MOVLW	0x05
	SUBWF	r0x00, W
	BNC	_00312_DS_
;	.line	177; var.c	senha_result=1;
	MOVLW	0x01
	BANKSEL	_senha_result
	MOVWF	_senha_result, B
	BANKSEL	(_senha_result + 1)
	CLRF	(_senha_result + 1), B
;	.line	178; var.c	return 1;
	CLRF	PRODL
	MOVLW	0x01
	BRA	_00314_DS_
_00309_DS_:
;	.line	180; var.c	return 0;
	CLRF	PRODL
	CLRF	WREG
_00314_DS_:
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__testSenha	code
_testSenha:
;	.line	120; var.c	int testSenha(char senha){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	BANKSEL	(_senha_i + 1)
;	.line	123; var.c	if(senha_i<5){
	MOVF	(_senha_i + 1), W, B
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00286_DS_
	MOVLW	0x05
	BANKSEL	_senha_i
	SUBWF	_senha_i, W, B
_00286_DS_:
	BC	_00255_DS_
	BANKSEL	_senha_result
;	.line	124; var.c	senha_result=0;
	CLRF	_senha_result, B
	BANKSEL	(_senha_result + 1)
	CLRF	(_senha_result + 1), B
;	.line	125; var.c	if(senha != 0){
	MOVF	r0x00, W
	BZ	_00251_DS_
	BANKSEL	_senha_i
;	.line	126; var.c	senha_i++;
	INCFSZ	_senha_i, F, B
	BRA	_30300_DS_
	BANKSEL	(_senha_i + 1)
	INCF	(_senha_i + 1), F, B
_30300_DS_:
	BANKSEL	_senha_i
;	.line	127; var.c	senha_count[senha_i - 1] = senha;
	MOVF	_senha_i, W, B
	MOVWF	r0x01
	DECF	r0x01, F
; ;multiply lit val:0x02 by variable r0x01 and store in r0x01
	MOVF	r0x01, W
	MULLW	0x02
	MOVF	PRODH, W
	BTFSC	r0x01, 7
	SUBLW	0x02
	MOVWF	r0x02
	MOVFF	PRODL, r0x01
	MOVLW	LOW(_senha_count)
	ADDWF	r0x01, F
	MOVLW	HIGH(_senha_count)
	ADDWFC	r0x02, F
	CLRF	r0x03
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	r0x00, POSTINC0
	MOVFF	r0x03, INDF0
_00251_DS_:
	BANKSEL	_senha_try
;	.line	129; var.c	if(senha_try==3){
	MOVF	_senha_try, W, B
	XORLW	0x03
	BNZ	_00255_DS_
	BANKSEL	(_senha_try + 1)
	MOVF	(_senha_try + 1), W, B
	BZ	_00288_DS_
_00287_DS_:
	BRA	_00255_DS_
_00288_DS_:
	BANKSEL	_senha_try
;	.line	130; var.c	senha_try=0;
	CLRF	_senha_try, B
	BANKSEL	(_senha_try + 1)
	CLRF	(_senha_try + 1), B
_00255_DS_:
	BANKSEL	_senha_i
;	.line	133; var.c	if(senha_i==5){
	MOVF	_senha_i, W, B
	XORLW	0x05
	BNZ	_00289_DS_
	BANKSEL	(_senha_i + 1)
	MOVF	(_senha_i + 1), W, B
	BZ	_00290_DS_
_00289_DS_:
	BRA	_00260_DS_
_00290_DS_:
;	.line	134; var.c	for(i=0;i<5;i++){
	CLRF	r0x00
	CLRF	r0x01
	CLRF	r0x02
_00261_DS_:
;	.line	135; var.c	if(senha_count[i] != senha_save[i]){
	MOVLW	LOW(_senha_count)
	ADDWF	r0x01, W
	MOVWF	r0x03
	MOVLW	HIGH(_senha_count)
	ADDWFC	r0x02, W
	MOVWF	r0x04
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	POSTINC0, r0x03
	MOVFF	INDF0, r0x04
	MOVLW	LOW(_senha_save)
	ADDWF	r0x01, W
	MOVWF	r0x05
	MOVLW	HIGH(_senha_save)
	ADDWFC	r0x02, W
	MOVWF	r0x06
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x03, W
	XORWF	r0x05, W
	BNZ	_00292_DS_
	MOVF	r0x04, W
	XORWF	r0x06, W
	BZ	_00262_DS_
_00292_DS_:
	BANKSEL	_senha_try
;	.line	136; var.c	senha_try++;
	INCFSZ	_senha_try, F, B
	BRA	_40301_DS_
	BANKSEL	(_senha_try + 1)
	INCF	(_senha_try + 1), F, B
_40301_DS_:
	BANKSEL	_senha_i
;	.line	137; var.c	senha_i=0;
	CLRF	_senha_i, B
	BANKSEL	(_senha_i + 1)
	CLRF	(_senha_i + 1), B
;	.line	138; var.c	return 0;
	CLRF	PRODL
	CLRF	WREG
	BRA	_00263_DS_
_00262_DS_:
;	.line	134; var.c	for(i=0;i<5;i++){
	MOVLW	0x02
	ADDWF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	INCF	r0x00, F
	MOVLW	0x05
	SUBWF	r0x00, W
	BNC	_00261_DS_
	BANKSEL	_senha_try
;	.line	142; var.c	senha_try = 0;
	CLRF	_senha_try, B
	BANKSEL	(_senha_try + 1)
	CLRF	(_senha_try + 1), B
	BANKSEL	_senha_i
;	.line	143; var.c	senha_i = 0;
	CLRF	_senha_i, B
	BANKSEL	(_senha_i + 1)
	CLRF	(_senha_i + 1), B
;	.line	144; var.c	senha_result = 1;
	MOVLW	0x01
	BANKSEL	_senha_result
	MOVWF	_senha_result, B
	BANKSEL	(_senha_result + 1)
	CLRF	(_senha_result + 1), B
;	.line	145; var.c	return 1;
	CLRF	PRODL
	MOVLW	0x01
	BRA	_00263_DS_
_00260_DS_:
;	.line	147; var.c	return 0;
	CLRF	PRODL
	CLRF	WREG
_00263_DS_:
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setTestResult	code
_setTestResult:
;	.line	117; var.c	void setTestResult(int x){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _senha_result
	MOVLW	0x03
	MOVFF	PLUSW2, (_senha_result + 1)
;	.line	118; var.c	senha_result = x;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getTestResult	code
_getTestResult:
;	.line	114; var.c	int getTestResult(){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	115; var.c	return senha_result;
	MOVFF	(_senha_result + 1), PRODL
	BANKSEL	_senha_result
	MOVF	_senha_result, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getSenha_try	code
_getSenha_try:
;	.line	111; var.c	int getSenha_try(){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	112; var.c	return senha_try;
	MOVFF	(_senha_try + 1), PRODL
	BANKSEL	_senha_try
	MOVF	_senha_try, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getSenha_i	code
_getSenha_i:
;	.line	108; var.c	int getSenha_i(){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	109; var.c	return senha_i;
	MOVFF	(_senha_i + 1), PRODL
	BANKSEL	_senha_i
	MOVF	_senha_i, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__enableSenha	code
_enableSenha:
;	.line	105; var.c	void enableSenha(int x){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _senha_enable
	MOVLW	0x03
	MOVFF	PLUSW2, (_senha_enable + 1)
;	.line	106; var.c	senha_enable = x;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getSenhaStatus	code
_getSenhaStatus:
;	.line	102; var.c	int getSenhaStatus(){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	103; var.c	return senha_enable;
	MOVFF	(_senha_enable + 1), PRODL
	BANKSEL	_senha_enable
	MOVF	_senha_enable, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setLanguage	code
_setLanguage:
;	.line	95; var.c	void setLanguage(char newLanguage){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	98; var.c	language = newLanguage%2;
	MOVLW	0x01
	ANDWF	r0x00, W
	BANKSEL	_language
	MOVWF	_language, B
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getLanguage	code
_getLanguage:
;	.line	92; var.c	char getLanguage(void){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_language
;	.line	93; var.c	return language;
	MOVF	_language, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setAlarmLevel	code
_setAlarmLevel:
;	.line	82; var.c	void setAlarmLevel(int newAlarmLevel, int valor) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	83; var.c	if(valor == 2){
	MOVF	r0x02, W
	XORLW	0x02
	BNZ	_00202_DS_
	MOVF	r0x03, W
	BZ	_00203_DS_
_00202_DS_:
	BRA	_00191_DS_
_00203_DS_:
;	.line	84; var.c	alarmLevel_H = newAlarmLevel;
	MOVFF	r0x00, _alarmLevel_H
	MOVFF	r0x01, (_alarmLevel_H + 1)
_00191_DS_:
;	.line	86; var.c	if(valor == 1){
	MOVF	r0x02, W
	XORLW	0x01
	BNZ	_00204_DS_
	MOVF	r0x03, W
	BZ	_00205_DS_
_00204_DS_:
	BRA	_00194_DS_
_00205_DS_:
;	.line	87; var.c	alarmLevel_L = newAlarmLevel;
	MOVFF	r0x00, _alarmLevel_L
	MOVFF	r0x01, (_alarmLevel_L + 1)
_00194_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getAlarmLevel	code
_getAlarmLevel:
;	.line	73; var.c	int getAlarmLevel(int valor) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
;	.line	74; var.c	if(valor == 2)
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00182_DS_
	MOVF	r0x01, W
	BZ	_00183_DS_
_00182_DS_:
	BRA	_00170_DS_
_00183_DS_:
;	.line	75; var.c	return alarmLevel_H;
	MOVFF	(_alarmLevel_H + 1), PRODL
	BANKSEL	_alarmLevel_H
	MOVF	_alarmLevel_H, W, B
	BRA	_00174_DS_
_00170_DS_:
;	.line	76; var.c	if(valor == 1)
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00184_DS_
	MOVF	r0x01, W
	BZ	_00185_DS_
_00184_DS_:
	BRA	_00172_DS_
_00185_DS_:
;	.line	77; var.c	return alarmLevel_L;
	MOVFF	(_alarmLevel_L + 1), PRODL
	BANKSEL	_alarmLevel_L
	MOVF	_alarmLevel_L, W, B
	BRA	_00174_DS_
_00172_DS_:
;	.line	79; var.c	return 0;
	CLRF	PRODL
	CLRF	WREG
_00174_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setMult	code
_setMult:
;	.line	68; var.c	void setMult(int mult){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _multiplicador
	MOVLW	0x03
	MOVFF	PLUSW2, (_multiplicador + 1)
;	.line	69; var.c	multiplicador = mult;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getMult	code
_getMult:
;	.line	65; var.c	int getMult(){
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	66; var.c	return multiplicador;
	MOVFF	(_multiplicador + 1), PRODL
	BANKSEL	_multiplicador
	MOVF	_multiplicador, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setTime	code
_setTime:
;	.line	62; var.c	void setTime(int newTime) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _time
	MOVLW	0x03
	MOVFF	PLUSW2, (_time + 1)
;	.line	63; var.c	time = newTime;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getTime	code
_getTime:
;	.line	59; var.c	int getTime(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	60; var.c	return time;
	MOVFF	(_time + 1), PRODL
	BANKSEL	_time
	MOVF	_time, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__setState	code
_setState:
;	.line	54; var.c	void setState(char newState) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVLW	0x02
	MOVFF	PLUSW2, _state
;	.line	55; var.c	state = newState;
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__getState	code
_getState:
;	.line	51; var.c	char getState(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	BANKSEL	_state
;	.line	52; var.c	return state;
	MOVF	_state, W, B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__varInit	code
_varInit:
;	.line	34; var.c	void varInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	BANKSEL	_state
;	.line	35; var.c	state = 0;
	CLRF	_state, B
;	.line	36; var.c	time = 1000;
	MOVLW	0xe8
	BANKSEL	_time
	MOVWF	_time, B
	MOVLW	0x03
	BANKSEL	(_time + 1)
	MOVWF	(_time + 1), B
;	.line	37; var.c	alarmLevel_L = 20;
	MOVLW	0x14
	BANKSEL	_alarmLevel_L
	MOVWF	_alarmLevel_L, B
	BANKSEL	(_alarmLevel_L + 1)
	CLRF	(_alarmLevel_L + 1), B
;	.line	38; var.c	alarmLevel_H = 80;
	MOVLW	0x50
	BANKSEL	_alarmLevel_H
	MOVWF	_alarmLevel_H, B
	BANKSEL	(_alarmLevel_H + 1)
	CLRF	(_alarmLevel_H + 1), B
	BANKSEL	_language
;	.line	39; var.c	language = 0;
	CLRF	_language, B
;	.line	40; var.c	multiplicador = 10;
	MOVLW	0x0a
	BANKSEL	_multiplicador
	MOVWF	_multiplicador, B
	BANKSEL	(_multiplicador + 1)
	CLRF	(_multiplicador + 1), B
	BANKSEL	_senha_i
;	.line	41; var.c	for(senha_i=0;senha_i<5;senha_i++){
	CLRF	_senha_i, B
	BANKSEL	(_senha_i + 1)
	CLRF	(_senha_i + 1), B
_00124_DS_:
	BANKSEL	(_senha_i + 1)
;	.line	42; var.c	senha_save[senha_i]= 5 ;
	MOVF	(_senha_i + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_senha_i
	MOVF	_senha_i, W, B
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_senha_save)
	ADDWF	r0x00, F
	MOVLW	HIGH(_senha_save)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x05
	MOVWF	POSTINC0
	MOVLW	0x00
	MOVWF	INDF0
	BANKSEL	_senha_i
;	.line	41; var.c	for(senha_i=0;senha_i<5;senha_i++){
	INCFSZ	_senha_i, F, B
	BRA	_50302_DS_
	BANKSEL	(_senha_i + 1)
	INCF	(_senha_i + 1), F, B
_50302_DS_:
	BANKSEL	(_senha_i + 1)
	MOVF	(_senha_i + 1), W, B
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00134_DS_
	MOVLW	0x05
	BANKSEL	_senha_i
	SUBWF	_senha_i, W, B
_00134_DS_:
	BNC	_00124_DS_
;	.line	44; var.c	senha_enable = 1;
	MOVLW	0x01
	BANKSEL	_senha_enable
	MOVWF	_senha_enable, B
	BANKSEL	(_senha_enable + 1)
	CLRF	(_senha_enable + 1), B
	BANKSEL	_senha_i
;	.line	45; var.c	senha_i = 0;
	CLRF	_senha_i, B
	BANKSEL	(_senha_i + 1)
	CLRF	(_senha_i + 1), B
	BANKSEL	_senha_try
;	.line	46; var.c	senha_try = 0;
	CLRF	_senha_try, B
	BANKSEL	(_senha_try + 1)
	CLRF	(_senha_try + 1), B
	BANKSEL	_senha_result
;	.line	47; var.c	senha_result = 0;
	CLRF	_senha_result, B
	BANKSEL	(_senha_result + 1)
	CLRF	(_senha_result + 1), B
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__delay2ms	code
_delay2ms:
;	.line	27; var.c	void delay2ms(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	29; var.c	for (i = 0; i < 50; i++) {
	MOVLW	0x32
	MOVWF	r0x00
_00117_DS_:
;	.line	30; var.c	delay40us();
	CALL	_delay40us
	DECF	r0x00, W
	MOVWF	r0x01
	MOVFF	r0x01, r0x00
;	.line	29; var.c	for (i = 0; i < 50; i++) {
	MOVF	r0x01, W
	BNZ	_00117_DS_
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_var__delay40us	code
_delay40us:
;	.line	22; var.c	void delay40us(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	24; var.c	for (i = 0; i < 10; i++); //valor aproximado
	MOVLW	0x0a
	MOVWF	r0x00
_00108_DS_:
	DECF	r0x00, W
	MOVWF	r0x01
	MOVFF	r0x01, r0x00
	MOVF	r0x01, W
	BNZ	_00108_DS_
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	



; Statistics:
; code size:	 1696 (0x06a0) bytes ( 1.29%)
;           	  848 (0x0350) words
; udata size:	   48 (0x0030) bytes ( 3.75%)
; access size:	    7 (0x0007) bytes


	end
