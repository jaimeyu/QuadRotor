

void readButtons(){  
  if ( digitalRead(PINHALT) == HIGH){      
    stateHalt = true; 
    stateTelemetryMatlab = false;
  }//halt pin has priority over pin start. 
  else if (digitalRead(PINSTART) == HIGH) stateHalt = false;//it is implied that PINHALT is low. 
  //  if (digitalRead(PINSET) == HIGH) ADCEQUILIBRIUM = adcAX;

  if  ( digitalRead(PINMATLAB) == HIGH) {//&& (stateHalt == true) ) {
    stateTelemetryMatlab = true;
  }

}

void setLeds(){
  if (stateHalt == true) digitalWrite(PINSTATELED, HIGH);
  else digitalWrite(PINSTATELED, LOW);
  
  if (joyStickControl == true) digitalWrite(PINMATLABLED, HIGH);
  else digitalWrite(PINMATLABLED, LOW);
  
  //if (stateTelemetryMatlab == true) digitalWrite(PINMATLABLED, HIGH);
  //else digitalWrite(PINMATLABLED, LOW);
}

