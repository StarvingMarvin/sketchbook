/*
*
* Thanks for using this library! If you like it, please drop me a comment at bart@sbo-dewindroos.nl.
*
* File     : AdvButton.h
* Version  : 1.0
* Released : 24/01/2010
* Author   : Bart Meijer (bart@sbo-dewindroos.nl)
*
* This is the Advanced Button library for the Arduino platform. It will enable you to easily 
* react to user input using simple press-to-make buttons. Features include:
* - Event based implementation 
* - Recording the time a button is pressed
* - Adjustable repeat delay, start delay for the keypressed event
* - requires only a single call in the main loop
*
* This file defines the AdvButton class
*
* Usage: 
* - Include AdvButton.h and ButtonManager.h in your sketch
* - Add a call to ButtonManager::instance()->checkButtons(); in your main loop
* - Declare each button and define the events using a overload of AdvButton ( AdvButton button = AdvButton(<pin>) )
* - Declare the required event functions ( void OnKeyXXX(AdvButton* but) )
* - See the comments below for more help
*/


#include "WProgram.h"


#ifndef ADVBUTTON_H
#define ADVBUTTON_H

class AdvButton;

typedef void (*functiontype)(AdvButton*);


class AdvButton
{

public:
	/*
	This is the first constructor call, use it for keypress buttons 
	pin        : pin number of the button
        OnKeyPress : Function to call when the event occurs
     	repeat     : time between the event is raised while pressing the button (optional)
	startDelay : amount of time between the initial keypress event and when to start repeating (optional)
	*/
	AdvButton(uint8_t pin,void (*OnKeyPress)(AdvButton*) , unsigned long repeat = 300, unsigned long startDelay = 500);

	/*
	This is the second constructor call, use it for other types of buttons
	pin        : pin number of the button
        OnKeyPress : Function to call when the keypress event occurs (optional)
     	OnKeyDown  : Function to call when the keydown event occurs (optional) 
	OnKeyUp    : Function to call when the keyup event occurs (optional) 
	*/
	AdvButton(uint8_t pin,void (*OnKeyPress)(AdvButton*) =NULL, void (*OnKeyDown)(AdvButton*)=NULL,void (*OnKeyUp)(AdvButton*)=NULL);

	/* 
	Checks the state of the button and triggers events accordingly
	Will be called from the ButtonManager	
	*/
	void check();

	/* 
	This function will set the function to call when the keypress event occurs
	*/
	void setOnKeyPress(void (*f)(AdvButton*));

	/* 
	This function will set the function to call when the keydown event occurs
	*/
	void setOnKeyDown(void (*f)(AdvButton*));

	/* 
	This function will set the function to call when the keyup event occurs
	*/
	void setOnKeyUp(void (*f)(AdvButton*));

	/* 
	Sets the time (milliseconds) between each repeated keypress event
	*/
	void setRepeat(unsigned long repeat);

	/* 
	Sets the delay (milliseconds) before the keypress event is repeated
	*/
	void setStartDelay(unsigned long startDelay);

	/* 
	Changes the pin number 
	*/
	void setPin(uint8_t pin);
	
	/* 
	Retrieve the amount of milliseconds the button was pressed,  only valid in keyevents
	*/
	unsigned long getPressTime(); 
private: 
	/* private variables */
	functiontype func_keyUp;
	functiontype func_keyDown;
	functiontype func_keyPress;
    	uint8_t pin;
    	unsigned long repeat;
	unsigned long startDelay;
	unsigned long startPress;
	
};





#endif
