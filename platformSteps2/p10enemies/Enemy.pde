class Enemy {

  float w, h, x, y, vx, vy, 
    accelerationX, accelerationY, 
    speedLimit;

  float leftEdge, rightEdge, ground;

  //world variables
  float friction, bounce, gravity;

  //boolean isOnGround;
  //float jumpForce;

  float halfWidth, halfHeight;
  //String collisionSide;

  //image variables
  int currentFrame;
  boolean facingRight;
  int frameSequence;
  int frameOffset;

  color c;

  Enemy(Platform p) {
    w = 48;
    h = 48;
    halfWidth = w/2;
    halfHeight = h/2;
    x = p.x + p.w/2 - halfWidth;
    y = p.y - h - 100;

    leftEdge = p.x;
    rightEdge = p.x + p.w;
    ground = p.y;

    vx = (random(10)<5)? -1 : 1;
    
    //if (random(10) < 5) {
    //  vx = -1;
    //} else {
    //  vx = 1;
    //}
    
    //if condition is true do the first thing otherwise do the second
    //ternary operator
    vy = 0;
    accelerationX = 0;
    accelerationY = 0;
    speedLimit = 10;
    //isOnGround = false;
    //jumpForce = -10;

    //world values
    friction = 0.96;
    bounce = -0.7;
    gravity = .3;


    //collisionSide = "";
    currentFrame = 0;
    facingRight = true;
    frameSequence = 6;//number of frames in each animation sequence
    frameOffset = 0;

    c = color(255);
  }

  void update() {
    //start all moves off with friction at 1

    //if (left && !right) {
    //  accelerationX = -0.2;
    //  friction = 1;
    //  facingRight = false;
    //}
    //if (right && !left) {
    //  accelerationX = 0.2;
    //  friction = 1;
    //  facingRight = true;
    //}
    //if (!left&&!right) {
    //  accelerationX = 0;
    //}


    //friction = 0.96; 

    //vx += accelerationX;
    //vy += accelerationY;

    //friction 1 = no friction
    //vx *= friction;

    //apply gravity
    vy += gravity;

    ////correct for maximum speeds
    //need to let gravity ramp it up
    if (vy > 3 * speedLimit) {
      vy = 3 * speedLimit;
    }
    //don't need when jumping
    //if (vy < -speedLimit) {
    //  vy = -speedLimit;
    //}

    //correct minimum speeds

    if (abs(vy) < 0.2) {
      vy = 0;
    }

    ////move the enemy
    //x+=vx;
    //y+=vy;
    x = Math.max(0, Math.min(x + vx, rightEdge - w)); 
    y = Math.max(0, Math.min(y + vy, ground - h));

    checkBoundaries();
  }


  void checkBoundaries() {
    ////check boundaries
    ////left
    if (x <= leftEdge) {
      vx *= -1;
      //accelerationX *= -1;
      x = leftEdge;
    }
    //// right
    if (x >= rightEdge - w) {
      vx *= -1;
      //accelerationX *= -1;
      x = rightEdge - w;
    }
    ////ground
    if (y >= ground - h) {
      if (vy < 1) {
        vy = 0;
      } else {
        //reduced bounce for floor bounce
        vy *= bounce/2;
      }
      y = ground - h;
    }
  }



  void display() {
    fill(255, 255, 0);
    rect(x, y, w, h);
  }
}
