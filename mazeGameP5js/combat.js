var fighting = false;
var combatResult = "";

function stateCombat(e) {
  sfxWalk.stop();
  for(var i = 0; i < enemySounds.length; i++){
   enemySounds[i].stop();
  }
  background(200, 200, 100);
  //define combat
  copy(combatArt, s.offsetX*10/3, 0, 320, 320, 25, height/2, 320, 320);
  copy(combatArt, e.offsetX*10/3, 320, 320, 320, 300, 0, 320, 320);

  fill(255, 0, 0);
  ellipse(300, height-100, 100, 100);
  ellipse(425, height-100, 100, 100);
  ellipse(550, height-100, 100, 100);
  fill(255);
  textAlign(CENTER);
  text(s.actions[0], 300, height-100);
  text(s.actions[1], 425, height-100);
  text(s.actions[2], 550, height-100);

  if (mouseIsPressed && !fighting) {
    if (dist(mouseX, mouseY, 300, height-100) < 50) {
      // println("ROCK");
      sfxPunch.play();
      fight(0, e);
    }
    if (dist(mouseX, mouseY, 425, height-100) < 50) {
      // println("PAPER");
      sfxKick.play();
      fight(1, e);
    }
    if (dist(mouseX, mouseY, 550, height-100) < 50) {
      // println("SCISSORS");
      sfxStare.play();
      fight(2, e);
    }
  } else if (mouseIsPressed && fighting &&
    mouseX>width/2-200 && mouseX<width/2+200 &&
    mouseY>height/2-100 && mouseY<height/2+100) {
      fighting = false;
      e.hide();
      gameState = "PLAY";
  }

  if (fighting) {
    fill(0, 200);
    rect(0, 0, width, height);
    fill(200, 0, 0);
    rect(width/2-200, height/2-100, 400, 200);
    textSize(64);
    fill(255);
    textAlign(CENTER, CENTER);
    text(combatResult, width/2, height/2);
  }
}

function fight(playerChoice, e) {
  //0=rock, 1=paper, 2=scissors
  //win combos
  //1:0, 2:1, 0:2
  //player lose combos
  //0:1, 1:2, 2:0
  //tie combos
  //0:0, 1:1, 2:2
  var enemyChoice = floor(random(3));

  fighting = true;
  if (playerChoice == enemyChoice) {
    //tie
    combatResult = s.actions[playerChoice] + "\nis blocked by\n"+e.actions[enemyChoice];
  } else if (playerChoice - enemyChoice == 1 || playerChoice - enemyChoice == -2) {
    //player wins
    combatResult = s.actions[playerChoice] + "\ndestroys\n"+e.actions[enemyChoice];
    score += 100;
  } else {
    //player loses
    combatResult = s.actions[playerChoice] + " \nis wrecked by\n"+e.actions[enemyChoice];
    score -= 100;
  }
  // println(combatResult);
  //fighting = false;
}
