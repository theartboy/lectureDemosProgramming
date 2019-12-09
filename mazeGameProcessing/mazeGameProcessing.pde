int [][] tileMap = {	
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1}, 
  {1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1}, 
  {1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1}, 
  {1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1}, 
  {1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}, 
  {1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1}, 
  {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
};
////1 is wall
////0 is floor
int rows, cols;
int cellWidth, cellHeight;

boolean left, right, up, down;
Sprite s;
PImage art;
PImage sheet;
PImage objects;
PImage combatArt;

Pickup [] pickups;
int score;

String gameState;

final int SKIN = 0;
final int BOY = 3;
final int GIRL = 6;
final int BONE = 9;

final int SLIME = 0;
final int BAT = 3;
final int GHOST = 6;
final int SPIDER = 9;

Enemy [] enemies;

PVector goal;

Timer gameTimer;
int maxTime, currentTime;
boolean timerStartCounting;

PFont eightBitFont;
Enemy currentEnemy;

import processing.sound.*;
SoundFile music;
SoundFile sfxPunch;
SoundFile sfxKick;
SoundFile sfxStare;
SoundFile sfxWalk;

SoundFile [] enemySounds;

void setup() {
  size(640, 640);
  background(0);
  smooth();
  noStroke();
  rows=20;
  cols=20;
  cellWidth=32;
  cellHeight=32;
  s=new Sprite(BONE);
  //art = loadImage("mazeart.png");
  sheet = loadImage("data/images/characters2x.png");
  objects = loadImage("data/images/pickups.png");
  combatArt = loadImage("data/images/combat.png");

  gameState = "START";

  //pickupType values
  //0 = coin
  //1 = gem
  pickups = new Pickup[4];
  pickups[0] = new Pickup(1, 10*32, 7*32);
  pickups[1] = new Pickup(0, 12*32, 7*32);
  pickups[2] = new Pickup(1, 14*32, 7*32);
  pickups[3] = new Pickup(0, 16*32, 7*32);

  score = 0;

  goal = new PVector(19*cellWidth, 7*cellHeight);

  gameTimer = new Timer(1000);
  maxTime = 100;
  currentTime = maxTime;
  timerStartCounting = false;

  enemies = new Enemy[2];
  //art type, x, y, collide with walls
  enemies[0] = new Enemy(SLIME, 4*32, 3*32, true);
  enemies[1] = new Enemy(GHOST, 8*32, 3*32, false);
  //REMOVE LATER
  //currentEnemy = enemies[0];
  eightBitFont = createFont("data/fonts/8-Bit-Madness.ttf", 64);
  textFont(eightBitFont);
  
  //sounds
  //sfx
  sfxPunch = new SoundFile(this, "data/sounds/punch.wav");
  sfxKick = new SoundFile(this, "data/sounds/kick.wav");
  sfxStare = new SoundFile(this, "data/sounds/stare.wav");
  sfxWalk = new SoundFile(this, "data/sounds/walk.wav");
  
  //monsters 
  enemySounds = new SoundFile[4];
  enemySounds[0] = new SoundFile(this, "data/sounds/slime.wav");
  enemySounds[1] = new SoundFile(this, "data/sounds/bat.wav");
  enemySounds[2] = new SoundFile(this, "data/sounds/ghost.wav");
  enemySounds[3] = new SoundFile(this, "data/sounds/spider.wav");
  
  //music
  //music = new SoundFile(this, "data/sounds/bitQuest.mp3");
  //music.loop();
}

void draw() {
  textSize(24);
  if (gameState=="START") {
    stateStart();
  } else if (gameState=="PLAY") {
    statePlay();
  } else if (gameState=="WIN") {
    stateWin();
  } else if (gameState=="LOSE") {
    stateLose();
  } else if (gameState=="RESET") {
    stateReset();
  } else if (gameState=="COMBAT") {
    stateCombat(currentEnemy);
  } else {
    println("something went wrong with the state");
  }
}

void stateStart() {
  background(0, 0, 255);
  fill(255);
  textAlign(CENTER);
  text("Press to Start", width/2, height/2-100);
  textAlign(LEFT);
  ellipse(width/2, height/2, 100, 100);
  if (mousePressed && dist(mouseX, mouseY, width/2, height/2)<50) {
    gameState = "PLAY";
  }
}

void statePlay() {
  //image(art,0,0);
  //clear background
  background(0);

  //draw the maze artwork
  renderMap();

  s.update();
  checkWallCollisions(s);
  s.display();

  for (int i = 0; i < enemies.length; i++) {
    enemies[i].update();
    if (enemies[i].collider == true) {
      checkWallCollisions(enemies[i]);
    }
    if (rectangleIntersect(s, enemies[i]) == true) {
      currentEnemy = enemies[i];
      gameState = "COMBAT";
    }
    enemies[i].display();
  }

  if (dist(goal.x, goal.y, s.x, s.y) < 1) {
    gameState = "WIN";
  }

  for (int i = 0; i < pickups.length; i++) {
    pickups[i].display();
    if (rectangleIntersect(s, pickups[i]) == true) {
      score += pickups[i].scoreValue;
      pickups[i].hide();
    }
  }
  if (gameTimer.complete() && gameState == "PLAY" && timerStartCounting==true) {
    if (currentTime < 5) {
      background(255, 0, 0);
    }
    currentTime--;
    if (currentTime>0) {
      gameTimer.start();
    } else {
      gameState = "LOSE";
    }
  } else if (!timerStartCounting) {
    fill(0, 200);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER);
    text("Press any KEY to Begin", width/2, height/2);
    textAlign(LEFT);
  }

  //UI
  fill(255);
  textAlign(LEFT);
  text("Score: " + score, 32, 16);
  text("Time: " + currentTime, 32*6, 16);

  fill(255, 0, 0, 200);
  rect(goal.x, goal.y, cellWidth, cellHeight);
}

///////////////////////////////
void stateWin() {
  background(0, 255, 0);
  fill(255);
  textAlign(CENTER);
  text("Winner, Winner, Chicken Dinner", width/2, height/2-100);
  textAlign(LEFT);
  ellipse(width/2, height/2, 100, 100);
  if (mousePressed && dist(mouseX, mouseY, width/2, height/2)<50) {
    gameState = "RESET";
  }
}
void stateLose() {
  background(255, 0, 0);
  fill(255);
  textAlign(CENTER);
  text("Loser all day long", width/2, height/2-100);
  textAlign(LEFT);
  ellipse(width/2, height/2, 100, 100);
  if (mousePressed && dist(mouseX, mouseY, width/2, height/2)<50) {
    gameState = "RESET";
  }
}
void stateReset() {
  score = 0;
  s.x=width/2;
  s.y = height/2;
  gameState = "START";
}

boolean rectangleIntersect(Sprite r1, Pickup r2) {
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

void checkWallCollisions(Sprite s) {
  String collisionSide = "";
  for (int i = 0; i<rows; i++) {
    for (int j = 0; j<cols; j++) {
      //check if the tile is a wall 
      if (tileMap[i][j] == 1) {
        //determine the distance apart on the X axis
        int distX = floor((s.x+s.w/2)-(j*cellWidth+cellWidth/2));
        //determine the distance apart on the Y axis
        int distY = floor((s.y+s.h/2)-(i*cellHeight+cellHeight/2));
        //determine the sum of the half width of the object and the wall
        int combinedHalfWidths = floor(s.w/2+cellWidth/2);
        //determine the sum of the half height and the wall
        int combinedHalfHeights = floor(s.h/2+cellHeight/2);
        //check if they are overlapping on the X axis
        if (abs(distX) < combinedHalfWidths) {
          //check if they are overlapping on the Y axis
          //if so, a collision has occurred
          if (abs(distY) < combinedHalfHeights) {
            //compute the overlap of the object and the wall
            //on both the X and Y axes
            int overlapX = combinedHalfWidths - abs(distX);
            int overlapY = combinedHalfHeights - abs(distY);
            //the collision occurred on the axis with the smallest overlap
            if (overlapX >= overlapY) {
              //because distY is the object Y minus the wall Y
              //a positive value indicates the object started below
              //the wall and was moving up when the collision occurred
              //so it has hit its top into the wall
              if (distY > 0) {
                collisionSide = "TOPSIDE";
                //move the object down so it is no longer overlapping the wall
                s.y += overlapY;
              } else {
                collisionSide = "BOTTOMSIDE";
                //move the object up so it is no longer overlapping the wall
                s.y -= overlapY;
              }
            } else {
              //same logic as the Y axis collision
              if (distX > 0) {
                collisionSide = "LEFTSIDE";
                //move the object to the right so it is no longer overlapping the wall
                s.x += overlapX;
              } else {
                collisionSide = "RIGHTSIDE";
                //move the object to the left so it is no longer overlapping the wall
                s.x -= overlapX;
              }
            }
          } else {
            collisionSide = "NONE";
          }
        }
      }
    }
  }
}
void checkWallCollisions(Enemy s) {
  String collisionSide = "";
  for (int i = 0; i<rows; i++) {
    for (int j = 0; j<cols; j++) {
      //check if the tile is a wall 
      if (tileMap[i][j] == 1) {
        //determine the distance apart on the X axis
        int distX = floor((s.x+s.w/2)-(j*cellWidth+cellWidth/2));
        //determine the distance apart on the Y axis
        int distY = floor((s.y+s.h/2)-(i*cellHeight+cellHeight/2));
        //determine the sum of the half width of the object and the wall
        int combinedHalfWidths = floor(s.w/2+cellWidth/2);
        //determine the sum of the half height and the wall
        int combinedHalfHeights = floor(s.h/2+cellHeight/2);
        //check if they are overlapping on the X axis
        if (abs(distX) < combinedHalfWidths) {
          //check if they are overlapping on the Y axis
          //if so, a collision has occurred
          if (abs(distY) < combinedHalfHeights) {
            //compute the overlap of the object and the wall
            //on both the X and Y axes
            int overlapX = combinedHalfWidths - abs(distX);
            int overlapY = combinedHalfHeights - abs(distY);
            //the collision occurred on the axis with the smallest overlap
            if (overlapX >= overlapY) {
              //because distY is the object Y minus the wall Y
              //a positive value indicates the object started below
              //the wall and was moving up when the collision occurred
              //so it has hit its top into the wall
              if (distY > 0) {
                collisionSide = "TOPSIDE";
                //move the object down so it is no longer overlapping the wall
                s.y += overlapY;
              } else {
                collisionSide = "BOTTOMSIDE";
                //move the object up so it is no longer overlapping the wall
                s.y -= overlapY;
              }
            } else {
              //same logic as the Y axis collision
              if (distX > 0) {
                collisionSide = "LEFTSIDE";
                //move the object to the right so it is no longer overlapping the wall
                s.x += overlapX;
              } else {
                collisionSide = "RIGHTSIDE";
                //move the object to the left so it is no longer overlapping the wall
                s.x -= overlapX;
              }
            }
          } else {
            collisionSide = "NONE";
          }
        }
      }
    }
  }
}


void renderMap() {
  for (int i = 0; i<rows; i++) {
    for (int j = 0; j<cols; j++) {
      // noStroke();
      switch (tileMap[i][j]) {
      case 0:
        //floor
        fill(100, 200, 0, 255);
        rect(j*cellWidth, i*cellHeight, 64, 64);
        break;
      case 1:
        //wall
        fill(200, 100, 0, 255);
        rect(j*cellWidth, i*cellHeight, 64, 64);
        break;
      default:
        println("You did not make the map right.");
      }
    }
  }
}


void keyPressed() {
  if (gameState == "PLAY" && !timerStartCounting) {
    timerStartCounting = true;
  }

  switch (keyCode) {
  case 37://left
    left = true;
    break;
  case 39://right
    right = true;
    break;
  case 38://up
    up = true;
    break;
  case 40://down
    down = true;
    break;
  }
}
void keyReleased() {
  switch (keyCode) {
  case 37://left
    left = false;
    break;
  case 39://right
    right = false;
    break;
  case 38://up
    up = false;
    break;
  case 40://down
    down = false;
    break;
  }
}
