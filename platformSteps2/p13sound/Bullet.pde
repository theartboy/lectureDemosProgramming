class Bullet {
  float w,h,x,y;
  float halfWidth,halfHeight;
  float vx,vy;
  boolean inMotion;
  
  float leftBound, rightBound, lowerBound, upperBound;
  
  Bullet(){
    w = 35;
    h = 10;
    x = 0;
    y = -h;
    halfWidth = w/2;
    halfHeight = h/2;
    vx = 0;
    vy = 0;
    inMotion = false;

    leftBound = 0;
    rightBound = 0;
    lowerBound = 0;
    upperBound = 0;
  }
  void fire(float ux, float uy, float uw, boolean ufacingRight){
    if (!inMotion){
      y = uy - 3;
      inMotion = true;
      if (ufacingRight == true){
        vx = 15;
        x = ux + uw - 35;//shift starting point for laser to right side of unicorn
      }else{
        vx = -15;
        x = ux;
      }
    }
  }
  void reset(){
    x = 0;
    y = -h;
    vx = 0;
    vy = 0;
    inMotion = false;
  }
  void update(){
    if (inMotion){
      x += vx;
      y += vy;
    }
    ////check boundaries
    rightBound = Math.max(camera.w, u.x + u.halfWidth + camera.w/2);
    leftBound = camera.x;
    upperBound = camera.y;
    lowerBound = Math.max(camera.h, u.y + u.halfHeight + camera.h/2);
    if (x < leftBound || x > rightBound || y < upperBound || y > lowerBound){
      reset();
    }
  }
  void display(){
     fill(255,0,0);
     rect(x,y,w,h);
  }
}
