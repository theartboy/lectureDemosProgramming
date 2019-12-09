function Timer(timeInterval) {
  var startTime;
  var interval = timeInterval;

  this.start = function() {
    this.startTime = millis();
  }

  this.complete = function() {
    var elapsedTime = millis() - this.startTime;
    if (elapsedTime > this.interval) {
      return true;
    } else {
      return false;
    }
  }
}
