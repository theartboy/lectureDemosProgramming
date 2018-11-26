
Unicorn u;
Platform [] platforms;

boolean left, right, up, down, space;
FrameObject camera, gameWorld;
ImageObject backImage;
PImage aaron;
void setup() {
  size(800, 600);

  left = false;
  right = false;
  up = false;
  down = false;
  space = false;

  aaron = loadImage("DesktopAaronR.jpg");
  backImage = new ImageObject(0, 0, 1024, 768, aaron);
  gameWorld = new FrameObject(0, 0, backImage.w*3, backImage.h);
  camera = new FrameObject(0, 0, width, height);

  camera.x = (gameWorld.x + gameWorld.w/2) - camera.w/2;
  camera.y = (gameWorld.y + gameWorld.h/2) - camera.h/2;


  //unicorn values
  u = new Unicorn();
  platforms = new Platform[7];
  platforms[0] = new Platform (300, 460, 200, 25, "safe");
  platforms[1] = new Platform (0, 300, 200, 25, "safe");
  platforms[2] = new Platform (600, 300, 200, 25, "safe");
  platforms[3] = new Platform (300, 140, 200, 25, "safe");
  platforms[4] = new Platform (824, 460, 200, 25, "safe");
  platforms[5] = new Platform (824, 140, 200, 25, "safe");
  platforms[6] = new Platform (0, gameWorld.h-20, gameWorld.w, 25, "death");
}

void draw() {
  background(255);
  u.update();
  //Move the camera
  camera.x = floor(u.x + (u.halfWidth) - (camera.w / 2));
  camera.y = floor(u.y + (u.halfHeight) - (camera.h / 2));

  //Keep the camera inside the gameWorld boundaries
  if (camera.x < gameWorld.x) {
    camera.x = gameWorld.x;
  }
  if (camera.y < gameWorld.y) {
    camera.y = gameWorld.y;
  }
  if (camera.x + camera.w > gameWorld.x + gameWorld.w) {
    camera.x = gameWorld.x + gameWorld.w - camera.w;
  }
  if (camera.y + camera.h > gameWorld.h) {
    camera.y = gameWorld.h - camera.h;
  }
  
  pushMatrix();
  translate(-camera.x, -camera.y);
  
  backImage.display();
  u.display();
  for (int i = 0; i < platforms.length; ++i) {
    platforms[i].display();
  }

  popMatrix();
  
  displayPositionData();
}


void displayPositionData() {
  fill(0);
  String s = "\nvx: "+u.vx+"  vy: ";
  text(s, 50, 50);
}

void keyPressed() {
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
  case 32: //space
    space = true;
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
  case 32: //space
    space = false;
    break;
  }
}
