int roadX=-1200,roadY=1600,buildingZ=500;
int angle = 0, order = 1;
int galaxyZ = -8000, winskyZ = -1000;
int timer = 0, checkTimer = 2, giftTime = 0, giftNum=0, ghostNum = 7, lightTimer=0; 
float roadZ = 1000, u =0, galaxyU =0, i = 0.01, speed, carAngle =0, ghostSpeed = 80, size1 = random(20,60), size2 = random(20,60),size3 = random(20,60), size4 = random(20,60), x1 = random(roadX+1500,roadX+3500), y1 = 0, x2 = random(roadX+1500,roadX+3500), y2 = 0;
float x3 = random(roadX+1500,roadX+3500), y3 = 0,  x4 = random(roadX+1500,roadX+3500), y4 = 0, x5 = random(roadX+1500,roadX+3500), y5 = 0, x6 = random(roadX+1500,roadX+3500), y6 = 0, x7 = random(roadX+1500,roadX+3500), y7 = 0, x8 = random(roadX+1500,roadX+3500), y8 = 0;
float size5 = random(20,60), size6 = random(20,60),size7 = random(20,60), size8 = random(20,60),carY = 1200, textY=0, overAngle = 0, giftX = random(roadX+2500,roadX+4000);
PImage road, building, ghostpic1, ghostpic2, ghostpic3, ghostpic4, ghostpic5, ghostpic6, ghostpic7, ghostpic8, giftpic, galaxy, overpic, winskypic, savepic;
PShape s, roadS, buildingS, ghost1, ghost2, ghost3, ghost4, ghost5, ghost6, ghost7, ghost8, gift, over, savelight;
boolean overcheck = true, giftShow = false, timerstatus = true, textShow = true, giftNumshow = false, giftText = true, light = false, skyfront = true;
boolean   ghost1show = true, ghost2show = true,  ghost3show = true, ghost5show = true,  ghost6show = true, ghost7show = true,  ghost8show = true, loseGo = true, winGo = true;
boolean   ghost1check = false, ghost2check = false,  ghost3check = false, ghost5check = false,  ghost6check = false, ghost7check = false,  ghost8check = false, win = false;
float num = 3;
import ddf.minim.*; 
 
Minim minim;          
AudioPlayer giftSound;
AudioPlayer saveSound;
AudioPlayer winSound;
AudioPlayer ghostworld;
void setup()
{
 minim = new Minim(this); 
 winSound = minim.loadFile("win.mp3");
textureWrap(REPEAT);
size(2000, 1200, P3D);
s = loadShape("car.obj");
road = loadImage("road.jpeg");
galaxy = loadImage("1.jpg");
giftpic = loadImage("ghostsave.jpeg");
gift = createShape(BOX, 150,150,150);
gift.setStroke(false);
gift.setTexture(giftpic);
savelight = createShape(SPHERE, 200); // it's the shape of the light when user press the "contorl" key(if they have the gift)
savelight.setStroke(false);
savepic = loadImage("save.jpeg");
savelight.setTexture(savepic);
textureMode(NORMAL);
fill(255);
box(2000,2000,200);
over = createShape(SPHERE, 200); // this is the ball when game over show
overpic = loadImage("over.jpg");
over.setTexture(overpic);
}
void draw()
{
giftSound = minim.loadFile("gift.wav");
saveSound = minim.loadFile("save.wav");
ghostworld = minim.loadFile("lose.wav");
  if(timerstatus) // the timer, to calculate if the gift should display
  {
  timer++;
  }
  if (timer == checkTimer*10) // the gift will display every  num*10 loop, when player "save" a ghost, the num will plus 0.5
  {
  giftShow = true;
  timerstatus = false;
  checkTimer+=num;
  giftX = random(roadX+1000,roadX+3000); // the position that gift display
  }
  // gifts
  if (giftShow && giftTime <10 && !win && overcheck)
  
  {
  giftTime++; // gifttime is the loop times gift should exit, I set as 10,when it is 10, then let the gift disappear
  pushMatrix(); 
  if (angle>0 && roadX > -1700 ){
  giftX-=speed*tan(radians (abs(2*angle)));} // tweak the moving direction of the gift (according to the angle which is operated by players)
  else if (angle<0 && roadX<-500)
  {
  giftX+=speed*tan(radians (abs(2*angle)));}
  rotateY (radians (angle) );
  translate(giftX,carY,-1200);
  shape(gift, 0, 0);
  giftNumshow = true;
  popMatrix();   
  }
  else{
  giftTime = 0; 
  giftShow = false;
  giftNumshow = false;
  timerstatus = true; // restart timer
  }
 
  if (giftX>800&& giftX<1400 && giftNumshow) // when the car touch the gift then it will add one gift
  {
  giftSound.play();   
  giftNum++; // the number of the gift the car have plus one
  giftShow = false;
  giftNumshow = false;
  }  
  
  // the road and ghosts moving direction   
  if (angle>0 && roadX > -1700 ) // set the range that the road can move, avoid it being moved out of screen range
  {roadX-=speed*tan(radians (abs(2*angle))); // Keep them facing directly towards the front of the screen 
  x1-=speed*tan(radians (abs(2*angle)));
  x2-=speed*tan(radians (abs(2*angle)));
  x3-=speed*tan(radians (abs(2*angle)));
  x4-=speed*tan(radians (abs(2*angle)));
  x5-=speed*tan(radians (abs(2*angle)));
  x6-=speed*tan(radians (abs(2*angle)));
  x7-=speed*tan(radians (abs(2*angle)));
  x8-=speed*tan(radians (abs(2*angle)));
  }
  else if (angle<0 && roadX<-500)
  {roadX+=speed*tan(radians (abs(2*angle)));
  x1+=speed*tan(radians (abs(2*angle)));
  x2+=speed*tan(radians (abs(2*angle)));
  x3+=speed*tan(radians (abs(2*angle)));
  x4+=speed*tan(radians (abs(2*angle)));
  x5+=speed*tan(radians (abs(2*angle)));
  x6+=speed*tan(radians (abs(2*angle)));
  x7+=speed*tan(radians (abs(2*angle)));
  x8+=speed*tan(radians (abs(2*angle)));
  }
  
  

// draw the ghosts
 ghost1 = createShape(SPHERE, size1);
 ghostpic1 = loadImage("ghostred.jpeg");
 ghost1.setTexture(ghostpic1);
 ghost2 = createShape(SPHERE, size2);
 ghostpic2 = loadImage("ghostgreen.jpeg");
 ghost2.setTexture(ghostpic2);
 ghost3 = createShape(SPHERE, size3);
 ghostpic3 = loadImage("colorfulghost.jpeg");
 ghost3.setTexture(ghostpic3);
 ghost4 = createShape(SPHERE, size4);
 ghostpic4 = loadImage("ghostcolorful.jpeg");
 ghost4.setTexture(ghostpic4);
 ghost5 = createShape(SPHERE, size5);
 ghostpic5 = loadImage("ghostwhite.jpeg");
 ghost5.setTexture(ghostpic5);
 ghost6 = createShape(SPHERE, size6);
 ghostpic6 = loadImage("ghostpurple.jpeg");
 ghost6.setTexture(ghostpic6);
 ghost7 = createShape(SPHERE, size7);
 ghostpic7 = loadImage("ghost7.jpeg");
 ghost7.setTexture(ghostpic7);
 ghost8 = createShape(SPHERE, size8);
 ghostpic8 = loadImage("ghost8.jpeg");
 ghost8.setTexture(ghostpic8);
  if (y1 > 1600 && ghost1show){
  y1 = random(100,200);
  x1 = random(roadX+1500,roadX+3500); // the position that ghost will display
  size1 = random(30,70);
  }
  if (y2 > 1600 && ghost2show){
  y2 = random(100,200);
  x2 = random(roadX+1500,roadX+3500);
  size2 = random(30,70);
  }
  if (y3 > 1600 && ghost3show){
  y3 = random(100,200);
  x3 = random(roadX+1500,roadX+3500);
  size3 = random(30,70);
  }
  if (y5 > 1600 && ghost5show){
  y5 = random(100,200);
  x5 = random(roadX+1500,roadX+3500);
  size5 = random(30,70);
  }
  if (y6 > 1600 && ghost6show){
  y6 = random(100,200);
  x6 = random(roadX+1500,roadX+3500);
  size6 = random(30,70);
  }
  if (y7 > 1600 && ghost7show){
  y7 = random(100,200);
  x7 = random(roadX+1500,roadX+3500);
  size7 = random(30,70);
  }
  if (y8 > 1600 && ghost8show){
  y8 = random(100,200);
  x8 = random(roadX+1500,roadX+3500);
  size8 = random(30,70);
  }
  
  u+=i; // to make the texture to move to give the players a feeling that the car is moving
  speed = 10000*i;
 
  // draw the road
  if(overcheck && !win){
  pushMatrix(); //save this position
  rotateY (radians (angle) );
  translate(roadX,roadY,roadZ); 
  textureWrap(REPEAT);
  beginShape();
  texture(road);
  vertex (0, 0, 0 , 0, u); // uv map to add the texture on the road and set the texture as "repeat"
  vertex (5000, 0, 0, 2, u);
  vertex(0, 10,0,  0, 0);
  vertex (5000, 10, 0 , 0, 0);
  vertex (0, 0, -100000, 0, u+10);
  vertex(5000, 0, -100000, 2, u+10);
  vertex (0, 10, -100000, 0, 10);
  vertex(5000,10,-100000,0,0);
  endShape();
  popMatrix();
  }
   
   
   
   
   //draw the galaxy
  pushMatrix(); //save this position
  galaxyU-=0.05;
  rotateX(radians(90));
  translate(-10000,galaxyZ,5000); 
  beginShape();
  texture(galaxy);
  vertex (0, 0, 0 , galaxyU, 0);
  vertex (50000, 0, 0, galaxyU,8);
  vertex(0, 10,0,  0, 0);
  vertex (50000, 10, 0 , 0, 0);
  vertex (0, 0, -30000, galaxyU+8, 0);
  vertex(5000, 0, -30000, galaxyU+8, 8);
  vertex (0, 10, -30000, 0, 0);
  vertex(5000,10,-30000,0,0);
  endShape();
  popMatrix();
  
  // write the ghost
  if (overcheck){
  pushMatrix(); //the whole ghosts
  rotateY (radians (angle) );
 if (ghost1show){
  pushMatrix(); //ghost1
  rotateY (radians (angle) );
  translate(x1,y1,-800);
  y1+=ghostSpeed;
  ghost1.setStroke(0);
  shape(ghost1, 0, 0);
  popMatrix(); 
    }
  if (ghost2show){
  pushMatrix(); //ghost2
  translate(x2,y2,-800);
  y2+=ghostSpeed;
  ghost2.setStroke(0);
  shape(ghost2, 0, 0);
  popMatrix(); 
  }
  if (ghost3show){
  pushMatrix(); //ghost3
  translate(x3,y3,-800);
  y3+=ghostSpeed;
  ghost3.setStroke(0);
  shape(ghost3, 0, 0);
  popMatrix(); 
  }
  if(ghost5show){
  pushMatrix(); //ghost5
  translate(x5,y5,-800);
  y5+=ghostSpeed;
  ghost5.setStroke(0);
  shape(ghost5, 0, 0);
  popMatrix(); 
  }
  if(ghost6show){
  pushMatrix(); //ghost6
  translate(x6,y6,-800);
  y6+=ghostSpeed;
  ghost6.setStroke(0);
  shape(ghost6, 0, 0);
  popMatrix(); 
  }
  if(ghost7show){
  pushMatrix(); //ghost7
  translate(x7,y7,-800);
  y7+=ghostSpeed;
  ghost7.setStroke(0);
  shape(ghost7, 0, 0);
  popMatrix();
  }
  if(ghost8show){
  pushMatrix(); //ghost8
  translate(x8,y8,-800);
  y8+=ghostSpeed;
  ghost8.setStroke(0);
  shape(ghost8, 0, 0);
  popMatrix();

  }
  
    popMatrix();
  }

  
  
  
  
  if(!overcheck){ // if the player loses
    giftText = false;
    textSize(150);
    fill(255, 0, 0);
    text("Game Over", 300, textY, -30); 
    textY+=30;
  }
  if (giftText)
  { // the text about the number of the gifts and ghosts
  textSize(100);
  noStroke();
  text("Gifts:", 200, 500, 0);  
  text(giftNum, 450, 500, 0);  
  text("Ghosts:", 200, 350, 0);  
  text(ghostNum, 550, 350, 0); 
  }
  if (light && overcheck){ // when the players uses the "saving light"
  translate(1100,carY,-700);
  rotateY (radians (carAngle) );
  shape(savelight,0,0);
  lightTimer++;
  if(x1>900&& x1<1300 && y1>900) // when "saving light" touch the ghost, it will be saved and disapear
  {
  saveSound.play();
  ghost1check = true;
  x1=0;
  }
  if(x2>900&& x2<1300 && y2>900)
  {
  saveSound.play(); 
  ghost2check = true;
  x2=0;
  }
    if(x3>900&& x3<1300 && y3>900)
  {
   saveSound.play();
  ghost3check = true;
  x3=0;
  }
    if(x5>900&& x5<1300 && y5>900)
  {
     saveSound.play();
  ghost5check = true;
  x5=0;
  }
  if(x6>900&& x6<1300 && y6>900)
  {
     saveSound.play();
  ghost6check = true;
  x6=0;
  }
    if(x7>900&& x7<1300 && y7 > 900)
  {
     saveSound.play();
  ghost7check = true;
  x7=0;
  }
      if(x8>900&& x8<1300 && y8>900)
  {
     saveSound.play();
  ghost8check = true;
  x8=0;
  }
  }
  if(lightTimer == 5){ // the saving light can exist 5 loop times
  lightTimer=0;
  light = false;
  }
    if(ghost1check && ghost1show) // when "saving light" touch the ghost, it will be saved and disapear
  {
  ghost1show = false;
  ghostNum--;
  num+=0.5;
  }
  if(ghost2check && ghost2show)
  {
  ghost2show = false;
  ghostNum--;
  num+=0.5;
  }
    if(ghost3check && ghost3show)
  {
  ghost3show = false;
  ghostNum--;
  num+=0.5;
  }
    if(ghost5check && ghost5show)
  {
  ghost5show = false;
  ghostNum--;
  num+=0.5;
  }
  if(ghost6check && ghost6show)
  {
  ghost6show = false;
  ghostNum--;
  num+=0.5;
  }
    if(ghost7check && ghost7show)
  {
  ghost7show = false;
  ghostNum--;
  num+=0.5;
  }
      if(ghost8check && ghost8show)
  {
  ghost8show = false;
  ghostNum--;
  num+=0.5;
  }
  
  // when the player win
  if(ghostNum == 0){
   if(winGo){
   winSound();} // the win sound founction
   winGo = false; // make it not loop
   if(galaxyZ <-550 && skyfront){
   galaxyZ+=1500;}
   win  = true;
   if(galaxyZ > -1000)
   {
   galaxy = loadImage("sky.jpg"); // the win background
   skyfront = false;
   }
   if(galaxyZ>-8000)
   {
    galaxyZ-=500;
   }
      
    giftText = false;
    textSize(80);
    fill(255,215,0);
    text("Congratulations!", 300, textY, -30);  
    text("You won!", 300, textY+100, -30); 
    if(textY<500){
    textY+=30;
  }
  
  
  }
  

  pushMatrix(); //save this position
  translate(1100,carY,-900);
  rotateY (radians (carAngle) );
  if (light == false && !win){ // if player's car touch a ghost, he or she will lose
  if( (x1>1000&& x1<1200&&y1<1600&&y1>1100) || (x2>1000&& x2<1200&&y2<1600&&y2>1100) || (x3>1000&& x3<1200&&y3<1600&&y3>1100) || (x5>1000&& x5<1200&&y5<1600&&y5>1100) 
  || (x6>1000&& x6<1200&&y6<1600&&y6>1100) || (x7>1000&& x7<1200&&y7<1600&&y7>1100) || (x8>1000&& x8<1200&&y8<1600&&y8>1100))
  {overcheck = false;  
  if(loseGo){
  ghostWorld();}
  loseGo = false;}}
  if (overcheck) { // draw the car
  scale(150,150,-150);
  rotateX(PI/2);
  shape(s, 0, 0);
  }
  else 
  {
  rotateZ(radians (overAngle)); // if lose, the car will become a "ghost" (a sphere)
  over.setStroke(0);
  shape(over, 0, 0);
  carY -=20;
  overAngle +=80;
  }
  popMatrix(); //save this position
}


void winSound(){
winSound.play();

}
void ghostWorld(){

ghostworld.play();

}
void keyPressed(){
if(keyCode == LEFT){
  if (angle > -20 ) { // set the angle range
  angle-=3;
  carAngle+=3;
  }
}
if(keyCode == RIGHT){
  if (angle < 30 ) {
  angle+=3;
  carAngle-=3;
  }
}
if(keyCode == UP){
  if (i<0.15){
  i+=0.01;
  ghostSpeed+=10;}
}
if(keyCode == DOWN){
  roadZ+=50;
}
if(keyCode ==  CONTROL && giftNum >0){
  light = true;
  giftNum--; // when players user a saving light, his gift will minus one
}
  else if (key == 's'){
  save("game" + order + ".jpg"); // it can save many screen shots
  order++;
  }
}
