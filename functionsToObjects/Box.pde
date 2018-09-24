class Box {
  //properties
  float x, y, w, h, speedX, speedY;
  color c;
  
  //constructor
  Box(color newColor) {
    x = random(200, width-200);
    y = random(200, height-200);
    w = 50;
    h = 50;
    speedX = random(2,7);
    speedY = random(2,7);
    c = newColor;
  }
  //methods
  void update() {
    x += speedX;
    y += speedY;
    checkBoundaries();
  }
  void checkBoundaries() {
    if (x<0 || x > width-w) {
      speedX *= -1;
    }
    if (y < 0 || y > height - h) {
      speedY *= -1;
    }
  }
  void display() {
    fill(c);
    rect(x, y, w, h);
    rect(x-10, y-10, 20, 20);
    rect(x+w-10, y-10, 20, 20);
  }
}
