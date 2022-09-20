// Constructors/Variables
PImage bkgr1, bkgr2, bkgr3;
PImage runLSheet, runRSheet;
PImage idleRSheet, idleLSheet;
PImage jumpLSheet, jumpRSheet;

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
float vX = 0;
float vY = 0;

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
  
  bkgr1 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_1_sm.png");
  bkgr2 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_2_sm.png");
  bkgr3 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_3_sm.png");
  //bkgr1.resize(1000, 400);
  //bkgr2.resize(1000, 400);
  //bkgr3.resize(1000, 400);
  
  idleRSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_l.png");
  idleLSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_r.png");
  runRSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/run_r.png");
  runLSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/run_l.png");
  jumpRSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/jump_r.png");
  jumpLSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/jump_l.png");
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
    if(vX > 0){
      charX += vX;
      if(charX > 0.8*width){
        charX = (int)(0.8*width);
        cameraX += vX;
      }
    }
    if(vX < 0){
      charX += vX;
      if(charX < 0.2*width){
        charX = (int)(0.2*width);
        cameraX += vX;
      }
    }
    if(!moveLeft && !moveRight){
      if(vY > 0){
        charY += vY;
      }
    }
  }
  
  drawParallax();
  
  if(moveLeft){
    getCharState(runLSheet, runL);
    drawCharacter(runL);
  }
  else if(moveRight){
    getCharState(runRSheet, runR);
    drawCharacter(runR);
  }
  else if(idleLeft){
    getCharState(idleLSheet, idleL);
    drawCharacter(idleL);
  }
  else if(idleRight){
    getCharState(idleRSheet, idleR);
    drawCharacter(idleR);
  }
  else if(jumpLeft){
    getCharState(jumpLSheet, jumpL);
    drawCharacter(jumpL);
  }
  else if(jumpRight){
    getCharState(jumpRSheet, jumpR);
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
  image(bkgr1, world2ScreenX(0,0,3),0);
  image(bkgr1, world2ScreenX(bkgr1.width*3,0,3),0);
  image(bkgr1, world2ScreenX(bkgr1.width*3,0,3)+bkgr1.width,0);
  
  image(bkgr2, world2ScreenX(0,0,2),0);
  image(bkgr2, world2ScreenX(bkgr2.width*2,0,2),0);
  image(bkgr2, world2ScreenX(bkgr2.width*2,0,2)+bkgr2.width,0);
  
  image(bkgr3, world2ScreenX(0,1,1),0);
  image(bkgr3, world2ScreenX(bkgr3.width,0,1),0);
  image(bkgr3, world2ScreenX(bkgr3.width,0,1)+bkgr3.width,0);
  
  if(cameraX > bkgr1.width){
    cameraX = 0;
  }
  if(cameraX < -bkgr1.width){
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
    vX = -3;
  }
  if(key == 'd' || key == 'D'){
    moveRight = true;
    idleLeft = false;
    idleRight = false;
    vX = 3;
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
      print(vX);
      jumpLeft = true;
      moveLeft = false;
      moveRight = false;
      idleLeft = false;
      idleRight = false;
      vY = 5;
      for(int i = 0; i < frameCount; i++){
        vY -= 0.5;
      }
    }
    if(idleLeft){
      print(vX);
      jumpRight = true;
      moveLeft = false;
      moveRight = false;
      idleLeft = false;
      idleRight = false;
      vY = 5;
      for(int i = 0; i < frameCount; i++){
        vY -= 0.5;
      }
    }
    if(moveRight){
      jumpRight = true;
      moveLeft = false;
      moveRight = false;
      idleLeft = false;
      idleRight = false;
      vY = 5;
      for(int i = 0; i < frameCount; i++){
        vY -= 0.5;
      }
    }
    if(idleRight){
      jumpLeft = true;
      moveLeft = false;
      moveRight = false;
      idleLeft = false;
      idleRight = false;
      vY = 5;
      for(int i = 0; i < frameCount; i++){
        vY -= 0.5;
      }
    }
    if(charY == 0){
      vY = 0;
    }
  }
  if((key == 'a' || key == 'A') && (key == 'd' || key == 'D')){
    vX = 0;
  }
}

void keyReleased(){
  if(key == 'a' || key == 'A'){
    moveLeft = false;
    idleRight = true;
    vX = 0;
  }
  if(key == 'd' || key == 'D'){
    moveRight = false;
    idleLeft = true;
    vX = 0;
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
    




  
