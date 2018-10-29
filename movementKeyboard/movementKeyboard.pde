boolean left, right, up, down;
Vehicle v;

PImage [] imagesLeft;
PImage [] imagesRight;
PImage [] imagesUp;
PImage [] imagesDown;

int numFrames;

void setup() {
  size(800, 600);
  background(255);

  numFrames = 7;
  imagesLeft = new PImage[numFrames];
  imagesRight = new PImage[numFrames];
  imagesUp = new PImage[numFrames];
  imagesDown = new PImage[numFrames];

  for (int i = 0; i < numFrames; i++) {
    imagesLeft[i] = loadImage("Data/left/sprite_left" + i + ".png"); 
    imagesRight[i] = loadImage("Data/right/sprite_right" + i + ".png"); 
    imagesUp[i] = loadImage("Data/up/sprite_up" + i + ".png"); 
    imagesDown[i] = loadImage("Data/down/sprite_down" + i + ".png");
  }

  v=new Vehicle();
}

void draw() {
  background(0);
  v.update();
  v.display();
}

void keyPressed() {
  //if (keyCode == 37) {
  //  left = true;
  //} else if (keyCode == 39) {
  //  right = true;
  //}else if (keyCode == 38) {
  //  up = true;
  //}else if (keyCode == 40) {
  //  down = true;
  //}
  switch (keyCode) {
  case 37://left
    left = true;
    break;
  case 39://right
    right = true;
    break;
  case 38://up
    up = true;
    break;
  case 40://down
    down = true;
    break;
  }
}
void keyReleased() {
  switch (keyCode) {
  case 37://left
    left = false;
    break;
  case 39://right
    right = false;
    break;
  case 38://up
    up = false;
    break;
  case 40://down
    down = false;
    break;
  }
}
