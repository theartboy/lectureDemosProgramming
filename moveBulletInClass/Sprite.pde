class Sprite {
  float x, y, w, h;

  //float speedX, speedY;
  float speed, rotation, maxSpeed;

  Sprite() {
    x = 100;
    y = 100;
    w = 64;
    h = 32;

    //speedX = 0;
    //speedY = 0;
    speed = 0;
    rotation = 0;
    maxSpeed = 1;
  }
  void update() {
    if (left){
      rotation -= radians(1);
    }
    if (right){
      rotation += radians(1);
    }
    if (up){
      speed = 5;
      // if (speed < maxSpeed){
      //   speed += 1;
      // }
    }
    if (down){
      speed = -5;
    }
    if (!up && !down){
      //speedY = 0;
      if (speed > 0 || speed < 0){
        speed *= 0.98; 
      }
    }else if (up && down){
       //speedY = 0; 
    }
    
    x += cos(rotation) * speed;
    y += sin(rotation) * speed;
    
    //asteroids sytyle screen wrap
    if (x > width){x = 0;}
    if (x < 0){ x = width;}
    if (y > height){y = 0;}
    if (y < 0){y = height;}
  }
  void display() {
    pushMatrix();
      translate(x,y);
      //draw transparent box that shows the bounds of the object
      fill(0,0,255,100);
      rect(-w/2,-h/2,w,h);
      rotate(rotation);
      //draw visible artwork
      fill(0,0,255); 
      rect(-w/2,-h/2,w,h);
      fill(255,0,0);
      ellipse(w/2,0,10,10);
    popMatrix();
  }
}