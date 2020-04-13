class Bullet {
  float w, h, x, y;
  float halfWidth, halfHeight;
  float vx, vy, rotation, speed;
  boolean inMotion;

  float leftBound, rightBound, lowerBound, upperBound;

  Bullet() {
    w = 35;
    h = 10;
    x = 0;
    y = -h;
    halfWidth = w/2;
    halfHeight = h/2;
    vx = 0;
    vy = 0;
    rotation = 0;
    speed = 0;
    inMotion = false;

    leftBound = 0;
    rightBound = 0;
    lowerBound = 0;
    upperBound = 0;
  }
  void fire(float startX, float startY, float startRotation) {
    if (!inMotion) {
      x = startX;
      y = startY;
      rotation = startRotation;
      speed = 12;//needs to be a factor faster than the sprite object
      vx = cos(rotation)*speed;
      vx = sin(rotation)*speed;
      inMotion = true;
    }
  }
  void reset() {
    x = 0;
    y = -h;
    vx = 0;
    vy = 0;
    inMotion = false;
  }
  void update() {
    if (inMotion) {
    x += cos(rotation)*speed;
    y += sin(rotation)*speed;
    }
    ////check boundaries
    rightBound = width;
    leftBound = 0;
    upperBound = 0;
    lowerBound = height;
    if (x < leftBound || x > rightBound || y < upperBound || y > lowerBound) {
      reset();
    }
  }
  void display() {
    fill(255, 0, 0);
    pushMatrix();
    translate(x,y);
    rotate(rotation);
    rect(0, 0, w, h);
    popMatrix();
  }
}
