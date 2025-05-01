import processing.serial.*;
import processing.sound.*;

//Piano Key Sounds
SoundFile c3;
SoundFile d3;
SoundFile e3;
SoundFile f3;
SoundFile buzzer;
SoundFile titleMusic;
SoundFile victoryMusic;

Serial port;

float timerHeight;
int startTime;

ArrayList<Tiles> tilesList;

//timer color
float r;
float g;

//states
int state;

//Player Scores
int scoreLeft;
int scoreRight;
int winSize;

boolean bigger;

//Countdown
int countdown;
boolean cowntdown;

//Start Screen
PImage startScreen;
boolean show;

boolean move;

void setup(){
size(1800, 900);

String portname = "COM3";
port = new Serial(this, portname, 9600);

textAlign(CENTER);
imageMode(CENTER);

timerHeight = 175;
startTime = millis();
winSize = 125;

tilesList = new ArrayList<Tiles>();

for(int rectY = -300; rectY < height; rectY += 300){
  
tilesList.add (new Tiles(rectY,rectY));

}

r = 0;
g = 255;

bigger = false;

countdown = 4;
cowntdown = false;

startScreen = loadImage("StartScreenPianoTilesNoBackground.png");
show = true;

move = true;

c3 = new SoundFile (this, "C3.mp3");
d3 = new SoundFile (this, "D3.mp3");
e3 = new SoundFile (this, "E3.mp3");
f3 = new SoundFile (this, "F3.mp3");
buzzer = new SoundFile (this, "buzzer.mp3");
titleMusic = new SoundFile(this, "StartScreenMusic.mp3");
victoryMusic = new SoundFile (this, "VictoryMusic.mp3");

}

void draw(){
background(200); 

while(port.available() > 0){

char inByte = port.readChar();
println(inByte);

powerButtonPressed(inByte);
buttonPressed(inByte);

}

switch(state){
  
case 0:

timer(10000);

for(int numTiles = 0; numTiles < tilesList.size(); numTiles++){ 

tilesList.get(numTiles).renderLeft();
tilesList.get(numTiles).renderRight();

tilesList.get(numTiles).tilesMoveSolo(tilesList);

}

scoreBoard();

if(show == true){
image(startScreen, width/2,425);
startScreen.resize(0,900);
}

countdown();

if (titleMusic.isPlaying() == false) {
titleMusic.play();
}

break;

  
case 1:

titleMusic.stop();

//Putting in the tiles
for(int numTiles = 0; numTiles < tilesList.size(); numTiles++){ 

tilesList.get(numTiles).renderLeft();
tilesList.get(numTiles).renderRight();

tilesList.get(numTiles).moveTilesLeft(tilesList);
tilesList.get(numTiles).moveTilesRight(tilesList);

}

//Adding timer
timer(55);

//Adding Scoreboard
scoreBoard();

break;

case 2:

titleMusic.stop();

for(int numTiles = 0; numTiles < tilesList.size(); numTiles++){ 

tilesList.get(numTiles).renderLeft();
tilesList.get(numTiles).renderRight();

}

scoreBoard();

winner();

if (victoryMusic.isPlaying() == false) {
victoryMusic.play();
}

break;

}

}

void bunchOfIfsLeft(){
  
for(int numTiles = 0; numTiles < tilesList.size(); numTiles++){   
  
if(keyPressed == true && key == 'a'){
  
tilesList.get(numTiles).leftLoc = 0; 
  
}

if(keyPressed == true && key == 's'){
  
tilesList.get(numTiles).leftLoc = 1; 
  
}

if(keyPressed == true && key == 'd'){
  
tilesList.get(numTiles).leftLoc = 2; 
  
}

if(keyPressed == true && key == 'f'){
  
tilesList.get(numTiles).leftLoc = 3; 
  
}

if(tilesList.get(numTiles).rectYLeft == 600){
  
tilesList.get(numTiles).bottomLeft = true;  
  
}

}

}

void bunchOfIfsRight(){
  
for(int numTiles = 0; numTiles < tilesList.size(); numTiles++){   
  
if(keyPressed == true && key == 'h'){
  
tilesList.get(numTiles).rightLoc = 0; 
  
}

if(keyPressed == true && key == 'j'){
  
tilesList.get(numTiles).rightLoc = 1; 
  
}

if(keyPressed == true && key == 'k'){
  
tilesList.get(numTiles).rightLoc = 2; 
  
}

if(keyPressed == true && key == 'l'){
  
tilesList.get(numTiles).rightLoc = 3; 
  
}

if(tilesList.get(numTiles).rectYRight == 600){
  
tilesList.get(numTiles).bottomRight = true;  
  
}

}

}


void keyPressed(){
  
if(key == 'a' || key == 's' || key == 'd' || key == 'f'){  
bunchOfIfsLeft();
}
if(key == 'h' || key == 'j' || key == 'k' || key == 'l'){  
bunchOfIfsRight();
}

if (key == 'q' && state == 2){
  
scoreLeft = 0;
scoreRight = 0;
state = 0;

timerHeight = 175;

countdown = 4;

move = true;
  
}

if(key == 'r' && state == 0){
  
cowntdown = true;
show = false;
move = false;
  
}
  
}
  
void timer(int interval){

fill(r,g,0);

rect(width/2 - 25, timerHeight, 50, 900);

if(millis() - startTime > interval){
  
startTime = millis();
timerHeight += 1;

if(g > 0 && r <= 255){
  
r += .7;
  
}

if(r >= 255){
  
g -= .7;
  
}
}

if (timerHeight >= 900){
  
g = 255;  
r = 0;  
timerHeight = 175;  
state = 2; 
  
}

}

void keyReleased(){
  
for(int numTiles = 0; numTiles < tilesList.size(); numTiles++){     
  
if(key == 'a' || key == 's' || key == 'd' || key == 'f'){  
tilesList.get(numTiles).leftLoc = -1;
}
if(key == 'h' || key == 'j' || key == 'k' || key == 'l'){  
tilesList.get(numTiles).rightLoc = -1;
}
  
}

}

void scoreBoard(){
  
int rectX = width/2 - 300;
int rectW = 600;
int rectH = 175;
  
fill(#FFB921);
rect(rectX,0, rectW, rectH, 60);
fill(0);
textSize(125);
text(scoreLeft, rectX + 150, rectH - 50);
text(scoreRight, rectX + rectW/2 + 150, rectH - 50);  
  
}

void winner(){
  
if( scoreLeft > scoreRight){
  
fill(0);
textSize(winSize);
text("BLUE WINS", width/2, height/2 +100);

}  

if( scoreRight > scoreLeft){
  
fill(0);
textSize(winSize);
text("GREEN WINS", width/2, height/2 +100);

}  

if( scoreRight == scoreLeft){
  
fill(0);
textSize(200);
text("TIE?!?! :0", width/2, height/2 +100);

}  

if(winSize <= 125){
bigger = !bigger;
}
if(winSize >= 275){
bigger = !bigger;
}

if(bigger == true){
winSize += 4;
}

if(bigger == false){
winSize -= 4;
}

fill(0);
textSize(100);
text("PRESS START TO RETURN TO MENU", width/2, height - 125);

}

void countdown(){
  
if(countdown == 3){  
fill(0);
textSize(200);
text("READY!", width/2, height/2 + 110);
}
if(countdown == 2){  
fill(0);
textSize(200);
text("SET!!", width/2, height/2 +125);
}
if(countdown == 1){  
fill(0);
textSize(200);
text("GO!!!", width/2, height/2 +140);
}
if(countdown == 0){  
cowntdown = false;
state = 1;
show = true;
}

if(cowntdown == true){
  
titleMusic.stop();
  
if(millis() - startTime > 1000){

startTime = millis();
countdown -= 1;
  
}
  
}

}

void buttonPressedRight(char inByte){
  
for(int numTiles = 0; numTiles < tilesList.size(); numTiles++){   
  
if(inByte == 'h'){
  
tilesList.get(numTiles).rightLoc = 0; 
c3.play();
  
}

if(inByte == 'j'){
  
tilesList.get(numTiles).rightLoc = 1; 
d3.play();
  
}

if(inByte == 'k'){
  
tilesList.get(numTiles).rightLoc = 2; 
e3.play();
  
}

if(inByte == 'l'){
  
tilesList.get(numTiles).rightLoc = 3; 
f3.play();
  
}

if(tilesList.get(numTiles).rectYRight == 600){
  
tilesList.get(numTiles).bottomRight = true;  
  
}

}

}

void buttonPressedLeft(char inByte){

for(int numTiles = 0; numTiles < tilesList.size(); numTiles++){

if(inByte == 'a'){
  
tilesList.get(numTiles).leftLoc = 0; 
c3.play();
  
}

if(inByte == 's'){
  
tilesList.get(numTiles).leftLoc = 1; 
d3.play();
  
}

if(inByte == 'd'){
  
tilesList.get(numTiles).leftLoc = 2; 
e3.play();
  
}

if(inByte == 'f'){
  
tilesList.get(numTiles).leftLoc = 3; 
f3.play();
  
}

if(tilesList.get(numTiles).rectYLeft == 600){
  
tilesList.get(numTiles).bottomLeft = true;  
  
}
  
}

}

void powerButtonPressed(char inByte){

if(inByte == 'q' && state == 0){
  
cowntdown = true;
show = false;
move = false;
  
}

if (inByte == 'q' && state == 2){
  
scoreLeft = 0;
scoreRight = 0;
state = 0;

timerHeight = 175;

countdown = 4;

move = true;
  
}

}

void buttonPressed(char inByte){
  
if(inByte == 'a' || inByte == 's' || inByte == 'd' || inByte == 'f'){
buttonPressedLeft(inByte);
}
if(inByte == 'h' || inByte == 'j' || inByte == 'k' || inByte == 'l'){
buttonPressedRight(inByte);
}
  
}
