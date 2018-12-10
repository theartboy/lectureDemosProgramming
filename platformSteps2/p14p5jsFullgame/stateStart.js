function startGame() {
  image(startImage, 0, 0);
  if (mouseIsPressed) {
    firingTimer.start();//shift to appropriate state function once states are implemented
    gameState = "PLAY";
    musicPlayer(startMusic, playMusic);

  }
  // var s = "Click to Play!!!";
  // textAlign(CENTER);
  // textSize(18);
  // fill(255, 0, 0);
  // text(s, width/2, height/2);
  // s = "go left to WIN.\ngo right to LOSE.";
  // textSize(14);
  // text(s, width/2, height/2+30);

}
