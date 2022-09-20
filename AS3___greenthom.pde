// Constructors/Variables
PImage background1, background2, background3;
PImage runLeftSheet, runRightSheet;
PImage idleRightSheet, idleLeftSheet;
PImage jumpLeftSheet, jumpRightSheet;

PImage[] runL = new PImage[8];
PImage[] runR = new PImage[8];
PImage[] idleL = new PImage[6];
PImage[] idleR = new PImage[6];
PImage[] jumpL = new PImage[10];
PImage[] jumpR = new PImage[10];

int charWidth = 56;
int charX;
int charY = 0;
int cameraX = 0;
int animFrame = 0;
float velX = 0;
float velY = 0;

boolean moveLeft = false;
boolean moveRight = false;
boolean idleLeft = false;
boolean idleRight = true;
boolean jumpLeft = false;
boolean jumpRight = false;
String actionPreJump = "idle";

// Setup (pull images)
void setup(){
  size(1000,180);
  charX = width/2;
  
  background1 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_1_sm.png");
  background2 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_2_sm.png");
  background3 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_3_sm.png");
  //background1.resize(1000, 400);
  //background2.resize(1000, 400);
  //background3.resize(1000, 400);
  
  idleRightSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_l.png");
  idleLeftSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_r.png");
  runRightSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/run_r.png");
  runLeftSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/run_l.png");
  jumpRightSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/jump_r.png");
  jumpLeftSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/jump_l.png");
}

void getCharState(PImage sheet, PImage[] array){
  for(int i = 0; i < array.length; i++){
    array[i] = sheet.get(i*charWidth,0,charWidth,charWidth);
  }
}

// Draw Method (pull)
void draw(){
  
  println(charY);
  if(!idleLeft && !idleRight){
    if(velX > 0){
      charX += velX;
      if(charX > 0.8*width){
        charX = (int)(0.8*width);
        cameraX += velX;
      }
    }
    if(velX < 0){
      charX += velX;
      if(charX < 0.2*width){
        charX = (int)(0.2*width);
        cameraX += velX;
      }
    }
    if(!moveLeft && !moveRight){
      if(velY > 0){
        charY += velY;
      }
    }
  }
  
  drawParallax();
  
  if(moveLeft){
    getCharState(runLeftSheet, runL);
    drawCharacter(runL);
  }
  else if(moveRight){
    getCharState(runRightSheet, runR);
    drawCharacter(runR);
  }
  else if(idleLeft){
    getCharState(idleLeftSheet, idleL);
    drawCharacter(idleL);
  }
  else if(idleRight){
    getCharState(idleRightSheet, idleR);
    drawCharacter(idleR);
  }
  else if(jumpLeft){
    getCharState(jumpLeftSheet, jumpL);
    drawCharacter(jumpL);
  }
  else if(jumpRight){
    getCharState(jumpRightSheet, jumpR);
    drawCharacter(jumpR);
  }
  
  if(world2ScreenX(charX,0,1) > 0.8*width){
    cameraX += world2ScreenX(charX, 0,1) - 0.8*width;
  }
  
  animFrame = (frameCount/3)%6;
}

int world2ScreenX(int x, int y, int z){
  return (x - cameraX)/z;
}

void drawParallax(){
  image(background1, world2ScreenX(0,0,3),0);
  image(background1, world2ScreenX(background1.width*3,0,3),0);
  image(background1, world2ScreenX(background1.width*3,0,3)+background1.width,0);
  
  image(background2, world2ScreenX(0,0,2),0);
  image(background2, world2ScreenX(background2.width*2,0,2),0);
  image(background2, world2ScreenX(background2.width*2,0,2)+background2.width,0);
  
  image(background3, world2ScreenX(0,1,1),0);
  image(background3, world2ScreenX(background3.width,0,1),0);
  image(background3, world2ScreenX(background3.width,0,1)+background3.width,0);
  
  if(cameraX > background1.width){
    cameraX = 0;
  }
  if(cameraX < -background1.width){
    cameraX = 0;
  }
}

void drawCharacter(PImage[] array){
  image(array[animFrame],charX,(height-5)-charWidth-charY);
}

//Key Methods
void keyPressed(){
  if(key == 'a' || key == 'A'){
    moveLeft = true;
    idleLeft = false;
    idleRight = false;
    velX = -3;
  }
  if(key == 'd' || key == 'D'){
    moveRight = true;
    idleLeft = false;
    idleRight = false;
    velX = 3;
  }
  if(key == ' '){
   if(moveLeft){
     actionPreJump = "moveLeft";
   }
   if(moveRight){
     actionPreJump = "moveRight";
   }
   if(idleLeft){
     actionPreJump = "idleLeft";
   }
   if(idleRight){
     actionPreJump = "idleRight";
   }
    if(moveLeft){
      print(velX);
      jumpLeft = true;
      moveLeft = false;
      moveRight = false;
      idleLeft = false;
      idleRight = false;
      velY = 5;
      for(int i = 0; i < frameCount; i++){
        velY -= 0.5;
      }
    }
    if(idleLeft){
      print(velX);
      jumpRight = true;
      moveLeft = false;
      moveRight = false;
      idleLeft = false;
      idleRight = false;
      velY = 5;
      for(int i = 0; i < frameCount; i++){
        velY -= 0.5;
      }
    }
    if(moveRight){
      jumpRight = true;
      moveLeft = false;
      moveRight = false;
      idleLeft = false;
      idleRight = false;
      velY = 5;
      for(int i = 0; i < frameCount; i++){
        velY -= 0.5;
      }
    }
    if(idleRight){
      jumpLeft = true;
      moveLeft = false;
      moveRight = false;
      idleLeft = false;
      idleRight = false;
      velY = 5;
      for(int i = 0; i < frameCount; i++){
        velY -= 0.5;
      }
    }
    if(charY == 0){
      velY = 0;
    }
  }
  if((key == 'a' || key == 'A') && (key == 'd' || key == 'D')){
    velX = 0;
  }
}

void keyReleased(){
  if(key == 'a' || key == 'A'){
    moveLeft = false;
    idleRight = true;
    velX = 0;
  }
  if(key == 'd' || key == 'D'){
    moveRight = false;
    idleLeft = true;
    velX = 0;
  }
  if(key == ' '){
    if(actionPreJump.equals("idleLeft")){
      idleLeft = true;
      jumpLeft = false;
    }
     if(actionPreJump.equals("idleRight")){
      idleRight = true;
      jumpRight = false;
    }
     if(actionPreJump.equals("moveLeft")){
      moveLeft = true;
      jumpLeft = false;
    }
     if(actionPreJump.equals("moveRight")){
      moveRight = true;
      jumpRight = false;
    }
  }
}
    




  
