Catcher catcher;
Drop [] drops;
int numDrops;

Timer timer;
int timeInterval;
int activeDrops;

int score;
String s;

void setup() {
  size(800, 600);
  catcher = new Catcher(16);

  numDrops = 500;
  drops = new Drop [numDrops];
  for (int i = 0; i < numDrops; i++) {
    drops[i] = new Drop();
  }
  activeDrops = 0;
  timeInterval = 100;
  
  timer = new Timer(timeInterval);
  timer.start();
  
  score = 0;
  s = "";
}

void draw() {
  noStroke();
  clearBackground();
  catcher.update();
  catcher.display();
  //timer stuff
  if (timer.complete()==true) {
    if (activeDrops < numDrops ) {
     activeDrops++; 
    }
    timer.start();
  }
  
  //update stuff
  for (int i = 0; i < activeDrops; i++) {
    drops[i].update();
    drops[i].display();
    //check collisions
    if (intersect(catcher, drops[i]) == true ) {
      drops[i].caught();
      score++;
    }
  }
  
  //update UI
  textSize(12);
  textAlign(LEFT);
  fill(255, 0, 0);
  s = "Score: " + score;
  text(s, 10, 20);
}

void clearBackground() {
  //background(255);
  fill(255, 120);
  rect(0, 0, width, height);
}

boolean intersect(Catcher a, Drop b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  if (distance < a.r+b.r) {
    return true;
  } else {
    return false;
  }
}
