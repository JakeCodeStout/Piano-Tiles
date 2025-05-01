class Tiles{
  
//Tile Variables
int tileW;
int tileH;

int rectYLeft;
int rectYRight;

//Color tiles
int colorTileLeftX1;
int colorTileRightX1;

color tileC1;
color tileC2;

int speedY;

boolean prevMoveTileLeft;
boolean moveTilesLeft;

boolean prevMoveTileRight;
boolean moveTilesRight;

boolean bottomLeft;
boolean bottomRight;

int [] tilePositioningLeft = {0, 219, 438, 657};
int [] tilePositioningRight = {925, 1144, 1363, 1582};

int tilePlacementLeft1;
int tilePlacementRight1;

int leftLoc;
int rightLoc;

int buzzTimeRight;
int buzzTimeLeft;
int interval;

boolean wrongTileRight;
boolean wrongTileLeft;

int soloTimeRight;
int soloTimeLeft;

Tiles(int leftY, int rightY){
  
tilePlacementLeft1 = int(random(0,3));
tilePlacementRight1 = int(random(0,3));

colorTileLeftX1 = tilePositioningLeft[tilePlacementLeft1];
colorTileRightX1 = tilePositioningRight[tilePlacementRight1];

tileW = 219;
tileH = 300;
rectYLeft = leftY;
rectYRight = rightY;

tileC1 = color(0,0,255);
tileC2 = color(0,255,0);

bottomLeft = false;
bottomRight = false;

leftLoc = -1;
rightLoc = -1;

interval = 1000;

wrongTileRight = false;
wrongTileLeft = false;

soloTimeRight = millis();
soloTimeLeft = millis();
  
}

//Adding piano tiles to the left side  
void renderLeft(){
  
for(int rectX = 0; rectX < width/2 - 25; rectX += 219){

fill(255);
rect(rectX,rectYLeft,tileW,tileH);

}

strokeWeight(4);
stroke(0);
fill(tileC1);
rect(colorTileLeftX1, rectYLeft, tileW, tileH);

}

void renderRight(){
  
//Adding piano tiles to the right side
for(int rectX = width/2 + 25; rectX < width; rectX += 219){

fill(255);
rect(rectX,rectYRight, tileW, tileH);
  
}

fill(tileC2);
rect(colorTileRightX1, rectYRight, tileW, tileH);
  
}

void moveTilesLeft(ArrayList<Tiles> aTileList){

if (moveTilesLeft == true && prevMoveTileLeft == false){
  
  for(int numTiles = 0; numTiles < tilesList.size(); numTiles++){
    
    aTileList.get(numTiles).rectYLeft += 300;
     aTileList.get(numTiles).resetLeft();
    
  }
   scoreLeft += 1;

}

prevMoveTileLeft = moveTilesLeft; 
moveTilesLeft = false;

if(bottomLeft == true && tilePlacementLeft1 == leftLoc && wrongTileLeft == false){
  
moveTilesLeft = true;

}
else if(bottomLeft == true && tilePlacementLeft1 != leftLoc && leftLoc > -1 ){
  
leftLoc = -1;
  
wrongTileLeft = true;  
tileC1 = color(255,0,0);
  
buzzTimeLeft = millis();
buzzer.play();
  
}

if(millis() - buzzTimeLeft > interval){
  
tileC1 = color(0,0,255);
wrongTileLeft = false;
  
}

}

void moveTilesRight(ArrayList<Tiles> aTileList){
  
if (moveTilesRight == true && prevMoveTileRight == false){
  
  for(int numTiles = 0; numTiles < tilesList.size(); numTiles++){ 
    aTileList.get(numTiles).rectYRight += 300;
     aTileList.get(numTiles).resetRight();
     
  }
  
scoreRight += 1;

}

prevMoveTileRight = moveTilesRight; 
moveTilesRight = false;

if(bottomRight == true && tilePlacementRight1 == rightLoc && wrongTileRight == false){
   
moveTilesRight = true;

}
else if(bottomRight == true && tilePlacementRight1 != rightLoc && rightLoc > -1 ){
  
rightLoc = -1;  

wrongTileRight = true;  
tileC2 = color(255,0,0);
buzzTimeRight = millis();

buzzer.play();
  
}

if(millis() - buzzTimeRight > interval){

tileC2 = color(0,255,0);
wrongTileRight = false;
  
}

}

void resetLeft(){

if(rectYLeft >= 900){
  
rectYLeft = -300;

bottomLeft = false;
tilePlacementLeft1 = int(random(0,4));
colorTileLeftX1 = tilePositioningLeft[tilePlacementLeft1];

}

}

void resetRight(){

if(rectYRight >= 900){
  
rectYRight = -300;

bottomRight = false;
tilePlacementRight1 = int(random(0,4));
colorTileRightX1 = tilePositioningRight[tilePlacementRight1]; 
  
}

}

void tilesMoveSolo(ArrayList<Tiles> aTileList){
  
bunchOfIfsLeft();
bunchOfIfsRight();
  
if(millis() - soloTimeRight > random(400,600) && bottomRight == true && move == true){
  
soloTimeRight = millis();

for(int numTiles = 0; numTiles < tilesList.size(); numTiles++){ 
  
    aTileList.get(numTiles).rectYRight += 300;
    delay(10);
     aTileList.get(numTiles).resetRight();
     
}

}

if(millis() - soloTimeLeft > random(400,600) && bottomLeft == true && move == true){
  
soloTimeLeft = millis();
  
for(int numTiles = 0; numTiles < tilesList.size(); numTiles++){ 
  
  aTileList.get(numTiles).rectYLeft += 300;
  delay(10);
     aTileList.get(numTiles).resetLeft();
     
}
  
}

}

}
