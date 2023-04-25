class Enemy {

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

  Enemy(int tempX, int tempY, int speed, int handling) {
    x = tempX;
    y = tempY;
    w = enemyCarImages[enemyCarIndex].width*scale;
    h = enemyCarImages[enemyCarIndex].height*scale;
    
    
    for(int i = 0; i < 6; i++) {
    enemyCarImages[i].resize(int(enemyCarImages[i].width*scale),
                       int(enemyCarImages[i].height*scale));
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
  
  //draws enemy
  void render() {
      image(enemyCarImages[enemyCarIndex], x, y);
  }
  
  //detects if enemy is touching the edge of the highway
  void wallDetect() {
    // wall detection for right wall
    if (left >= width) {
      crashSound.play();
      playerReset();
      state = 8;
    }
    // wall detection for left wall
    if (right <= 0) {
      crashSound.play();
      playerReset();
      state = 8;
    }
  }
  
  //enemy control using booleans
  void move() {
    if(isEnemyMovingLEFT == true) {
      x = x - xSpeed;
    }
    if(isEnemyMovingRIGHT == true) {
      x = x + xSpeed;
    }
    if(isEnemyMovingUP == true) {
      y = y - ySpeed;
    }
    if(isEnemyMovingDOWN == true) {
      y = y + ySpeed;
    }
    top = y - h/2 + buffer;
    bottom = y + h/2 - buffer;
    left = x - w/2 + buffer;
    right = x + w/2 - buffer;
  }
}
