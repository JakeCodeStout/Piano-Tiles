const int numButtons = 9;

//1st 4 pins are left, other half are right
int buttonPins[numButtons] = {6,7,8,9,10,11,12,13,5};

boolean currentButtonState[numButtons] ={true,true,true,true,true,true,true,true,false};
boolean prevButtonState[numButtons]= {true,true,true,true,true,true,true,true,false};


void setup() {
  
Serial.begin(9600);

}

void loop() {
  
talkToProcessing();

}

void talkToProcessing(){

 for (int i = 0; i< numButtons ; i++){

prevButtonState[i] = currentButtonState[i];
delay(5);
currentButtonState[i] = digitalRead(buttonPins[i]);

 }

  if (currentButtonState[0] == false && prevButtonState[0] == true){

Serial.write('a');

  }
   if (currentButtonState[1] == false && prevButtonState[1] == true){

Serial.write('s');

  }
   if (currentButtonState[2] == false && prevButtonState[2] == true){

Serial.write('d');

  }
   if (currentButtonState[3] == false && prevButtonState[3] == true){

Serial.write('f');

  }

    if (currentButtonState[4] == false && prevButtonState[4] == true){

Serial.write('h');

  }
   if (currentButtonState[5] == false && prevButtonState[5] == true){

Serial.write('j');

  }
   if (currentButtonState[6] == false && prevButtonState[6] == true){

Serial.write('k');

  }
   if (currentButtonState[7] == false && prevButtonState[7] == true){

Serial.write('l');

  }

if (currentButtonState[8] == true && prevButtonState[8] == false){

Serial.write('q');

  }

}

