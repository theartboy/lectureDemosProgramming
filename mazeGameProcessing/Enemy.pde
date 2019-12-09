class Enemy {
  int x, y, w, h, sx, sy;
  int currentFrame, offsetX, offsetY, totalFrames, row;
  float vx, vy;

  int delay, hold;
  boolean collider;
  boolean moveLeft, moveRight, moveUp, moveDown;
  int speed =1;

  String [] actions;
  boolean dead;

  int type;

  Enemy(int character, int startX, int startY, boolean wall) {
    x=startX;
    y=startY;
    w = 32;
    h = 32;
    sx=0;
    sy=0;
    row=0;
    //characters SLIME, BAT, GHOST, SPIDER
    type = character/3;
    offsetX=character*32;
    offsetY=4*32;
    totalFrames=3;
    currentFrame=0;

    delay = 4;
    hold = 0;

    collider = wall;

    moveLeft = false;
    moveUp = false;
    moveRight = false;
    moveDown = false;

    //actions[0] = "Rock";
    //actions[1] = "Paper";
    //actions[2] = "Scissors";
    dead = false;

    actions = new String [3];

    switch (character) {
    case SLIME:
      actions[0] = "Acid Dissolve";
      actions[1] = "Suffocate";
      actions[2] = "Melt";
      break;

    case BAT:
      actions[0] = "Bite";
      actions[1] = "Wing Buffet";
      actions[2] = "Screech";
      break;

    case GHOST:
      actions[0] = "Scare";
      actions[1] = "Haunt";
      actions[2] = "Possess";
      break;

    case SPIDER:
      actions[0] = "Venom Bite";
      actions[1] = "Web Wrap";
      actions[2] = "Leg Crush";
      break;
    }
  }
  void hide() {
    x = 0;
    y = 0;
    dead = true;
  }
  void update() {
    if (dist(s.x, s.y, x, y) < 200 && !dead) {
      if (abs(s.x - x) < abs(s.y - y)) {
        //close y gap
        if (y < s.y) {
          moveUp = false;
          moveDown = true;
          println("down");
        } else {
          moveUp = true;
          moveDown = false;
          println("up");
        }
      } else {
        //close x gap
        if (x < s.x) {
          moveLeft = false;
          moveRight = true;
          println("right");
        } else {
          moveLeft = true;
          moveRight = false;
          println("left");
        }
      }
    } else {
      //not close so stop moving
      moveLeft = false;
      moveUp = false;
      moveRight = false;
      moveDown = false;
    }

    if (moveLeft&&!moveRight) {
      vx = -1;
      row = 1;
    }
    if (moveRight&&!moveLeft) {
      vx = 1;
      row = 2;
    }
    if (!moveLeft&&!moveRight&&!moveUp&&!moveDown) {
      vx = 0;
      vy = 0;
      //row = 0;
      currentFrame = 1;
    }
    if (moveUp&&!moveDown) {
      vy = -1;
      row = 3;
    }
    if (moveDown&&!moveUp) {
      vy = 1;
      row = 0;
    }


    x += vx;
    y += vy;

    sx = currentFrame * w;
    sy = row * h;

    //audio stuff
    if (vx==0 && vy==0) {
      if (enemySounds[type].isPlaying()==true) {
        enemySounds[type].pause();
      }
    } else if (enemySounds[type].isPlaying() == false) {
      enemySounds[type].loop();
    }
  }

  void display() {
    copy(sheet, sx + offsetX, sy + offsetY, w, h, x, y, w, h);

    hold = (hold + 1)%delay;
    if (hold == 0) {
      currentFrame++;    
      if (currentFrame == totalFrames) {
        currentFrame=0;
      }
    }
  }
}
