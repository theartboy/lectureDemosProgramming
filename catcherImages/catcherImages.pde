//John McCaffrey
//GameState framework
//TODO:
//add animated images
//rectangle hit detection


//COMPLETED:
//add static images

String gameState;
int wins;
int losses;

Timer countDownTimer;
int timeLeft;
int maxTime;

//variables from catcher game
Catcher catcher;
Drop [] drops;
int numDrops;

Timer timer;
int timeInterval;
int activeDrops;

int score;
String s;

//bomb
Bomb b;

//images
PImage backgroundImage;
PImage ship;
PImage[] unicornImages;

void setup() {
  size(800, 600);
  
  //images
  backgroundImage = loadImage("background.png");
  ship = loadImage("ship.png");
  unicornImages = new PImage[12];
  for (int i = 0; i < 12; i++) {
   unicornImages[i] = loadImage("unicorn/uni" + nf(i+1, 4) + ".png");
  }
  
  
  //bomb
  b = new Bomb();
  
  //catcher game vars init
  catcher = new Catcher(16);

  numDrops = 500;
  drops = new Drop [numDrops];
  for (int i = 0; i < numDrops; i++) {
    drops[i] = new Drop();
  }
  activeDrops = 0;
  timeInterval = 500;

  timer = new Timer(timeInterval);
  timer.start();

  score = 0;
  s = "";

  //game state vars init
  gameState = "START";
  wins = 0;
  losses = 0;

  countDownTimer = new Timer(1000);
  maxTime = 5;
  timeLeft = maxTime;
}

void draw() {
  clearBackground();
  if (gameState == "START") {
    startGame();
  } else if (gameState == "PLAY") {
    playGame();
  } else if (gameState == "WIN") {
    winGame();
  } else if (gameState == "LOSE") {
    loseGame();
  }
}

void startGame() {
  textAlign(CENTER);
  textSize(18);
  fill(255, 0, 0);
  text("Click Anywhere to Play!", width/2, height/2);
  textSize(14);
  fill(0, 0, 255);
  text("Catch the drops\nbefore time runs out", width/2, height/2+30);
  //look for the click
  if (mousePressed == true) {
    gameState = "PLAY";
    countDownTimer.start();
  }
  showScore();
}
void playGame() {
  //catcher game logic
  noStroke();
  //clearBackground();
  image(backgroundImage, 0, 0);
  catcher.update();
  catcher.display();
  //timer stuff
  if (timer.complete()==true) {
    if (activeDrops < numDrops ) {
      activeDrops++;
    }
    timer.start();
  }

  //bomb stuff
  b.update();
  b.display();
  if (intersect(catcher, b) == true) {
     gameState = "LOSE"; 
  }

  //update stuff
  for (int i = 0; i < activeDrops; i++) {
    drops[i].update();
    drops[i].display();
    //check collisions
    if (intersect(catcher, drops[i]) == true ) {
      drops[i].caught();
      score++;
      if (score >= 5) {
        //win 
        wins++;
        gameState = "WIN";
      }
    }
  }
  //countDown logic
  if (countDownTimer.complete() == true) {
    if (timeLeft > 1 ) {
      timeLeft--;
      countDownTimer.start();
    } else {
      //lose
      losses++;
      gameState = "LOSE";
    }
  }
  //update UI
  textAlign(LEFT);
  textSize(12);
  fill(255, 0, 0);
  
  //show countDown
  s = "Time Left: " + timeLeft;
  text(s, 20, 20);

  //show score
  s = "Score: " + score;
  text(s, 20, 40);
}

void winGame() {
  textAlign(CENTER);
  textSize(18);
  fill(255, 0, 0);
  text("Great Job! That was so difficult.\nYou should be proud", width/2, height/2);
  textSize(14);
  fill(0, 0, 255);
  text("Play Again?", width/2, height/2+50);

  drawReplayButton();
  showScore();
}
void loseGame() {
  textAlign(CENTER);
  textSize(18);
  fill(255, 0, 0);
  text("You Lost! That takes talent.", width/2, height/2);
  textSize(14);
  fill(0, 0, 255);
  text("Again?", width/2, height/2+50);

  drawReplayButton();
  showScore();
}

void resetGame() {
  timeLeft = maxTime;
  countDownTimer.start();
  score = 0;
  for (int i = 0; i < numDrops; i++) {
   drops[i].reset(); 
  }
  activeDrops = 0;
  timer.start();
  b.reset();
}

void showScore() {
  //set the text for w/l
  textAlign(LEFT);
  textSize(14);
  fill(0);
  String s = "Wins: " + wins + "\n" + "Losses: " + losses;
  text(s, 20, 50);
}
void drawReplayButton() {
  //draw button
  fill(100);
  rect(width/2-50, height/2+80, 100, 60);
  fill(0, 255, 0);
  textSize(36);
  text("PLAY", width/2, height/2+122);
  //edges of the button
  float leftEdge = width/2-50;
  float rightEdge = width/2 + 50;
  float topEdge = height/2 + 80;
  float bottomEdge = height/2 + 140;
  //look for the click
  if (mousePressed == true && 
    mouseX > leftEdge &&
    mouseX < rightEdge &&
    mouseY > topEdge &&
    mouseY < bottomEdge
    ) {
    resetGame();
    gameState = "PLAY";
  }
}

boolean intersect(Catcher a, Drop b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  if (distance < a.r+b.r) {
    return true;
  } else {
    return false;
  }
}
boolean intersect(Catcher a, Bomb b) {
  float distance = dist(a.x, a.y, b.x, b.y);
  if (distance < a.r+b.r) {
    return true;
  } else {
    return false;
  }
}

void clearBackground() {
  fill(255, 120);
  rect(0, 0, width, height);
}
