class Traffic { 
  /*
  Class variables
   */
   
  //position 
  int x;
  float y;
  float w;
  float h;
  color fillColor;
  int minTrafficSpawn;
  int maxTrafficSpawn;
  
  //movement
  float ySpeed;
  int tempSpeed;
  float minSpeed;
  float maxSpeed;
  
  //hitbox
  float top;
  float bottom;
  float left;
  float right;
  int buffer = 5;
  float scale = 1;
  
  float resetY;
  int imageIndex = (int) random(0, 5);

  /*
  Constructor
   */

  Traffic(int tempX, float min, float max, int least, int most) {
    int speedMag = tempSpeed;
    minSpeed = min;
    maxSpeed = max;
    

    ySpeed = random(minSpeed, maxSpeed);
    if (ySpeed == 0) {
      ySpeed = speedMag;
    }
    
    minTrafficSpawn = least;
    maxTrafficSpawn = most;

    top = y - h/2 + buffer;
    bottom = y + h/2 - buffer;
    left = x - w/2 + buffer;
    right = x + w/2 - buffer;
    x = tempX;
    y = random(minTrafficSpawn, maxTrafficSpawn);
    resetY = y;
    w = trafficImages[imageIndex].width;
    h = trafficImages[imageIndex].height;
    fillColor = color(255, 0, 0);
  }
  
  //draws traffic
  void render() {
    image(trafficImages[imageIndex], x, y);
  }
  
  //scrolls traffic down screen
  void move() {
    y += ySpeed;
    top = y - h/2 + buffer;
    bottom = y + h/2 - buffer;
    left = x - w/2 + buffer;
    right = x + w/2 - buffer;
  }
  
  //resets traffic when it touches the bottom
  void wallDetect() {
    // wall detection for bottom wall
    if (y-100 >= height) {
      //random traffic spawn point that helps breakup groups of cars
      y = random(minTrafficSpawn, maxTrafficSpawn);
      ySpeed = random(minSpeed, maxSpeed);
      imageIndex = (int) random(0, 5);
    }
  }
  
  void reset() {
    y = random(-2000, 100);
    ySpeed = random(minTrafficSpawn, maxTrafficSpawn );
    
  }
  
  
  //detects when traffic hits enemy and resets cars
  void collisionEnemy(Enemy enemy) {
    if (enemy.top < bottom) {
      if (enemy.bottom > top) {
        if (enemy.left < right) {
          if (enemy.right > left) { 
            levelUpSound.play();
            crashSound.play();
            playerReset();
            state = 8;
            if (enemy.y < y) {          
            } else if (enemy.y >= y) { 
            levelUpSound.play();
            crashSound.play();
            playerReset();
            state = 8;
            }
          }
        }
      }
    }
  }
  
  //detects when traffic hits player and resets cars
  void collisionPlayer(Player player) {
    if (player.top < bottom) {
      if (player.bottom > top) {
        if (player.left < right) {
          if (player.right > left) {  
            crashSound.play();
            playerReset();
            state = 9;
            if (player.y < y) {          
            } else if (player.y >= y) {
            crashSound.play();
            playerReset();
            state = 9;
            }
          }
        }
      }
    }
  }
}
