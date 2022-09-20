PImage background1;
PImage background2;
PImage background3;
PImage idleSheet;
PImage idleSheetLeft;
PImage runSheetRight, runSheetLeft;
PImage jumpSheetRight, jumpSheetLeft;
PImage[] runAnimRight = new PImage[8];
PImage[] runAnimLeft = new PImage[8];
PImage[] jumpAnimRight = new PImage[10];
PImage[] jumpAnimLeft = new PImage[10];
//PImage[] currentAnimation = idleSheet;

int charDim = 56;

PImage[] idle = new PImage[6];
PImage[] idleLeft = new PImage[6];

int playerX = frameCount/10;

int cameraX = 0;
int animFrame = 0;

void setup(){
  size(1000, 180);
  background1 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_1_sm.png");
  background2 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_2_sm.png");
  background3 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_3_sm.png");

  idleSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_r.png");
  idleSheetLeft = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_l.png");
  runSheetRight = loadImage("run_r.png");
  runSheetLeft = loadImage("run_l.png");
  jumpSheetRight = loadImage("jump_r.png");
  jumpSheetLeft = loadImage("jump_l.png");
  
  for(int i = 0; i<idle.length; i++){
    idle[i] = idleSheet.get(i*charDim, 0, charDim, charDim);
    idle[i].resize(112, 112);
    idleLeft[i] = idleSheetLeft.get(i*charDim, 0, charDim, charDim);
    idleLeft[i].resize(112, 112);
  }
  
for(int i = 0; i < runAnimRight.length; i++) {
    runAnimRight[i] = runSheetRight.get(i*charDim, 0, charDim, charDim);
    runAnimRight[i].resize(112, 112);
    runAnimLeft[i] = runSheetLeft.get(i*charDim, 0, charDim, charDim);
    runAnimLeft[i].resize(112, 112);
  }
  
  for(int i = 0; i < jumpAnimRight.length; i++) {
    jumpAnimRight[i] = jumpSheetRight.get(i*charDim, 0, charDim, charDim);
    jumpAnimRight[i].resize(112, 112);
    jumpAnimLeft[i] = jumpSheetLeft.get(i*charDim, 0, charDim, charDim);
    jumpAnimLeft[i].resize(112, 112);
  }
}

void draw() {
  //scale(2.0);
  playerX = frameCount;
  if(world2ScreenX(playerX) > 0.8*width) {
    cameraX += world2ScreenX(playerX) - 0.8*width;
  }
  animFrame = (frameCount/3)%6; 
  drawParallax(cameraX);
  drawCharacter(animFrame);
}

int world2ScreenX(int x, int y, int z){
  return(x - cameraX)/z;
}

int world2ScreenX(int x){
  return (x - cameraX);
}

void drawParallax(int cameraX){
  image(background1, world2ScreenX(0, 0, 3), 0);
  image(background1, world2ScreenX(background1.width*3, 0, 3), 0);
  image(background2, world2ScreenX(0, 0, 2), 0);
  image(background2, world2ScreenX(background2.width*2, 0, 2), 0);
  image(background3, world2ScreenX(background3.width*(cameraX/background3.width), 0, 1), 0);
  image(background3, world2ScreenX(background3.width*((cameraX/background3.width)+1), 0, 1), 0);
}

void drawCharacter(int animFrame){
  image(idle[animFrame], playerX, (height-10)-charDim);
}
