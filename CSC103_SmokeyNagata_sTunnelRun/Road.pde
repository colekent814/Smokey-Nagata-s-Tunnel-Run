class Road {

  //////////////////////
  // Declaring Class Vars
  //////////////////////

  int startTime;
  int endTime;
  int interval = 200;

  int leftwallX;
  int rightwallX;
  int leftBorderX;
  int rightBorderX;
  int middleLeftX;
  int middleRightX;
  int x7;
  int x8;
  int x9;
  int y;
  int lineWidth;
  int wallWidth;
  int h;
  color lineColor;
  color wallColor;
  color middleLaneColor;

  //////////////////////
  // Constructor
  //////////////////////

  Road() {
    leftwallX = 30;
    rightwallX = width - 30;
    leftBorderX = 75;
    rightBorderX = width - 75;
    middleLeftX = (width/2) - 10;
    middleRightX = (width/2) + 10; 
    y = height / 2;
    lineWidth = 15;
    wallWidth = 60;
    h = height;
    lineColor = color(255);
    wallColor = color(42);
    middleLaneColor = color(200, 200, 100);
  }

  //////////////////////
  // Function definitions
  //////////////////////
  
  //draws road
  void render() {
    stroke(wallColor);
    fill(wallColor);
    rect(leftwallX, y, wallWidth, h);
    rect(rightwallX, y, wallWidth, h);
    stroke(lineColor);
    fill(lineColor);
    rect(leftBorderX, y, lineWidth, h);
    rect(rightBorderX, y, lineWidth, h);
    stroke(middleLaneColor);
    fill(middleLaneColor);
    rect(middleLeftX, y, lineWidth, h);
    rect(middleRightX, y, lineWidth, h);
    stroke(0);
  }
}
