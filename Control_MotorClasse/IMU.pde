/*---------------------------------------------------------------------------------*/
//		ADC
int ADCEQUILIBRIUM = 515; // mid point for the ADC (1024/2) --- May change it to be calibrated on run time ***************
int ADCERROR = 3; // +/- BOUNDARY around mid point. 
// Unrealistic to expect the accelerometer to be at exactly 512.
// Around a 10% error (10/1024). 
/*---------------------------------------------------------------------------------*/
int adcAX = 0; //will contain ADC data
//int adcAY = 0; //will contain ADC data


int AVGQUEUESIZE = 1;

int avgAX = 0;
int avgIndex = 0;
int avgTotal = 0;
int avgQueue[MAXAVGQUEUESIZE] = {
  0};
int avgToSub = 0;
int avgCount = 0;


void readSensors(){
  //	adcAX = analogRead(PINAX);       // analog devices Acc
  nunchuck_get_data();
  accx  = nunchuck_accely(); // ranges from approx 70 - 182

  //adcAY = analogRead(PINAY);
  //if (adcAX > ADCEQUILIBRIUM) comingFromNorthDown = false;
  //else if (adcAX < ADCEQUILIBRIUM) comingFromNorthDown = true;
}

void averageAcc(){
  if (avgCount < AVGQUEUESIZE){
    avgTotal += adcAX;
    avgQueue[avgCount] = adcAX;
    avgCount ++;
  }
  else{
    fillingQueue = false;
    //		avgTotal -= avgToSub; // start subtracting once 
    avgTotal -= avgQueue[avgIndex];
    avgQueue[avgIndex] = adcAX;
    avgTotal += adcAX;
    avgAX =avgTotal/AVGQUEUESIZE ;
    avgIndex = (avgIndex + 1) % AVGQUEUESIZE;
  }
}


