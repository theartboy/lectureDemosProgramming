class Bomb {
  //properties
  float x;
  float y;
  float r;
  float speedY;
  color c;

  //constructor
  Bomb() {
    r = 32;
    //x = random(width);
    //y = -r*4;
    //speedY = random(10,15);
    reset();
    c = color(0);
  }
  
  //methods
  void update() {
    //update position
    x += random(-2,2);
    y += speedY;
    //check bounds
    if (y > height + r) {
      y = -r;
      x = random(width);
    }
  }

  void display() {
    noStroke();
    fill(c);
    ellipse(x,y,r*2,r*2);
    fill(255,0,0);
    ellipse(x-10, y-15, 10,10);
    ellipse(x+10, y-15, 10,10);
    fill(255,255,0);
    rect(x-15,y+10, 30, 10);
  }

  void caught() {
    speedY = 0;
    y = -r * 4;
  }

  void reset() {
    x = random(width);
    y = -r * 4;
    speedY = random(10,15);
  }
  
  
  
  
  
  
  
  
  
}
