PImage background1, background2, background3;
PImage idleSheet, idleSheetLeft;
PImage runSheetRight, runSheetLeft;

//idle = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_l.png");
//idleLeft = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_r.png");

PImage[] idle = new PImage[6]; //right
PImage[] idleLeft = new PImage[6];

PImage[] runAnimRight = new PImage[8];
PImage[] runAnimLeft = new PImage[8];

int cameraX = 0;
int charSize = 56;

PVector camera = new PVector(0.0,0.0,0.0);
enum animState {
  idle, idleLeft, RunningRight, RunningLeft, jumpRight, jumpLeft
};
animState state = animState.idle;

void setup(){
  size(1000,400);
  noSmooth();
  
idleSheet = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_l.png");
idleSheetLeft = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/idle_r.png");

  runSheetRight = loadImage("run_r.png");
  runSheetLeft = loadImage("run_l.png");
  
  background1 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_1_sm.png");
  background2 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_2_sm.png");
  background3 = loadImage("https://ecs.wgtn.ac.nz/foswiki/pub/Courses/CGRA151_2022T2/Assignment3/background_layer_3_sm.png");
  background1.resize(1000, 400);
  background2.resize(1000, 400);
  background3.resize(1000, 400);
  
  imageMode(CORNER);
  frameRate(30);
  for(int i = 0; i<idle.length; i++){
    int x = i*charSize;
    int y = 0;
   idle[i] = idleSheet.get(x,y,charSize,charSize);
    imageDouble(idle[i]);
  }
  
  for(int i = 0; i < runAnimRight.length; i++) {
    runAnimRight[i] = runSheetRight.get(i*charSize, 0, charSize, charSize);
    runAnimRight[i].resize(112, 112);
    runAnimLeft[i] = runSheetLeft.get(i*charSize, 0, charSize, charSize);
    runAnimLeft[i].resize(112, 112);
  }
  
}

void draw(){
  drawParallax();
  //background(0);
  image(idle[frameCount%6],500,290);
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

void imageDouble(PImage toScale){
  toScale.resize(toScale.width*2,toScale.height*2);
}
