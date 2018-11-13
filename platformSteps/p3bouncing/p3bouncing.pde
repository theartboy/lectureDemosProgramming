//bounce

Unicorn u;

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
}

void draw() {
  background(255);
  u.update();
  u.display();
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
