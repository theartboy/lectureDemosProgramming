float x, y, w, h, speedX, speedY;

void setup() {
  size(800, 600);
  x = 400;
  y = 300;
  w = 50;
  h = 50;
  speedX = 5;
  speedY = 5;
  noStroke();
}

void draw() {
  clearBackground();
  updatePosition();
  displayBox();
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
void checkBoundaries() {
  if (x<0 || x > width-w) {
    speedX *= -1;
  }
  if (y < 0 || y > height - h) {
    speedY *= -1;
  }
}
void displayBox() {
  fill(255, 0, 0);
  rect(x, y, w, h);
  rect(x-10,y-10,20,20);
  rect(x+w-10,y-10,20,20);
}
