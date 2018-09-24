Snake2 s;

void setup() {
  size(800, 600);
  
  s = new Snake2();
}

void draw() {
  background(255);
  s.update();
  s.display();
}
