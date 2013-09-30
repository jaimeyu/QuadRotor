#include "motor.h"

Motor::Motor(){
  zero();
}

void Motor::init(int pin, char identifier){
  serv.attach(pin);
  ID = identifier;
  zero();
} 

void Motor::inc(int s){
  if (throttle < THROTTLEMAX) throttle += s;
  updateSpeed();
}

void Motor::inc(){
  inc(STEP);
}

void Motor::incDelay(int s, int delay){
  //////////////////////////fill it later
}

void Motor::dec(int s){
  if (throttle > THROTTLEMIN) throttle -= s;
  updateSpeed();
}

void Motor::dec(){
  dec(STEP);
}
void Motor::decDelay(int sep, int delay){
  //////////////////////////////////
}

void Motor::halt(){
  dec(HALTSTEPS);  
}

void Motor::zero(){
  throttle = 0;
  updateSpeed();
}

void Motor::noBeep(){
  throttle = THROTTLENOBEEP;
  updateSpeed();
}

void Motor::goTo(int target, int s){
  if (throttle > target) dec(s);
  else if (throttle < target) inc(s);
}

void Motor::goToIdle(int s){
  goTo(THROTTLEIDLE, s);
}

void Motor::sendSpeed(){
  //Serial.println(ID);
  Serial.print(throttle, DEC);
  Serial.print(",");
  
}
void Motor::updateSpeed(){
    serv.write(throttle); // update the servo signals
}
