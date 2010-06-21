/*
*
* Thanks for using this library! If you like it, please drop me a comment at bart@sbo-dewindroos.nl.
*
* File     : ButtonManager.h
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
* This file defines the ButtonManager class. 
*
*/

#include "AdvButton.h"

// define the number of buttons
#define MAXBUTTONS 10


#ifndef BUTTONMANAGER_H
#define BUTTONMANAGER_H

class ButtonManager
{

    	int numButtons;
   	AdvButton* buttons[MAXBUTTONS]; 
    
    	static ButtonManager *s_instance;
    	ButtonManager();
  public:

    	static ButtonManager *instance();
	void checkButtons();
	void addButton(AdvButton* but);
	
};

//extern 

#endif;


