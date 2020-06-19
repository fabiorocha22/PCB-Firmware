#include "output.h"
#include "lcd.h"
#include "stateMachine.h"
#include "var.h"
#include "rtc.h"
#include "led.h"


#define NUM_IDIOMAS 2

unsigned int ADread;
unsigned int i;

//msgs com 16 caracteres
//1 msg por estado (apenas linha de cima)
static char * msgs[STATE_FIM][NUM_IDIOMAS] = {
    {"Leitura:", "Reading:"},
    {"Inserir senha:  ", "Insert password:"},
    {"Configura alarme", "Set alarm       "},
    {"*Alarmes (B/A)  ", "*Alarms (L/H)   "},
    {"Baixo:   Alto:  ", "Low:    High:   "},
    {"Baixo:   Alto:  ", "Low:    High:   "},
    {"Baixo:   Alto:  ", "Low:    High:   "},
    {"Baixo:   Alto:  ", "Low:    High:   "},
    {" Alarmes (B/A)  ", " Alarms (L/H)   "},
    {"Tempo aquisição:", "Time acquisition"},
    {"Tempo aquisição:", "Time acquisition"},
    {"Tempo aquisição:", "Time acquisition"}, 
    {"Configura idioma", "Set language    "},
    {"Seleciona idioma", "Select language "},
    {"Data  /  Hora:  ", "Date  /  Time   "},
    {"*Data           ", "*Date           "},
    {" Data:          ", " Date:          "},
    {" Data:          ", " Date:          "},
    {" Data:          ", " Date:          "},
    {" Data           ", " Date           "},
    {" Horas:         ", " Time:          "},
    {" Horas:         ", " Time:          "},
    {" Horas:         ", " Time:          "},
    {"Config.segurança", "Config. security"},
    {"*Alterar senha  ", "*Set password   "},
    {"Senha atual     ", "Current password"},
    {"Senha nova      ", "New password    "},
    {" Alterar senha  ", " Set password   "},
    {"Inserir senha   ", "Insert passwor  "},
    {"*Habilitar      ", "*Enable         "},
    {" Habilitar      ", " Enable         "},
    {"Reset do sistema", "System reset    "},
    {"Inserir senha:  ", "Insert password:"},
    {"Inserir senha:  ", "Insert password:"} 
};

void outputInit(void) {
    lcdInit();
    ADread = 19;
}

void outputPrint(int numTela, int idioma) {
    
    if (numTela == STATE_OP) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdString(" ");
        lcdInt(ADread);  //criar função getRead
        lcdString("(uni)"); //colocar a unidade ou deixar assim genérico
        lcdCommand(0xC0);
        lcdInt(getPeriodo(3));
        lcdString("/");
        lcdInt(getPeriodo(4));
        lcdString("/");
        lcdInt(getPeriodo(5));
        lcdString("  ");
        lcdInt(getPeriodo(1));
        lcdString(":");
        lcdInt(getPeriodo(2));
        lcdString(" ");
    }
    
    
    if (numTela == SECURITY_CONFIG) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
       if(getSenha_i() == 0 ){
          lcdString("                "); 
        }
       if(getSenha_i() == 1 ){
          lcdString("*               "); 
        }
        if(getSenha_i() == 2 ){ //colocar o nome certo do contador de digitos
          lcdString("**              "); 
        }
        if(getSenha_i() == 3 ){ //colocar o nome certo do contador de digitos
           lcdString("***            "); 
        }
        if(getSenha_i() == 4 ){ //colocar o nome certo do contador de digitos
           lcdString("****           "); 
        }
        if(getSenha_i() == 5 ){ //colocar o nome certo do contador de digitos
           lcdString("*****          ");
           for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
                 Delay2ms(); 
            }
        }
        if(getSenha_try() == 3){
            lcdCommand(0xC0);
            if (getLanguage() == 0) {
            lcdString("Senha incorreta!");
            }
            if (getLanguage() == 1) {
            lcdString("Wrong password! ");
            }
        for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
                 Delay2ms(); 
        }
    }
}
            
    if (numTela == STATE_ALARME) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        lcdString("   (");
        lcdInt(getAlarmLevel(1));
        lcdString(",");
        lcdInt(getAlarmLevel(2));
        lcdString(") ");
        lcdInt(getMult());
        lcdString("   ");
    }
    
    if (numTela == CONFIG_ALARME) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        if (getLanguage() == 0) {
            lcdString(" Configura tempo");
        }
        if (getLanguage() == 1) {
            lcdString(" Set time:       ");
        }
     
    }
    
    if (numTela == ALARME_ALTO_DEC || numTela == ALARME_ALTO_UNI 
     || numTela == ALARME_BAIXO_DEC || numTela == ALARME_BAIXO_UNI ) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        lcdString("      ");
        lcdInt(getAlarmLevel(1));
        lcdString("      ");
        lcdInt(getAlarmLevel(2));
   
    }    
    
    if (numTela == STATE_TEMPO) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        if (getLanguage() == 0) {
            lcdString("*Configura tempo");
        }
        if (getLanguage() == 1) {
            lcdString("*Set time:      ");
        }
     
    }
    
     if (numTela == CONFIG_TEMPO_DEC || numTela == CONFIG_TEMPO_UNI
        || numTela == CONFIG_TEMPO_MULT) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        lcdString("  ");
        lcdInt(getTime()); // ver com o eudes o nome da função
        lcdString("  ");
        lcdInt(getMult()); // ver nome certo
        lcdString("       ");
    }
     
    
    if (numTela == STATE_IDIOMA) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        if (getLanguage() == 0) {
            lcdString("Portugues       ");
        }
        if (getLanguage() == 1) {
            lcdString("English         ");
        }
    }
    
    if (numTela == CONFIG_IDIOMA) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        if (getLanguage() == 0) {
            lcdString("*Portugues      ");
        }
        if (getLanguage() == 1) {
            lcdString("*English        ");
        }
    }
    
    if (numTela == STATE_PERIODO) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);   
        lcdCommand(0xC0);
        lcdString("                "); //comentar essa linha
        //lcdInt(rtcGetDate());
        //lcdString("/");
        //lcdInt(rtcGetMonth());
        //lcdString("/");
        //lcdInt(rtcGetYear());
        //lcdString("  ");
        //lcdInt(rtcGetHours());
        //lcdString(":");
        //lcdInt(rtcGetMinutes());
    }
    
    if (numTela == STATE_DATA) {
        lcdCommand(0x80);
        //lcdString(0x10);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
         if (getLanguage() == 0) {
            lcdString(" Hora           ");
        }
        if (getLanguage() == 1) {
            lcdString(" Hour           ");
        }
              
    }
    
    if (numTela == CONFIG_DATA_D || numTela == CONFIG_DATA_M || numTela == CONFIG_DATA_A) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);   
        lcdCommand(0xC0);
        lcdInt(getPeriodo(3));
        lcdString("/");
        lcdInt(getPeriodo(4));
        lcdString("/");
        lcdInt(getPeriodo(5));
        lcdString("        ");
            
    }
    
    if (numTela == STATE_HORA) {
        lcdCommand(0x80);
        //lcdString(0x10);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        if (getLanguage() == 0) {
            lcdString("*Hora           ");
        }
        if (getLanguage() == 1) {
            lcdString("*Hour           ");
        }
    }
    
    if (numTela == CONFIG_HORA || numTela == CONFIG_MINUTOS_DEC
    || numTela == CONFIG_MINUTOS_UNI) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);   
        lcdCommand(0xC0);
        lcdString("  ");
        lcdInt(getPeriodo(1));
        lcdString(":");
        lcdInt(getPeriodo(2));
        lcdString("         ");
    }
    
    if (numTela == STATE_SECURITY) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        lcdString("                ");
        
    }
    
    if (numTela == CONFIG_SENHA) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        if (getLanguage() == 0) {
            lcdString(" Habilitar senha");
        }
        if (getLanguage() == 1) {
            lcdString(" Enable password");
        }
    }
    
    if (numTela == SECURITY_SENHA) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
       if(getSenha_i() == 0 ){
          lcdString("                "); 
        }
       if(getSenha_i() == 1 ){
          lcdString("*               "); 
        }
        if(getSenha_i() == 2 ){ //colocar o nome certo do contador de digitos
          lcdString("**              "); 
        }
        if(getSenha_i() == 3 ){ //colocar o nome certo do contador de digitos
           lcdString("***            "); 
        }
        if(getSenha_i() == 4 ){ //colocar o nome certo do contador de digitos
           lcdString("****           "); 
        }
        if(getSenha_i() == 5 ){ //colocar o nome certo do contador de digitos
           lcdString("*****          "); 
        }
        if(getSenha_try() == 3){
            lcdCommand(0xC0);
            if (getLanguage() == 0) {
            lcdString("Senha incorreta!");
            }
            if (getLanguage() == 1) {
            lcdString("Wrong password! ");
            }
            for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
                 Delay2ms(); 
            }
        }
    }
    
    if (numTela == NOVA_SENHA) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
       if(getSenha_i() == 0 ){
          lcdString("                "); 
        }
       if(getSenha_i() == 1 ){
          lcdString("*               "); 
        } 
       if(getSenha_i() == 2 ){ //colocar o nome certo do contador de digitos
          lcdString("**              "); 
       }
       if(getSenha_i() == 3 ){ //colocar o nome certo do contador de digitos
          lcdString("***             "); 
       }
       if(getSenha_i() == 4 ){ //colocar o nome certo do contador de digitos
          lcdString("****            "); 
       }
       if(getSenha_i() == 5 ){ //colocar o nome certo do contador de digitos
           lcdString("*****           "); 
           //for (i = 0; i <= 500; i++) { //delay para leitur da frase de 5s
             //    Delay2ms(); 
            //}
        }
        
        lcdCommand(0xC0);
        if(getSenha_i() == 5 ){ //colocar o nome certo do contador de digitos
           lcdString("                "); 
        }
        if(getSenha_i() == 6 ){ //colocar o nome certo do contador de digitos
           lcdString("*               "); 
        }
        if(getSenha_i() == 7 ){ //colocar o nome certo do contador de digitos
            lcdString("**              "); 
        }
        if(getSenha_i() == 8 ){ //colocar o nome certo do contador de digitos
            lcdString("***             "); 
        }
        if(getSenha_i() == 9 ){ //colocar o nome certo do contador de digitos
            lcdString("****            "); 
        }
        if(getSenha_i() == 10 ){ //colocar o nome certo do contador de digitos
            lcdString("*****           ");
            for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
                 Delay2ms(); 
            }
        }
        if(getSenha_try() == 1){
            lcdCommand(0xC0);
            if (getLanguage() == 0) {
            lcdString("Senha incorreta!");
            }
            if (getLanguage() == 1) {
            lcdString("Wrong password! ");
            }
            for (i = 0; i <= 1500; i++) {
                 Delay2ms(); 
            }
        }
        if(getTestResult()){
            lcdCommand(0xC0);
            if (getLanguage() == 0) {
                lcdString("Senha alterada! ");
            }
            if (getLanguage() == 1) {
                lcdString("Password changed!");
            }
            for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
                 Delay2ms(); 
            }
        }
        
    }
     if(numTela == AGUARDO){
        lcdCommand(0xC0);
           if (getLanguage() == 0) {
                lcdString("Insira novamente");
           }
           if (getLanguage() == 1) {
                lcdString("Please re-enter ");
           }
           for (i = 0; i <= 1500; i++){
                Delay2ms();
            }    
    }
    if (numTela == CONFIG_HABILITA) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        if (getLanguage() == 0) {
            lcdString("*Habilitar senha");
        }
        if (getLanguage() == 1) {
            lcdString("*Enable password");
        }
        
        
    }
    
    if (numTela == SECURITY_HABILITA) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
       if(getSenha_i() == 0 ){
          lcdString("                "); 
        }
       if(getSenha_i() == 1 ){
          lcdString("*               "); 
        }
        if(getSenha_i() == 2 ){ //colocar o nome certo do contador de digitos
          lcdString("**              "); 
        }
        if(getSenha_i() == 3 ){ //colocar o nome certo do contador de digitos
           lcdString("***            "); 
        }
        if(getSenha_i() == 4 ){ //colocar o nome certo do contador de digitos
           lcdString("****           "); 
        }
        if(getSenha_i() == 5 ){ //colocar o nome certo do contador de digitos
           lcdString("*****          "); 
           for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
                 Delay2ms(); 
            }
        }
        if(getSenha_try() == 3){
            lcdCommand(0xC0);
            if (getLanguage() == 0) {
            lcdString("Senha incorreta!");
            }
            if (getLanguage() == 1) {
            lcdString("Wrong password! ");
            }
            for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
                 Delay2ms(); 
            }
        } 
    }
        
    if(numTela == HABILITA_SENHA){   
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        if (getLanguage() == 0) {
            lcdString(" Desabilitar    ");
            }
            if (getLanguage() == 1) {
            lcdString(" Disable        "); 
            }     
    }
    
    if(numTela == DESABILITA_SENHA){   
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        if (getLanguage() == 0) {
            lcdString("*Desabilitar    ");
            }
            if (getLanguage() == 1) {
            lcdString("*Disable        "); 
            }     
    }
    
    if (numTela == STATE_RESET) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        lcdString("                ");
    }
    
    if (numTela == SECURITY_RESET) {
        lcdCommand(0x80);
        lcdString(msgs[numTela][idioma]);
        lcdCommand(0xC0);
        if(getSenha_i() == 0 ){
          lcdString("                "); 
        }
        if(getSenha_i() == 1 ){
          lcdString("*               "); 
        }
        if(getSenha_i() == 2 ){ //colocar o nome certo do contador de digitos
          lcdString("**              "); 
        }
        if(getSenha_i() == 3 ){ //colocar o nome certo do contador de digitos
           lcdString("***            "); 
        }
        if(getSenha_i() == 4 ){ //colocar o nome certo do contador de digitos
           lcdString("****           "); 
        }
        if(getSenha_i() == 5 ){ //colocar o nome certo do contador de digitos
           lcdString("*****          "); 
        }
        lcdCommand(0xC0);
        if(getSenha_try() == 3){
            lcdCommand(0xC0);
            if (getLanguage() == 0) {
            lcdString("Senha incorreta!");
            }
            if (getLanguage() == 1) {
            lcdString("Wrong password! ");
            }
            for (i = 0; i <= 1500; i++) { //delay para leitur da frase de 5s
                 Delay2ms(); 
            }
        }
        if(getTestResult()){
            if (getLanguage() == 0) {
                lcdString("ReiniciandoTchau");
            }
            if (getLanguage() == 1) {
                lcdString("RestartingByebye");
            }
            for (i = 0; i <= 1500; i++){
                Delay2ms();
            }
        }
    }
   
}
/*void outputSinal(unsigned int leitura){
  
   ADread = leitura;
   if (leitura >= getAlarmeLevel(2)){
       ledOFF(2);
   } else{
       ledOFF(2);
   }
   if(leitura <= getAlarmeLevel(1)){
       ledOFF(1);
   } else{
       ledOFF(1);
   }

}*/
   



