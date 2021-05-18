void playRoomOne() {
  image(mapRoomOne, 0, 0);
  //shooting
  if (space) {
    if (firingTimer.complete()) {
      projectiles[nextProjectile].fire(p.x+p.w/2, p.y+p.h/2, p.facing);
      nextProjectile = (nextProjectile+1)%projectiles.length;
      firingTimer.start();
      shootSound.play();
    }//end firingTimer
  }//end space

  for (int i=0; i<projectiles.length; i++) {
    projectiles[i].update();
    for (int j=0; j<enemies.length; j++) {
      if (rectangleIntersect(projectiles[i], enemies[j])&&!enemies[j].dead) {
        fill(0, 0, 255);
        rect(0, 0, width, height);
        projectiles[i].reset();
        enemies[j].destroy();
        score++;
        if(score == (enemies.length+enemies2.length)){
          gameMusic.stop();
          winMusic.play();
          gameState = "WIN";
        }
      }
    }
    for (int k=0; k<blocks.length; k++) {
      if (rectangleIntersect(projectiles[i], blocks[k])) {
        projectiles[i].reset();
      }
    }
    projectiles[i].display();
  }

  p.update();
  for (int i = 0; i < blocks.length; i++) {
    //blocks[i].display();
    playerBlockCollision(p, blocks[i]);
  }
  if(p.x > width){
   p.x = 0;
   room = 2;
  }
  //blocks[0].display();
  p.display();
  
  
  for (int k=0; k<enemies.length; k++) {
    if (!enemies[k].dead) {
      enemies[k].chase(p.x, p.y);
      enemies[k].update();
      for (int i = 0; i < blocks.length; i++) {
        enemyBlockCollision(enemies[k], blocks[i]) ;
      }
      enemies[k].display();
      if (rectangleIntersect(p, enemies[k])&&!enemies[k].dead) {
        fill(255, 0, 0, 50);
        rect(0, 0, width, height);
        health -= 5;
        if(health<=0){
          gameMusic.stop();
          loseMusic.play();
          gameState="LOSE";
        }
      }//player enemy intersect
    }//enemy not dead
  }//end enemies

  //display health
  noStroke();
  fill(255);
  rect(64, 8, 100, 16);
  fill(255, 75, 243);
  rect(64, 8, health/10, 16);
}//end room one
///////////////////////////
///////////////////////////
void playRoomTwo() {
  image(mapRoomTwo, 0, 0);
  //shooting
  if (space) {
    if (firingTimer.complete()) {
      projectiles[nextProjectile].fire(p.x+p.w/2, p.y+p.h/2, p.facing);
      nextProjectile = (nextProjectile+1)%projectiles.length;
      firingTimer.start();
      shootSound.play();
    }//end firingTimer
  }//end space

  for (int i=0; i<projectiles.length; i++) {
    projectiles[i].update();
    for (int j=0; j<enemies2.length; j++) {
      if (rectangleIntersect(projectiles[i], enemies2[j])&&!enemies2[j].dead) {
        fill(0, 0, 255);
        rect(0, 0, width, height);
        projectiles[i].reset();
        enemies2[j].destroy();
        score++;
        if(score == (enemies.length+enemies2.length)){
          gameMusic.stop();
          winMusic.play();
          gameState = "WIN";
        }
        //if score == total enemies then win game
      }
    }
    for (int k=0; k<blocks2.length; k++) {
      if (rectangleIntersect(projectiles[i], blocks2[k])) {
        projectiles[i].reset();
      }
    }
    projectiles[i].display();
  }

  p.update();
  for (int i = 0; i < blocks2.length; i++) {
    //blocks[i].display();
    playerBlockCollision(p, blocks2[i]);
    //blocks2[i].display();
  }
  if(p.x < -p.w){
   p.x = width;
   room = 1;
  }
  p.display();
  
  for (int k=0; k<enemies2.length; k++) {
    if (!enemies2[k].dead) {
      enemies2[k].chase(p.x, p.y);
      enemies2[k].update();
      for (int i = 0; i < blocks2.length; i++) {
        enemyBlockCollision(enemies2[k], blocks2[i]) ;
      }
      blendMode(SCREEN);
      enemies2[k].display();
      blendMode(BLEND);
      if (rectangleIntersect(p, enemies2[k])&&!enemies2[k].dead) {
        fill(255, 0, 0, 50);
        rect(0, 0, width, height);
        health -= 5;
        if(health<=0){
          gameMusic.stop();
          loseMusic.play();
          gameState="LOSE";
        }
      }//player enemy intersect
    }//enemy not dead
  }//end enemies

  //display health
  noStroke();
  fill(0);
  rect(64, 8, 100, 16);
  fill(86, 255, 75);
  rect(64, 8, health/10, 16);
}//end room two
