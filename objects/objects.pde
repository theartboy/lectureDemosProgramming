Box b0;
Box b1;
Box b2;

void setup() {
  size(800, 600);
  noStroke();
  
  b0 = new Box(color(255,0,0));
  b1 = new Box(color(0,255,0));
  b2 = new Box(color(0,0,255));
}

void draw() {
  clearBackground();
  b0.update();
  b0.display();
  b1.update();
  b1.display();
  b2.update();
  b2.display();
}

void clearBackground() {
  fill(128, 150);
  rect(0, 0, width, height);
}
