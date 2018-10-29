class Vehicle {
  float x, y, w, h;
  float speedX, speedY, maxSpeed;
  int numFrames, currentFrame;
  PImage spriteImage;

  Vehicle() {
    x=width/2;
    y=height/2;
    w=32;
    h=32;
    speedX=0;
    speedY=0;
    maxSpeed = 10;

    numFrames = 7;
    currentFrame = 0;
    spriteImage = imagesRight[currentFrame];
  }
  void update() {
    if (left && !right) {
      speedY = 0;
      speedX = -maxSpeed;
      spriteImage = imagesLeft[currentFrame];
    }
    if (right && !left) {
      speedY = 0;
      speedX = maxSpeed;
      spriteImage = imagesRight[currentFrame];
    }
    if ((!left && !right)) {
      speedX = 0;
    }
    if (left && right) {
      speedX = 0;
    }

    if (up && !down) {
      speedX = 0;
      speedY = -maxSpeed;
      spriteImage = imagesUp[currentFrame];
    }
    if (down && !up) {
      speedX = 0;
      speedY = maxSpeed;
      spriteImage = imagesDown[currentFrame];
    }
    if (!up && !down) {
      speedY = 0;
    }
    if (up && down) {
      speedY = 0;
    }

    x += speedX;
    y += speedY;
    
    currentFrame++;
    if (currentFrame == numFrames) {
     currentFrame = 0; 
    }
  }
  void display() {
    image(spriteImage, x, y);
  }
}
