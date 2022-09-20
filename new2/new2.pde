//Constructors
Boolean left, right, jumpRight, jumpLeft;
PImage background1, background2, background3;
PImage idleSheet, idleSheetLeft;
PImage runSheetRight, runSheetLeft;
PImage jumpSheetRight, jumpSheetLeft;

PImage[] idle = new PImage[6]; //idle right
PImage[] idleLeft = new PImage[6]; //idle left
PImage[] runAnimRight = new PImage[8]; //run right
PImage[] runAnimLeft = new PImage[8]; //run left
PImage[] jumpAnimRight = new PImage[10]; //jump right
PImage[] jumpAnimLeft = new PImage[10]; //jump left
PImage[] currentAnimation = idle;

int charSize = 56;
float charX = 20;
float charY = 288;
float step = 60;
int cameraX = 0;
int charNum = 0;
int jumpIndex = -1;

PVector camera = new PVector(0.0,0.0,0.0);



enum animState {
  idle, idleLeft, RunningRight, RunningLeft, jumpRight, jumpLeft
};
animState state = animState.idle;



//Setup
void setup(){
  size(1000,400);
 smooth();
  frameRate(120);
  imageMode(CORNER);
  
  left = false;
  right = false;
  jumpRight = false;
  jumpLeft = false;
  
  idleSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_l.png");
  idleSheetLeft = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_r.png");
  runSheetRight = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/run_r.png");
  runSheetLeft = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/run_l.png");
  jumpSheetRight = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/jump_r.png");
  jumpSheetLeft = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/jump_l.png");
  
  background1 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_1_sm.png");
  background2 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_2_sm.png");
  background3 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_3_sm.png");
  background1.resize(1000, 400);
  background2.resize(1000, 400);
  background3.resize(1000, 400);
  
  
  //for(int i = 0; i<idle.length; i++){
   // int x = i*charSize;
   // int y = 0;
   //idle[i] = idleSheet.get(x,y,charSize,charSize);
   // imageDouble(idle[i]);
 // }
  
  for(int i = 0; i<idle.length; i++){
    idle[i] = idleSheet.get(i*charSize, 0, charSize, charSize);
    idle[i].resize(112, 112);
    idleLeft[i] = idleSheetLeft.get(i*charSize, 0, charSize, charSize);
    idleLeft[i].resize(112, 112);
  }
  
  for(int i = 0; i < runAnimRight.length; i++) {
    runAnimRight[i] = runSheetRight.get(i*charSize, 0, charSize, charSize);
    runAnimRight[i].resize(112, 112);
    runAnimLeft[i] = runSheetLeft.get(i*charSize, 0, charSize, charSize);
    runAnimLeft[i].resize(112, 112);
  }
  
  for(int i = 0; i < jumpAnimRight.length; i++) {
    jumpAnimRight[i] = jumpSheetRight.get(i*charSize, 0, charSize, charSize);
    jumpAnimRight[i].resize(112, 112);
    jumpAnimLeft[i] = jumpSheetLeft.get(i*charSize, 0, charSize, charSize);
    jumpAnimLeft[i].resize(112, 112);
  } 
}


//Draw
void draw(){
  
  if(jumpIndex == charNum){
    jumpIndex = -1;
  } if(state == animState.idleLeft || state == animState.idle){
    charNum = (frameCount/3)%6;
  } else if(state == animState.RunningLeft || state == animState.RunningRight){
    charNum = (frameCount/3)%8;
  } else if(state == animState.jumpLeft || state == animState.jumpRight){
    charNum = (frameCount/3)%10;
    if(jumpIndex == -1){
      jumpIndex = charNum -1;
    }}
  
  drawParallax();

  image(currentAnimation[charNum], charX, charY);   //1
  //image(idle[frameCount%6],500,290);    //2
}




int world2ScreenX(int x, int z){
  return (x-cameraX)/z;}
float world2ScreenX(float x){
  return (x-cameraX);}


int backgroundNum = 0;
void drawParallax(){
  //println(" print0 " + world2ScreenX(background1.width * (backgroundNum+1), 3)+" "+cameraX);
  //println(" print1 " + world2ScreenX(background1.width * backgroundNum, 3)+" "+cameraX);
  image(background1, world2ScreenX(background1.width * backgroundNum, 3)%(background1.width*1/40), 0);
  //image(background1, world2ScreenX(background1.width * backgroundNum, 3)%(background1.width*1/4), 0);
  image(background1, world2ScreenX(background1.width * (backgroundNum+1)%(background1.width*1/40),1), 0);
  image(background2, world2ScreenX(background2.width * backgroundNum, 2)%(background2.width*1/40), 0);
  image(background2, world2ScreenX(background2.width * (backgroundNum+1)%(background2.width*1/40), 2), 0);
  image(background3, world2ScreenX(background3.width * backgroundNum, 1)%(background3.width*1/40), 0);
  image(background3, world2ScreenX(background3.width * (backgroundNum+1)%(background3.width*1/40), 3), 0);
  //left
  //image(background1, world2ScreenX(background1.width * (backgroundNum-3),3), 0);
  //image(background2, world2ScreenX(background2.width * (backgroundNum-2), 2), 0);
  //image(background3, world2ScreenX(background3.width * (backgroundNum-1), 1), 0);
}



void imageDouble(PImage toScale){
  toScale.resize(toScale.width*2,toScale.height*2);}




void keyPressed(){
  //int keyIndex = -1;
  println(key);
  if(key == 'A' || key == 'a'){
   left = true;
   state = animState.RunningLeft;
   currentAnimation = runAnimLeft;
    if(charX < width*0.1){
      cameraX -= step/3;
    } else {
      charX -= step;
    }
  }else if (key == 'D' || key == 'd'){
    right = true;
   state = animState.RunningRight;
   currentAnimation = runAnimRight;
    if(charX > width * 0.8){
      cameraX += step/3;
    } else {
      charX += step;
    }
  } else if (key == ' '){
    if(state == animState.idle || state == animState.RunningRight || state == animState.RunningLeft){
      jumpRight = true;
      right = true;
      state = animState.jumpLeft;
      currentAnimation = jumpAnimLeft;
      
    } else {
      jumpLeft = true;
      left = true;
      state = animState.jumpRight;
      currentAnimation = jumpAnimRight;
      
    }
  }
}

void keyReleased(){
  //int keyIndex = -1;
  if(key == 'A' || key == 'a'){
   left = false;
   state = animState.idle;
   currentAnimation = idle;
    if(charX < width*0.8){
      cameraX -= step/3;
    } else {
      charX -= step;
    }
  }else if (key == 'D' || key == 'd'){
    right = false;
    state = animState.idleLeft;
   currentAnimation = idleLeft;
    if(charX > width * 0.8){
      cameraX += step/3;
    } else {
      charX += step;
    }
  } else if (key == ' '){
    if(state == animState.idle || state == animState.RunningRight ){//|| state == animState.RunningLeft){
      jumpRight = false;
      right = false;
      state = animState.RunningRight;
      currentAnimation = jumpAnimRight;
    } else {
      jumpLeft = false;
      left = false;
      state = animState.RunningLeft;
      currentAnimation = jumpAnimLeft;
 }}}
