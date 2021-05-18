class Block{
 float x,y,w,h;
 Block(float sx, float sy, float sw, float sh){
   x = sx;
   y = sy;
   w = sw;
   h = sh; 
 }
 void display(){
   fill(128);
   rect(x,y,w,h);
 }
}
