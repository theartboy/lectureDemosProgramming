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
  void respawn(){
    x = random(400, width-100);
    y = random(100, height-100);
    speed = 0;
    rotation = 0;
  }
  void update(Sprite s) {
    //find the distance between enemy and sprite
    float distanceApart = dist(x, y, s.x, s.y);
    if (distanceApart < 300) {
      rotation = atan2((s.y - y), (s.x - x));
      //speed = 2;
      if (speed < maxSpeed){
        speed += 0.2;
      }
      
    } else {
      if (speed > 0){
        speed *= 0.95;
      }
    }
    x += cos(rotation) * speed;
    y += sin(rotation) * speed;
  }
  void display() {
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