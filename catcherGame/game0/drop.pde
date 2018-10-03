class Drop {
  float x;
  float y;
  float r;
  float speedY;
  color c;

  Drop() {
    r = 8;
    x = random(width);
    y = 0;
    speedY = random(1,5);
    c = color(50, 100, random(100,255));
  }

  void update() {
    //update position
    y += speedY;
    //check bounds
    if (y > height + r) {
      y = -r;
    }
  }

  void display() {
    noStroke();
    fill(c);
    ellipse(x,y,r*2,r*2);
  }

  void caught() {
    speedY = 0;
    y = -r * 4;
  }

  void reset() {
  }
}
