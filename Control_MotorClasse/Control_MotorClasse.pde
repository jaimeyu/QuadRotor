/*
COEN / ELEC 490, group 2009 - 04 Vertical Take Off and Land Autonomous Micro Aerial Vehicle
 
 The following code uses an acceleromer to control the ouput of the motors
 So if you roll left, the heli will roll left (hopefully by the same linear amt)
 
 The code can be adapted to become autonomous.
 
 It uses timer2 to interrupt the arduino to control the motors. 
 Apparently, we're supposed to pulse it every 40ms and  I really 
 _REALLY_
 hate seeing delay(x) or sleep(x) in code.
 
 Talk about throwing CPU cycles into the garbage.
 
 So the CPU is spent mostly checking the sensors and Serial instead of waiting for the next motor pulse. 
 
 */

//#include "WProgram.h" in the motor class
#include <MsTimer2.h> //Interrupt class - its in ../hardware/libraries/MStimer2/
#include <Wire.h>
#include "nunchuck_funcs.h"
#include "motor.h"
#include <Servo.h> 
#include "constants.h"

void setup(); // all these may not be needed
void loop();
void readXbee();
void readButtons();
void readSensors();
void averageAcc();
void setLeds();
void sendTelemetry();
void tele(char identifier, int var);
void setMotors(); 


bool stateTelemetryMatlab = false; //matlab can't deal with too much info at once.
bool stateHalt = true;
bool fillingQueue = true;
bool joyStickControl  = false;
int incomingAscii= 0;
int ccount = 0;

/*---------------------------------------------------------------------------------*/
// Wii
//int loop_cnt=0;

byte accx,accy,zbut,cbut;
//int ledPin = 13;

Motor north, south, west, east;
/*---------------------------------------------------------------------------------*/
void setup() {
  //analogReference(EXTERNAL); // tells the arduino to use the external AREF for the ADC

  pinMode(PINHALT, INPUT);
  pinMode(PINSTART, INPUT);
  pinMode(PINSTATELED, OUTPUT);
  pinMode(PINMATLAB, INPUT);
  pinMode(PINMATLABLED, OUTPUT);
  Serial.begin(9600);   //Serial

  Serial.println("Started, initializing motors:");
  north.init(PINMN, 'N');
  south.init(PINMS, 'S');
  west.init(PINMW, 'W'); 
  east.init(PINME, 'E');

  //  Wii Nunchuck init
  //  nunchuck_setpowerpins();    //doesn't go through
  //  nunchuck_init(); // send the initilization handshake
  Serial.println("initializing interrupt timer");  
  MsTimer2::set(MOTORPERIOD, setMotors); // 25ms period, call setMotors 25 ms
  MsTimer2::start();
  delay(5000); // give it 5 seconds to power all motors with 0 throttle
  Serial.println("5 seconds delay is over");  
  north.noBeep(); // give them both throttle 5 to shut down the 2 beeps
  south.noBeep();
  west.noBeep();
  east.noBeep();
  Serial.println("Setup is done"); 
  Serial.println("---------------------");  
}

void loop() { 
  readXbee();
  readButtons();
  //readSensors();
  //averageAcc();
  setLeds();
  sendTelemetry();
  //setMotors(); //called by the interrupt initiated by the timer 
  delay(10); // needed to send data to matlab
} 

