/* 

This is a demo sketch showing the Advanced Button 
library features for the Arduino platform. This demo
requires 4 buttons connected on pin 2,3,4,5 and 4 LED's
connected on pins 8,9,10,11. Each button will show 
a different behaviour:

Button1: Demonstrates the keypress events. Upon pressing, 
LED 1 will light up shortly showing the key is down. After
a short delay (1 second) the keypress event will occur
every 100 millisseconds blinking the LED shortly.

Button2: Shows the basic key up/down events. LED 2 will
light up while button 2 is pressed, until the button is 
released.

Button3: Records the amount of time the button is pressed
and lights up LED3 for the same duration.

Button4: Shows a on/off switch. Upon pressing for the first 
time LED 4 will start blinking. Pressing again will stop
the LED from blinking.

*/


#include <AdvButton.h>
#include <ButtonManager.h>

#define PINBUTTON1 2
#define PINBUTTON2 3
#define PINBUTTON3 4
#define PINBUTTON4 5

#define PINLIGHT1 8
#define PINLIGHT2 9
#define PINLIGHT3 10
#define PINLIGHT4 11

AdvButton but1 = AdvButton(PINBUTTON1,OnKeyPressBut1,100,1000);
AdvButton but2 = AdvButton(PINBUTTON2,NULL,OnKeyDownBut2,OnKeyUpBut2);
AdvButton but3 = AdvButton(PINBUTTON3,NULL,NULL,OnKeyUpBut3);
AdvButton but4 = AdvButton(PINBUTTON4,NULL,OnKeyDownBut4);

boolean blinking = false;

void setup()
{
  
  
}

void OnKeyPressBut1(AdvButton* but)
{
  digitalWrite(PINLIGHT1,HIGH);
  delay(5);
  digitalWrite(PINLIGHT1,LOW);
}


void OnKeyDownBut2(AdvButton* but)
{
  digitalWrite(PINLIGHT2,HIGH);
  
}

void OnKeyUpBut2(AdvButton* but)
{
  digitalWrite(PINLIGHT2,LOW);
}

void OnKeyUpBut3(AdvButton* but)
{
  digitalWrite(PINLIGHT3,HIGH);
  delay(but->getPressTime());
  digitalWrite(PINLIGHT3,LOW);
}

void OnKeyDownBut4(AdvButton* but)
{
  blinking = !blinking;  
}

void loop()
{
  ButtonManager::instance()->checkButtons();
 
  if (blinking)
  {
    if (millis() % 500 > 250)
    {
      digitalWrite(PINLIGHT4,HIGH);
    }
    else
    {
      digitalWrite(PINLIGHT4,LOW);     
    }
  }
  else
    digitalWrite(PINLIGHT4,LOW);
   
}


