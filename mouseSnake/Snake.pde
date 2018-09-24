class Snake {
  //properties
  int[] xpos;
  int[] ypos;

  //constructor
  Snake() {
    xpos = new int[50];
    ypos = new int[50];
    for (int i = 0; i < xpos.length; i++) {
      xpos[i] = 0;
      ypos[i] = 0;//can set both since we need them all to be set to zero
    }
  }
  //methods
  void update() {
    //shift the old positions one left to make room for current pos
    //we are drawing the array tail to head
    //first position [0] is the end ofthe tail and the head is the last item in the array
    for (int i = 0; i < xpos.length - 1; i++) {
      xpos[i] = xpos[i+1];
      ypos[i] = ypos[i+1];
    }

    //capture the new location
    xpos[xpos.length-1] = mouseX;
    ypos[xpos.length-1] = mouseY;
  }
  void display() {
    //display the snake
    for (int i = 0; i<xpos.length; i++) {
      noStroke();
      fill(255 - i*5);
      ellipse(xpos[i], ypos[i], i, i);
    }
  }
}
