class Player {
  //properties
  float x, y, w, h;
  float speedX, speedY, maxSpeed;
  int currentFrame, loopFrames, offset, delay;
  String facing;
  //constructor
  Player() {
    x = width/2;
    y = height/2;
    w = 44;
    h = 64;
    maxSpeed = 5;
    speedX = 0;
    speedY = 0;
    currentFrame = 0;
    loopFrames = 3;
    offset = 6;
    delay = 0;
    facing = "down";
  }
  //methods
  void update() {
    ////horizontal movement
    if (left) {
      //speedY = 0;
      speedX = -maxSpeed;
      offset = 9;
      facing = "left";
    }
    if (right) {
      //speedY = 0;
      speedX = maxSpeed;
      offset = 3;
      facing = "right";
    }
    if ((!left && !right) || (left && right)) {
      speedX = 0;
    }
    //vertical movement
    if (up) {
      //speedX = 0;
      speedY = -maxSpeed;
      offset = 0;
      facing = "up";
    }
    if (down) {
      //speedX = 0;
      speedY = maxSpeed;
      offset = 6;
      facing = "down";
    }
    if ((!up && !down) || (up && down)) {
      speedY = 0;
    }

    if (!up&&!down&&!left&&!right) {
      currentFrame = 1;
    } else {
      //currentFrame++;
      //if (currentFrame == loopFrames) {
      //  currentFrame = 0;
      //}
      if (delay == 0) {
        currentFrame = (currentFrame+1)%loopFrames;
      }
      delay = (delay+1)%1;
    }//end no keys

    checkBounds();
    
    //update position
    PVector v = new PVector();
    v.x = speedX;
    v.y = speedY;

    v.normalize().mult(maxSpeed);
    x += v.x;
    y += v.y;
    
    //x += speedX;
    //y += speedY;
  }//end update

  void display() {
    //fill(255, 255, 0, 100);
    //rect(x, y, w, h);

    //fill(255, 255, 0, 100);
    //circle(x, y, 600);
    image(playerImages[currentFrame+offset], x, y);
  }
  void checkBounds() {
    if (x > width) {
      x = -w;
    } 
    if (x < -w) {
      x = width;
    }
    if (y > height) {
      y = -h;
    }
    if (y < -h) {
      y = height;
    }
  }
}
