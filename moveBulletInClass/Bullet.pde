class Bullet {
  float x, y, w, h;
  float speed, rotation, maxSpeed, minSpeed;
  boolean firing;

  Bullet() {
    x = 100;
    y = -100;
    w = 20;
    h = 10;

    speed = 0;
    rotation = 0;
    maxSpeed = 15;
    minSpeed = 5;
    firing = false;
  }
  void setStartLocation(float startX, float startY, float startRotation) {
     if (firing == false) {
      x = startX;
      y = startY;
      rotation = startRotation;
      firing = true;
      speed = 20;
     }
  }
  void update() {
    if (firing == true) {
      //bullet speeds up
      //if (speed < maxSpeed) {
      //  speed += 2;
      //}
      //bullet slows down
      if (speed > minSpeed) {
        speed -= 0.3;
      }

      x += cos(rotation) * speed;
      y += sin(rotation) * speed;

      //check for moving out of bounds
      if (x>width||x<0||y>height||y<0) {
        reset();
      }
    }
  }
  void reset() {
    speed = 0;
    firing = false;
    y = -100;
  }
  void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    fill(0, 255, 0); 
    rect(-w/2, -h/2, w, h);
    popMatrix();
  }
}