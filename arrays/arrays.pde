int[] ints;
String[] strings;

void setup() {
  size(800,600);
  
  //set the total number of items in the array
  ints = new int[3];
  //populate the array
  //ints = [28, 104, 52];
  ints[0] = 28;
  ints[1] = 104;
  ints[2] = 52;
  
  println(ints[2]);//52
  ints[2] = 36;
  println(ints[2]);//36
  
  strings = new String[5];
  
  //use loop to populate
  for(int i = 0; i < 5; i++) {
    strings[i] = "string item is ";
  }
  
  strings[2] = "The third is now different";
  
  //print out the contents of my strings array
  for(int i = 0; i < 5; i++) {
    println(strings[i]);
  }

}

void draw(){
  
}
