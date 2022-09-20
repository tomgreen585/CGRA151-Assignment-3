PImage background1, background2, background3;
PImage idleSheet, idleSheetLeft;
//PImage runSheetRight, runSheetLeft;
//PImage jumpSheetRight, jumpSheetLeft;

PImage[] idle = new PImage[6];
PImage[] idleLeft = new PImage[6];
//PImage[] runAnimRight = new PImage[8];
//PImage[] runAnimLeft = new PImage[8];
//PImage[] jumpAnimRight = new PImage[10];
//PImage[] jumpAnimLeft = new PImage[10];
PImage[] currentAnimation = idle;

int charDimen = 56;
float charX = 20;
float charY = 260;
float step = 11;
int cameraX = 0;
int charNum = 0;

int jumpIndex = -1;

enum animState {
  idle, idleLeft, RunningRight, RunningLeft, jumpRight, jumpLeft
};
animState state = animState.idle;

void setup(){
  size(1000, 400);
  frameRate = 30;
  
  background1 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_1_sm.png");
  background2 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_2_sm.png");
  background3 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_3_sm.png");
  background1.resize(1000, 400);
  background2.resize(1000, 400);
  background3.resize(1000, 400);
  
  idleSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_r.png");
  idleSheetLeft = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_l.png");
  runSheetRight = loadImage("run_r.png");
  runSheetLeft = loadImage("run_l.png");
  jumpSheetRight = loadImage("jump_r.png");
  jumpSheetLeft = loadImage("jump_l.png");
  
  //1
  for(int i = 0; i<idle.length; i++){
    idle[i] = idleSheet.get(i*charDimen, 0, charDimen, charDimen);
    idle[i].resize(112, 112);
    idleLeft[i] = idleSheetLeft.get(i*charDimen, 0, charDimen, charDimen);
    idleLeft[i].resize(112, 112);
  }
  
  for(int i = 0; i < runAnimRight.length; i++) {
    runAnimRight[i] = runSheetRight.get(i*charDimen, 0, charDimen, charDimen);
    runAnimRight[i].resize(112, 112);
    runAnimLeft[i] = runSheetLeft.get(i*charDimen, 0, charDimen, charDimen);
    runAnimLeft[i].resize(112, 112);
  }
  
  for(int i = 0; i < jumpAnimRight.length; i++) {
    jumpAnimRight[i] = jumpSheetRight.get(i*charDimen, 0, charDimen, charDimen);
    jumpAnimRight[i].resize(112, 112);
    jumpAnimLeft[i] = jumpSheetLeft.get(i*charDimen, 0, charDimen, charDimen);
    jumpAnimLeft[i].resize(112, 112);
  }
}

void draw() {
  if(jumpIndex == charNum){
    jumpIndex = -1;
    //toIdle();
  }
  if(state == animState.IdleLeft || state == animState.IdleRight){
    charNum = (frameCount/3)%6;
  } else if(state == animState.RunningLeft || state == animState.RunningRight){
    charNum = (frameCount/3)%8;
  }else if(state == animState.jumpLeft || state == animState.jumpRight){
    charNum = (frameCount/3)%10;
    if(jumpIndex == -1){
      jumpIndex = charNum -1;
    }
  }
  
  drawParallax();
  image(currentAnimation[charNum], charX, charY);
}

int world2ScreenX(int x, int z){
  return (x-cameraX)/z;
}

float world2ScreenX(float x){
  return (x-cameraX);
}

int backgroundNum = 0;
void drawParallax(){
  image(background1, world2ScreenX(background1.width * backgroundNum, 3), 0);
  image(background1, world2ScreenX(background1.width * (backgroundNum+1),3), 0);
  image(background2, world2ScreenX(background2.width * backgroundNum, 2), 0);
  image(background2, world2ScreenX(background2.width * (backgroundNum+1), 2), 0);
  image(background3, world2ScreenX(background3.width * backgroundNum, 1), 0);
  image(background3, world2ScreenX(background3.width * (backgroundNum+1), 1), 0);
  //drawAgain();
}

//method to be fixed
//void drawAgain(){
//  if(world2ScreenX(background1.width * backgroundNum) < world2ScreenX(0)) {
 //   backgroundNum;
//  }
//}

/*void keyPressed(){
  if(key == 'A' || key == 'a'){
    runLeft();
    if(charX < width*0.1){
      cameraX -= step/3;
    } else {
      charX -= step;
    }
  }else if (key == 'D' || key == 'd'){
    runRight();
    if(charX > width * 0.8){
      cameraX += step/3;
    } else {
      charX += step;
    }
  } else if (key == ' '){
    if(state == animState.IdleRight || state == animState.RunningRight || state == animState.RunningLeft){
      state = animState.jumpRight;
      currentAnimation = jumpAnimRight;
    } else {
      state = animState.jumpLeft;
      currentAnimation = jumpAnimLeft;
    }
  }
}*/
