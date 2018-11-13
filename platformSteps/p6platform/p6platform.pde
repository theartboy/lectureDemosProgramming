//platform
//TODO: images, platforms, shooting, enemies

Unicorn u;
Platform p;

boolean left, right, up, down, space;

void setup() {
  size(800, 600);

  left = false;
  right = false;
  up = false;
  down = false;
  space = false;


  //unicorn values
  u = new Unicorn();
  //platform values
  p = new Platform(300, 460, 200, 25, "safe");
}

void draw() {
  background(255);
  u.update();
  u.collisionSide = rectangleCollisions(u, p);
  u.display();
  p.display();
  
  displayPositionData();
}

String rectangleCollisions(Unicorn r1, Platform r2) {
  ////r1 is the player
  ////r2 is the platform rectangle
  ////function returns the String collisionSide

  //allow unicorn to pass through platforms.
  //Disable if you want unicorn to bounce off bottom of platforms

  if (r1.vy < 0) { return "none"; }

  float dx = (r1.x+r1.w/2) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/2) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    ////now check on the y axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      //determine the overlap on each axis
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      ////the collision is on the axis with the
      ////SMALLEST overlap
      if (overlapX >= overlapY) {
        if (dy > 0) {
          ////move the rectangle back to eliminate overlap
          ////before calling its display to prevent
          ////drawing object inside each other
          r1.y += overlapY;
          return "top";
        } else {
          r1.y -= overlapY;
          return "bottom";
        }
      } else {
        if (dx > 0) {
          r1.x += overlapX;
          return "left";
        } else {
          r1.x -= overlapX;
          return "right";
        }
      }
    } else {
      //collision failed on the y axis
      return "none";
    }
  } else {
    //collision failed on the x axis
    return "none";
  }
}

void displayPositionData() {
  fill(0);
  float dx = (u.x+u.w/2) - (p.x+p.w/2);
  float dy = (u.y+u.h/2) - (p.y+p.h/2);

  float combinedHalfWidths = u.halfWidth + p.halfWidth;
  float combinedHalfHeights = u.halfHeight + p.halfHeight;
  String s = "dx:"+dx+"   dy:"+dy+"\n"+
    "chw:"+combinedHalfWidths+"   chh:"+combinedHalfHeights+
    "\nvx: "+u.vx+"  vy: "+u.vy + 
    "\ncollisionSide: "+u.collisionSide;
  text(s, 50, 50);
}

void keyPressed() {
  switch (keyCode) {
  case 37://left
    left = true;
    break;
  case 39://right
    right = true;
    break;
  case 38://up
    up = true;
    break;
  case 40://down
    down = true;
    break;
  case 32: //space
    space = true;
    break;
  }
}
void keyReleased() {
  switch (keyCode) {
  case 37://left
    left = false;
    break;
  case 39://right
    right = false;
    break;
  case 38://up
    up = false;
    break;
  case 40://down
    down = false;
    break;
  case 32: //space
    space = false;
    break;
  }
}
