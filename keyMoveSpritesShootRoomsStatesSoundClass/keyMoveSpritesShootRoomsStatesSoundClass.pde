//"Bit Quest" Kevin MacLeod (incompetech.com)
//"Spazzmatica Polka" Kevin MacLeod (incompetech.com)
//"Pinball Spring" Kevin MacLeod (incompetech.com)
//"Desert of Lost Souls" Kevin MacLeod (incompetech.com)
//Licensed under Creative Commons: By Attribution 4.0 License
//http://creativecommons.org/licenses/by/4.0/

import processing.sound.*;
SoundFile shootSound;
SoundFile titleMusic, gameMusic, winMusic, loseMusic;

boolean left, right, up, down;
Player p;

//images
PImage playerImages [];
PImage enemyImages [];
int playerFrames, enemyFrames;
Enemy[] enemies;
Enemy[] enemies2;

//new vars
boolean space;
Projectile [] projectiles;
int nextProjectile;
Timer firingTimer;
String s;
PImage mapRoomOne;
Block [] blocks;
PImage mapRoomTwo;
Block [] blocks2;

int health;
int score;
int room;
String gameState;
void setup() {
  size(800, 600);
  background(255);
  playerFrames = 12;
  enemyFrames = 16;
  playerImages = new PImage[playerFrames];
  for (int i = 0; i<playerFrames; i++) {
    playerImages[i] = loadImage("assets/skeleton-NESW/skeletonRedEye"+nf(i, 2)+".png");
  }
  enemyImages = new PImage[enemyFrames];
  for (int j = 0; j<enemyFrames; j++) {
    enemyImages[j] = loadImage("assets/unicorn/unicorn"+nf(j, 2)+".png");
  }
  enemies = new Enemy[3];
  for (int k=0; k<enemies.length; k++) {
    enemies[k] = new Enemy();
  }
  enemies2 = new Enemy[2];
  for (int k=0; k<enemies2.length; k++) {
    enemies2[k] = new Enemy();
  }
  p = new Player();
  s = "";

  left = false;
  right = false;
  up = false;
  down = false;

  //new stuff
  space = false;
  projectiles = new Projectile[5];
  for (int k=0; k < projectiles.length; k++) {
    projectiles[k] = new Projectile(150+k*50, 576);
  }
  nextProjectile = 0;

  firingTimer = new Timer(200);
  firingTimer.start();

  blocks = new Block[10];
  //left wall
  blocks[0] = new Block(-32, 0, 64, 300);
  blocks[1] = new Block(-32, 364, 64, 236);
  //right wall
  blocks[2] = new Block(768, 0, 64, 300);
  blocks[3] = new Block(768, 364, 64, 236);
  //top wall
  blocks[4] = new Block(32, -32, 352, 64);
  blocks[5] = new Block(448, -32, 320, 64);
  //bottom wall
  blocks[6] = new Block(32, 568, 352, 64);
  blocks[7] = new Block(448, 568, 320, 64);
  //interior
  blocks[8] = new Block(200, 100, 32, 400);
  blocks[9] = new Block(568, 100, 32, 400);

    blocks2 = new Block[7];
  //left wall
  blocks2[0] = new Block(-32, 0, 64, 300);
  blocks2[1] = new Block(-32, 364, 64, 236);
  //right wall
  blocks2[2] = new Block(768, 0, 64, 600);
  //top wall
  blocks2[3] = new Block(32, -32, 736, 64);
  //bottom wall
  blocks2[4] = new Block(32, 568, 736, 64);
  //interior
  blocks2[5] = new Block(200, 100, 32, 200);
  blocks2[6] = new Block(568, 364, 32, 132);

  mapRoomOne = loadImage("assets/map.png");
  mapRoomTwo = loadImage("assets/map2.png");
    
  health = 1000;
  score = 0;
  room = 1;
  gameState = "TITLE";
  
  shootSound = new SoundFile(this, "assets/sounds/shoot.mp3");
  titleMusic = new SoundFile(this, "assets/sounds/dolsStart.mp3");
  gameMusic = new SoundFile(this, "assets/sounds/bitQuest.mp3");
  winMusic = new SoundFile(this, "assets/sounds/psWin.mp3");
  loseMusic = new SoundFile(this, "assets/sounds/spLose.mp3");
  
  titleMusic.play();
}//end setup

void draw() {
  //background(200);
  if (gameState == "TITLE") {
    title();
  } else if (gameState == "GAME") {
    noCursor();
    game();
  } else if (gameState == "WIN") {
    cursor();
    win();
  } else if (gameState == "LOSE") {
    cursor();
    lose();
  } else {
    println("something went wrong with gameState");
  }
 
}//end draw
void game(){
  if (room == 1){
    playRoomOne();
  }else if (room == 2){
    playRoomTwo();
  }
  
}
void resetGame() {
  for (int i = 0; i < enemies.length; i++) {
    enemies[i].reset();
  }
  for (int i = 0; i < enemies2.length; i++) {
    enemies2[i].reset();
  }
  room = 1;
  score = 0;
  health = 1000;
  gameState = "GAME";
}

void keyPressed() {
  s = "key: " + keyCode;
  switch(keyCode) {
  case 37: //left
    left = true;
    break;
  case 38: //up
    up = true;
    break;
  case 39: //right
    right = true;
    break;
  case 40: //down
    down = true;
    break;
  case 32: //space
    space = true;
    break;
  }

  //if (keyCode == 37) {
  //  left = true;
  //} else if (keyCode == 38) {
  //  up = true;
  //} else if (keyCode == 39) {
  //  right = true;
  //} else if (keyCode == 40) {
  //  down = true;
  //}
}

void keyReleased() {
  switch(keyCode) {
  case 37: //left
    left = false;
    break;
  case 38: //up
    up = false;
    break;
  case 39: //right
    right = false;
    break;
  case 40: //down
    down = false;
    break;
  case 32: //space
    space = false;
    break;
  }
}

//intersects
void enemyBlockCollision(Enemy r1, Block r2) {
  float distX = ((r1.x+r1.w/2)-(r2.x+r2.w/2));
  float distY = ((r1.y+r1.h/2)-(r2.y+r2.h/2));
  float combinedHalfWidths = r1.w/2+r2.w/2;
  float combinedHalfHeights = r1.h/2+r2.h/2;
  if (abs(distX) < combinedHalfWidths) {
    if (abs(distY) < combinedHalfHeights) {
      float overlapX = combinedHalfWidths - abs(distX);
      float overlapY = combinedHalfHeights - abs(distY);
      if (overlapX >= overlapY){
        if (distY > 0){
          r1.y += overlapY;
        }else{
         r1.y -= overlapY;
        }
      }else{
        if (distX > 0){
          r1.x += overlapX;
        }else{
         r1.x -= overlapX;
        }
      }
    }//end overlap adjustment
  }//end successful overlap
}//end player block

void playerBlockCollision(Player r1, Block r2) {
  //what is the dist on the x-axis
  float distX = ((r1.x+r1.w/2)-(r2.x+r2.w/2));
  //what is the dist on the y-axis
  float distY = ((r1.y+r1.h/2)-(r2.y+r2.h/2));
  //what is the combined half widths
  float combinedHalfWidths = r1.w/2+r2.w/2;
  //what is the combined half heights
  float combinedHalfHeights = r1.h/2+r2.h/2;

  //check for x-axis intersection
  if (abs(distX) < combinedHalfWidths) {
    //check on y-axis
    if (abs(distY) < combinedHalfHeights) {
      //yippee we are intersecting
      //adjust for overlap
      //////////////////
      float overlapX = combinedHalfWidths - abs(distX);
      float overlapY = combinedHalfHeights - abs(distY);
      if (overlapX >= overlapY){
        //correct y overlaps
        if (distY > 0){
          //player top is inside block
          r1.y += overlapY;
        }else{
         //player bottom is inside block
         r1.y -= overlapY;
        }
      }else{
        //correct x overlaps
        if (distX > 0){
          //player left is inside block
          r1.x += overlapX;
        }else{
         //player right is inside block
         r1.x -= overlapX;
        }
      }
      /////////////////
    }//end overlap adjustment
  }//end successful overlap
}//end player block

//intersects
boolean rectangleIntersect(Projectile r1, Block r2) {
  //what is the dist on the x-axis
  float distX = abs((r1.x+r1.w/2)-(r2.x+r2.w/2));
  //what is the dist on the y-axis
  float distY = abs((r1.y+r1.h/2)-(r2.y+r2.h/2));
  //what is the combined half widths
  float combinedHalfWidths = r1.w/2+r2.w/2;
  //what is the combined half heights
  float combinedHalfHeights = r1.h/2+r2.h/2;

  //check for x-axis intersection
  if (distX < combinedHalfWidths) {
    //check on y-axis
    if (distY < combinedHalfHeights) {
      //yippee we are intersecting
      return true;
    }
  }

  return false;
}
boolean rectangleIntersect(Projectile r1, Enemy r2) {
  //what is the dist on the x-axis
  float distX = abs((r1.x+r1.w/2)-(r2.x+r2.w/2));
  //what is the dist on the y-axis
  float distY = abs((r1.y+r1.h/2)-(r2.y+r2.h/2));
  //what is the combined half widths
  float combinedHalfWidths = r1.w/2+r2.w/2;
  //what is the combined half heights
  float combinedHalfHeights = r1.h/2+r2.h/2;

  //check for x-axis intersection
  if (distX < combinedHalfWidths) {
    //check on y-axis
    if (distY < combinedHalfHeights) {
      //yippee we are intersecting
      return true;
    }
  }

  return false;
}
boolean rectangleIntersect(Player r1, Enemy r2) {
  //what is the dist on the x-axis
  float distX = abs((r1.x+r1.w/2)-(r2.x+r2.w/2));
  //what is the dist on the y-axis
  float distY = abs((r1.y+r1.h/2)-(r2.y+r2.h/2));
  //what is the combined half widths
  float combinedHalfWidths = r1.w/2+r2.w/2;
  //what is the combined half heights
  float combinedHalfHeights = r1.h/2+r2.h/2;

  //check for x-axis intersection
  if (distX < combinedHalfWidths) {
    //check on y-axis
    if (distY < combinedHalfHeights) {
      //yippee we are intersecting
      return true;
    }
  }

  return false;
}
