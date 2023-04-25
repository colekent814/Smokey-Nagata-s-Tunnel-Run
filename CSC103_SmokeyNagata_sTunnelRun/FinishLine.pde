class FinishLine {
  
  //////////////////////
  // Declaring Class Vars
  //////////////////////
  
  int x;
  int y;
  int w;
  int h;
  int ySpeed;
  color fillColor;

  //////////////////////
  // Constructor
  //////////////////////

  FinishLine() {
    x = width / 2;
    y = 0;
    w = width;
    h = 30;
    fillColor = color(255);
    ySpeed = 12;
  }
  
  //////////////////////
  // Function definitions
  //////////////////////
  
  //draws finish line
  void render() {
    fill(fillColor);
    rect(x, y, w, h);
  }
  
  //updates y pos
  void move() {
    y += ySpeed;
  }
  
  //wall detection for bottom wall
  void wallDetect() {
    if (y+h/2 <= 0) {
      y = 0;
      score = 0;
    }
  }
}
