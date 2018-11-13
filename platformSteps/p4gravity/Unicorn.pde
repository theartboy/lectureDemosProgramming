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
    speedLimit = 10;
    isOnGround = false;
    jumpForce = -10;

    //world values
    friction = 0.96;
    bounce = -0.7;
    gravity = .3;

    halfWidth = w/2;
    halfHeight = h/2;

    collisionSide = "";
  }

  void update() {
    //start all moves off with friction at 1
    if (left && !right) {
      accelerationX = -0.2;
      friction = 1;
    }
    if (right && !left) {
      accelerationX = 0.2;
      friction = 1;
    }
    if (!left&&!right) {
      accelerationX = 0;
    }

    if (up && !down) {
      accelerationY = -0.2;
      gravity = 0;
      friction = 1;
    }
    if (down && !up) {
      accelerationY = 0.2;
      friction = 1;
    }
    if (!up&&!down) {
      accelerationY = 0;
    }
    //removing impulse reintroduces friction
    if (!up && !down && !left && !right) {
      friction = 0.96; 
      gravity = 0.3;
    }

    vx += accelerationX;
    vy += accelerationY;

    //friction 1 = no friction
    vx *= friction;
    vy *= friction;

    //apply gravity
    vy += gravity;

    ////correct for maximum speeds
    if (vx > speedLimit) {
      vx = speedLimit;
    }
    if (vx < -speedLimit) {
      vx = -speedLimit;
    }
    //need to let gravity ramp it up
    if (vy > 3 * speedLimit) {
      vy = 3 * speedLimit;
    }
    if (vy < -speedLimit) {
      vy = -speedLimit;
    }

    ////move the player
    x+=vx;
    y+=vy;

    checkBoundaries();
  }

  void checkBoundaries() {
    ////check boundaries
    ////left
    if (x < 0) {
      vx *= bounce;
      x = 0;
    }
    //// right
    if (x + w > width) {
      vx *= bounce;
      x = width - w;
    }
    ////top
    if (y < 0) {
      vy *= bounce;
      y = 0;
    }
    if (y + h > height) {
      vy *= bounce;
      y = height - h;
    }
  }

  void display() {
    fill(0, 255, 0, 128);
    rect(x, y, w, h);
  }
}
