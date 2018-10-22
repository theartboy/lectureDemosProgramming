
Sprite s;
Enemy e;
void setup() {

  size(800, 600);
  s = new Sprite();
  e = new Enemy();
}
void draw(){
  background(255);
 s.update();
 s.display();
 e.display();
 
 if (rectangleIntersect(s,e)){
  fill(255,255,0,128);
  rect(0,0,width,height);
 }
}
boolean rectangleIntersect(Sprite r1, Enemy r2) {
  //what is the distance apart on x-axis
  float distanceX = (r1.x + r1.w/2) - (r2.x + r2.w/2);
  //what is the distance apart on y-axis
  float distanceY = (r1.y + r1.h/2) - (r2.y + r2.h/2);

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
