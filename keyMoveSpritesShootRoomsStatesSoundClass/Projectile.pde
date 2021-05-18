class Projectile {
  //props
  float x, y, w, h, vx, vy, startingX, startingY;
  float speed;
  boolean inMotion;
  //constructor
  Projectile(float sx, float sy) {
    startingX = sx;
    startingY = sy;
    x = sx;
    y = sy;
    w = 10;
    h = 10;
    vx = 0;
    vy = 0;
    inMotion = false;
    speed = 10;
  }
  //methods
  void update(){
    x += vx;
    y += vy;
    checkBounds();
  }//end update
  
  void display(){
    fill(255,0,255);
    rect(x,y,w,h);
  }//end display
  
  void fire(float newX, float newY, String facing){
    x = newX;
    y = newY;
    if (!inMotion){
      switch (facing){
        case "left":
        vx = -speed;
        vy = 0;
        w = 20;
        h = 10;
        break;
        case "right":
        vx = speed;
        vy = 0;
        w = 20;
        h = 10;
        break;
        case "up":
        vx = 0;
        vy = -speed;
        w = 10;
        h = 20;
        break;
        case "down":
        vx = 0;
        vy = speed;
        w = 10;
        h = 20;
        break;
      }//end switch
      inMotion = true;
    }
  }//end fire
  
  void reset(){
    x = startingX;
    y = startingY;
    vx = 0;
    vy = 0;
    w = 10;
    h = 10;
    inMotion = false;
  }//end reset
  
  void checkBounds(){
    if ( x < -w || x > width || y < -h || y > height){
     reset(); 
    }
  }
}
