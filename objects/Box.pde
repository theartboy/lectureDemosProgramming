class Box {
 //properties
 float x, y, w, h;
 float speedX, speedY;
 color c;
 
 //constructor
 Box(color cTemp) {
   x = random(200,600);
   y = random(200,400);
   w = 50;
   h = 50;
   speedX = random(3,7);
   speedY = random(3,7);
   c = cTemp;
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
  rect(x-10,y-10,20,20);
  rect(x+w-10,y-10,20,20);
}

}
