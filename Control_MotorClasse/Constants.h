const int ADCBOUNDARYUPPER = 527;//ADCEQUILIBRIUM + 20; the south is down
const int ADCBOUNDARYLOWER = 502;// ADCEQUILIBRIUM - 20; the north is down
//		Motors
//const int THROTTLEMAX =	45; //maximum throttle position
//const int THROTTLEIDLE = 20;
//const int THROTTLEMIN = 0;
//const int THROTTLENOBEEP = 5;
//const int THROTTLEINCREMENT = 5; // how much to increase or decrease speed
//const int THROTTLEDECREMENT = 5;
//const int DELAYLOOP = 100;
//		Pins
//			acc
const int PINAX = 5; // accelerometer for X axis is on analog pin 5 
//			LEDs
const int PINSTATELED =	8; // Halt State LED
const int PINMATLABLED = 12; // sending telemetry for matlab?
// not using it yet const int PINAY = 4; // accelerometer for Y axis is on analog pin 5 
//			motors
const int PINMN = 9; //N: north / front, marked with the green tape
const int PINMS = 10;//S: south
const int PINMW = 11;//W: west
const int PINME = 6; //E: east
//			buttons
const int PINHALT = 2;
const int PINSTART = 3;
const int PINMATLAB = 4;
//		timer
//const int MOTORPERIOD = 50;
//		input Bytes in ascii

// Average acc
const int MAXAVGQUEUESIZE = 100;
