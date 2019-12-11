function Pickup(pickupType, locX, locY) {
    this.startLoc = createVector(locX, locY);
    this.x=this.startLoc.x;
    this.y= this.startLoc.y;
    this.w = 32;
    this.h = 32;

    if (pickupType == 0) {
      this.row = 0;
      this.scoreValue = 5;
    } else {
      this.row = 1;
      this.scoreValue = 20;
    }
    this.sx=0;
    this.sy=this.row * this.h;
    //0 = coin
    //1 = gem
    this.totalFrames=8;
    this.currentFrame= floor(random(this.totalFrames));

    this.delay = 4;
    this.hold = 0;

  this.update = function() {
  }

  this.display = function() {
    copy( objects,
      this.sx, this.sy, this.w, this.h,
      this.x, this.y, this.w, this.h);

    this.sx = this.currentFrame * this.w;

    this.hold = (this.hold + 1)%this.delay;
    if (this.hold == 0) {
      this.currentFrame++;
      if (this.currentFrame == this.totalFrames) {
        this.currentFrame=0;
      }
    }
  }

  this.hide = function(){
   this.y = 0;
  }
  this.reset = function() {
    this.x = this.startLoc.x;
    this.y = this.startLoc.y;
  }}
