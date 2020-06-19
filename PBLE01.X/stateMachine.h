/* 
 * File:   stateMachine.h
 * Author: Avell
 *
 * Created on 18 de Junho de 2017, 22:17
 */

#ifndef STATEMACHINE_H
#define	STATEMACHINE_H


//estados da maquina de Estados

enum {
    STATE_OP,
    SECURITY_CONFIG,
    STATE_ALARME,
    CONFIG_ALARME,
    ALARME_ALTO_DEC,
    ALARME_ALTO_UNI,
    ALARME_BAIXO_DEC,
    ALARME_BAIXO_UNI,    
    STATE_TEMPO,
    CONFIG_TEMPO_DEC,
    CONFIG_TEMPO_UNI,
    CONFIG_TEMPO_MULT,
    STATE_IDIOMA,
    CONFIG_IDIOMA,
    STATE_PERIODO,
    STATE_DATA,
    CONFIG_DATA_D,
    CONFIG_DATA_M,
    CONFIG_DATA_A,
    STATE_HORA,
    CONFIG_HORA,
    CONFIG_MINUTOS_DEC,
    CONFIG_MINUTOS_UNI,
    STATE_SECURITY,
    CONFIG_SENHA,
    SECURITY_SENHA,
    NOVA_SENHA,
    CONFIG_HABILITA,
    SECURITY_HABILITA,
    HABILITA_SENHA,
    DESABILITA_SENHA,
    STATE_RESET,
    SECURITY_RESET,
    AGUARDO,
    STATE_FIM
};

char getPeriodo(int x);
void smInit(void);
void smLoop(void);


#endif	/* STATEMACHINE_H */

