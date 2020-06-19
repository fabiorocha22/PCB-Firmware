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
	global	_outputInit
	global	_outputPrint
	global	_ADread
	global	_i

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern	_Delay2ms
	extern	_lcdCommand
	extern	_lcdString
	extern	_lcdInt
	extern	_lcdInit
	extern	_getPeriodo
	extern	_getTime
	extern	_getMult
	extern	_getAlarmLevel
	extern	_getLanguage
	extern	_getSenha_i
	extern	_getSenha_try
	extern	_getTestResult
	extern	__mulint

;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTINC0	equ	0xfee
POSTINC1	equ	0xfe6
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3


	idata
_msgs	db	LOW(___str_50), HIGH(___str_50), UPPER(___str_50), LOW(___str_51), HIGH(___str_51), UPPER(___str_51), LOW(___str_52), HIGH(___str_52), UPPER(___str_52), LOW(___str_53), HIGH(___str_53), UPPER(___str_53)
	db	LOW(___str_54), HIGH(___str_54), UPPER(___str_54), LOW(___str_55), HIGH(___str_55), UPPER(___str_55), LOW(___str_56), HIGH(___str_56), UPPER(___str_56), LOW(___str_57), HIGH(___str_57), UPPER(___str_57)
	db	LOW(___str_58), HIGH(___str_58), UPPER(___str_58), LOW(___str_59), HIGH(___str_59), UPPER(___str_59), LOW(___str_58), HIGH(___str_58), UPPER(___str_58), LOW(___str_59), HIGH(___str_59), UPPER(___str_59)
	db	LOW(___str_58), HIGH(___str_58), UPPER(___str_58), LOW(___str_59), HIGH(___str_59), UPPER(___str_59), LOW(___str_58), HIGH(___str_58), UPPER(___str_58), LOW(___str_59), HIGH(___str_59), UPPER(___str_59)
	db	LOW(___str_60), HIGH(___str_60), UPPER(___str_60), LOW(___str_61), HIGH(___str_61), UPPER(___str_61), LOW(___str_62), HIGH(___str_62), UPPER(___str_62), LOW(___str_63), HIGH(___str_63), UPPER(___str_63)
	db	LOW(___str_62), HIGH(___str_62), UPPER(___str_62), LOW(___str_63), HIGH(___str_63), UPPER(___str_63), LOW(___str_62), HIGH(___str_62), UPPER(___str_62), LOW(___str_63), HIGH(___str_63), UPPER(___str_63)
	db	LOW(___str_64), HIGH(___str_64), UPPER(___str_64), LOW(___str_65), HIGH(___str_65), UPPER(___str_65), LOW(___str_66), HIGH(___str_66), UPPER(___str_66), LOW(___str_67), HIGH(___str_67), UPPER(___str_67)
	db	LOW(___str_68), HIGH(___str_68), UPPER(___str_68), LOW(___str_69), HIGH(___str_69), UPPER(___str_69), LOW(___str_70), HIGH(___str_70), UPPER(___str_70), LOW(___str_71), HIGH(___str_71), UPPER(___str_71)
	db	LOW(___str_72), HIGH(___str_72), UPPER(___str_72), LOW(___str_73), HIGH(___str_73), UPPER(___str_73), LOW(___str_72), HIGH(___str_72), UPPER(___str_72), LOW(___str_73), HIGH(___str_73), UPPER(___str_73)
	db	LOW(___str_72), HIGH(___str_72), UPPER(___str_72), LOW(___str_73), HIGH(___str_73), UPPER(___str_73), LOW(___str_74), HIGH(___str_74), UPPER(___str_74), LOW(___str_75), HIGH(___str_75), UPPER(___str_75)
	db	LOW(___str_76), HIGH(___str_76), UPPER(___str_76), LOW(___str_77), HIGH(___str_77), UPPER(___str_77), LOW(___str_76), HIGH(___str_76), UPPER(___str_76), LOW(___str_77), HIGH(___str_77), UPPER(___str_77)
	db	LOW(___str_76), HIGH(___str_76), UPPER(___str_76), LOW(___str_77), HIGH(___str_77), UPPER(___str_77), LOW(___str_78), HIGH(___str_78), UPPER(___str_78), LOW(___str_79), HIGH(___str_79), UPPER(___str_79)
	db	LOW(___str_80), HIGH(___str_80), UPPER(___str_80), LOW(___str_81), HIGH(___str_81), UPPER(___str_81), LOW(___str_82), HIGH(___str_82), UPPER(___str_82), LOW(___str_83), HIGH(___str_83), UPPER(___str_83)
	db	LOW(___str_84), HIGH(___str_84), UPPER(___str_84), LOW(___str_85), HIGH(___str_85), UPPER(___str_85), LOW(___str_86), HIGH(___str_86), UPPER(___str_86), LOW(___str_87), HIGH(___str_87), UPPER(___str_87)
	db	LOW(___str_88), HIGH(___str_88), UPPER(___str_88), LOW(___str_89), HIGH(___str_89), UPPER(___str_89), LOW(___str_90), HIGH(___str_90), UPPER(___str_90), LOW(___str_91), HIGH(___str_91), UPPER(___str_91)
	db	LOW(___str_92), HIGH(___str_92), UPPER(___str_92), LOW(___str_93), HIGH(___str_93), UPPER(___str_93), LOW(___str_94), HIGH(___str_94), UPPER(___str_94), LOW(___str_95), HIGH(___str_95), UPPER(___str_95)
	db	LOW(___str_52), HIGH(___str_52), UPPER(___str_52), LOW(___str_53), HIGH(___str_53), UPPER(___str_53), LOW(___str_52), HIGH(___str_52), UPPER(___str_52), LOW(___str_53), HIGH(___str_53), UPPER(___str_53)


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1
r0x07	res	1

udata_output_0	udata
_ADread	res	2

udata_output_1	udata
_i	res	2

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_output__outputPrint	code
_outputPrint:
;	.line	58; output.c	void outputPrint(int numTela, int idioma) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
;	.line	60; output.c	if (numTela == STATE_OP) {
	MOVF	r0x00, W
	IORWF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00111_DS_
;	.line	61; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	62; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	63; output.c	lcdString(" ");
	MOVLW	UPPER(___str_0)
	MOVWF	r0x06
	MOVLW	HIGH(___str_0)
	MOVWF	r0x05
	MOVLW	LOW(___str_0)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	(_ADread + 1)
;	.line	64; output.c	lcdInt(ADread);  //criar função getRead
	MOVF	(_ADread + 1), W, B
	MOVWF	POSTDEC1
	BANKSEL	_ADread
	MOVF	_ADread, W, B
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	65; output.c	lcdString("(uni)"); //colocar a unidade ou deixar assim genérico
	MOVLW	UPPER(___str_1)
	MOVWF	r0x06
	MOVLW	HIGH(___str_1)
	MOVWF	r0x05
	MOVLW	LOW(___str_1)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	66; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	67; output.c	lcdInt(getPeriodo(3));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_getPeriodo
	MOVWF	r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	CLRF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	68; output.c	lcdString("/");
	MOVLW	UPPER(___str_2)
	MOVWF	r0x06
	MOVLW	HIGH(___str_2)
	MOVWF	r0x05
	MOVLW	LOW(___str_2)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	69; output.c	lcdInt(getPeriodo(4));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_getPeriodo
	MOVWF	r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	CLRF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	70; output.c	lcdString("/");
	MOVLW	UPPER(___str_2)
	MOVWF	r0x06
	MOVLW	HIGH(___str_2)
	MOVWF	r0x05
	MOVLW	LOW(___str_2)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	71; output.c	lcdInt(getPeriodo(5));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_getPeriodo
	MOVWF	r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	CLRF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	72; output.c	lcdString("  ");
	MOVLW	UPPER(___str_3)
	MOVWF	r0x06
	MOVLW	HIGH(___str_3)
	MOVWF	r0x05
	MOVLW	LOW(___str_3)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	73; output.c	lcdInt(getPeriodo(1));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getPeriodo
	MOVWF	r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	CLRF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	74; output.c	lcdString(":");
	MOVLW	UPPER(___str_4)
	MOVWF	r0x06
	MOVLW	HIGH(___str_4)
	MOVWF	r0x05
	MOVLW	LOW(___str_4)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	75; output.c	lcdInt(getPeriodo(2));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getPeriodo
	MOVWF	r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	CLRF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	76; output.c	lcdString(" ");
	MOVLW	UPPER(___str_0)
	MOVWF	r0x06
	MOVLW	HIGH(___str_0)
	MOVWF	r0x05
	MOVLW	LOW(___str_0)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00111_DS_:
;	.line	80; output.c	if (numTela == SECURITY_CONFIG) {
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00722_DS_
	MOVF	r0x01, W
	BZ	_00723_DS_
_00722_DS_:
	BRA	_00133_DS_
_00723_DS_:
;	.line	81; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	82; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	83; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	84; output.c	if(getSenha_i() == 0 ){
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	IORWF	r0x05, W
	BNZ	_00113_DS_
;	.line	85; output.c	lcdString("                "); 
	MOVLW	UPPER(___str_5)
	MOVWF	r0x06
	MOVLW	HIGH(___str_5)
	MOVWF	r0x05
	MOVLW	LOW(___str_5)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00113_DS_:
;	.line	87; output.c	if(getSenha_i() == 1 ){
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00724_DS_
	MOVF	r0x05, W
	BZ	_00725_DS_
_00724_DS_:
	BRA	_00115_DS_
_00725_DS_:
;	.line	88; output.c	lcdString("*               "); 
	MOVLW	UPPER(___str_6)
	MOVWF	r0x06
	MOVLW	HIGH(___str_6)
	MOVWF	r0x05
	MOVLW	LOW(___str_6)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00115_DS_:
;	.line	90; output.c	if(getSenha_i() == 2 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x02
	BNZ	_00726_DS_
	MOVF	r0x05, W
	BZ	_00727_DS_
_00726_DS_:
	BRA	_00117_DS_
_00727_DS_:
;	.line	91; output.c	lcdString("**              "); 
	MOVLW	UPPER(___str_7)
	MOVWF	r0x06
	MOVLW	HIGH(___str_7)
	MOVWF	r0x05
	MOVLW	LOW(___str_7)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00117_DS_:
;	.line	93; output.c	if(getSenha_i() == 3 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x03
	BNZ	_00728_DS_
	MOVF	r0x05, W
	BZ	_00729_DS_
_00728_DS_:
	BRA	_00119_DS_
_00729_DS_:
;	.line	94; output.c	lcdString("***            "); 
	MOVLW	UPPER(___str_8)
	MOVWF	r0x06
	MOVLW	HIGH(___str_8)
	MOVWF	r0x05
	MOVLW	LOW(___str_8)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00119_DS_:
;	.line	96; output.c	if(getSenha_i() == 4 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x04
	BNZ	_00730_DS_
	MOVF	r0x05, W
	BZ	_00731_DS_
_00730_DS_:
	BRA	_00121_DS_
_00731_DS_:
;	.line	97; output.c	lcdString("****           "); 
	MOVLW	UPPER(___str_9)
	MOVWF	r0x06
	MOVLW	HIGH(___str_9)
	MOVWF	r0x05
	MOVLW	LOW(___str_9)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00121_DS_:
;	.line	99; output.c	if(getSenha_i() == 5 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x05
	BNZ	_00732_DS_
	MOVF	r0x05, W
	BZ	_00733_DS_
_00732_DS_:
	BRA	_00124_DS_
_00733_DS_:
;	.line	100; output.c	lcdString("*****          ");
	MOVLW	UPPER(___str_10)
	MOVWF	r0x06
	MOVLW	HIGH(___str_10)
	MOVWF	r0x05
	MOVLW	LOW(___str_10)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_i
;	.line	101; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	CLRF	_i, B
	BANKSEL	(_i + 1)
	CLRF	(_i + 1), B
_00338_DS_:
;	.line	102; output.c	Delay2ms(); 
	CALL	_Delay2ms
	BANKSEL	_i
;	.line	101; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	INCFSZ	_i, F, B
	BRA	_10110_DS_
	BANKSEL	(_i + 1)
	INCF	(_i + 1), F, B
_10110_DS_:
	MOVLW	0x05
	BANKSEL	(_i + 1)
	SUBWF	(_i + 1), W, B
	BNZ	_00734_DS_
	MOVLW	0xdd
	BANKSEL	_i
	SUBWF	_i, W, B
_00734_DS_:
	BNC	_00338_DS_
_00124_DS_:
;	.line	105; output.c	if(getSenha_try() == 3){
	CALL	_getSenha_try
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x03
	BNZ	_00735_DS_
	MOVF	r0x05, W
	BZ	_00736_DS_
_00735_DS_:
	BRA	_00133_DS_
_00736_DS_:
;	.line	106; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	107; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00126_DS_
;	.line	108; output.c	lcdString("Senha incorreta!");
	MOVLW	UPPER(___str_11)
	MOVWF	r0x06
	MOVLW	HIGH(___str_11)
	MOVWF	r0x05
	MOVLW	LOW(___str_11)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00126_DS_:
;	.line	110; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00128_DS_
;	.line	111; output.c	lcdString("Wrong password! ");
	MOVLW	UPPER(___str_12)
	MOVWF	r0x06
	MOVLW	HIGH(___str_12)
	MOVWF	r0x05
	MOVLW	LOW(___str_12)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00128_DS_:
	BANKSEL	_i
;	.line	113; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	CLRF	_i, B
	BANKSEL	(_i + 1)
	CLRF	(_i + 1), B
_00340_DS_:
;	.line	114; output.c	Delay2ms(); 
	CALL	_Delay2ms
	BANKSEL	_i
;	.line	113; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	INCFSZ	_i, F, B
	BRA	_20111_DS_
	BANKSEL	(_i + 1)
	INCF	(_i + 1), F, B
_20111_DS_:
	MOVLW	0x05
	BANKSEL	(_i + 1)
	SUBWF	(_i + 1), W, B
	BNZ	_00739_DS_
	MOVLW	0xdd
	BANKSEL	_i
	SUBWF	_i, W, B
_00739_DS_:
	BNC	_00340_DS_
_00133_DS_:
;	.line	119; output.c	if (numTela == STATE_ALARME) {
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00740_DS_
	MOVF	r0x01, W
	BZ	_00741_DS_
_00740_DS_:
	BRA	_00135_DS_
_00741_DS_:
;	.line	120; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	121; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	122; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	123; output.c	lcdString("   (");
	MOVLW	UPPER(___str_13)
	MOVWF	r0x06
	MOVLW	HIGH(___str_13)
	MOVWF	r0x05
	MOVLW	LOW(___str_13)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	124; output.c	lcdInt(getAlarmLevel(1));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	125; output.c	lcdString(",");
	MOVLW	UPPER(___str_14)
	MOVWF	r0x06
	MOVLW	HIGH(___str_14)
	MOVWF	r0x05
	MOVLW	LOW(___str_14)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	126; output.c	lcdInt(getAlarmLevel(2));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	127; output.c	lcdString(") ");
	MOVLW	UPPER(___str_15)
	MOVWF	r0x06
	MOVLW	HIGH(___str_15)
	MOVWF	r0x05
	MOVLW	LOW(___str_15)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	128; output.c	lcdInt(getMult());
	CALL	_getMult
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	129; output.c	lcdString("   ");
	MOVLW	UPPER(___str_16)
	MOVWF	r0x06
	MOVLW	HIGH(___str_16)
	MOVWF	r0x05
	MOVLW	LOW(___str_16)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00135_DS_:
;	.line	132; output.c	if (numTela == CONFIG_ALARME) {
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00742_DS_
	MOVF	r0x01, W
	BZ	_00743_DS_
_00742_DS_:
	BRA	_00141_DS_
_00743_DS_:
;	.line	133; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	134; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	135; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	136; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00137_DS_
;	.line	137; output.c	lcdString(" Configura tempo");
	MOVLW	UPPER(___str_17)
	MOVWF	r0x06
	MOVLW	HIGH(___str_17)
	MOVWF	r0x05
	MOVLW	LOW(___str_17)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00137_DS_:
;	.line	139; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00141_DS_
;	.line	140; output.c	lcdString(" Set time:       ");
	MOVLW	UPPER(___str_18)
	MOVWF	r0x06
	MOVLW	HIGH(___str_18)
	MOVWF	r0x05
	MOVLW	LOW(___str_18)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00141_DS_:
;	.line	145; output.c	if (numTela == ALARME_ALTO_DEC || numTela == ALARME_ALTO_UNI 
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00747_DS_
	MOVF	r0x01, W
	BZ	_00142_DS_
_00747_DS_:
;	.line	146; output.c	|| numTela == ALARME_BAIXO_DEC || numTela == ALARME_BAIXO_UNI ) {
	MOVF	r0x00, W
	XORLW	0x05
	BNZ	_00749_DS_
	MOVF	r0x01, W
	BZ	_00142_DS_
_00749_DS_:
	MOVF	r0x00, W
	XORLW	0x06
	BNZ	_00751_DS_
	MOVF	r0x01, W
	BZ	_00142_DS_
_00751_DS_:
	MOVF	r0x00, W
	XORLW	0x07
	BNZ	_00752_DS_
	MOVF	r0x01, W
	BZ	_00142_DS_
_00752_DS_:
	BRA	_00143_DS_
_00142_DS_:
;	.line	147; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	148; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	149; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	150; output.c	lcdString("      ");
	MOVLW	UPPER(___str_19)
	MOVWF	r0x06
	MOVLW	HIGH(___str_19)
	MOVWF	r0x05
	MOVLW	LOW(___str_19)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	151; output.c	lcdInt(getAlarmLevel(1));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	152; output.c	lcdString("      ");
	MOVLW	UPPER(___str_19)
	MOVWF	r0x06
	MOVLW	HIGH(___str_19)
	MOVWF	r0x05
	MOVLW	LOW(___str_19)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	153; output.c	lcdInt(getAlarmLevel(2));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getAlarmLevel
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
_00143_DS_:
;	.line	157; output.c	if (numTela == STATE_TEMPO) {
	MOVF	r0x00, W
	XORLW	0x08
	BNZ	_00754_DS_
	MOVF	r0x01, W
	BZ	_00755_DS_
_00754_DS_:
	BRA	_00152_DS_
_00755_DS_:
;	.line	158; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	159; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	160; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	161; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00148_DS_
;	.line	162; output.c	lcdString("*Configura tempo");
	MOVLW	UPPER(___str_20)
	MOVWF	r0x06
	MOVLW	HIGH(___str_20)
	MOVWF	r0x05
	MOVLW	LOW(___str_20)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00148_DS_:
;	.line	164; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00152_DS_
;	.line	165; output.c	lcdString("*Set time:      ");
	MOVLW	UPPER(___str_21)
	MOVWF	r0x06
	MOVLW	HIGH(___str_21)
	MOVWF	r0x05
	MOVLW	LOW(___str_21)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00152_DS_:
;	.line	170; output.c	if (numTela == CONFIG_TEMPO_DEC || numTela == CONFIG_TEMPO_UNI
	MOVF	r0x00, W
	XORLW	0x09
	BNZ	_00759_DS_
	MOVF	r0x01, W
	BZ	_00153_DS_
_00759_DS_:
;	.line	171; output.c	|| numTela == CONFIG_TEMPO_MULT) {
	MOVF	r0x00, W
	XORLW	0x0a
	BNZ	_00761_DS_
	MOVF	r0x01, W
	BZ	_00153_DS_
_00761_DS_:
	MOVF	r0x00, W
	XORLW	0x0b
	BNZ	_00762_DS_
	MOVF	r0x01, W
	BZ	_00153_DS_
_00762_DS_:
	BRA	_00154_DS_
_00153_DS_:
;	.line	172; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	173; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	174; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	175; output.c	lcdString("  ");
	MOVLW	UPPER(___str_3)
	MOVWF	r0x06
	MOVLW	HIGH(___str_3)
	MOVWF	r0x05
	MOVLW	LOW(___str_3)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	176; output.c	lcdInt(getTime()); // ver com o eudes o nome da função
	CALL	_getTime
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	177; output.c	lcdString("  ");
	MOVLW	UPPER(___str_3)
	MOVWF	r0x06
	MOVLW	HIGH(___str_3)
	MOVWF	r0x05
	MOVLW	LOW(___str_3)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	178; output.c	lcdInt(getMult()); // ver nome certo
	CALL	_getMult
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	179; output.c	lcdString("       ");
	MOVLW	UPPER(___str_22)
	MOVWF	r0x06
	MOVLW	HIGH(___str_22)
	MOVWF	r0x05
	MOVLW	LOW(___str_22)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00154_DS_:
;	.line	183; output.c	if (numTela == STATE_IDIOMA) {
	MOVF	r0x00, W
	XORLW	0x0c
	BNZ	_00764_DS_
	MOVF	r0x01, W
	BZ	_00765_DS_
_00764_DS_:
	BRA	_00162_DS_
_00765_DS_:
;	.line	184; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	185; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	186; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	187; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00158_DS_
;	.line	188; output.c	lcdString("Portugues       ");
	MOVLW	UPPER(___str_23)
	MOVWF	r0x06
	MOVLW	HIGH(___str_23)
	MOVWF	r0x05
	MOVLW	LOW(___str_23)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00158_DS_:
;	.line	190; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00162_DS_
;	.line	191; output.c	lcdString("English         ");
	MOVLW	UPPER(___str_24)
	MOVWF	r0x06
	MOVLW	HIGH(___str_24)
	MOVWF	r0x05
	MOVLW	LOW(___str_24)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00162_DS_:
;	.line	195; output.c	if (numTela == CONFIG_IDIOMA) {
	MOVF	r0x00, W
	XORLW	0x0d
	BNZ	_00768_DS_
	MOVF	r0x01, W
	BZ	_00769_DS_
_00768_DS_:
	BRA	_00168_DS_
_00769_DS_:
;	.line	196; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	197; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	198; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	199; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00164_DS_
;	.line	200; output.c	lcdString("*Portugues      ");
	MOVLW	UPPER(___str_25)
	MOVWF	r0x06
	MOVLW	HIGH(___str_25)
	MOVWF	r0x05
	MOVLW	LOW(___str_25)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00164_DS_:
;	.line	202; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00168_DS_
;	.line	203; output.c	lcdString("*English        ");
	MOVLW	UPPER(___str_26)
	MOVWF	r0x06
	MOVLW	HIGH(___str_26)
	MOVWF	r0x05
	MOVLW	LOW(___str_26)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00168_DS_:
;	.line	207; output.c	if (numTela == STATE_PERIODO) {
	MOVF	r0x00, W
	XORLW	0x0e
	BNZ	_00772_DS_
	MOVF	r0x01, W
	BZ	_00773_DS_
_00772_DS_:
	BRA	_00170_DS_
_00773_DS_:
;	.line	208; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	209; output.c	lcdString(msgs[numTela][idioma]);   
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	210; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	211; output.c	lcdString("                "); //comentar essa linha
	MOVLW	UPPER(___str_5)
	MOVWF	r0x06
	MOVLW	HIGH(___str_5)
	MOVWF	r0x05
	MOVLW	LOW(___str_5)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00170_DS_:
;	.line	223; output.c	if (numTela == STATE_DATA) {
	MOVF	r0x00, W
	XORLW	0x0f
	BNZ	_00774_DS_
	MOVF	r0x01, W
	BZ	_00775_DS_
_00774_DS_:
	BRA	_00176_DS_
_00775_DS_:
;	.line	224; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	226; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	227; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	228; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00172_DS_
;	.line	229; output.c	lcdString(" Hora           ");
	MOVLW	UPPER(___str_27)
	MOVWF	r0x06
	MOVLW	HIGH(___str_27)
	MOVWF	r0x05
	MOVLW	LOW(___str_27)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00172_DS_:
;	.line	231; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00176_DS_
;	.line	232; output.c	lcdString(" Hour           ");
	MOVLW	UPPER(___str_28)
	MOVWF	r0x06
	MOVLW	HIGH(___str_28)
	MOVWF	r0x05
	MOVLW	LOW(___str_28)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00176_DS_:
;	.line	237; output.c	if (numTela == CONFIG_DATA_D || numTela == CONFIG_DATA_M || numTela == CONFIG_DATA_A) {
	MOVF	r0x00, W
	XORLW	0x10
	BNZ	_00779_DS_
	MOVF	r0x01, W
	BZ	_00177_DS_
_00779_DS_:
	MOVF	r0x00, W
	XORLW	0x11
	BNZ	_00781_DS_
	MOVF	r0x01, W
	BZ	_00177_DS_
_00781_DS_:
	MOVF	r0x00, W
	XORLW	0x12
	BNZ	_00782_DS_
	MOVF	r0x01, W
	BZ	_00177_DS_
_00782_DS_:
	BRA	_00178_DS_
_00177_DS_:
;	.line	238; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	239; output.c	lcdString(msgs[numTela][idioma]);   
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	240; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	241; output.c	lcdInt(getPeriodo(3));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	_getPeriodo
	MOVWF	r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	CLRF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	242; output.c	lcdString("/");
	MOVLW	UPPER(___str_2)
	MOVWF	r0x06
	MOVLW	HIGH(___str_2)
	MOVWF	r0x05
	MOVLW	LOW(___str_2)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	243; output.c	lcdInt(getPeriodo(4));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x04
	MOVWF	POSTDEC1
	CALL	_getPeriodo
	MOVWF	r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	CLRF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	244; output.c	lcdString("/");
	MOVLW	UPPER(___str_2)
	MOVWF	r0x06
	MOVLW	HIGH(___str_2)
	MOVWF	r0x05
	MOVLW	LOW(___str_2)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	245; output.c	lcdInt(getPeriodo(5));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x05
	MOVWF	POSTDEC1
	CALL	_getPeriodo
	MOVWF	r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	CLRF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	246; output.c	lcdString("        ");
	MOVLW	UPPER(___str_29)
	MOVWF	r0x06
	MOVLW	HIGH(___str_29)
	MOVWF	r0x05
	MOVLW	LOW(___str_29)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00178_DS_:
;	.line	250; output.c	if (numTela == STATE_HORA) {
	MOVF	r0x00, W
	XORLW	0x13
	BNZ	_00784_DS_
	MOVF	r0x01, W
	BZ	_00785_DS_
_00784_DS_:
	BRA	_00186_DS_
_00785_DS_:
;	.line	251; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	253; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	254; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	255; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00182_DS_
;	.line	256; output.c	lcdString("*Hora           ");
	MOVLW	UPPER(___str_30)
	MOVWF	r0x06
	MOVLW	HIGH(___str_30)
	MOVWF	r0x05
	MOVLW	LOW(___str_30)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00182_DS_:
;	.line	258; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00186_DS_
;	.line	259; output.c	lcdString("*Hour           ");
	MOVLW	UPPER(___str_31)
	MOVWF	r0x06
	MOVLW	HIGH(___str_31)
	MOVWF	r0x05
	MOVLW	LOW(___str_31)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00186_DS_:
;	.line	263; output.c	if (numTela == CONFIG_HORA || numTela == CONFIG_MINUTOS_DEC
	MOVF	r0x00, W
	XORLW	0x14
	BNZ	_00789_DS_
	MOVF	r0x01, W
	BZ	_00187_DS_
_00789_DS_:
;	.line	264; output.c	|| numTela == CONFIG_MINUTOS_UNI) {
	MOVF	r0x00, W
	XORLW	0x15
	BNZ	_00791_DS_
	MOVF	r0x01, W
	BZ	_00187_DS_
_00791_DS_:
	MOVF	r0x00, W
	XORLW	0x16
	BNZ	_00792_DS_
	MOVF	r0x01, W
	BZ	_00187_DS_
_00792_DS_:
	BRA	_00188_DS_
_00187_DS_:
;	.line	265; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	266; output.c	lcdString(msgs[numTela][idioma]);   
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	267; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	268; output.c	lcdString("  ");
	MOVLW	UPPER(___str_3)
	MOVWF	r0x06
	MOVLW	HIGH(___str_3)
	MOVWF	r0x05
	MOVLW	LOW(___str_3)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	269; output.c	lcdInt(getPeriodo(1));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	MOVWF	POSTDEC1
	CALL	_getPeriodo
	MOVWF	r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	CLRF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	270; output.c	lcdString(":");
	MOVLW	UPPER(___str_4)
	MOVWF	r0x06
	MOVLW	HIGH(___str_4)
	MOVWF	r0x05
	MOVLW	LOW(___str_4)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	271; output.c	lcdInt(getPeriodo(2));
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	CALL	_getPeriodo
	MOVWF	r0x04
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
	CLRF	r0x05
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdInt
	MOVF	POSTINC1, F
	MOVF	POSTINC1, F
;	.line	272; output.c	lcdString("         ");
	MOVLW	UPPER(___str_32)
	MOVWF	r0x06
	MOVLW	HIGH(___str_32)
	MOVWF	r0x05
	MOVLW	LOW(___str_32)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00188_DS_:
;	.line	275; output.c	if (numTela == STATE_SECURITY) {
	MOVF	r0x00, W
	XORLW	0x17
	BNZ	_00794_DS_
	MOVF	r0x01, W
	BZ	_00795_DS_
_00794_DS_:
	BRA	_00192_DS_
_00795_DS_:
;	.line	276; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	277; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	278; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	279; output.c	lcdString("                ");
	MOVLW	UPPER(___str_5)
	MOVWF	r0x06
	MOVLW	HIGH(___str_5)
	MOVWF	r0x05
	MOVLW	LOW(___str_5)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00192_DS_:
;	.line	283; output.c	if (numTela == CONFIG_SENHA) {
	MOVF	r0x00, W
	XORLW	0x18
	BNZ	_00796_DS_
	MOVF	r0x01, W
	BZ	_00797_DS_
_00796_DS_:
	BRA	_00198_DS_
_00797_DS_:
;	.line	284; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	285; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	286; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	287; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00194_DS_
;	.line	288; output.c	lcdString(" Habilitar senha");
	MOVLW	UPPER(___str_33)
	MOVWF	r0x06
	MOVLW	HIGH(___str_33)
	MOVWF	r0x05
	MOVLW	LOW(___str_33)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00194_DS_:
;	.line	290; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00198_DS_
;	.line	291; output.c	lcdString(" Enable password");
	MOVLW	UPPER(___str_34)
	MOVWF	r0x06
	MOVLW	HIGH(___str_34)
	MOVWF	r0x05
	MOVLW	LOW(___str_34)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00198_DS_:
;	.line	295; output.c	if (numTela == SECURITY_SENHA) {
	MOVF	r0x00, W
	XORLW	0x19
	BNZ	_00800_DS_
	MOVF	r0x01, W
	BZ	_00801_DS_
_00800_DS_:
	BRA	_00219_DS_
_00801_DS_:
;	.line	296; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	297; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	298; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	299; output.c	if(getSenha_i() == 0 ){
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	IORWF	r0x05, W
	BNZ	_00200_DS_
;	.line	300; output.c	lcdString("                "); 
	MOVLW	UPPER(___str_5)
	MOVWF	r0x06
	MOVLW	HIGH(___str_5)
	MOVWF	r0x05
	MOVLW	LOW(___str_5)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00200_DS_:
;	.line	302; output.c	if(getSenha_i() == 1 ){
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00802_DS_
	MOVF	r0x05, W
	BZ	_00803_DS_
_00802_DS_:
	BRA	_00202_DS_
_00803_DS_:
;	.line	303; output.c	lcdString("*               "); 
	MOVLW	UPPER(___str_6)
	MOVWF	r0x06
	MOVLW	HIGH(___str_6)
	MOVWF	r0x05
	MOVLW	LOW(___str_6)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00202_DS_:
;	.line	305; output.c	if(getSenha_i() == 2 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x02
	BNZ	_00804_DS_
	MOVF	r0x05, W
	BZ	_00805_DS_
_00804_DS_:
	BRA	_00204_DS_
_00805_DS_:
;	.line	306; output.c	lcdString("**              "); 
	MOVLW	UPPER(___str_7)
	MOVWF	r0x06
	MOVLW	HIGH(___str_7)
	MOVWF	r0x05
	MOVLW	LOW(___str_7)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00204_DS_:
;	.line	308; output.c	if(getSenha_i() == 3 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x03
	BNZ	_00806_DS_
	MOVF	r0x05, W
	BZ	_00807_DS_
_00806_DS_:
	BRA	_00206_DS_
_00807_DS_:
;	.line	309; output.c	lcdString("***            "); 
	MOVLW	UPPER(___str_8)
	MOVWF	r0x06
	MOVLW	HIGH(___str_8)
	MOVWF	r0x05
	MOVLW	LOW(___str_8)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00206_DS_:
;	.line	311; output.c	if(getSenha_i() == 4 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x04
	BNZ	_00808_DS_
	MOVF	r0x05, W
	BZ	_00809_DS_
_00808_DS_:
	BRA	_00208_DS_
_00809_DS_:
;	.line	312; output.c	lcdString("****           "); 
	MOVLW	UPPER(___str_9)
	MOVWF	r0x06
	MOVLW	HIGH(___str_9)
	MOVWF	r0x05
	MOVLW	LOW(___str_9)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00208_DS_:
;	.line	314; output.c	if(getSenha_i() == 5 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x05
	BNZ	_00810_DS_
	MOVF	r0x05, W
	BZ	_00811_DS_
_00810_DS_:
	BRA	_00210_DS_
_00811_DS_:
;	.line	315; output.c	lcdString("*****          "); 
	MOVLW	UPPER(___str_10)
	MOVWF	r0x06
	MOVLW	HIGH(___str_10)
	MOVWF	r0x05
	MOVLW	LOW(___str_10)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00210_DS_:
;	.line	317; output.c	if(getSenha_try() == 3){
	CALL	_getSenha_try
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x03
	BNZ	_00812_DS_
	MOVF	r0x05, W
	BZ	_00813_DS_
_00812_DS_:
	BRA	_00219_DS_
_00813_DS_:
;	.line	318; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	319; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00212_DS_
;	.line	320; output.c	lcdString("Senha incorreta!");
	MOVLW	UPPER(___str_11)
	MOVWF	r0x06
	MOVLW	HIGH(___str_11)
	MOVWF	r0x05
	MOVLW	LOW(___str_11)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00212_DS_:
;	.line	322; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00214_DS_
;	.line	323; output.c	lcdString("Wrong password! ");
	MOVLW	UPPER(___str_12)
	MOVWF	r0x06
	MOVLW	HIGH(___str_12)
	MOVWF	r0x05
	MOVLW	LOW(___str_12)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00214_DS_:
	BANKSEL	_i
;	.line	325; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	CLRF	_i, B
	BANKSEL	(_i + 1)
	CLRF	(_i + 1), B
_00342_DS_:
;	.line	326; output.c	Delay2ms(); 
	CALL	_Delay2ms
	BANKSEL	_i
;	.line	325; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	INCFSZ	_i, F, B
	BRA	_30112_DS_
	BANKSEL	(_i + 1)
	INCF	(_i + 1), F, B
_30112_DS_:
	MOVLW	0x05
	BANKSEL	(_i + 1)
	SUBWF	(_i + 1), W, B
	BNZ	_00816_DS_
	MOVLW	0xdd
	BANKSEL	_i
	SUBWF	_i, W, B
_00816_DS_:
	BNC	_00342_DS_
_00219_DS_:
;	.line	331; output.c	if (numTela == NOVA_SENHA) {
	MOVF	r0x00, W
	XORLW	0x1a
	BNZ	_00817_DS_
	MOVF	r0x01, W
	BZ	_00818_DS_
_00817_DS_:
	GOTO	_00260_DS_
_00818_DS_:
;	.line	332; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	333; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	334; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	335; output.c	if(getSenha_i() == 0 ){
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	IORWF	r0x05, W
	BNZ	_00221_DS_
;	.line	336; output.c	lcdString("                "); 
	MOVLW	UPPER(___str_5)
	MOVWF	r0x06
	MOVLW	HIGH(___str_5)
	MOVWF	r0x05
	MOVLW	LOW(___str_5)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00221_DS_:
;	.line	338; output.c	if(getSenha_i() == 1 ){
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00819_DS_
	MOVF	r0x05, W
	BZ	_00820_DS_
_00819_DS_:
	BRA	_00223_DS_
_00820_DS_:
;	.line	339; output.c	lcdString("*               "); 
	MOVLW	UPPER(___str_6)
	MOVWF	r0x06
	MOVLW	HIGH(___str_6)
	MOVWF	r0x05
	MOVLW	LOW(___str_6)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00223_DS_:
;	.line	341; output.c	if(getSenha_i() == 2 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x02
	BNZ	_00821_DS_
	MOVF	r0x05, W
	BZ	_00822_DS_
_00821_DS_:
	BRA	_00225_DS_
_00822_DS_:
;	.line	342; output.c	lcdString("**              "); 
	MOVLW	UPPER(___str_7)
	MOVWF	r0x06
	MOVLW	HIGH(___str_7)
	MOVWF	r0x05
	MOVLW	LOW(___str_7)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00225_DS_:
;	.line	344; output.c	if(getSenha_i() == 3 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x03
	BNZ	_00823_DS_
	MOVF	r0x05, W
	BZ	_00824_DS_
_00823_DS_:
	BRA	_00227_DS_
_00824_DS_:
;	.line	345; output.c	lcdString("***             "); 
	MOVLW	UPPER(___str_35)
	MOVWF	r0x06
	MOVLW	HIGH(___str_35)
	MOVWF	r0x05
	MOVLW	LOW(___str_35)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00227_DS_:
;	.line	347; output.c	if(getSenha_i() == 4 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x04
	BNZ	_00825_DS_
	MOVF	r0x05, W
	BZ	_00826_DS_
_00825_DS_:
	BRA	_00229_DS_
_00826_DS_:
;	.line	348; output.c	lcdString("****            "); 
	MOVLW	UPPER(___str_36)
	MOVWF	r0x06
	MOVLW	HIGH(___str_36)
	MOVWF	r0x05
	MOVLW	LOW(___str_36)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00229_DS_:
;	.line	350; output.c	if(getSenha_i() == 5 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x05
	BNZ	_00827_DS_
	MOVF	r0x05, W
	BZ	_00828_DS_
_00827_DS_:
	BRA	_00231_DS_
_00828_DS_:
;	.line	351; output.c	lcdString("*****           "); 
	MOVLW	UPPER(___str_37)
	MOVWF	r0x06
	MOVLW	HIGH(___str_37)
	MOVWF	r0x05
	MOVLW	LOW(___str_37)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00231_DS_:
;	.line	357; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	358; output.c	if(getSenha_i() == 5 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x05
	BNZ	_00829_DS_
	MOVF	r0x05, W
	BZ	_00830_DS_
_00829_DS_:
	BRA	_00233_DS_
_00830_DS_:
;	.line	359; output.c	lcdString("                "); 
	MOVLW	UPPER(___str_5)
	MOVWF	r0x06
	MOVLW	HIGH(___str_5)
	MOVWF	r0x05
	MOVLW	LOW(___str_5)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00233_DS_:
;	.line	361; output.c	if(getSenha_i() == 6 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x06
	BNZ	_00831_DS_
	MOVF	r0x05, W
	BZ	_00832_DS_
_00831_DS_:
	BRA	_00235_DS_
_00832_DS_:
;	.line	362; output.c	lcdString("*               "); 
	MOVLW	UPPER(___str_6)
	MOVWF	r0x06
	MOVLW	HIGH(___str_6)
	MOVWF	r0x05
	MOVLW	LOW(___str_6)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00235_DS_:
;	.line	364; output.c	if(getSenha_i() == 7 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x07
	BNZ	_00833_DS_
	MOVF	r0x05, W
	BZ	_00834_DS_
_00833_DS_:
	BRA	_00237_DS_
_00834_DS_:
;	.line	365; output.c	lcdString("**              "); 
	MOVLW	UPPER(___str_7)
	MOVWF	r0x06
	MOVLW	HIGH(___str_7)
	MOVWF	r0x05
	MOVLW	LOW(___str_7)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00237_DS_:
;	.line	367; output.c	if(getSenha_i() == 8 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x08
	BNZ	_00835_DS_
	MOVF	r0x05, W
	BZ	_00836_DS_
_00835_DS_:
	BRA	_00239_DS_
_00836_DS_:
;	.line	368; output.c	lcdString("***             "); 
	MOVLW	UPPER(___str_35)
	MOVWF	r0x06
	MOVLW	HIGH(___str_35)
	MOVWF	r0x05
	MOVLW	LOW(___str_35)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00239_DS_:
;	.line	370; output.c	if(getSenha_i() == 9 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x09
	BNZ	_00837_DS_
	MOVF	r0x05, W
	BZ	_00838_DS_
_00837_DS_:
	BRA	_00241_DS_
_00838_DS_:
;	.line	371; output.c	lcdString("****            "); 
	MOVLW	UPPER(___str_36)
	MOVWF	r0x06
	MOVLW	HIGH(___str_36)
	MOVWF	r0x05
	MOVLW	LOW(___str_36)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00241_DS_:
;	.line	373; output.c	if(getSenha_i() == 10 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x0a
	BNZ	_00839_DS_
	MOVF	r0x05, W
	BZ	_00840_DS_
_00839_DS_:
	BRA	_00244_DS_
_00840_DS_:
;	.line	374; output.c	lcdString("*****           ");
	MOVLW	UPPER(___str_37)
	MOVWF	r0x06
	MOVLW	HIGH(___str_37)
	MOVWF	r0x05
	MOVLW	LOW(___str_37)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_i
;	.line	375; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	CLRF	_i, B
	BANKSEL	(_i + 1)
	CLRF	(_i + 1), B
_00344_DS_:
;	.line	376; output.c	Delay2ms(); 
	CALL	_Delay2ms
	BANKSEL	_i
;	.line	375; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	INCFSZ	_i, F, B
	BRA	_40113_DS_
	BANKSEL	(_i + 1)
	INCF	(_i + 1), F, B
_40113_DS_:
	MOVLW	0x05
	BANKSEL	(_i + 1)
	SUBWF	(_i + 1), W, B
	BNZ	_00841_DS_
	MOVLW	0xdd
	BANKSEL	_i
	SUBWF	_i, W, B
_00841_DS_:
	BNC	_00344_DS_
_00244_DS_:
;	.line	379; output.c	if(getSenha_try() == 1){
	CALL	_getSenha_try
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00842_DS_
	MOVF	r0x05, W
	BZ	_00843_DS_
_00842_DS_:
	BRA	_00251_DS_
_00843_DS_:
;	.line	380; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	381; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00246_DS_
;	.line	382; output.c	lcdString("Senha incorreta!");
	MOVLW	UPPER(___str_11)
	MOVWF	r0x06
	MOVLW	HIGH(___str_11)
	MOVWF	r0x05
	MOVLW	LOW(___str_11)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00246_DS_:
;	.line	384; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00248_DS_
;	.line	385; output.c	lcdString("Wrong password! ");
	MOVLW	UPPER(___str_12)
	MOVWF	r0x06
	MOVLW	HIGH(___str_12)
	MOVWF	r0x05
	MOVLW	LOW(___str_12)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00248_DS_:
	BANKSEL	_i
;	.line	387; output.c	for (i = 0; i <= 1500; i++) {
	CLRF	_i, B
	BANKSEL	(_i + 1)
	CLRF	(_i + 1), B
_00346_DS_:
;	.line	388; output.c	Delay2ms(); 
	CALL	_Delay2ms
	BANKSEL	_i
;	.line	387; output.c	for (i = 0; i <= 1500; i++) {
	INCFSZ	_i, F, B
	BRA	_50114_DS_
	BANKSEL	(_i + 1)
	INCF	(_i + 1), F, B
_50114_DS_:
	MOVLW	0x05
	BANKSEL	(_i + 1)
	SUBWF	(_i + 1), W, B
	BNZ	_00846_DS_
	MOVLW	0xdd
	BANKSEL	_i
	SUBWF	_i, W, B
_00846_DS_:
	BNC	_00346_DS_
_00251_DS_:
;	.line	391; output.c	if(getTestResult()){
	CALL	_getTestResult
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	IORWF	r0x05, W
	BTFSC	STATUS, 2
	BRA	_00260_DS_
;	.line	392; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	393; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00253_DS_
;	.line	394; output.c	lcdString("Senha alterada! ");
	MOVLW	UPPER(___str_38)
	MOVWF	r0x06
	MOVLW	HIGH(___str_38)
	MOVWF	r0x05
	MOVLW	LOW(___str_38)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00253_DS_:
;	.line	396; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00255_DS_
;	.line	397; output.c	lcdString("Password changed!");
	MOVLW	UPPER(___str_39)
	MOVWF	r0x06
	MOVLW	HIGH(___str_39)
	MOVWF	r0x05
	MOVLW	LOW(___str_39)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00255_DS_:
	BANKSEL	_i
;	.line	399; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	CLRF	_i, B
	BANKSEL	(_i + 1)
	CLRF	(_i + 1), B
_00348_DS_:
;	.line	400; output.c	Delay2ms(); 
	CALL	_Delay2ms
	BANKSEL	_i
;	.line	399; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	INCFSZ	_i, F, B
	BRA	_60115_DS_
	BANKSEL	(_i + 1)
	INCF	(_i + 1), F, B
_60115_DS_:
	MOVLW	0x05
	BANKSEL	(_i + 1)
	SUBWF	(_i + 1), W, B
	BNZ	_00849_DS_
	MOVLW	0xdd
	BANKSEL	_i
	SUBWF	_i, W, B
_00849_DS_:
	BNC	_00348_DS_
_00260_DS_:
;	.line	405; output.c	if(numTela == AGUARDO){
	MOVF	r0x00, W
	XORLW	0x21
	BNZ	_00850_DS_
	MOVF	r0x01, W
	BZ	_00851_DS_
_00850_DS_:
	BRA	_00267_DS_
_00851_DS_:
;	.line	406; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	407; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00262_DS_
;	.line	408; output.c	lcdString("Insira novamente");
	MOVLW	UPPER(___str_40)
	MOVWF	r0x06
	MOVLW	HIGH(___str_40)
	MOVWF	r0x05
	MOVLW	LOW(___str_40)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00262_DS_:
;	.line	410; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00264_DS_
;	.line	411; output.c	lcdString("Please re-enter ");
	MOVLW	UPPER(___str_41)
	MOVWF	r0x06
	MOVLW	HIGH(___str_41)
	MOVWF	r0x05
	MOVLW	LOW(___str_41)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00264_DS_:
	BANKSEL	_i
;	.line	413; output.c	for (i = 0; i <= 1500; i++){
	CLRF	_i, B
	BANKSEL	(_i + 1)
	CLRF	(_i + 1), B
_00350_DS_:
;	.line	414; output.c	Delay2ms();
	CALL	_Delay2ms
	BANKSEL	_i
;	.line	413; output.c	for (i = 0; i <= 1500; i++){
	INCFSZ	_i, F, B
	BRA	_70116_DS_
	BANKSEL	(_i + 1)
	INCF	(_i + 1), F, B
_70116_DS_:
	MOVLW	0x05
	BANKSEL	(_i + 1)
	SUBWF	(_i + 1), W, B
	BNZ	_00854_DS_
	MOVLW	0xdd
	BANKSEL	_i
	SUBWF	_i, W, B
_00854_DS_:
	BNC	_00350_DS_
_00267_DS_:
;	.line	417; output.c	if (numTela == CONFIG_HABILITA) {
	MOVF	r0x00, W
	XORLW	0x1b
	BNZ	_00855_DS_
	MOVF	r0x01, W
	BZ	_00856_DS_
_00855_DS_:
	BRA	_00273_DS_
_00856_DS_:
;	.line	418; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	419; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	420; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	421; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00269_DS_
;	.line	422; output.c	lcdString("*Habilitar senha");
	MOVLW	UPPER(___str_42)
	MOVWF	r0x06
	MOVLW	HIGH(___str_42)
	MOVWF	r0x05
	MOVLW	LOW(___str_42)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00269_DS_:
;	.line	424; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00273_DS_
;	.line	425; output.c	lcdString("*Enable password");
	MOVLW	UPPER(___str_43)
	MOVWF	r0x06
	MOVLW	HIGH(___str_43)
	MOVWF	r0x05
	MOVLW	LOW(___str_43)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00273_DS_:
;	.line	431; output.c	if (numTela == SECURITY_HABILITA) {
	MOVF	r0x00, W
	XORLW	0x1c
	BNZ	_00859_DS_
	MOVF	r0x01, W
	BZ	_00860_DS_
_00859_DS_:
	BRA	_00295_DS_
_00860_DS_:
;	.line	432; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	433; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	434; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	435; output.c	if(getSenha_i() == 0 ){
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	IORWF	r0x05, W
	BNZ	_00275_DS_
;	.line	436; output.c	lcdString("                "); 
	MOVLW	UPPER(___str_5)
	MOVWF	r0x06
	MOVLW	HIGH(___str_5)
	MOVWF	r0x05
	MOVLW	LOW(___str_5)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00275_DS_:
;	.line	438; output.c	if(getSenha_i() == 1 ){
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00861_DS_
	MOVF	r0x05, W
	BZ	_00862_DS_
_00861_DS_:
	BRA	_00277_DS_
_00862_DS_:
;	.line	439; output.c	lcdString("*               "); 
	MOVLW	UPPER(___str_6)
	MOVWF	r0x06
	MOVLW	HIGH(___str_6)
	MOVWF	r0x05
	MOVLW	LOW(___str_6)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00277_DS_:
;	.line	441; output.c	if(getSenha_i() == 2 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x02
	BNZ	_00863_DS_
	MOVF	r0x05, W
	BZ	_00864_DS_
_00863_DS_:
	BRA	_00279_DS_
_00864_DS_:
;	.line	442; output.c	lcdString("**              "); 
	MOVLW	UPPER(___str_7)
	MOVWF	r0x06
	MOVLW	HIGH(___str_7)
	MOVWF	r0x05
	MOVLW	LOW(___str_7)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00279_DS_:
;	.line	444; output.c	if(getSenha_i() == 3 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x03
	BNZ	_00865_DS_
	MOVF	r0x05, W
	BZ	_00866_DS_
_00865_DS_:
	BRA	_00281_DS_
_00866_DS_:
;	.line	445; output.c	lcdString("***            "); 
	MOVLW	UPPER(___str_8)
	MOVWF	r0x06
	MOVLW	HIGH(___str_8)
	MOVWF	r0x05
	MOVLW	LOW(___str_8)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00281_DS_:
;	.line	447; output.c	if(getSenha_i() == 4 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x04
	BNZ	_00867_DS_
	MOVF	r0x05, W
	BZ	_00868_DS_
_00867_DS_:
	BRA	_00283_DS_
_00868_DS_:
;	.line	448; output.c	lcdString("****           "); 
	MOVLW	UPPER(___str_9)
	MOVWF	r0x06
	MOVLW	HIGH(___str_9)
	MOVWF	r0x05
	MOVLW	LOW(___str_9)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00283_DS_:
;	.line	450; output.c	if(getSenha_i() == 5 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x05
	BNZ	_00869_DS_
	MOVF	r0x05, W
	BZ	_00870_DS_
_00869_DS_:
	BRA	_00286_DS_
_00870_DS_:
;	.line	451; output.c	lcdString("*****          "); 
	MOVLW	UPPER(___str_10)
	MOVWF	r0x06
	MOVLW	HIGH(___str_10)
	MOVWF	r0x05
	MOVLW	LOW(___str_10)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
	BANKSEL	_i
;	.line	452; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	CLRF	_i, B
	BANKSEL	(_i + 1)
	CLRF	(_i + 1), B
_00352_DS_:
;	.line	453; output.c	Delay2ms(); 
	CALL	_Delay2ms
	BANKSEL	_i
;	.line	452; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	INCFSZ	_i, F, B
	BRA	_80117_DS_
	BANKSEL	(_i + 1)
	INCF	(_i + 1), F, B
_80117_DS_:
	MOVLW	0x05
	BANKSEL	(_i + 1)
	SUBWF	(_i + 1), W, B
	BNZ	_00871_DS_
	MOVLW	0xdd
	BANKSEL	_i
	SUBWF	_i, W, B
_00871_DS_:
	BNC	_00352_DS_
_00286_DS_:
;	.line	456; output.c	if(getSenha_try() == 3){
	CALL	_getSenha_try
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVF	r0x04, W
	XORLW	0x03
	BNZ	_00872_DS_
	MOVF	r0x05, W
	BZ	_00873_DS_
_00872_DS_:
	BRA	_00295_DS_
_00873_DS_:
;	.line	457; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	458; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00288_DS_
;	.line	459; output.c	lcdString("Senha incorreta!");
	MOVLW	UPPER(___str_11)
	MOVWF	r0x06
	MOVLW	HIGH(___str_11)
	MOVWF	r0x05
	MOVLW	LOW(___str_11)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00288_DS_:
;	.line	461; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00290_DS_
;	.line	462; output.c	lcdString("Wrong password! ");
	MOVLW	UPPER(___str_12)
	MOVWF	r0x06
	MOVLW	HIGH(___str_12)
	MOVWF	r0x05
	MOVLW	LOW(___str_12)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00290_DS_:
	BANKSEL	_i
;	.line	464; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	CLRF	_i, B
	BANKSEL	(_i + 1)
	CLRF	(_i + 1), B
_00354_DS_:
;	.line	465; output.c	Delay2ms(); 
	CALL	_Delay2ms
	BANKSEL	_i
;	.line	464; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	INCFSZ	_i, F, B
	BRA	_90118_DS_
	BANKSEL	(_i + 1)
	INCF	(_i + 1), F, B
_90118_DS_:
	MOVLW	0x05
	BANKSEL	(_i + 1)
	SUBWF	(_i + 1), W, B
	BNZ	_00876_DS_
	MOVLW	0xdd
	BANKSEL	_i
	SUBWF	_i, W, B
_00876_DS_:
	BNC	_00354_DS_
_00295_DS_:
;	.line	470; output.c	if(numTela == HABILITA_SENHA){   
	MOVF	r0x00, W
	XORLW	0x1d
	BNZ	_00877_DS_
	MOVF	r0x01, W
	BZ	_00878_DS_
_00877_DS_:
	BRA	_00301_DS_
_00878_DS_:
;	.line	471; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	472; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	473; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	474; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00297_DS_
;	.line	475; output.c	lcdString(" Desabilitar    ");
	MOVLW	UPPER(___str_44)
	MOVWF	r0x06
	MOVLW	HIGH(___str_44)
	MOVWF	r0x05
	MOVLW	LOW(___str_44)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00297_DS_:
;	.line	477; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00301_DS_
;	.line	478; output.c	lcdString(" Disable        "); 
	MOVLW	UPPER(___str_45)
	MOVWF	r0x06
	MOVLW	HIGH(___str_45)
	MOVWF	r0x05
	MOVLW	LOW(___str_45)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00301_DS_:
;	.line	482; output.c	if(numTela == DESABILITA_SENHA){   
	MOVF	r0x00, W
	XORLW	0x1e
	BNZ	_00881_DS_
	MOVF	r0x01, W
	BZ	_00882_DS_
_00881_DS_:
	BRA	_00307_DS_
_00882_DS_:
;	.line	483; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	484; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	485; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	486; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	BNZ	_00303_DS_
;	.line	487; output.c	lcdString("*Desabilitar    ");
	MOVLW	UPPER(___str_46)
	MOVWF	r0x06
	MOVLW	HIGH(___str_46)
	MOVWF	r0x05
	MOVLW	LOW(___str_46)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00303_DS_:
;	.line	489; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x04
	MOVF	r0x04, W
	XORLW	0x01
	BNZ	_00307_DS_
;	.line	490; output.c	lcdString("*Disable        "); 
	MOVLW	UPPER(___str_47)
	MOVWF	r0x06
	MOVLW	HIGH(___str_47)
	MOVWF	r0x05
	MOVLW	LOW(___str_47)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00307_DS_:
;	.line	494; output.c	if (numTela == STATE_RESET) {
	MOVF	r0x00, W
	XORLW	0x1f
	BNZ	_00885_DS_
	MOVF	r0x01, W
	BZ	_00886_DS_
_00885_DS_:
	BRA	_00309_DS_
_00886_DS_:
;	.line	495; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	496; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x04
	MOVFF	PRODL, r0x05
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x04, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x05, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x06
	MOVFF	PRODL, r0x07
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x06, W
	ADDWF	r0x04, F
	MOVF	r0x07, W
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVFF	POSTINC0, r0x04
	MOVFF	POSTINC0, r0x05
	MOVFF	INDF0, r0x06
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	497; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	498; output.c	lcdString("                ");
	MOVLW	UPPER(___str_5)
	MOVWF	r0x06
	MOVLW	HIGH(___str_5)
	MOVWF	r0x05
	MOVLW	LOW(___str_5)
	MOVWF	r0x04
	MOVF	r0x06, W
	MOVWF	POSTDEC1
	MOVF	r0x05, W
	MOVWF	POSTDEC1
	MOVF	r0x04, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00309_DS_:
;	.line	501; output.c	if (numTela == SECURITY_RESET) {
	MOVF	r0x00, W
	XORLW	0x20
	BNZ	_00887_DS_
	MOVF	r0x01, W
	BZ	_00888_DS_
_00887_DS_:
	BRA	_00360_DS_
_00888_DS_:
;	.line	502; output.c	lcdCommand(0x80);
	MOVLW	0x80
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	503; output.c	lcdString(msgs[numTela][idioma]);
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x06
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_msgs)
	ADDWF	r0x00, F
	MOVLW	HIGH(_msgs)
	ADDWFC	r0x01, F
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x03
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x02
	MOVFF	PRODL, r0x03
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	POSTINC0, r0x00
	MOVFF	POSTINC0, r0x01
	MOVFF	INDF0, r0x02
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
;	.line	504; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	505; output.c	if(getSenha_i() == 0 ){
	CALL	_getSenha_i
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x00, W
	IORWF	r0x01, W
	BNZ	_00311_DS_
;	.line	506; output.c	lcdString("                "); 
	MOVLW	UPPER(___str_5)
	MOVWF	r0x02
	MOVLW	HIGH(___str_5)
	MOVWF	r0x01
	MOVLW	LOW(___str_5)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00311_DS_:
;	.line	508; output.c	if(getSenha_i() == 1 ){
	CALL	_getSenha_i
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00889_DS_
	MOVF	r0x01, W
	BZ	_00890_DS_
_00889_DS_:
	BRA	_00313_DS_
_00890_DS_:
;	.line	509; output.c	lcdString("*               "); 
	MOVLW	UPPER(___str_6)
	MOVWF	r0x02
	MOVLW	HIGH(___str_6)
	MOVWF	r0x01
	MOVLW	LOW(___str_6)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00313_DS_:
;	.line	511; output.c	if(getSenha_i() == 2 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00891_DS_
	MOVF	r0x01, W
	BZ	_00892_DS_
_00891_DS_:
	BRA	_00315_DS_
_00892_DS_:
;	.line	512; output.c	lcdString("**              "); 
	MOVLW	UPPER(___str_7)
	MOVWF	r0x02
	MOVLW	HIGH(___str_7)
	MOVWF	r0x01
	MOVLW	LOW(___str_7)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00315_DS_:
;	.line	514; output.c	if(getSenha_i() == 3 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00893_DS_
	MOVF	r0x01, W
	BZ	_00894_DS_
_00893_DS_:
	BRA	_00317_DS_
_00894_DS_:
;	.line	515; output.c	lcdString("***            "); 
	MOVLW	UPPER(___str_8)
	MOVWF	r0x02
	MOVLW	HIGH(___str_8)
	MOVWF	r0x01
	MOVLW	LOW(___str_8)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00317_DS_:
;	.line	517; output.c	if(getSenha_i() == 4 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x00, W
	XORLW	0x04
	BNZ	_00895_DS_
	MOVF	r0x01, W
	BZ	_00896_DS_
_00895_DS_:
	BRA	_00319_DS_
_00896_DS_:
;	.line	518; output.c	lcdString("****           "); 
	MOVLW	UPPER(___str_9)
	MOVWF	r0x02
	MOVLW	HIGH(___str_9)
	MOVWF	r0x01
	MOVLW	LOW(___str_9)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00319_DS_:
;	.line	520; output.c	if(getSenha_i() == 5 ){ //colocar o nome certo do contador de digitos
	CALL	_getSenha_i
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x00, W
	XORLW	0x05
	BNZ	_00897_DS_
	MOVF	r0x01, W
	BZ	_00898_DS_
_00897_DS_:
	BRA	_00321_DS_
_00898_DS_:
;	.line	521; output.c	lcdString("*****          "); 
	MOVLW	UPPER(___str_10)
	MOVWF	r0x02
	MOVLW	HIGH(___str_10)
	MOVWF	r0x01
	MOVLW	LOW(___str_10)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00321_DS_:
;	.line	523; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	524; output.c	if(getSenha_try() == 3){
	CALL	_getSenha_try
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00899_DS_
	MOVF	r0x01, W
	BZ	_00900_DS_
_00899_DS_:
	BRA	_00328_DS_
_00900_DS_:
;	.line	525; output.c	lcdCommand(0xC0);
	MOVLW	0xc0
	MOVWF	POSTDEC1
	CALL	_lcdCommand
	MOVF	POSTINC1, F
;	.line	526; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x00
	MOVF	r0x00, W
	BNZ	_00323_DS_
;	.line	527; output.c	lcdString("Senha incorreta!");
	MOVLW	UPPER(___str_11)
	MOVWF	r0x02
	MOVLW	HIGH(___str_11)
	MOVWF	r0x01
	MOVLW	LOW(___str_11)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00323_DS_:
;	.line	529; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x00
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00325_DS_
;	.line	530; output.c	lcdString("Wrong password! ");
	MOVLW	UPPER(___str_12)
	MOVWF	r0x02
	MOVLW	HIGH(___str_12)
	MOVWF	r0x01
	MOVLW	LOW(___str_12)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00325_DS_:
	BANKSEL	_i
;	.line	532; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	CLRF	_i, B
	BANKSEL	(_i + 1)
	CLRF	(_i + 1), B
_00356_DS_:
;	.line	533; output.c	Delay2ms(); 
	CALL	_Delay2ms
	BANKSEL	_i
;	.line	532; output.c	for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
	INCFSZ	_i, F, B
	BRA	_100119_DS_
	BANKSEL	(_i + 1)
	INCF	(_i + 1), F, B
_100119_DS_:
	MOVLW	0x05
	BANKSEL	(_i + 1)
	SUBWF	(_i + 1), W, B
	BNZ	_00903_DS_
	MOVLW	0xdd
	BANKSEL	_i
	SUBWF	_i, W, B
_00903_DS_:
	BNC	_00356_DS_
_00328_DS_:
;	.line	536; output.c	if(getTestResult()){
	CALL	_getTestResult
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVF	r0x00, W
	IORWF	r0x01, W
	BTFSC	STATUS, 2
	BRA	_00360_DS_
;	.line	537; output.c	if (getLanguage() == 0) {
	CALL	_getLanguage
	MOVWF	r0x00
	MOVF	r0x00, W
	BNZ	_00330_DS_
;	.line	538; output.c	lcdString("ReiniciandoTchau");
	MOVLW	UPPER(___str_48)
	MOVWF	r0x02
	MOVLW	HIGH(___str_48)
	MOVWF	r0x01
	MOVLW	LOW(___str_48)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00330_DS_:
;	.line	540; output.c	if (getLanguage() == 1) {
	CALL	_getLanguage
	MOVWF	r0x00
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00332_DS_
;	.line	541; output.c	lcdString("RestartingByebye");
	MOVLW	UPPER(___str_49)
	MOVWF	r0x02
	MOVLW	HIGH(___str_49)
	MOVWF	r0x01
	MOVLW	LOW(___str_49)
	MOVWF	r0x00
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_lcdString
	MOVLW	0x03
	ADDWF	FSR1L, F
_00332_DS_:
	BANKSEL	_i
;	.line	543; output.c	for (i = 0; i <= 1500; i++){
	CLRF	_i, B
	BANKSEL	(_i + 1)
	CLRF	(_i + 1), B
_00358_DS_:
;	.line	544; output.c	Delay2ms();
	CALL	_Delay2ms
	BANKSEL	_i
;	.line	543; output.c	for (i = 0; i <= 1500; i++){
	INCFSZ	_i, F, B
	BRA	_110120_DS_
	BANKSEL	(_i + 1)
	INCF	(_i + 1), F, B
_110120_DS_:
	MOVLW	0x05
	BANKSEL	(_i + 1)
	SUBWF	(_i + 1), W, B
	BNZ	_00906_DS_
	MOVLW	0xdd
	BANKSEL	_i
	SUBWF	_i, W, B
_00906_DS_:
	BNC	_00358_DS_
_00360_DS_:
	MOVFF	PREINC1, r0x07
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
S_output__outputInit	code
_outputInit:
;	.line	53; output.c	void outputInit(void) {
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	54; output.c	lcdInit();
	CALL	_lcdInit
;	.line	55; output.c	ADread = 19;
	MOVLW	0x13
	BANKSEL	_ADread
	MOVWF	_ADread, B
	BANKSEL	(_ADread + 1)
	CLRF	(_ADread + 1), B
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
___str_0:
	DB	0x20, 0x00
; ; Starting pCode block
___str_1:
	DB	0x28, 0x75, 0x6e, 0x69, 0x29, 0x00
; ; Starting pCode block
___str_2:
	DB	0x2f, 0x00
; ; Starting pCode block
___str_3:
	DB	0x20, 0x20, 0x00
; ; Starting pCode block
___str_4:
	DB	0x3a, 0x00
; ; Starting pCode block
___str_5:
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_6:
	DB	0x2a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_7:
	DB	0x2a, 0x2a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_8:
	DB	0x2a, 0x2a, 0x2a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_9:
	DB	0x2a, 0x2a, 0x2a, 0x2a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_10:
	DB	0x2a, 0x2a, 0x2a, 0x2a, 0x2a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_11:
	DB	0x53, 0x65, 0x6e, 0x68, 0x61, 0x20, 0x69, 0x6e, 0x63, 0x6f, 0x72, 0x72
	DB	0x65, 0x74, 0x61, 0x21, 0x00
; ; Starting pCode block
___str_12:
	DB	0x57, 0x72, 0x6f, 0x6e, 0x67, 0x20, 0x70, 0x61, 0x73, 0x73, 0x77, 0x6f
	DB	0x72, 0x64, 0x21, 0x20, 0x00
; ; Starting pCode block
___str_13:
	DB	0x20, 0x20, 0x20, 0x28, 0x00
; ; Starting pCode block
___str_14:
	DB	0x2c, 0x00
; ; Starting pCode block
___str_15:
	DB	0x29, 0x20, 0x00
; ; Starting pCode block
___str_16:
	DB	0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_17:
	DB	0x20, 0x43, 0x6f, 0x6e, 0x66, 0x69, 0x67, 0x75, 0x72, 0x61, 0x20, 0x74
	DB	0x65, 0x6d, 0x70, 0x6f, 0x00
; ; Starting pCode block
___str_18:
	DB	0x20, 0x53, 0x65, 0x74, 0x20, 0x74, 0x69, 0x6d, 0x65, 0x3a, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_19:
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_20:
	DB	0x2a, 0x43, 0x6f, 0x6e, 0x66, 0x69, 0x67, 0x75, 0x72, 0x61, 0x20, 0x74
	DB	0x65, 0x6d, 0x70, 0x6f, 0x00
; ; Starting pCode block
___str_21:
	DB	0x2a, 0x53, 0x65, 0x74, 0x20, 0x74, 0x69, 0x6d, 0x65, 0x3a, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_22:
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_23:
	DB	0x50, 0x6f, 0x72, 0x74, 0x75, 0x67, 0x75, 0x65, 0x73, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_24:
	DB	0x45, 0x6e, 0x67, 0x6c, 0x69, 0x73, 0x68, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_25:
	DB	0x2a, 0x50, 0x6f, 0x72, 0x74, 0x75, 0x67, 0x75, 0x65, 0x73, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_26:
	DB	0x2a, 0x45, 0x6e, 0x67, 0x6c, 0x69, 0x73, 0x68, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_27:
	DB	0x20, 0x48, 0x6f, 0x72, 0x61, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_28:
	DB	0x20, 0x48, 0x6f, 0x75, 0x72, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_29:
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_30:
	DB	0x2a, 0x48, 0x6f, 0x72, 0x61, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_31:
	DB	0x2a, 0x48, 0x6f, 0x75, 0x72, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_32:
	DB	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_33:
	DB	0x20, 0x48, 0x61, 0x62, 0x69, 0x6c, 0x69, 0x74, 0x61, 0x72, 0x20, 0x73
	DB	0x65, 0x6e, 0x68, 0x61, 0x00
; ; Starting pCode block
___str_34:
	DB	0x20, 0x45, 0x6e, 0x61, 0x62, 0x6c, 0x65, 0x20, 0x70, 0x61, 0x73, 0x73
	DB	0x77, 0x6f, 0x72, 0x64, 0x00
; ; Starting pCode block
___str_35:
	DB	0x2a, 0x2a, 0x2a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_36:
	DB	0x2a, 0x2a, 0x2a, 0x2a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_37:
	DB	0x2a, 0x2a, 0x2a, 0x2a, 0x2a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_38:
	DB	0x53, 0x65, 0x6e, 0x68, 0x61, 0x20, 0x61, 0x6c, 0x74, 0x65, 0x72, 0x61
	DB	0x64, 0x61, 0x21, 0x20, 0x00
; ; Starting pCode block
___str_39:
	DB	0x50, 0x61, 0x73, 0x73, 0x77, 0x6f, 0x72, 0x64, 0x20, 0x63, 0x68, 0x61
	DB	0x6e, 0x67, 0x65, 0x64, 0x21, 0x00
; ; Starting pCode block
___str_40:
	DB	0x49, 0x6e, 0x73, 0x69, 0x72, 0x61, 0x20, 0x6e, 0x6f, 0x76, 0x61, 0x6d
	DB	0x65, 0x6e, 0x74, 0x65, 0x00
; ; Starting pCode block
___str_41:
	DB	0x50, 0x6c, 0x65, 0x61, 0x73, 0x65, 0x20, 0x72, 0x65, 0x2d, 0x65, 0x6e
	DB	0x74, 0x65, 0x72, 0x20, 0x00
; ; Starting pCode block
___str_42:
	DB	0x2a, 0x48, 0x61, 0x62, 0x69, 0x6c, 0x69, 0x74, 0x61, 0x72, 0x20, 0x73
	DB	0x65, 0x6e, 0x68, 0x61, 0x00
; ; Starting pCode block
___str_43:
	DB	0x2a, 0x45, 0x6e, 0x61, 0x62, 0x6c, 0x65, 0x20, 0x70, 0x61, 0x73, 0x73
	DB	0x77, 0x6f, 0x72, 0x64, 0x00
; ; Starting pCode block
___str_44:
	DB	0x20, 0x44, 0x65, 0x73, 0x61, 0x62, 0x69, 0x6c, 0x69, 0x74, 0x61, 0x72
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_45:
	DB	0x20, 0x44, 0x69, 0x73, 0x61, 0x62, 0x6c, 0x65, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_46:
	DB	0x2a, 0x44, 0x65, 0x73, 0x61, 0x62, 0x69, 0x6c, 0x69, 0x74, 0x61, 0x72
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_47:
	DB	0x2a, 0x44, 0x69, 0x73, 0x61, 0x62, 0x6c, 0x65, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_48:
	DB	0x52, 0x65, 0x69, 0x6e, 0x69, 0x63, 0x69, 0x61, 0x6e, 0x64, 0x6f, 0x54
	DB	0x63, 0x68, 0x61, 0x75, 0x00
; ; Starting pCode block
___str_49:
	DB	0x52, 0x65, 0x73, 0x74, 0x61, 0x72, 0x74, 0x69, 0x6e, 0x67, 0x42, 0x79
	DB	0x65, 0x62, 0x79, 0x65, 0x00
; ; Starting pCode block
___str_50:
	DB	0x4c, 0x65, 0x69, 0x74, 0x75, 0x72, 0x61, 0x3a, 0x00
; ; Starting pCode block
___str_51:
	DB	0x52, 0x65, 0x61, 0x64, 0x69, 0x6e, 0x67, 0x3a, 0x00
; ; Starting pCode block
___str_52:
	DB	0x49, 0x6e, 0x73, 0x65, 0x72, 0x69, 0x72, 0x20, 0x73, 0x65, 0x6e, 0x68
	DB	0x61, 0x3a, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_53:
	DB	0x49, 0x6e, 0x73, 0x65, 0x72, 0x74, 0x20, 0x70, 0x61, 0x73, 0x73, 0x77
	DB	0x6f, 0x72, 0x64, 0x3a, 0x00
; ; Starting pCode block
___str_54:
	DB	0x43, 0x6f, 0x6e, 0x66, 0x69, 0x67, 0x75, 0x72, 0x61, 0x20, 0x61, 0x6c
	DB	0x61, 0x72, 0x6d, 0x65, 0x00
; ; Starting pCode block
___str_55:
	DB	0x53, 0x65, 0x74, 0x20, 0x61, 0x6c, 0x61, 0x72, 0x6d, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_56:
	DB	0x2a, 0x41, 0x6c, 0x61, 0x72, 0x6d, 0x65, 0x73, 0x20, 0x28, 0x42, 0x2f
	DB	0x41, 0x29, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_57:
	DB	0x2a, 0x41, 0x6c, 0x61, 0x72, 0x6d, 0x73, 0x20, 0x28, 0x4c, 0x2f, 0x48
	DB	0x29, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_58:
	DB	0x42, 0x61, 0x69, 0x78, 0x6f, 0x3a, 0x20, 0x20, 0x20, 0x41, 0x6c, 0x74
	DB	0x6f, 0x3a, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_59:
	DB	0x4c, 0x6f, 0x77, 0x3a, 0x20, 0x20, 0x20, 0x20, 0x48, 0x69, 0x67, 0x68
	DB	0x3a, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_60:
	DB	0x20, 0x41, 0x6c, 0x61, 0x72, 0x6d, 0x65, 0x73, 0x20, 0x28, 0x42, 0x2f
	DB	0x41, 0x29, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_61:
	DB	0x20, 0x41, 0x6c, 0x61, 0x72, 0x6d, 0x73, 0x20, 0x28, 0x4c, 0x2f, 0x48
	DB	0x29, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_62:
	DB	0x54, 0x65, 0x6d, 0x70, 0x6f, 0x20, 0x61, 0x71, 0x75, 0x69, 0x73, 0x69
	DB	0xe7, 0xe3, 0x6f, 0x3a, 0x00
; ; Starting pCode block
___str_63:
	DB	0x54, 0x69, 0x6d, 0x65, 0x20, 0x61, 0x63, 0x71, 0x75, 0x69, 0x73, 0x69
	DB	0x74, 0x69, 0x6f, 0x6e, 0x00
; ; Starting pCode block
___str_64:
	DB	0x43, 0x6f, 0x6e, 0x66, 0x69, 0x67, 0x75, 0x72, 0x61, 0x20, 0x69, 0x64
	DB	0x69, 0x6f, 0x6d, 0x61, 0x00
; ; Starting pCode block
___str_65:
	DB	0x53, 0x65, 0x74, 0x20, 0x6c, 0x61, 0x6e, 0x67, 0x75, 0x61, 0x67, 0x65
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_66:
	DB	0x53, 0x65, 0x6c, 0x65, 0x63, 0x69, 0x6f, 0x6e, 0x61, 0x20, 0x69, 0x64
	DB	0x69, 0x6f, 0x6d, 0x61, 0x00
; ; Starting pCode block
___str_67:
	DB	0x53, 0x65, 0x6c, 0x65, 0x63, 0x74, 0x20, 0x6c, 0x61, 0x6e, 0x67, 0x75
	DB	0x61, 0x67, 0x65, 0x20, 0x00
; ; Starting pCode block
___str_68:
	DB	0x44, 0x61, 0x74, 0x61, 0x20, 0x20, 0x2f, 0x20, 0x20, 0x48, 0x6f, 0x72
	DB	0x61, 0x3a, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_69:
	DB	0x44, 0x61, 0x74, 0x65, 0x20, 0x20, 0x2f, 0x20, 0x20, 0x54, 0x69, 0x6d
	DB	0x65, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_70:
	DB	0x2a, 0x44, 0x61, 0x74, 0x61, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_71:
	DB	0x2a, 0x44, 0x61, 0x74, 0x65, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_72:
	DB	0x20, 0x44, 0x61, 0x74, 0x61, 0x3a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_73:
	DB	0x20, 0x44, 0x61, 0x74, 0x65, 0x3a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_74:
	DB	0x20, 0x44, 0x61, 0x74, 0x61, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_75:
	DB	0x20, 0x44, 0x61, 0x74, 0x65, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_76:
	DB	0x20, 0x48, 0x6f, 0x72, 0x61, 0x73, 0x3a, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_77:
	DB	0x20, 0x54, 0x69, 0x6d, 0x65, 0x3a, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_78:
	DB	0x43, 0x6f, 0x6e, 0x66, 0x69, 0x67, 0x2e, 0x73, 0x65, 0x67, 0x75, 0x72
	DB	0x61, 0x6e, 0xe7, 0x61, 0x00
; ; Starting pCode block
___str_79:
	DB	0x43, 0x6f, 0x6e, 0x66, 0x69, 0x67, 0x2e, 0x20, 0x73, 0x65, 0x63, 0x75
	DB	0x72, 0x69, 0x74, 0x79, 0x00
; ; Starting pCode block
___str_80:
	DB	0x2a, 0x41, 0x6c, 0x74, 0x65, 0x72, 0x61, 0x72, 0x20, 0x73, 0x65, 0x6e
	DB	0x68, 0x61, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_81:
	DB	0x2a, 0x53, 0x65, 0x74, 0x20, 0x70, 0x61, 0x73, 0x73, 0x77, 0x6f, 0x72
	DB	0x64, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_82:
	DB	0x53, 0x65, 0x6e, 0x68, 0x61, 0x20, 0x61, 0x74, 0x75, 0x61, 0x6c, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_83:
	DB	0x43, 0x75, 0x72, 0x72, 0x65, 0x6e, 0x74, 0x20, 0x70, 0x61, 0x73, 0x73
	DB	0x77, 0x6f, 0x72, 0x64, 0x00
; ; Starting pCode block
___str_84:
	DB	0x53, 0x65, 0x6e, 0x68, 0x61, 0x20, 0x6e, 0x6f, 0x76, 0x61, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_85:
	DB	0x4e, 0x65, 0x77, 0x20, 0x70, 0x61, 0x73, 0x73, 0x77, 0x6f, 0x72, 0x64
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_86:
	DB	0x20, 0x41, 0x6c, 0x74, 0x65, 0x72, 0x61, 0x72, 0x20, 0x73, 0x65, 0x6e
	DB	0x68, 0x61, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_87:
	DB	0x20, 0x53, 0x65, 0x74, 0x20, 0x70, 0x61, 0x73, 0x73, 0x77, 0x6f, 0x72
	DB	0x64, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_88:
	DB	0x49, 0x6e, 0x73, 0x65, 0x72, 0x69, 0x72, 0x20, 0x73, 0x65, 0x6e, 0x68
	DB	0x61, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_89:
	DB	0x49, 0x6e, 0x73, 0x65, 0x72, 0x74, 0x20, 0x70, 0x61, 0x73, 0x73, 0x77
	DB	0x6f, 0x72, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_90:
	DB	0x2a, 0x48, 0x61, 0x62, 0x69, 0x6c, 0x69, 0x74, 0x61, 0x72, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_91:
	DB	0x2a, 0x45, 0x6e, 0x61, 0x62, 0x6c, 0x65, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_92:
	DB	0x20, 0x48, 0x61, 0x62, 0x69, 0x6c, 0x69, 0x74, 0x61, 0x72, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_93:
	DB	0x20, 0x45, 0x6e, 0x61, 0x62, 0x6c, 0x65, 0x20, 0x20, 0x20, 0x20, 0x20
	DB	0x20, 0x20, 0x20, 0x20, 0x00
; ; Starting pCode block
___str_94:
	DB	0x52, 0x65, 0x73, 0x65, 0x74, 0x20, 0x64, 0x6f, 0x20, 0x73, 0x69, 0x73
	DB	0x74, 0x65, 0x6d, 0x61, 0x00
; ; Starting pCode block
___str_95:
	DB	0x53, 0x79, 0x73, 0x74, 0x65, 0x6d, 0x20, 0x72, 0x65, 0x73, 0x65, 0x74
	DB	0x20, 0x20, 0x20, 0x20, 0x00


; Statistics:
; code size:	 9662 (0x25be) bytes ( 7.37%)
;           	 4831 (0x12df) words
; udata size:	    4 (0x0004) bytes ( 0.31%)
; access size:	    8 (0x0008) bytes


	end
