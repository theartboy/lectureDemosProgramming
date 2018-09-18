float x, x2;

void setup() {
  size(800, 600);
  x = 10;
  x2 = 10;
}
void draw() {
  //rect(10, 100, 50, 50);
  //rect(70, 100, 50, 50);
  while (x < width) {
    //draw another box
    rect(x, 100, 50, 50);
    x += 60;
  }
  //i = i + 1;
  //i += 1;
  //i++;
  for (int i = 0; i < 5; i++) {
    fill(255, 0, 0);
    rect(x2 + i*60, 200 + i*20, 50, 50);
    //x2 += 60;
  }
  //x2 = 10;
}
