class Drop {
  //properties
  float x;
  float y;
  float r;
  float speedY;
  color c;
  
  int frames;
  int currentFrame;

  //constructor
  Drop() {
    r = 8;
    x = random(width);
    y = 0;
    speedY = random(1,5);
    c = color(50, 100, random(100,255));
    frames = 12;
    currentFrame = 0;
    
  }
  
  //methods
  void update() {
    //update position
    y += speedY;
    //check bounds
    if (y > height + r) {
      y = -r;
    }
    currentFrame++;
    if (currentFrame == frames) {
      currentFrame = 0;
    }
  }

  void display() {
    noStroke();
    fill(c);
    image(unicornImages[currentFrame],x-16,y-16);
  }

  void caught() {
    speedY = 0;
    y = -r * 4;
  }

  void reset() {
    x = random(width);
    y = -r * 4;
    speedY = random(1,5);
  }
  
  
  
  
  
  
  
  
  
}
