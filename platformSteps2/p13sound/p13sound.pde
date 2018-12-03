//credits
//Bit Quest Kevin MacLeod (incompetech.com)
//Licensed under Creative Commons: By Attribution 3.0 License
//http://creativecommons.org/licenses/by/3.0/

Unicorn u;
Platform [] platforms;
PImage [] spriteImages;
int frames;

boolean left, right, up, down, space;
FrameObject camera, gameWorld;
ImageObject backImage;
PImage landscape;

Enemy [] enemies;

float health;
float pHealth;

Timer firingTimer;
Bullet [] bullets;
int nextBullet;

int a;//health warning strobe alpha value

//sounds
import ddf.minim.*;
Minim minim;
AudioPlayer music;
AudioPlayer sfxDead;
AudioPlayer sfxDing;
AudioPlayer sfxHit;
AudioPlayer sfxJump;
AudioPlayer sfxShoot;

void setup() {
  size(800, 600);

  left = false;
  right = false;
  up = false;
  down = false;
  space = false;

  landscape = loadImage("landscape2.jpg");
  backImage = new ImageObject(0, 0, 1152, 768, landscape);
  gameWorld = new FrameObject(0, 0, backImage.w*3, backImage.h);
  camera = new FrameObject(0, 0, width, height-100);//100 shift is for upper UI elements

  camera.x = (gameWorld.x + gameWorld.w/2) - camera.w/2;
  camera.y = (gameWorld.y + gameWorld.h/2) - camera.h/2;


  //unicorn values
  u = new Unicorn();
  frames = 24;
  spriteImages = new PImage[frames];
  for (int i = 0; i<frames; i++) {
    spriteImages[i]=loadImage("unicorn"+nf(i+1, 4)+".png");
  }

  platforms = new Platform[9];
  //ground of doom
  platforms[0] = new Platform (0, gameWorld.h-20, gameWorld.w, 25, "death");

  platforms[1] = new Platform (300, 150, 200, 25, "safe");
  platforms[2] = new Platform (824, 150, 200, 25, "safe");
  platforms[3] = new Platform (0, 300, 200, 25, "safe");
  platforms[4] = new Platform (600, 300, 200, 25, "safe");
  platforms[5] = new Platform (824, 450, 200, 25, "safe");
  platforms[6] = new Platform (300, 450, 200, 25, "death");
  platforms[7] = new Platform (0, 600, 200, 25, "safe");
  platforms[8] = new Platform (600, 600, 200, 25, "safe");

  ////number of enemies is one less than all the platforms because the ground doesn't need one
  enemies = new Enemy[platforms.length-1];
  for (int i = 1; i < platforms.length; i++) {
    enemies[i-1] = new Enemy(platforms[i]);
  }

  health = 100;
  pHealth = health;

  bullets = new Bullet [100];
  for (int i = 0; i < bullets.length; ++i) {
    bullets[i] = new Bullet();
  }
  nextBullet = 0;

  firingTimer = new Timer(50);
  firingTimer.start();//shift to appropriate state function once states are implemented

  //sound stuff
  minim = new Minim( this );
  //sfx
  sfxDead = minim.loadFile("data/sounds/dead.mp3");
  sfxDing = minim.loadFile("data/sounds/ding.mp3");
  sfxHit = minim.loadFile("data/sounds/hit.mp3");
  sfxJump = minim.loadFile("data/sounds/jump.mp3");
  sfxShoot = minim.loadFile("data/sounds/shoot.mp3");
  //background music
  music = minim.loadFile("data/sounds/bitQuest.mp3");
  //music.play(0);
}

void draw() {
  background(255);
  pHealth = health;

  ////unicorn
  u.update();
  for (int i = 0; i < platforms.length; ++i) {
    u.collisionSide = rectangleCollisions(u, platforms[i]);

    if (u.collisionSide != "none" && platforms[i].typeof == "death") {
      health -= 0.1;//lower health when on the bad platform
    }
    //change the uni color when on the ground
    if (pHealth > health) {
      u.c = color(255, 0, 0);
    } else {
      u.c = color(255);
    }
    u.checkPlatforms();
  }

  ////enemies
  for (int i = 0; i < enemies.length; i++) {
    enemies[i].update();
    if (rectangleCollisionPvE(u, enemies[i]) && !enemies[i].dead) {
      enemies[i].deathJump();
      health -= 20;
      sfxDead.play(0);
      //playSFX(sfxDead, true);
    }
  }

  ////bullets
  if (space) {
    if (firingTimer.complete()) {
      //playSFX(sfxShoot, false);
      sfxShoot.play(0);
      bullets[nextBullet].fire(u.x, u.y, u.w, u.facingRight);
      nextBullet = (nextBullet+1)%bullets.length;
      firingTimer.start();
    }
  }
  for (int i = 0; i < bullets.length; ++i) {
    bullets[i].update();
    for (int j = 0; j < enemies.length; j++) {
      if (rectangleCollisionBvE(bullets[i], enemies[j]) && !enemies[j].dead) {
        enemies[j].deathJump();
        bullets[i].reset();
        health += 20;
        sfxDing.play(0);
        //playSFX(sfxDing, true);
      }
    }
  }


  //Move the camera
  camera.x = floor(u.x + (u.halfWidth) - (camera.w / 2));
  camera.y = floor(u.y + (u.halfHeight) - (camera.h / 2));

  //Keep the camera inside the gameWorld boundaries
  if (camera.x < gameWorld.x) {
    camera.x = gameWorld.x;
  }
  if (camera.y < gameWorld.y) {
    camera.y = gameWorld.y;
  }
  if (camera.x + camera.w > gameWorld.x + gameWorld.w) {
    camera.x = gameWorld.x + gameWorld.w - camera.w;
  }
  if (camera.y + camera.h > gameWorld.h) {
    camera.y = gameWorld.h - camera.h;
  }

  pushMatrix();
  translate(-camera.x, -camera.y+100);//downward shift is for UI elements

  backImage.display();
  u.display();

  for (int i = 0; i < platforms.length; ++i) {
    platforms[i].display();
  }
  for (int i = 0; i < enemies.length; i++) {
    enemies[i].display();
  }
  for (int i = 0; i < bullets.length; ++i) {
    bullets[i].display();
  }

  popMatrix();

  displayUI();

  //strobe BG overlay if touching ground
  if (u.y >= platforms[0].y - u.h) {
    fill(255, 0, 0, a*8);
    rect(0, 100, camera.w, camera.h);
    a = (a + 1)%20;
  }

  if (health<=0) {
    //chage game state when implemented
  }
}

void playSFX(AudioPlayer sound, boolean isDone) {
  if (isDone) {
    if (!sound.isPlaying()) {
      sound.play(0);
    }
  } else {
    sound.play(0);
  }
}

boolean rectangleCollisionPvE(Unicorn r1, Enemy r2) {
  ////r1 is the player
  ////r2 is the enemy

  float dx = (r1.x+r1.w/2) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/2) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    ////now check on the y axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      return true;
    }
  }
  return false;
}

boolean rectangleCollisionBvE(Bullet r1, Enemy r2) {
  ////r1 is the player
  ////r2 is the enemy

  float dx = (r1.x+r1.w/2) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/2) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    ////now check on the y axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      return true;
    }
  }
  return false;
}


String rectangleCollisions(Unicorn r1, Platform r2) {
  ////r1 is the player
  ////r2 is the platform rectangle
  ////function returns the String collisionSide

  //allow unicorn to pass through platforms.
  //Disable if you want unicorn to bounce off bottom of platforms

  if (r1.vy < 0) { 
    return "none";
  }

  float dx = (r1.x+r1.w/2) - (r2.x+r2.w/2);
  float dy = (r1.y+r1.h/2) - (r2.y+r2.h/2);

  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;

  if (abs(dx) < combinedHalfWidths) {
    ////collision has happened on the x axis
    ////now check on the y axis
    if (abs(dy) < combinedHalfHeights) {
      ////collision detected
      //determine the overlap on each axis
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      ////the collision is on the axis with the
      ////SMALLEST overlap
      if (overlapX >= overlapY) {
        if (dy > 0) {
          ////move the rectangle back to eliminate overlap
          ////before calling its display to prevent
          ////drawing object inside each other
          r1.y += overlapY;
          return "top";
        } else {
          r1.y -= overlapY;
          return "bottom";
        }
      } else {
        if (dx > 0) {
          r1.x += overlapX;
          return "left";
        } else {
          r1.x -= overlapX;
          return "right";
        }
      }
    } else {
      //collision failed on the y axis
      return "none";
    }
  } else {
    //collision failed on the x axis
    return "none";
  }
}

void displayUI() {
  fill(0);
  rect(0, 0, width, 100);
  //String s = "\nvx: "+u.vx+"  vy: ";
  //text(s, 50, 50);
  fill(255);
  String s = "cs: "+u.collisionSide + "\nhealth: " + floor(health) + "\niog: "+u.isOnGround+"  "+
    "ux:"+u.x+"  cx:"+camera.x+"  gwx:"+gameWorld.x+"\nblb:"+bullets[0].leftBound+"  brb:"+bullets[0].rightBound;
  text(s, 40, 50);

  //draw health bar
  fill(255, 0, 0);
  rect(20, 10, health * 5, 10);
}

void keyPressed() {
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
  case 32: //space
    space = true;
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
  case 32: //space
    space = false;
    break;
  }
}
