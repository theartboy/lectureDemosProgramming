class Timer {
  //properties
  int startTime;
  int interval;

  //constructor
  Timer(int timeInterval) {
    interval = timeInterval;
  }
  //methods
  void start() {
    startTime = millis();
  }
  boolean complete(){
    int elapsedTime = millis() - startTime;
    if (elapsedTime > interval){
      return true;
    } else {
      return false;
    }
  }
}
