////fails if rect of enemy is not mostly square.
////The rotation is for visual purposes.
////The collision is tied to the unrotated rect of the box not the rotated visual

Sprite s;
Enemy e;
Bullet b;

boolean left, right, up, down, space;

void setup() {
  size(800, 600);
  background(255);
  smooth();
  s = new Sprite();
  e = new Enemy();
  b = new Bullet();

  left = false;
  right = false;
  up = false;
  down = false;
  space = false;
  //frameRate(10);
}

void draw() {
  background(255);
  s.update();
  s.display();
  e.update(s);
  e.display();
  if (rectangleIntersect(s, e)) {
    fill(255, 0, 0, 100);
    rect(0, 0, width, height);
  }//end rect intersect
  if (space) {
    b.setStartLocation(s.x, s.y, s.rotation);
  }//end space
  b.update();
  b.display();

  if (rectangleIntersect(b, e)) {
    //kill the enemy
    fill(255, 255, 0, 100);
    rect(0, 0, width, height);
    // e.respawn();
    // b.reset();
  }
}// end draw

boolean rectangleIntersect(Sprite r1, Enemy r2) {
  //what is the distance apart on x-axis
  float distanceX = (r1.x) - (r2.x);
  //what is the distance apart on y-axis
  float distanceY = (r1.y) - (r2.y);


  //what is the combined half-widths
  float combinedHalfW = r1.w/2 + r2.w/2;
  //what is the combined half-heights
  float combinedHalfH = r1.h/2 + r2.h/2;

  //check for intersection on x-axis
  if (abs(distanceX) < combinedHalfW) {
    //check for intersection on y-axis
    if (abs(distanceY) < combinedHalfH) {
      //huzzah they are intersecting
      return true;
    }
  }
  return false;
}

boolean rectangleIntersect(Bullet r1, Enemy r2) {
  //what is the distance apart on x-axis
  float distanceX = (r1.x) - (r2.x);
  //what is the distance apart on y-axis
  float distanceY = (r1.y) - (r2.y);

  //what is the combined half-widths
  float combinedHalfW = r1.w/2 + r2.w/2;
  //what is the combined half-heights
  float combinedHalfH = r1.h/2 + r2.h/2;

  //check for intersection on x-axis
  if (abs(distanceX) < combinedHalfW) {
    //check for intersection on y-axis
    if (abs(distanceY) < combinedHalfH) {
      //huzzah they are intersecting
      return true;
    }
  }
  return false;
}

void keyPressed() {
  switch (keyCode) {
  case 37:
    left = true;
    break;
  case 38:
    up = true;
    break;
  case 39:
    right = true;
    break;
  case 40:
    down = true;
    break;
  case 32:
    space = true;
    break;
  }
}
void keyReleased() {
  switch (keyCode) {
  case 37:
    left = false;
    break;
  case 38:
    up = false;
    break;
  case 39:
    right = false;
    break;
  case 40:
    down = false;
    break;
  case 32:
    space = false;
    break;
  }
}
