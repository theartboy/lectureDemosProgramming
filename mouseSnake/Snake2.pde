class Snake2 {
  //properties
  Point[] points;

  //constructor
  Snake2() {
     points = new Point[50];
    for (int i = 0; i < points.length; i++) {
     points[i] = new Point(0,0); 
    }
  }
  
  //methods
  void update() {
    for (int i = 0; i < points.length - 1; i++) {
      points[i] = points[i+1];
    }

    //capture the new location
    points[points.length-1] = new Point(mouseX, mouseY);
  }
  void display() {
    //display the snake
    for (int i = 0; i<points.length; i++) {
      noStroke();
      fill(255 - i*5);
      ellipse(points[i].x, points[i].y, i, i);
    }
  }
}
