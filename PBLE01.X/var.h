#ifndef VAR_H
#define	VAR_H

void varInit(void);

char getState(void);
void setState(char newState);
int getTime(void);
void setTime(int newTime);
int getMult(void);
void setMult(int mult);
int getAlarmLevel(int valor);
void setAlarmLevel(int newAlarmLevel, int valor);
char getLanguage(void);
void setLanguage(char newLanguage);
int getSenhaStatus();
void enableSenha(int x);
int getSenha_i(void);
int getSenha_try(void);
int getTestResult();
void setTestResult(int x);
int testSenha(char senha);
int setSenha(char senha);

#endif	/* VAR_H */
