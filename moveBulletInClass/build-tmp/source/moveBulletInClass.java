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

public class moveBulletInClass extends PApplet {

////fails if rect of enemy is not mostly square.
////The rotation is for visual purposes.
////The collision is tied to the unrotated rect of the box not the rotated visual

Sprite s;
Enemy e;
Bullet b;

boolean left, right, up, down, space;

public void setup() {
  
  background(255);
  
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

public void draw() {
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

public boolean rectangleIntersect(Sprite r1, Enemy r2) {
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

public boolean rectangleIntersect(Bullet r1, Enemy r2) {
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

public void keyPressed() {
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
public void keyReleased() {
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
class Bullet {
  float x, y, w, h;
  float speed, rotation, maxSpeed, minSpeed;
  boolean firing;

  Bullet() {
    x = 100;
    y = -100;
    w = 20;
    h = 10;

    speed = 0;
    rotation = 0;
    maxSpeed = 15;
    minSpeed = 5;
    firing = false;
  }
  public void setStartLocation(float startX, float startY, float startRotation) {
     if (firing == false) {
      x = startX;
      y = startY;
      rotation = startRotation;
      firing = true;
      speed = 20;
     }
  }
  public void update() {
    if (firing == true) {
      //bullet speeds up
      //if (speed < maxSpeed) {
      //  speed += 2;
      //}
      //bullet slows down
      if (speed > minSpeed) {
        speed -= 0.3f;
      }

      x += cos(rotation) * speed;
      y += sin(rotation) * speed;

      //check for moving out of bounds
      if (x>width||x<0||y>height||y<0) {
        reset();
      }
    }
  }
  public void reset() {
    speed = 0;
    firing = false;
    y = -100;
  }
  public void display() {
    pushMatrix();
    translate(x, y);
    rotate(rotation);
    fill(0, 255, 0); 
    rect(-w/2, -h/2, w, h);
    popMatrix();
  }
}
class Enemy {
  float x, y, w, h;

  //float speedX, speedY;
  float speed, rotation, maxSpeed;

  Enemy() {
    x = 400;//random(400, width-100);
    y = 100;//random(100, height-100);
    w = 64;
    h = 64;

    speed = 0;
    rotation = 0;
    maxSpeed = 3;
  }
  public void respawn(){
    x = random(400, width-100);
    y = random(100, height-100);
    speed = 0;
    rotation = 0;
  }
  public void update(Sprite s) {
    //find the distance between enemy and sprite
    float distanceApart = dist(x, y, s.x, s.y);
    if (distanceApart < 300) {
      rotation = atan2((s.y - y), (s.x - x));
      //speed = 2;
      if (speed < maxSpeed){
        speed += 0.2f;
      }
      
    } else {
      if (speed > 0){
        speed *= 0.95f;
      }
    }
    x += cos(rotation) * speed;
    y += sin(rotation) * speed;
  }
  public void display() {
    pushMatrix();
      translate(x,y);
      //draw transparent box that shows the bounds of the object
      fill(0,0,255,128); 
      rect(-w/2,-h/2,w,h);
      rotate(rotation);
      //draw visible artwork
      fill(0,255,0,128); 
      rect(-w/2,-h/2,w,h);
      fill(255,0,0);
      ellipse(w/2,0,10,10);
    popMatrix();
  }
}
class Sprite {
  float x, y, w, h;

  //float speedX, speedY;
  float speed, rotation, maxSpeed;

  Sprite() {
    x = 100;
    y = 100;
    w = 64;
    h = 32;

    //speedX = 0;
    //speedY = 0;
    speed = 0;
    rotation = 0;
    maxSpeed = 1;
  }
  public void update() {
    if (left){
      rotation -= radians(1);
    }
    if (right){
      rotation += radians(1);
    }
    if (up){
      speed = 5;
      // if (speed < maxSpeed){
      //   speed += 1;
      // }
    }
    if (down){
      speed = -5;
    }
    if (!up && !down){
      //speedY = 0;
      if (speed > 0 || speed < 0){
        speed *= 0.98f; 
      }
    }else if (up && down){
       //speedY = 0; 
    }
    
    x += cos(rotation) * speed;
    y += sin(rotation) * speed;
    
    //asteroids sytyle screen wrap
    if (x > width){x = 0;}
    if (x < 0){ x = width;}
    if (y > height){y = 0;}
    if (y < 0){y = height;}
  }
  public void display() {
    pushMatrix();
      translate(x,y);
      //draw transparent box that shows the bounds of the object
      fill(0,0,255,100);
      rect(-w/2,-h/2,w,h);
      rotate(rotation);
      //draw visible artwork
      fill(0,0,255); 
      rect(-w/2,-h/2,w,h);
      fill(255,0,0);
      ellipse(w/2,0,10,10);
    popMatrix();
  }
}
  public void settings() {  size(800, 600);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "moveBulletInClass" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
