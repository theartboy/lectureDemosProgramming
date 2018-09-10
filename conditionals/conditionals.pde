//John McCaffrey
//conditionals
//9-10-18

//global vars
float x;
float y;
float w;
float h;

float speedX;
float speedY;

void setup() {
  size(800, 600);

  x = 200;
  y = 200;
  w = 100;
  h = 100;

  speedX = 1;
  speedY = 1;
}

void draw() {
  background(128);
  fill(random(255), random(255), random(255));

  rect(x, y, w, h);
  
  fill(255);
  ellipse(x+50,y+50,20,20);

  x = x + speedX;
  //x += speedX;
  
  y = y + speedY;

  //check horizontal boundaries
  if (x > width - w) {
    speedX = speedX * -1;
    fill(random(255), random(255), random(255));
  } else if (x < 0) {
    speedX = speedX * -1;
    fill(random(255), random(255), 0);
  }
  
  //check vertical boundaries
  if (y > height - h) {
    speedY *= -1;
    //speedY = speedY * -1;
  }else if (y < 0) {
    speedY *= -1;
  }
}
