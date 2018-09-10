//John McCaffrey
//variables
//9-10-18

//global
int x = 100;
int y = 100;
float w = 100;
float h = 100;

void setup() {
  size(800, 600);
}

void draw() {
  background(200,200,100);
  //local
  //int x = 200;
  //int y = 200;
  //float w = 50;
  //float h = 50;
  fill(255,0,0);
  rect(x, y, w, h);
  x = x + 1;
}
