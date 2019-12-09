import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class maze extends PApplet {

int [][] tileMap = {	
				{1,1,1,1,1,1,1,1,1,1},
				{1,0,0,0,0,0,0,0,0,1},
				{1,0,1,1,1,1,0,0,0,1},
				{1,0,1,0,0,0,0,0,0,1},
				{1,0,1,0,0,0,0,0,0,1},
				{1,0,0,0,0,0,0,0,0,1},
				{1,0,0,0,0,0,0,0,0,1},
				{1,0,0,0,0,0,0,0,0,1},
				{1,0,0,0,0,0,0,0,0,1},
				{1,1,1,1,1,1,1,1,1,1}
				};
////1 is wall
////0 is floor
int rows,cols;
int cellWidth, cellHeight;

boolean left,right,up,down;
Vehicle v;

public void setup(){
    size(640,640);
    background(255);
    smooth();
    rows=10;
    cols=10;
    cellWidth=64;
    cellHeight=64;
    v=new Vehicle();
	
}

public void draw(){
	renderMap();
	//update the position of the vehicle
	v.update();
	//check if the updated position of the vehicle moved into a wall
	//correct the position if a wall collision occurred
	checkWallCollisions();
	//now display the corrected position of the vehicle
	v.display();
}
public void checkWallCollisions(){
	String collisionSide = "";
	for (int i = 0; i<rows; i++){
		for (int j = 0; j<cols; j++){
			//check if the tile is a wall 
			if(tileMap[i][j] == 1){
				//determine the distance apart on the X axis
				int distX = floor((v.x+v.w/2)-(j*cellWidth+cellWidth/2));
				//determine the distance apart on the Y axis
				int distY = floor((v.y+v.h/2)-(i*cellHeight+cellHeight/2));
				//determine the sum of the half width of the object and the wall
				int combinedHalfWidths = floor(v.w/2+cellWidth/2);
				//determine the sum of the half height and the wall
				int combinedHalfHeights = floor(v.h/2+cellHeight/2);
				//check if they are overlapping on the X axis
				if(abs(distX) < combinedHalfWidths){
					//check if they are overlapping on the Y axis
					//if so, a collision has occurred
					if(abs(distY) < combinedHalfHeights){
						//compute the overlap of the object and the wall
						//on both the X and Y axes
						int overlapX = combinedHalfWidths - abs(distX);
						int overlapY = combinedHalfHeights - abs(distY);
						//the collision occurred on the axis with the smallest overlap
						if (overlapX >= overlapY){
							//because distY is the object Y minus the wall Y
							//a positive value indicates the object started below
							//the wall and was moving up when the collision occurred
							//so it has hit its top into the wall
							if (distY > 0){
								collisionSide = "TOPSIDE";
								//move the object down so it is no longer overlapping the wall
								v.y += overlapY;
							}else {
								collisionSide = "BOTTOMSIDE";
								//move the object up so it is no longer overlapping the wall
								v.y -= overlapY;
							}
						}else {
							//same logic as the Y axis collision
							if (distX > 0){
								collisionSide = "LEFTSIDE";
								//move the object to the right so it is no longer overlapping the wall
								v.x += overlapX;
							}else {
								collisionSide = "RIGHTSIDE";
								//move the object to the left so it is no longer overlapping the wall
								v.x -= overlapX;
							}
						}
					}else{
						collisionSide = "NONE";
					}
				}

			}
		}
	}
}


public void renderMap(){
	for (int i = 0; i<rows; i++){
		for (int j = 0; j<cols; j++){
			// noStroke();
			switch (tileMap[i][j]){
				case 0:
					fill(100,200,0);
					rect(j*cellWidth,i*cellHeight,64,64);
					break;
				case 1:
					fill(200,100,0);
					rect(j*cellWidth,i*cellHeight,64,64);
					break;
				default:
					println("You did not make the map right.");
			}
		}
	}
}


public void keyPressed(){
	switch (keyCode){
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
public void keyReleased(){
		switch (keyCode){
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

class Vehicle {
	float x,y,w,h;
	float speedX,speedY;

	Vehicle(){
		x=cellWidth*5;
		y=cellHeight*5;
		w=32;
		h=32;
		speedX=0;
		speedY=0;
	}
	public void update(){
		if (left&&!right){
			speedX =-4;
		}
		if (right&&!left){
			speedX =4;
		}
		if(!left&&!right) {
			speedX=0;
		}
		if (up&&!down){
			speedY =-4;
		}
		if (down&&!up){
			speedY =4;
		}
		if(!up&&!down) {
			speedY=0;
		}
		x+=speedX;
		y+=speedY;
	}
	public void display(){
		fill(255);
		rect(x,y,w,h);
	}
}




  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "maze" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
