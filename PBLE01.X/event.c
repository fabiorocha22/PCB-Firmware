#include "keypad.h"
#include "event.h"
#include "pic18f4520.h"

static unsigned int key_ant;

void eventInit(void) {
    kpInit();
    key_ant = 0;
}

unsigned int eventRead(void) {
    int key;
    int ev = EV_NOEVENT;
    key = kpRead();
    if (key != key_ant) {
        if (BitTst(key, 3)) {
            ev = EV_RIGHT;
        }

        if (BitTst(key, 7)) {
            ev = EV_LEFT;
        }

        if (BitTst(key, 1)) {
            ev = EV_ENTER;
        }
        
        if (BitTst(key, 5)) {
            ev = EV_DOWN;
        }
        
        if (BitTst(key, 4)) {
            ev = EV_UP;
        }
    }

    key_ant = key;
    return ev;
}
