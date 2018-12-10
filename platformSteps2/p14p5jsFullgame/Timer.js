function Timer(timeInterval) {
    this.interval = timeInterval;
    this.startTime = millis();

  this.start = function() {
    this.startTime = millis();
  }

  this.complete = function() {
    var elapsedTime = millis() - this.startTime;
    if (elapsedTime > this.interval) {
      return true;
    }else {
      return false;
    }
  }
}
