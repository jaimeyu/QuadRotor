
void setMotors(){
  if ( stateHalt == true){ //halt state
    north.halt();
    south.halt();
    west.halt();
    east.halt();
  }
}
