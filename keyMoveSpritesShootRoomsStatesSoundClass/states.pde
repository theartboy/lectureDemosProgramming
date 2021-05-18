void title() {
  background(#CB4CFA);
  //text color
  fill(255);
  textSize(24);
  textAlign(CENTER);
  String s = "Title Scene\nClick to Play";
  text(s, 400, 200);
  fill(#4CFAED);
  circle(400, 300, 100);
  float distanceFromClick = dist(mouseX, mouseY, 400, 300);
  if (mousePressed && distanceFromClick < 50) {
    titleMusic.stop();
    gameMusic.play();
    gameState = "GAME";
  }
}

void win() {
  background(#EA2FCC);
  //text color
  fill(255);
  textSize(24);
  textAlign(CENTER);
  String s = "You are the chosen one\nClick to Play Again";
  text(s, 400, 200);
  fill(#4CFAED);
  circle(400, 300, 100);
  float distanceFromClick = dist(mouseX, mouseY, 400, 300);
  if (mousePressed && distanceFromClick < 50) {
    winMusic.stop();
    gameMusic.play();
    resetGame();
  }
}
void lose() {
  background(#D69170);
  //text color
  fill(255);
  textSize(24);
  textAlign(CENTER);
  String s = "You are a loser\nClick to Play Again";
  text(s, 400, 200);
  fill(#4CFAED);
  circle(400, 300, 100);
  float distanceFromClick = dist(mouseX, mouseY, 400, 300);
  if (mousePressed && distanceFromClick < 50) {
    loseMusic.stop();
    gameMusic.play();
    resetGame();
  }
}
