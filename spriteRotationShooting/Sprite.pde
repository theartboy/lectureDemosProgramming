class Sprite {
  float x, y, w, h;
  int currentFrame;

  float vx, vy, rotation, speed, maxSpeed, friction;
  boolean walking;

  Sprite() {
    x = width/2;
    y = height/2;
    vx = 0;
    vy = 0;
    w = 140;
    h = 95;
    rotation = 0;
    speed = 0;
    maxSpeed = 10;
    friction = 0.9;
  }
  void update() {
    if (left && !right){
     //rotation += -1; 
     rotation += -.1; 
    }
    if (right && !left) {
      //rotation += 1;
      rotation += .1;
    }
    if (!left && !right){
      //rotation = 0;
    }
    
    if (up && !down){
     if (speed<maxSpeed){
       speed+=0.2;
     }else{
       speed=maxSpeed;
     }
    }
    if (down && !up) {
      //
    }
    if (!up && !down){
      if (speed>0){
        speed *= friction;
      }else{
        speed = 0;
      }
    }
    
    
    x += cos(rotation)*speed;
    y += sin(rotation)*speed;
    //x += cos(rotation*PI/180)*speed;
    //y += sin(rotation*PI/180)*speed;
  }
  void display() {
    fill(255,255,0,100);
    pushMatrix();
    translate(x,y);
    rotate(rotation);
    rect(0-w/2,0-h/2,w,h);
    image(spriteImage, -w/2, -h/2);
    popMatrix();
    
  }
}
