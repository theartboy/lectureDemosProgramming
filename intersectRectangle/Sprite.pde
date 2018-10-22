class Sprite {
  float x, y, w, h;

  Sprite() {
    x = width/2;
    y = height/2;
    w = 20;
    h = 100;
  }
  void update() {
    x = mouseX;
    y = mouseY;
  }
  void display() {
    fill(255, 0, 0, 128);
    rect(x, y, w, h);
    ellipse(x+w/2,y+h/2,2,2);
  }
}
