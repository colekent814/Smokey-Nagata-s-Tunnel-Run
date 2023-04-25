class Player {

  //////////////////////
  // Declaring Class Vars
  //////////////////////
  
  //position
  int x;
  int y;
  float w;
  float h;
  
  //movement
  int xSpeed;
  int ySpeed;
  
  //hitbox
  float top;
  float bottom;
  float left;
  float right;
  int buffer = 20;
  float scale = 0.25;
  

  //////////////////////
  // Constructor
  //////////////////////

  Player(int tempX, int tempY, int speed, int handling) {
    x = tempX;
    y = tempY;
    w = playerCarImages[0].width*scale;
    h = playerCarImages[0].height*scale;
    
    for(int i = 0; i < 6; i++) {
    playerCarImages[i].resize(int(playerCarImages[i].width*scale),
                       int(playerCarImages[i].height*scale));
    }
                       
    xSpeed = handling;
    ySpeed = speed;
    
    top = y - h/2 + buffer;
    bottom = y + h/2 - buffer;
    left = x - w/2 + buffer;
    right = x + w/2 - buffer;
  }

  //////////////////////
  // Function definitions
  //////////////////////

  void render() {
    fill(0, 255, 0);
    image(playerCarImages[playerCarIndex], x, y);
    //rect(x,y,w,h);
  }
  
  //detects if player is touching the edge of the highway
  void wallDetect() {
    // wall detection for right wall
    if (left >= width) {
      crashSound.play();
      playerReset();
      state = 9;
    }
    // wall detection for left wall
    if (right <= 0) {
      crashSound.play();
      playerReset();
      state = 9;
    }
  }

  //player control using booleans
  void move() {
    if(isPlayerMovingLEFT == true) {
      x = x - xSpeed;
    }
    if(isPlayerMovingRIGHT == true) {
      x = x + xSpeed;
    }
    if(isPlayerMovingUP == true) {
      y = y - ySpeed;
    }
    if(isPlayerMovingDOWN == true) {
      y = y + ySpeed;
    }
    top = y - h/2 + buffer;
    bottom = y + h/2 - buffer;
    left = x - w/2 + buffer;
    right = x + w/2 - buffer;
  }
}
