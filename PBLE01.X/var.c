#include "var.h"

//variáveis a serem armazenadas
static char state;

static char language;

static int time;

static int alarmLevel_H;
static int alarmLevel_L;

static int senha_enable;
static int senha_i;
static int senha_save[5];
static int senha_result;
static int senha_count[5];
static int senha_try;
static int senha_new[5];
static int multiplicador;

void delay40us(void) {
    unsigned char i;
    for (i = 0; i < 10; i++); //valor aproximado
}

void delay2ms(void) {
    unsigned char i;
    for (i = 0; i < 50; i++) {
        delay40us();
    }
}

void varInit(void) {
    state = 0;
    time = 1000;
    alarmLevel_L = 20;
    alarmLevel_H = 80;
    language = 0;
    multiplicador = 10;
    for(senha_i=0;senha_i<5;senha_i++){
        senha_save[senha_i]= 5 ;
    }
    senha_enable = 1;
    senha_i = 0;
    senha_try = 0;
    senha_result = 0;
}


char getState(void) {
    return state;
}
void setState(char newState) {
    state = newState;
}


int getTime(void) {
    return time;
}
void setTime(int newTime) {
    time = newTime;
}
int getMult(){
    return multiplicador;
}
void setMult(int mult){
    multiplicador = mult;
}


int getAlarmLevel(int valor) {
    if(valor == 2)
        return alarmLevel_H;
    if(valor == 1)
        return alarmLevel_L;
    else{
        return 0;
    }
}
void setAlarmLevel(int newAlarmLevel, int valor) {
    if(valor == 2){
        alarmLevel_H = newAlarmLevel;
    }
    if(valor == 1){
        alarmLevel_L = newAlarmLevel;
    }
}


char getLanguage(void){
    return language;
}
void setLanguage(char newLanguage){
    //só tem 2 linguas
    //usando resto pra evitar colocar valor errado
    language = newLanguage%2;
}


int getSenhaStatus(){
    return senha_enable;
}
void enableSenha(int x){
    senha_enable = x;
}
int getSenha_i(){
    return senha_i;
}
int getSenha_try(){
    return senha_try;
}
int getTestResult(){
    return senha_result;
}
void setTestResult(int x){
    senha_result = x;
}
int testSenha(char senha){
    
    char i;
    if(senha_i<5){
        senha_result=0;
        if(senha != 0){
            senha_i++;
            senha_count[senha_i - 1] = senha;
        }
        if(senha_try==3){
            senha_try=0;
        }    
    }
    if(senha_i==5){
        for(i=0;i<5;i++){
            if(senha_count[i] != senha_save[i]){
                senha_try++;
                senha_i=0;
                return 0;
            }
        }
        
        senha_try = 0;
        senha_i = 0;
        senha_result = 1;
        return 1;
    }
    return 0;
}
int setSenha(char senha){
    
    unsigned char i;
    senha_try = 0;
    if(senha != 0 && senha_i>4){
        senha_count[senha_i - 5] = senha;
        senha_i++;
    }
    
    if(senha != 0 && senha_i<5 ){
        senha_new[senha_i] = senha;
        senha_i++;
    }
    
    senha_result = 0;
    if(senha_i==10){
        senha_i=0;
        for(i=0;i<5;i++){
            if(senha_new[i] != senha_count[i]){
                senha_result = 0;
                senha_try++;
                return 1;
            }    
        }
        
        for(i=0;i<5;i++){
            senha_save[i] = senha_new[i];
        }
        senha_result=1;
        return 1;
    }
    return 0;
}   