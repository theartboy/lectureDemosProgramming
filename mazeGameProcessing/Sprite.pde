class Sprite {
  int x, y, w, h, sx, sy;
  int currentFrame, offsetX, offsetY, totalFrames, row;
  float vx, vy;

  int delay, hold;

  String [] actions;
  
  Sprite(int character) {
    x=width/2;
    y=300;
    w = 32;
    h = 32;
    sx=0;
    sy=0;
    row=0;
    //characters SKIN, BOY, GIRL, BONE
    offsetX=character*32;
    offsetY=0*32;
    totalFrames=3;
    currentFrame=0;

    delay = 4;
    hold = 0;
    
    actions = new String [3];
    actions[0] = "Punch";
    actions[1] = "Kick";
    actions[2] = "Wink";
  }

  void update() {
    if (left&&!right&&!up&&!down) {
      vx = -2;
      row = 1;
    }

    if (right&&!left&&!up&&!down) {
      vx = 2;
      row = 2;
    }
    
    if (!left&&!right){
      vx = 0;
    }

    if (!left&&!right&&!up&&!down) {
      vx = 0;
      vy = 0;
      //row = 0;
      currentFrame = 1;
    }

    if (up&&!down&&!left&&!right) {
      vy = -2;
      row = 3;
    }

    if (down&&!up&&!left&&!right) {
      vy = 2;
      row = 0;
    }
    
    if (!up&&!down){
      vy = 0;
    }


    x += vx;
    y += vy;

    sx = currentFrame * w;
    sy = row * h;
    
    if (vx==0 && vy==0){
      if (sfxWalk.isPlaying()==true){
       sfxWalk.pause(); 
      }
    } else if (sfxWalk.isPlaying() == false){
      sfxWalk.loop();
    }
  }
  
  void display() {
    copy(sheet, sx + offsetX, sy + offsetY, w, h, x, y, w, h);

    hold = (hold + 1)%delay;
    if (hold == 0) {
      currentFrame++;    
      if (currentFrame == totalFrames){
        currentFrame=0;
      }
    }
    
  }
}
