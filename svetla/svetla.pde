
#include <AdvButton.h>
#include <ButtonManager.h>
#include <avr/sleep.h>

#define ledPin 9
#define upButtonPin 2
#define downButtonPin 3

#define holdDelay 500
#define holdRepeat 50
#define clickMin 20
#define incStep 15

AdvButton up = AdvButton(upButtonPin, inc, NULL, on);
AdvButton down = AdvButton(downButtonPin, dec, NULL, off);

byte ledValue = 0;

void setup() {
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  attachInterrupt(0, interrupt, CHANGE);
  attachInterrupt(1, interrupt, CHANGE);
  set_sleep_mode(SLEEP_MODE_IDLE);
  sleep_enable();
}

void interrupt() {
  ButtonManager::instance()->checkButtons();
}

void loop() {
  
  ButtonManager::instance()->checkButtons();
  
  if (digitalRead(upButtonPin) == LOW &&
      digitalRead(downButtonPin) == LOW) {
    
    sleep_mode();
  }

}



void inc(AdvButton* but) {
  long pressTime = but->getPressTime();
  if (pressTime > holdDelay) {
    if (ledValue > 255-incStep) {
      ledValue = 255;
    } 
    else {
      ledValue+=incStep;  
    }

    Serial.println(ledValue, DEC);
    analogWrite(ledPin, ledValue);
  }

}

void dec(AdvButton* but) {
  long pressTime = but->getPressTime();
  if (pressTime > holdDelay) {
    if (ledValue < incStep) {
      ledValue = 0;
    } 
    else {
      ledValue-=incStep;
    }
    Serial.println(ledValue, DEC);
    analogWrite(ledPin, ledValue);
  }
}

void on(AdvButton* but) {
  long pressTime = but->getPressTime();
  if (pressTime > clickMin && pressTime < holdDelay) {
    ledValue = 255;
    analogWrite(ledPin, ledValue); 
  }
}


void off(AdvButton* but) {
  long pressTime = but->getPressTime();
  if (pressTime > clickMin && pressTime < holdDelay) {
    ledValue = 0;
    analogWrite(ledPin, ledValue); 
  }
}


