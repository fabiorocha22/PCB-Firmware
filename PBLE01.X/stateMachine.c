#include "var.h"
#include "stateMachine.h"
#include "event.h"
#include "output.h"
#include "lcd.h"
#include "keypad.h"
#include "rtc.h"    

static char senha;
static char hora;
static char min;
static char dia;
static char mes;
static char ano;

void smInit(void) {
    setState(STATE_OP);
}
void changeEvento(unsigned char evento){
        senha = 0;
    if(evento == EV_LEFT){
        senha = 1;        
    }
    if(evento == EV_DOWN){
        senha = 2;
    }
    if(evento == EV_RIGHT){
        senha = 3;
    }
    if(evento == EV_UP){
        senha = 4;
    }
    if(evento == EV_ENTER){
        senha = 5; 
    }
}       
char getPeriodo(int x){
    if(x==1){
        return hora;
    }
    if(x==2){
        return min;
    }
    if(x==3){
        return dia;
    }
    if(x==4){
        return mes;
    }
    if(x==5){
        return ano;
    }

}

void smLoop(void) {
    unsigned char evento;

    
    evento = eventRead();
    changeEvento(evento); //atribui um valor para cara evento(usado pela senha))
    //máquina de estados
    switch (getState()) {
        case STATE_OP:
            hora = rtcGetHours();
            min = rtcGetMinutes();
            dia = rtcGetDate();
            mes = rtcGetMonth();
            ano = rtcGetYear();
            //funções de operação
            if (evento == EV_ENTER) {
                setState(SECURITY_CONFIG);
            }
            
            break;
        case SECURITY_CONFIG:
            
            //execução de atividade
            
            
            //gestão da maquina de estado
            if(getSenha_try() == 3){
                setState(STATE_OP);
            }
            if (!getSenhaStatus() || testSenha(senha) == 1) {
                outputPrint(getState(), getLanguage());
                setState(STATE_ALARME);    
            }
            
            break;    
        case STATE_ALARME:
            
            //gestão da maquina de estado
            if (evento == EV_ENTER) {
                setState(CONFIG_ALARME);
            }
            if (evento == EV_LEFT || evento == EV_RIGHT) {
                setState(STATE_OP);
            }
            if (evento == EV_DOWN) {
                setState(STATE_IDIOMA);
            }
            if (evento == EV_UP) {
                setState(STATE_RESET);
            }
            break;       
        case CONFIG_ALARME:
            
            //gestão da maquina de estado
            if (evento == EV_ENTER) {
                setState(ALARME_ALTO_DEC);
            }
            if (evento == EV_LEFT || evento == EV_RIGHT) {
                setState(STATE_ALARME);
            }
            if (evento == EV_DOWN || evento == EV_UP) {
                setState(STATE_TEMPO);
            }
            break;
        case ALARME_ALTO_DEC:
            
            //execução de atividade
            if (evento == EV_UP && getAlarmLevel(2)<=90) {
                setAlarmLevel(getAlarmLevel(2) + 10, 2);
            }
            if (evento == EV_DOWN && getAlarmLevel(2)>=10  && (getAlarmLevel(1)+10) < getAlarmLevel(2)) {
                setAlarmLevel(getAlarmLevel(2) - 10, 2);
            }
            //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                setState(ALARME_ALTO_UNI);
            }
            
            if (evento == EV_LEFT) {
                setState(ALARME_BAIXO_UNI);
            }
            if (evento == EV_ENTER) {
                setState(CONFIG_ALARME);
            }
            break;
        case ALARME_ALTO_UNI:
            
            //execução de atividade
            if (evento == EV_UP && getAlarmLevel(2)<100) {
                setAlarmLevel(getAlarmLevel(2) + 1, 2);
            }
            if (evento == EV_DOWN && getAlarmLevel(2)>0 && getAlarmLevel(1)<getAlarmLevel(2)) {
                setAlarmLevel(getAlarmLevel(2) - 1, 2);
            }
            //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                setState(ALARME_BAIXO_DEC);
            }
            if (evento == EV_LEFT) {
                setState(ALARME_ALTO_DEC);
            }
            if (evento == EV_ENTER) {
                setState(CONFIG_ALARME);
            }
            break;
        case ALARME_BAIXO_DEC:
            
            //execução de atividade
            if (evento == EV_UP && getAlarmLevel(1)<=90 && getAlarmLevel(1) <(getAlarmLevel(2)-10)) {
                setAlarmLevel(getAlarmLevel(1) + 10, 1);
            }
            if (evento == EV_DOWN && getAlarmLevel(1)>=10) {
                setAlarmLevel(getAlarmLevel(1) - 10, 1);
            }
            //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                setState(ALARME_BAIXO_UNI);
            }
            if (evento == EV_LEFT) {
                setState(ALARME_ALTO_UNI);
            }
            if (evento == EV_ENTER) {
                setState(CONFIG_ALARME);
            }
            break;
        case ALARME_BAIXO_UNI:
            
            //execução de atividade
            if (evento == EV_UP && getAlarmLevel(1)<100 && getAlarmLevel(1) <getAlarmLevel(2)) {
                setAlarmLevel(getAlarmLevel(1) + 1, 1);
            }
            if (evento == EV_DOWN && getAlarmLevel(1)>0) {
                setAlarmLevel(getAlarmLevel(1) - 1, 1);
            }
            //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                setState(ALARME_ALTO_DEC);
            }
            if (evento == EV_LEFT) {
                setState(ALARME_BAIXO_DEC);
            }
            if (evento == EV_ENTER) {
                setState(CONFIG_ALARME);
            }
            break;            
        case STATE_TEMPO:
            
            //gestão da maquina de estado
            if (evento == EV_ENTER) {
                setState(CONFIG_TEMPO_DEC);
            }
            if (evento == EV_LEFT || evento == EV_RIGHT) {
                setState(STATE_ALARME);
            }
            if (evento == EV_DOWN || evento == EV_UP) {
                setState(CONFIG_ALARME);
            }
            break;
        case CONFIG_TEMPO_DEC:
            //execução de atividade
            if (evento == EV_UP) {
                setTime(getTime() + 10);
            }
            if (evento == EV_DOWN) {
                setTime(getTime() - 10);
            }
            //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                setState(CONFIG_TEMPO_UNI);
            }
            if (evento == EV_LEFT) {
                setState(CONFIG_TEMPO_MULT);
            }
            if (evento == EV_ENTER) {
                setState(STATE_TEMPO);
            }
            break;
        case CONFIG_TEMPO_UNI:
            
            //execução de atividade
            if (evento == EV_UP) {
                setTime(getTime() + 1);
            }
            if (evento == EV_DOWN) {
                setTime(getTime() - 1);
            }
            //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                setState(CONFIG_TEMPO_MULT);
            }
            if (evento == EV_LEFT) {
                setState(CONFIG_TEMPO_DEC);
            }
            if (evento == EV_ENTER) {
                setState(STATE_TEMPO);
            }
            break;
        case CONFIG_TEMPO_MULT:
            
            //execução de atividade
            if (evento == EV_UP && getMult() <= 10000) {
                setMult(getMult()*10); //criar funções de get e set do multiplicador
            }
            if (evento == EV_DOWN && getMult() >= 0) {
                setMult(getMult()/10);
            }
            //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                setState(CONFIG_TEMPO_DEC);
            }
            if (evento == EV_LEFT) {
                setState(CONFIG_TEMPO_UNI);
            }
            if (evento == EV_ENTER) {
                setState(STATE_TEMPO);
            }
            break;
        case STATE_IDIOMA:

            //gestão da maquina de estado
            if (evento == EV_UP) {
                setState(STATE_ALARME);
            }
            if (evento == EV_DOWN) {
                setState(STATE_PERIODO);
            }
            if (evento == EV_RIGHT || evento == EV_LEFT) {
                setState(STATE_OP);
            }
            if (evento == EV_ENTER) {
                setState(CONFIG_IDIOMA);
            }
            break;
        case CONFIG_IDIOMA:

            //execução de atividade
            if (evento == EV_UP) {
                setLanguage(getLanguage() + 1);
            }
            if (evento == EV_DOWN) {
                setLanguage(getLanguage() - 1);
            }
            //gestão da maquina de estado
            if (evento == EV_ENTER) {
                setState(STATE_IDIOMA);
            }
            break;
        case STATE_PERIODO:
            
            //gestão da maquina de estado
            if (evento == EV_UP) {
                setState(STATE_IDIOMA);
            }
            if (evento == EV_DOWN) {
                setState(STATE_SECURITY);
            }
            if (evento == EV_RIGHT || evento == EV_LEFT) {
                setState(STATE_OP);
            }
            if (evento == EV_ENTER) {
                setState(STATE_DATA);
            }
            break;
        case STATE_DATA:
            
            //gestão da maquina de estado
            if (evento == EV_UP || evento == EV_DOWN) {
                setState(STATE_HORA);
            }
            if (evento == EV_LEFT || evento == EV_RIGHT) {
                setState(STATE_PERIODO);
            }
            if (evento == EV_ENTER) {
                setState(CONFIG_DATA_D);
            } 
            break;
        case CONFIG_DATA_D:

            //execução de atividade
            if (evento == EV_UP) {
                dia = (dia +1)%31;
            }
            if (evento == EV_DOWN) {
                dia = (dia -1)%32;
                if(dia == 0){
                    dia = 31;
                }
            }
             //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                rtcPutDate(dia);
                setState(CONFIG_DATA_M);
            }
            if (evento == EV_LEFT) {
                rtcPutDate(dia);
                setState(CONFIG_DATA_A);
            }
            if (evento == EV_ENTER) {
                rtcPutDate(dia);
                setState(STATE_DATA);
            }
            break;
        case CONFIG_DATA_M:

            //execução de atividade
            if (evento == EV_UP) {
                mes = (mes+1)%13;
                if(mes==0){
                    mes=1;
                }
            }
            if (evento == EV_DOWN) {
                mes = (mes-1)%13;
                if(mes == 0){
                    mes=12;
                }
            }
            
             //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                rtcPutMonth(mes);
                setState(CONFIG_DATA_A);
            }
            if (evento == EV_LEFT) {
                rtcPutMonth(mes);
                setState(CONFIG_DATA_D);
            }
            if (evento == EV_ENTER) {
                rtcPutMonth(mes);
                setState(STATE_DATA);
            }
            break;    
        case CONFIG_DATA_A:

            //execução de atividade
            if (evento == EV_UP) {
                ano = (ano+1)%100;
            }
           
            if (evento == EV_DOWN) {
                ano = (ano-1)%100;
                if(ano == 255){
                    ano = 99;
                }
            }
             //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                rtcPutYear(ano);
                setState(CONFIG_DATA_D);
            }
            if (evento == EV_LEFT) {
                rtcPutYear(ano);
                setState(CONFIG_DATA_M);
            }
            if (evento == EV_ENTER) {
                rtcPutYear(ano);
                setState(STATE_DATA);
            }
            break;
        case STATE_HORA:
            
            
            //gestão da maquina de estado
            if (evento == EV_UP || evento == EV_DOWN) {
                setState(STATE_DATA);
            }
 
            if (evento == EV_RIGHT || evento == EV_LEFT) {
                setState(STATE_PERIODO);
            }
             
            if (evento == EV_ENTER) {
                setState(CONFIG_HORA);
            }
            break;
        case CONFIG_HORA:

            //execução de atividade
            if (evento == EV_UP) {
                hora = (hora + 1)%24;
            }
            if (evento == EV_DOWN && hora !=0) {
                hora = (hora - 1)%24;
            }
            
            if (evento == EV_DOWN && hora == 0) {
                hora = 23;
            }
           
            //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                rtcPutHours(hora);
                setState(CONFIG_MINUTOS_DEC);
            }
            if (evento == EV_LEFT) {
                rtcPutHours(hora);
                setState(CONFIG_MINUTOS_UNI);
            }
            if (evento == EV_ENTER) {
                rtcPutHours(hora);                
                setState(STATE_HORA);
            }
            break;
        
        case CONFIG_MINUTOS_DEC:

            ///execução de atividade
            if (evento == EV_UP) {
                min = (min+10)%60;
            }
            if (evento == EV_DOWN && min>=10) {
                min = (min-10)%60;
            }
            if (evento == EV_DOWN && min == 0){
                min = 50;
            }
            
            //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                rtcPutMinutes(min);
                setState(CONFIG_MINUTOS_UNI);
            }
            if (evento == EV_LEFT) {
                rtcPutMinutes(min);
                setState(CONFIG_HORA);
            }
            if (evento == EV_ENTER) {
                rtcPutMinutes(min);
                setState(STATE_HORA);
            }
            break;
        case CONFIG_MINUTOS_UNI:

            //execução de atividade
           if (evento == EV_UP) {
                min = (min+1)%60;
            }
           if (evento == EV_DOWN && min>=1) {
                min = (min-1)%60;
            } 
           if (evento == EV_DOWN && min == 0){
                min = 59;
            }
            //gestão da maquina de estado
            if (evento == EV_RIGHT) {
                rtcPutMinutes(min);
                setState(CONFIG_HORA);
            }
            if (evento == EV_LEFT) {
                rtcPutMinutes(min);
                setState(CONFIG_MINUTOS_DEC);
            }
            if (evento == EV_ENTER) {
                rtcPutMinutes(min);
                setState(STATE_HORA);
            }
            break;
        case STATE_SECURITY:
           
            //gestão da maquina de estado
            if (evento == EV_UP) {
                setState(STATE_PERIODO);
            }
            if (evento == EV_DOWN) {
                setState(STATE_RESET);
            }
            if (evento == EV_ENTER) {
                setState(CONFIG_SENHA);
            }
            if (evento == EV_LEFT || evento ==  EV_RIGHT) {
                setState(STATE_OP);
            }
            break;
        case CONFIG_SENHA:
            
            //gestão da maquina de estado
            if (evento == EV_UP || evento == EV_DOWN) {
                setState(CONFIG_HABILITA);
            }
            if (evento == EV_ENTER){
                setState(SECURITY_SENHA);                
            }
            if (evento == EV_LEFT || evento ==  EV_RIGHT) {
                setState(STATE_SECURITY);
            }
            break;
        case SECURITY_SENHA:
            
            //execução de atividade
           
            //gestão da maquina de estado
            if(getSenha_try() ==  3){
                setState(CONFIG_SENHA);
            }
            if (testSenha(senha) == 1){
                setState(NOVA_SENHA);
                setTestResult(0);
            }
            
            break;
        case NOVA_SENHA:
            
            //execução de atividade
            if ((evento == EV_UP || evento == EV_DOWN || evento == EV_RIGHT || evento == EV_LEFT || evento == EV_ENTER)  && !getTestResult()) {
                if(setSenha(senha) != 0 || getSenha_i()==5){
                    if(getSenha_i()==5){
                        setState(AGUARDO);
                    }else{
                        outputPrint(getState(), getLanguage());
                        setState(CONFIG_SENHA);
                    }
                }
            }
            //gestão da maquina de estado
            break;
        case AGUARDO:
            
            setState(NOVA_SENHA);
            break;
            
        case CONFIG_HABILITA: 
           
           //gestão da maquina de estado
           if (evento == EV_ENTER){
               setState(SECURITY_HABILITA);
           }
           if(evento == EV_UP || evento == EV_DOWN){
               setState(CONFIG_SENHA);
           }
           if(evento == EV_RIGHT || evento == EV_LEFT){
               setState(STATE_SECURITY);
           }
           break;
        case SECURITY_HABILITA:
            
            //execução de atividade
            
            
            //gestão da maquina de estado
            if(getSenha_try() ==  3){
                setState(CONFIG_HABILITA);
            }
            if (testSenha(senha) == 1) {
                setState(HABILITA_SENHA);    
            }
            
            break;
        case HABILITA_SENHA:
            
            if(evento == EV_ENTER){
                enableSenha(1);
                setState(CONFIG_HABILITA);
            }
            if(evento == EV_UP || evento == EV_DOWN){
                setState(DESABILITA_SENHA);
            }
            if(evento == EV_RIGHT || evento == EV_LEFT){
                setState(CONFIG_HABILITA);
            }
            break;
        case DESABILITA_SENHA:
            //execução de atividade
            if(evento == EV_ENTER){
                enableSenha(0);
                setState(CONFIG_HABILITA);
            }
            //gestão da maquina de estado
            if(evento == EV_UP || evento == EV_DOWN){
                setState(HABILITA_SENHA);
            }
            if(evento == EV_RIGHT || evento == EV_LEFT){
                setState(CONFIG_HABILITA);
            }
            break;
        case STATE_RESET:
            
            //gestão da maquina de estado
            if(evento == EV_ENTER){
                setTestResult(0);
                setState(SECURITY_RESET);
            }
            if(evento == EV_UP){
                setState(STATE_SECURITY);
            }
            if(evento == EV_DOWN){
                setState(STATE_ALARME);
            }
            if(evento == EV_RIGHT || evento == EV_LEFT){
                setState(STATE_OP);
            }
            break;
            
        case SECURITY_RESET:
            
            //execução de atividade
            
            //gestão da maquina de estado
            
            if(getSenha_try() == 3){
                setState(STATE_RESET);
            }
            
            if (testSenha(senha) == 1) {
                outputPrint(getState(), getLanguage());
                varInit();
                setState(STATE_OP);    
            }
            break;
    } 
    outputPrint(getState(), getLanguage());
}
