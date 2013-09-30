#ifndef motor_H
#define motor_H

#include <WProgram.h>
#include <Servo.h> 

//  Motors constants

const int THROTTLEMAX =	45; //maximum throttle position
const int THROTTLEIDLE = 20;
const int THROTTLEMIN = 5;
const int THROTTLENOBEEP = 5;
const int THROTTLEINCREMENT = 5; // how much to increase or decrease speed
const int THROTTLEDECREMENT = 5;
const int DELAYLOOP = 100;
const int HALTSTEPS = 5; // how fast to break when halting
const int MOTORPERIOD = 25;
const int STEP = 5;

class Motor{
private:
  Servo serv;
  int PIN;
  int throttle;
  void updateSpeed();
  char ID;
public:
  Motor();
  void init(int pin, char identifier);
  void inc(int s);
  void inc(); //using default step size
  void incDelay(int step, int delay);
  void dec(int s);
  void dec();
  void decDelay(int s, int delay);
  void halt(); // slows speed fast, breaks faster than the zero function
  void zero(); //sets speed to zero right away
  void noBeep(); //not moving but not beeping
  void goTo(int target, int s); //increase or decrease to go to x
  void goToIdle(int s);
  void sendSpeed();
};

#endif

