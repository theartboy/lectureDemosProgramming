class Enemy {
  float x, y, w, h;

  Enemy() {
    x = width/2;
    y = height/2;
    w = 100;
    h = 20;
  }
  void update() {
  }
  void display() {
    fill(0, 0, 255, 128);
    rect(x, y, w, h);
    fill(0);
    ellipse(x+w/2,y+h/2,2,2);
  }
}
