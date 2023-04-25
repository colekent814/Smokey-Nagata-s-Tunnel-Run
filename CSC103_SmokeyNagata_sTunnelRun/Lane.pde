class Lane { 
  
  //////////////////////
  // Declaring Class Vars
  //////////////////////
  int x;
  int y;
  int w;
  int h;
  color fillColor;

  int ySpeed;

  //////////////////////
  // Constructor
  //////////////////////
 Lane(int tempX, int tempSpeed) {

    ySpeed = tempSpeed;

    x = tempX;
    y = 0;
    w = 10;
    h = 100;
    fillColor = color(255);
  }
  
  //////////////////////
  // Function definitions
  //////////////////////
  
  //draws a single lane marker
  void render() {
    fill(fillColor);
    stroke(255);
    rect(x, y, w, h);
  }
  
  //makes a single lane marker scroll
  void move() {
    y += ySpeed;
  }
  
  //resets the lane marker when it touches the bottom
  void wallDetect() {
    // wall detection for bottom wall
    if (y+h/2 <= 0) {
      y = 0;
    }
  } 
}
