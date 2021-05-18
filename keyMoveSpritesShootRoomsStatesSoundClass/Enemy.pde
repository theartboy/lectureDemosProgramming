class Enemy {
  float x, y, w, h, vx, vy, speed;
  int currentFrame, loopFrames, offset, delay;
  int storedTime = 0;
  boolean dead;
  //constructor
  Enemy() {
    x = random(width-200) + 100;
    y = random(height-200) + 100;
    w = 64;
    h = 64;
    vx = 0;
    vy = 0;
    speed = random(1, 2);
    currentFrame = 0;
    loopFrames = 4;
    offset = 0;
    delay = 0;
    dead = false;
  }
  void update() {
    x += vx;
    y += vy;
  }
  void display() {
    //fill(0, 255, 0, 100);
    //rect(x, y, w, h);
    image(enemyImages[currentFrame+offset], x, y);
  }
  void reset(){
    x = random(width-200) + 100;
    y = random(height-200) + 100;
    dead = false;
  }
  void destroy(){
    vx = 0;
    vy = 0;
    x = 0;
    dead = true;
  }
  
  void chase(float px, float py) {
    if (dist(x, y, px, py) > 300) {
      vx = 0;
      vy = 0;
      currentFrame = 1;
      return;
    }//end not chasing

    //start chasing
    if (delay == 0) {
      currentFrame = (currentFrame+1)%loopFrames;
    }
    delay = (delay+1)%1;
    int newTime = millis();
    if (newTime>storedTime) {
      storedTime = newTime+600;
      //update chase direction
      if (abs(x - px) < abs(y - py)) {
        //vertical separation is bigger
        if (y < py) {
          vy = speed;
          vx = 0;
          offset = 12;
        } else {
          vy = -speed;
          vx = 0;
          offset = 8;
        }//end y moves
      } else {
        //horizontal separation is bigger
        if (x < px) {
          vx = speed;
          vy = 0;
          offset = 0;
        } else {
          vx = -speed;
          vy = 0;
          offset = 4;
        }//end x moves
      }//end direction change
    }//end time delayed direction change
    

  }//end chase
}//end class
