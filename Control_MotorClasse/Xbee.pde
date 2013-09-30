const int HALT  = 104;  // | 72; // h or H
const int START = 115;  // | 83; // s or S
const int SLOWERN = 49; // 1
const int FASTERN = 50; // 2
const int SLOWERE = 52; // 4
const int FASTERE = 53; // 5
const int SLOWERW = 54; // 6
const int FASTERW = 55; // 7
const int SLOWERS = 57; // 9
const int FASTERS = 48; // 0
const int MATLABON = 109 | 77;// m s
const int GUION = 103;// | 71;// G
const int INCREASEQUEUESIZE = 113;// | 87; // q
const int DECREASEQUEUESIZE = 97;// | 81; // a
const int INCREASEEQ = 101;//e  // increase the equilibruim of the ACC
const int DECREASEEQ = 100;//d
const int SETQUEUESIZE = 119; // w
const int INCREASEERR = 111;// o
const int DECREASEERR = 108;// l
const int GOUP = 34; // "
const int GODOWN = 35; // #
const int TILTB = 37; // %
const int TILTF = 38; // &
const int ORIENTATIONHOLD = 36; // & 
const int NORMALHEIGHT = 33; //!
const int JOYSTICKON = 106; // joystick on 
const int JOYSTICKOFF = 117; // joystick off



//Receiving commands from the mesh
void readXbee(){
  if ( Serial.available() > 0)
  {
    incomingAscii = Serial.read();
    switch (incomingAscii){
    case HALT: 
      stateHalt = true;
      break;
    case START:
      stateHalt = false;	
      break;
    case JOYSTICKON:
      joyStickControl = true;
      break;
      
    case JOYSTICKOFF:
      joyStickControl = false;
      break;
       
    case FASTERS:
      south.inc(); 
      break;
    case SLOWERS:
      south.dec();
      break;
    case FASTERN:
      north.inc();
      break;
    case SLOWERN:
      north.dec();
      break;
    case FASTERW:
      west.inc(); 
      break;
    case SLOWERW:
      west.dec();
      break;
    case FASTERE:
      east.inc();
      break;
    case SLOWERE:
      east.dec();
      break;
    case MATLABON:
      stateTelemetryMatlab = true;
      break;
    case GUION:
      stateTelemetryMatlab = false;
      break;
    case INCREASEQUEUESIZE:
      AVGQUEUESIZE ++;
      break;
    case DECREASEQUEUESIZE:
      AVGQUEUESIZE --;
      break;
    case INCREASEEQ:
      ADCEQUILIBRIUM++;
      break;
    case DECREASEEQ:
      ADCEQUILIBRIUM--;
      break;
    case SETQUEUESIZE:
      fillingQueue = true;
      avgCount = 0; // to restart averaging, and refil the queue
      avgTotal = 0;
      avgIndex = 0;
      break;
    case INCREASEERR:
      ADCERROR++;
      break;
    case DECREASEERR:
      ADCERROR--;
      break;
    /*case TILTB:
      if (joyStickControl == true)
      {
      Serial.println('.'); //Acknoladgment 
      north.goTo(25,1);
      south.goTo(20,1);
      }
      break;
    case TILTF:
     if (joyStickControl == true)
     {
     Serial.println(','); //ack
     north.goTo(20,1);
     south.goTo(25,1);
     }
     break;  
    case NORMALHEIGHT:
    if (joyStickControl == true)
    {
    Serial.println('-'); //
    north.goTo(20,1);
    south.goTo(20,1);
    }
    break;*/
      
      
    }
  }
}

// What do you want to send on the xbee mesh
void sendTelemetry(){
  if (stateTelemetryMatlab == true){
    Serial.println("matlab");
    Serial.println((byte)accx, DEC);
  }
  else {
    north.sendSpeed();
    south.sendSpeed();
    west.sendSpeed();
    east.sendSpeed();
    Serial.print((byte)accx, DEC);
    Serial.print(",");
    Serial.print(AVGQUEUESIZE, DEC);
    Serial.print(",");
    Serial.print(ADCEQUILIBRIUM, DEC);
    Serial.print(",");
    Serial.print(ADCERROR, DEC);
    Serial.print(",");
    Serial.print(stateHalt, DEC);
    Serial.print(",");
    Serial.print(fillingQueue, DEC);
    Serial.print(",");
    Serial.print(joyStickControl, DEC);
    Serial.print(",");
    Serial.print(joyStickControl, DEC);


    /* -- old method --
    tele('A', (byte)accx);
    tele('Q', AVGQUEUESIZE);
    tele('U', ADCEQUILIBRIUM);
    tele('R', ADCERROR);
    teleIf('H', stateHalt);
    teleIf('F', fillingQueue);
    teleIf('J', joyStickControl);
    */
    
    Serial.println("*"); // needed for api to stop reading
  }
}

/* -- not needed w/ new API --
void tele(char identifier, int var){
  //Serial.print(identifier);
  Serial.print(var, DEC);
  Serial.print(",");
}*/

/* -- obsolete but kept for legacy purposes plz use the single input fn instead -- */
// sending a state, a bool
void teleIf(char identifier, boolean cond){ 
  //Serial.println(identifier);
  if (cond == true) {
    Serial.print(1,DEC);
    Serial.print(",");
  }
  else {
    Serial.print(0,DEC);
    Serial.print(",");
  }
}

/* -- converts a bool to an integer. Probably not needed -- */
void teleIf(boolean cond){
  if (cond == true) {
    Serial.print(1,DEC);
    Serial.print(",");
  }
  else {
    Serial.print(0,DEC);
    Serial.print(",");
  }
}
