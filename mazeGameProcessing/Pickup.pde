class Pickup {
  int x, y, w, h, sx, sy;
  int currentFrame, offsetX, offsetY, totalFrames, row;

  int delay, hold;
  int scoreValue;

  Pickup(int pickupType, int locX, int locY) {
    x=locX;
    y= locY;
    w = 32;
    h = 32;

    if (pickupType == 0) {
      row = 0;
      scoreValue = 5;
    } else {
      row = 1; 
      scoreValue = 20;
    }
    sx=0;
    sy=row * h;
    //0 = coin
    //1 = gem
    totalFrames=8;
    currentFrame= floor(random(totalFrames));

    delay = 4;
    hold = 0;
  }

  void update() {
  }

  void display() {
    copy( objects, 
      sx, sy, w, h, 
      x, y, w, h);

    sx = currentFrame * w;

    hold = (hold + 1)%delay;
    if (hold == 0) {
      currentFrame++;    
      if (currentFrame == totalFrames) {
        currentFrame=0;
      }
    }
  }
  
  void hide(){
   y = 0; 
  }
}
