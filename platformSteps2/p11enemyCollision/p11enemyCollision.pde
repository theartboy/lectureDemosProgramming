
Unicorn u;
Platform [] platforms;
PImage [] spriteImages;
int frames;

boolean left, right, up, down, space;
FrameObject camera, gameWorld;
ImageObject backImage;
PImage aaron;

Enemy [] enemies;

float health;
float pHealth;

Timer strobe;
Boolean strobeOn;
int a;

void setup() {
  size(800, 600);

  left = false;
  right = false;
  up = false;
  down = false;
  space = false;

  aaron = loadImage("DesktopAaronR.jpg");
  backImage = new ImageObject(0, 0, 1024, 768, aaron);
  gameWorld = new FrameObject(0, 0, backImage.w*2, backImage.h);
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
  platforms[6] = new Platform (300, 450, 200, 25, "safe");
  platforms[7] = new Platform (0, 600, 200, 25, "safe");
  platforms[8] = new Platform (600, 600, 200, 25, "safe");

  ////number of enemies is one less than all the platforms because the ground doesn't need one
  enemies = new Enemy[platforms.length-1];
  for (int i = 1; i < platforms.length; i++) {
    enemies[i-1] = new Enemy(platforms[i]);
  }

  health = 100;
  pHealth = health;

  strobe = new Timer(200);
  strobeOn = false;
  a = 0;
}

void draw() {
  background(255);
  pHealth = health;
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

  popMatrix();

  displayUI();
  //strobe BG overlay if touching ground
  if (u.y >= platforms[0].y - u.h) {
    fill(255, 0, 0, a*8);
    rect(0, 100, camera.w, camera.h);
    a = (a + 1)%20;
  }

  if (health<=0) {
    //gameState = "lose";
    //fill(255, 0, 0, a*10);
    //rect(0, 100, camera.w, camera.h);
    //a = (a + 1)%20;
    //if (!strobeOn) {
    //  fill(255, 0, 0, a);
    //  rect(0, 100, camera.w, camera.h);
    //  strobe.start();
    //  strobeOn = !strobeOn;
    //}
    //if (strobe.complete()) {
    //}
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
  String s = "cs: "+u.collisionSide + "\nhealth: " + floor(health) + "\niog: "+u.isOnGround;
  text(s, 50, 50);
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
