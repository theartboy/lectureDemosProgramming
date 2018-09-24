import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class objects extends PApplet {

Box b0;
Box b1;
Box b2;

public void setup() {
  
  noStroke();

  b0 = new Box(color(255,0,0));
  b1 = new Box(color(0,255,0));
  b2 = new Box(color(0,0,255));
}

public void draw() {
  clearBackground();
  b0.update();
  b0.display();
  b1.update();
  b1.display();
  b2.update();
  b2.display();
}

public void clearBackground() {
  fill(128, 150);
  rect(0, 0, width, height);
}
class Box {
 //properties
 float x, y, w, h;
 float speedX, speedY;
 int c;
 
 //constructor
 Box(int cTemp) {
   x = random(200,600);
   y = random(200,400);
   w = 50;
   h = 50;
   speedX = random(3,7);
   speedY = random(3,7);
   c = cTemp;
 }
 //methods
 public void update() {
  x += speedX;
  y += speedY;
  checkBoundaries();
}
public void checkBoundaries() {
  if (x<0 || x > width-w) {
    speedX *= -1;
  }
  if (y < 0 || y > height - h) {
    speedY *= -1;
  }
}
public void display() {
  fill(c);
  rect(x, y, w, h);
  rect(x-10,y-10,20,20);
  rect(x+w-10,y-10,20,20);
}

}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "objects" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
