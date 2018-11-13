class Unicorn {

  float w, h, x, y, vx, vy,
    accelerationX, accelerationY,
    speedLimit;

  //world variables
  float friction, bounce, gravity;

  boolean isOnGround;
  float jumpForce;

  float halfWidth, halfHeight;
  String collisionSide;


  Unicorn() {
    w = 100;//was 140. shrink to be centered on body
    h = 65;//was 95. shrink to be centered on body
    x = 400;
    y = 150;
    vx = 0;
    vy = 0;
    accelerationX = 0;
    accelerationY = 0;
    speedLimit = 5;
    isOnGround = false;
    jumpForce = -10;

    //world values
    friction = 0.96;
    bounce = -0.7;
    gravity = 3;

    halfWidth = w/2;
    halfHeight = h/2;

    collisionSide = "";
  }

  void update() {
    if (left && !right) {
      accelerationX = -0.2;
    }
    if (right && !left) {
      accelerationX = 0.2;
    }
    if (!left&&!right) {
      accelerationX = 0;
    }

    if (up && !down) {
      accelerationY = -0.2;
    }
    if (down && !up) {
      accelerationY = 0.2;
    }
    if (!up&&!down) {
      accelerationY = 0;
    }


    vx += accelerationX;
    vy += accelerationY;


    ////correct for maximum speeds
    if (vx > speedLimit) {
      vx = speedLimit;
    }
    if (vx < -speedLimit) {
      vx = -speedLimit;
    }
    if (vy > speedLimit) {
      vy = speedLimit;
    }
    if (vy < -speedLimit) {
      vy = -speedLimit;
    }

    ////move the player
    x+=vx;
    y+=vy;
  }


  void display() {
    fill(0, 255, 0, 128);
    rect(x, y, w, h);
  }
}
