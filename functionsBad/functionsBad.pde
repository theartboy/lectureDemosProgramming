float x, y, w, h, speedX, speedY;
float x2, y2, w2, h2, speedX2, speedY2;
float x3, y3, w3, h3, speedX3, speedY3;

void setup() {
  size(800, 600);
  x = 400;
  y = 300;
  w = 50;
  h = 50;
  speedX = 5;
  speedY = 5;
  x2 = 200;
  y2 = 300;
  w2 = 50;
  h2 = 50;
  speedX2 = 5;
  speedY2 = 5;
  x3 = 600;
  y3 = 300;
  w3 = 50;
  h3 = 50;
  speedX3 = 5;
  speedY3 = 5;
  noStroke();
}

void draw() {
  clearBackground();
  updatePosition();
  displayBox();
  updatePosition2();
  displayBox2();
  updatePosition3();
  displayBox3();
}

void clearBackground() {
  fill(128, 150);
  rect(0, 0, width, height);
}

void updatePosition() {
  x += speedX;
  y += speedY;
  checkBoundaries();
}
void updatePosition2() {
  x2 += speedX2;
  y2 += speedY2;
  checkBoundaries2();
}
void updatePosition3() {
  x3 += speedX3;
  y3 += speedY3;
  checkBoundaries3();
}
void checkBoundaries() {
  if (x<0 || x > width-w) {
    speedX *= -1;
  }
  if (y < 0 || y > height - h) {
    speedY *= -1;
  }
}
void checkBoundaries2() {
  if (x2<0 || x2 > width-w2) {
    speedX2 *= -1;
  }
  if (y2 < 0 || y2 > height - h2) {
    speedY2 *= -1;
  }
}
void checkBoundaries3() {
  if (x3<0 || x3 > width-w3) {
    speedX3 *= -1;
  }
  if (y3 < 0 || y3 > height - h3) {
    speedY3 *= -1;
  }
}
void displayBox() {
  fill(255, 0, 0);
  rect(x, y, w, h);
  rect(x-10,y-10,20,20);
  rect(x+w-10,y-10,20,20);
}
void displayBox2() {
  fill(0,255,0);
  rect(x2, y2, w2, h2);
  rect(x2-10,y2-10,20,20);
  rect(x2+w2-10,y2-10,20,20);
}
void displayBox3() {
  fill(0,0,255);
  rect(x3, y3, w3, h3);
  rect(x3-10,y3-10,20,20);
  rect(x3+w3-10,y3-10,20,20);
}
