#include "config.h"
#include "pic18f4520.h"
#include "timer.h"
#include "adc.h"
#include "lcd.h"
#include "keypad.h"
#include "event.h"
#include "var.h"
#include "stateMachine.h"
#include "output.h"
#include "rtc.h"


void main(void) {
     
    //init das bibliotecas
    kpInit();
    lcdInit();
    timerInit();
    varInit();
    eventInit();
    outputInit();
    rtcInit();
            
    ht1380write(7, 0); //liga relógio do RTC
    rtcPutSeconds(0);
    rtcPutMinutes(0);
    rtcPutHours(0);
    rtcPutDate(1);
    rtcPutMonth(1);
    rtcPutYear(17);
    rtcPutDay(4);
                
    for (;;) {
        timerReset(getTime());
        
        //infraestrutura da placa
        
        kpDebounce();
        
        //máquina de estados
        smLoop();
//        outputSinal(adcRead());
        timerWait();

    }
}