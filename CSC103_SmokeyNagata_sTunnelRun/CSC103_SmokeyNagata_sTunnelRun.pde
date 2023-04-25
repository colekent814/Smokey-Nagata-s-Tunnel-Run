/*
~~~~~~~~~~~~~~~~    SMOKEY NAGATA'S TUNNEL RUN   ~~~~~~~~~~~~~~~~~
 ~~~~~~~~~~~~~~~~        made by Cole Kent        ~~~~~~~~~~~~~~~~~
 */
 
 //HI CHRIS//
 //if you want to cheat here's how.  no matter what happens, just press X when it takes you to an end of level screen. that will take you to the next level
 
 
import processing.sound.*;

//classes
Enemy enemy;
Player player;
Road road;
FinishLine finish;
Animation crashAnimation;
Animation keysAnimation;
ArrayList <Lane> lane1;
ArrayList <Lane> lane2;
ArrayList <Lane> lane3;
ArrayList <Lane> lane4;
ArrayList <Traffic> trafficList;

//images
PImage[] playerCarImages = new PImage[6];
PImage [] enemyCarImages = new PImage[6];
PImage[] displayCarImages = new PImage[6];
int playerCarIndex = 0;
int enemyCarIndex = 1;
PImage[] trafficImages = new PImage[6];
PImage[] crashImages = new PImage[7];
PImage[] keysImages = new PImage[6];
PImage coverScreen;
PImage finalScreen;

//sounds
SoundFile crashSound;
SoundFile startSound;
SoundFile levelUpSound;
SoundFile backgroundMusic;
SoundFile level1Music;
SoundFile level2Music;
SoundFile level3Music;
SoundFile level4Music;
boolean soundPlaying = false;

//text
PFont mainTitle;
PFont subTitle;
PFont title;
PFont smallBody;
PFont body;
PFont prompts;
String carName = "void";
String prevCarName = "void";


//movement
boolean isEnemyMovingUP;
boolean isEnemyMovingDOWN;
boolean isEnemyMovingLEFT;
boolean isEnemyMovingRIGHT;
boolean isPlayerMovingUP;
boolean isPlayerMovingDOWN;
boolean isPlayerMovingLEFT;
boolean isPlayerMovingRIGHT;

//level
int laneWidth = 172;
int roadSpeed = 50;
float minTrafficSpeed = 7;
float maxTrafficSpeed = 10;
int minTrafficSpawn = -1500;
int maxTrafficSpawn = -200;
int state = 0;
int nextLevel= 1;
boolean playing = false;
boolean pToggle = false;


//millis
int startTimeLanes;
int endTimeLanes;
int intervalLanes = 150;
int startTimeScore;
int endTimeScore;
int intervalScore;
int score = 0;
int winScore = 1000;
int trafficStart = 50;


void setup() {
  //settings
  size(1200, 1000);
  rectMode(CENTER);
  imageMode(CENTER);

  //image lists
  for (int index=0; index<6; index++) {
    trafficImages[index] = loadImage("Ai" + index + ".png");
    trafficImages[index].resize(int(trafficImages[index].width*0.25), int(trafficImages[index].height*0.25));
  }

  for (int index=0; index<7; index++) {
    crashImages[index] = loadImage("crashScreen" + index + ".png");
  }

  for (int index=0; index<6; index++) {
    keysImages[index] = loadImage("keysAnimation" + index + ".png");
  }

  for (int index=0; index<6; index++) {
    playerCarImages[index] = loadImage("playerCar" + index + ".png");
  }

  for (int index=0; index<6; index++) {
    enemyCarImages[index] = loadImage("playerCar" + index + ".png");
  }

  for (int index=0; index<6; index++) {
    displayCarImages[index] = loadImage("playerCar" + index + "Side.png");
  }
  
  coverScreen = loadImage("coverImage.png");
  finalScreen = loadImage("finalScreenImage.png");
  finalScreen.resize(int(finalScreen.width*3.5),
                 int(finalScreen.height*3.5));
  
  //sounds
  crashSound = new SoundFile(this, "crashSound.mp3");
  startSound = new SoundFile(this, "startSound.wav");
  levelUpSound = new SoundFile(this, "levelUpSound.wav");
  backgroundMusic = new SoundFile(this, "Deserted Highway.mp3");
  level1Music = new SoundFile(this, "level1Music.mp3");
  level2Music = new SoundFile(this, "level2Music.mp3");
  level3Music = new SoundFile(this, "level3Music.mp3");
  level4Music = new SoundFile(this, "level4Music.mp3");

  //fonts
  mainTitle = createFont("osaka-re.ttf", 200);
  subTitle = createFont("INVASION2000.ttf", 100);
  title = createFont("osaka-re.ttf", 200);
  smallBody = createFont("INVASION2000.ttf", 40);
  body = createFont("INVASION2000.ttf", 50);
  prompts = createFont("INVASION2000.ttf", 65);

  //vars
  startTimeLanes = millis();
  startTimeScore = millis();
  crashAnimation = new Animation(crashImages, 0.15, 0.5);
  keysAnimation = new Animation(keysImages, 0.1, 0.9);
  enemy = new Enemy(610 + laneWidth + laneWidth/2, height - 100, 7, 7);
  player = new Player(75 + laneWidth + laneWidth/2, height - 100, 7, 7);
  road = new Road();
  finish = new FinishLine();
  isEnemyMovingUP = false;
  isEnemyMovingDOWN = false;
  isEnemyMovingLEFT = false;
  isEnemyMovingRIGHT = false;
  isPlayerMovingUP = false;
  isPlayerMovingDOWN = false;
  isPlayerMovingLEFT = false;
  isPlayerMovingRIGHT = false;
  lane1 = new ArrayList<Lane>();
  lane2 = new ArrayList<Lane>();
  lane3 = new ArrayList<Lane>();
  lane4 = new ArrayList<Lane>();
  trafficList = new ArrayList<Traffic>();
}

//variables that change per level:
//player speed, player handling, traffic speed, traffic spawn rate
void draw() {
  background(42);
  switch(state) {
  case 0:
  if (backgroundMusic.isPlaying() == false){
    backgroundMusic.play();
  }
    startScreen();
    break;
  case 1:
    //level 1
    backgroundMusic.stop();
    level2Music.stop();
  if (level1Music.isPlaying() == false){
    level1Music.play();
  }
    //level specific values
    playerCarIndex = 0;
    enemyCarIndex = 1;
    enemy.xSpeed = 10;
    enemy.ySpeed = 10;
    player.xSpeed = 10;
    player.ySpeed = 10;

    if (playing == false) {
      createTraffic(10, 12, -2000, -100);
      playing = true;
    }

    roadSpeed = 50;
    intervalLanes = 150;
    //
    game();
    break;
  case 2:
    //level 2
    level1Music.stop();
    level3Music.stop();
  if (level2Music.isPlaying() == false){
    level2Music.play();
  }
    //level specific values
    playerCarIndex = 1;
    enemyCarIndex = 2;
    enemy.xSpeed = 11;
    enemy.ySpeed = 12;
    player.xSpeed = 11;
    player.ySpeed = 12;

    if (playing == false) {
      createTraffic(12, 15, -1700, -100);
      playing = true;
    }

    roadSpeed = 60;
    intervalLanes = 140;
    //
    game();
    break;
  case 3:
    //level 3
    level2Music.stop();
    level4Music.stop();
  if (level3Music.isPlaying() == false){
    level3Music.play();
  }
    //level specific values
    playerCarIndex = 2;
    enemyCarIndex = 3;
    enemy.xSpeed = 12;
    enemy.ySpeed = 15;
    player.xSpeed = 12;
    player.ySpeed = 15;

    if (playing == false) {
      createTraffic(15, 18, -1500, -100);
      playing = true;
    }

    roadSpeed = 70;
    intervalLanes = 130;
    //
    game();
    break;
  case 4:
    //level 4
    level3Music.stop();
    backgroundMusic.stop();
  if (level4Music.isPlaying() == false){
    level4Music.play();
  }
    //level specific values
    playerCarIndex = 3;
    enemyCarIndex = 4;
    enemy.xSpeed = 13;
    enemy.ySpeed = 17;
    player.xSpeed = 13;
    player.ySpeed = 17;

    if (playing == false) {
      createTraffic(18, 22, -1200, -100);
      playing = true;
    }

    roadSpeed = 80;
    intervalLanes = 120;
    //
    game();
    break;
  case 5:
    //level 5
    level4Music.stop();
  if (backgroundMusic.isPlaying() == false){
    backgroundMusic.play();
  }
    //level specific values
    playerCarIndex = 4;
    enemyCarIndex = 5;
    enemy.xSpeed = 15;
    enemy.ySpeed = 20;
    player.xSpeed = 15;
    player.ySpeed = 20;

    if (playing == false) {
      createTraffic(22, 26, -1000, -100);
      playing = true;
    }

    roadSpeed = 90;
    intervalLanes = 110;
    //
    game();
    break;
    case 6:
    finalWinScreen();
      break;
  case 7:
    Enemywin();
    EnemyWinScreen();
    break;
  case 8:
    Playerwin();
    PlayerWinScreen();
    break;
  case 9:
    crashScreen();
    break;
  case 10:
    tutorialScreen();
    break;
  }
}

void keyPressed() {
  if (key == 'k') {
    isEnemyMovingLEFT = true;
  }
  if (key == ';') {
    isEnemyMovingRIGHT = true;
  }
  if (key == 'o') {
    isEnemyMovingUP = true;
  }
  if (key == 'l') {
    isEnemyMovingDOWN = true;
  }
  if (key == 'a') {
    isPlayerMovingLEFT = true;
  }
  if (key == 'd') {
    isPlayerMovingRIGHT = true;
  }
  if (key == 'w') {
    isPlayerMovingUP = true;
  }
  if (key == 's') {
    isPlayerMovingDOWN = true;
  }
  if (key == 'x') {
    startSound.play();
    updateLevel();
  }
  if (key == ' ') {
    startSound.play();
    prevLevel();
  }
  if (key == 'p') {
    pToggle = !pToggle;
    if (pToggle == true) {
    state = 10;
    }
    else {
    state = 0;
    }
  }
}

void keyReleased() {
  if (key == 'k') {
    isEnemyMovingLEFT = false;
  }
  if (key == ';') {
    isEnemyMovingRIGHT = false;
  }
  if (key == 'o') {
    isEnemyMovingUP = false;
  }
  if (key == 'l') {
    isEnemyMovingDOWN = false;
  }
  if (key == 'a') {
    isPlayerMovingLEFT = false;
  }
  if (key == 'd') {
    isPlayerMovingRIGHT = false;
  }
  if (key == 'w') {
    isPlayerMovingUP = false;
  }
  if (key == 's') {
    isPlayerMovingDOWN = false;
  }
}

void game() {
  //backgroundMusic.stop();
  endTimeLanes = millis();
  endTimeScore = millis();
  background(162, 156, 142);
  road.render();
  drawLanes();
  enemy.render();
  enemy.move();
  enemy.wallDetect();
  player.render();
  player.move();
  player.wallDetect();
  changeCarName();
  if (score > trafficStart) {
    drawTraffic();
  }
  if (endTimeScore - startTimeScore > intervalScore) {
    score = score + 1;
    startTimeScore = millis();
  }
  if (score > winScore) {
    finish.render();
    finish.move();
    finish.wallDetect();
    Enemywin();
    Playerwin();
  }
}

//draws scrolling lanes with a millis timer
void drawLanes() {
  if (endTimeLanes - startTimeLanes > intervalLanes) {
    lane1.add(new Lane(75 + laneWidth, roadSpeed));
    lane2.add(new Lane(75 + laneWidth*2, roadSpeed));
    lane3.add(new Lane(610 + laneWidth, roadSpeed));
    lane4.add(new Lane(610 + laneWidth*2, roadSpeed));
    startTimeLanes = millis();
  }
  for (Lane aLane : lane1) {
    aLane.render();
    aLane.move();
    aLane.wallDetect();
  }
  for (Lane aLane : lane2) {
    aLane.render();
    aLane.move();
    aLane.wallDetect();
  }
  for (Lane aLane : lane3) {
    aLane.render();
    aLane.move();
    aLane.wallDetect();
  }
  for (Lane aLane : lane4) {
    aLane.render();
    aLane.move();
    aLane.wallDetect();
  }
}

void createTraffic(float minSpeed, float maxSpeed, int minSpawn, int maxSpawn) {
  trafficList.clear();
  minTrafficSpeed = minSpeed;
  maxTrafficSpeed = maxSpeed;
  minTrafficSpawn = minSpawn;
  maxTrafficSpawn = maxSpawn;

  trafficList.add(new Traffic(75 + laneWidth/2, minTrafficSpeed, maxTrafficSpeed, minTrafficSpawn, maxTrafficSpawn));
  trafficList.add(new Traffic(75 + laneWidth + laneWidth/2, minTrafficSpeed, maxTrafficSpeed, minTrafficSpawn, maxTrafficSpawn));
  trafficList.add(new Traffic(75 + laneWidth*2 + laneWidth/2, minTrafficSpeed, maxTrafficSpeed, minTrafficSpawn, maxTrafficSpawn));
  trafficList.add(new Traffic(610 + laneWidth/2, minTrafficSpeed, maxTrafficSpeed, minTrafficSpawn, maxTrafficSpawn));
  trafficList.add(new Traffic(610 + laneWidth + laneWidth/2, minTrafficSpeed, maxTrafficSpeed, minTrafficSpawn, maxTrafficSpawn));
  trafficList.add(new Traffic(610 + laneWidth*2 + laneWidth/2, minTrafficSpeed, maxTrafficSpeed, minTrafficSpawn, maxTrafficSpawn));
}

//fills traffic array
void drawTraffic() {
  for (Traffic aTraffic : trafficList) {
    aTraffic.render();
    aTraffic.move();
    aTraffic.wallDetect();
    aTraffic.collisionEnemy(enemy);
    aTraffic.collisionPlayer(player);
  }
}

//detects if the players have crossed the finish line
void Enemywin() {
  if (enemy.y <= finish.y) {
    playerReset();
    state = 7;
  }
}

void Playerwin() {
  if (player.y <= finish.y) {
    levelUpSound.play();
    playerReset();
    state = 8;
  }
}

void startScreen() {
  image(coverScreen, width / 2, height / 2);
  
  textAlign(CENTER);
  fill(160, 0, 0);
  textFont(mainTitle);
  text("Smokey", width / 2, height / 6);
  text("Nagata's", width / 2, height / 6 + 150);
  fill(255);
  textFont(subTitle);
  text("TUNNEL RUN", width / 2, height / 6 + 250);
  textFont(body);
  fill(255);
  text("press P for tutorial", width / 2, height - height/12 - 100);
  textFont(prompts);
  fill(160, 0, 0);
  text("press X to play", width / 2, height - height/12);
}

void EnemyWinScreen() {
  score = 0;
  background(0);
  keysAnimation.isAnimating = true;
  keysAnimation.display(width / 2, height / 4 + 125);
  fill(160, 0, 0);
  textAlign(CENTER);
  textFont(title);
  text("You Lose", width / 2, (height / 4) - 50);
  fill(255);
  textFont(body);
  text("Smokey has taken your", width / 2, (height/3) - 50);
  textFont(prompts);
  text(prevCarName + ".", width / 2, (height / 3) + 20);
  fill(160, 0, 0);
  textFont(prompts);
  text("press space to win it back.", width / 2, height - height/12);
  for (Traffic aTraffic : trafficList) {
    aTraffic.reset();
  }
  for (Traffic aTraffic : trafficList) {
    aTraffic.reset();
  }
}

void PlayerWinScreen() {
  score = 0;
  background(0);
  fill(160, 0, 0);
  textAlign(CENTER);
  textFont(title);
  text("You win", width / 2, (height / 4) - 50);
  fill(255);
  textFont(body);
  text("You have taken Smokey's", width / 2, (height/3) - 50);
  textFont(prompts);
  text(carName + ".", width / 2, (height / 3) + 20);
  fill(160, 0, 0);
  text("press X to proceed.", width / 2, height - height/12);
  image(displayCarImages[nextLevel - 1], width / 2, height / 2 + 100);
  for (Traffic aTraffic : trafficList) {
    aTraffic.reset();
  }
}

void crashScreen() {
  score = 0;
  background(0);
  crashAnimation.isAnimating = true;
  crashAnimation.display(width / 2 - 35, height / 2 + 50);
  fill(160, 0, 0);
  textAlign(CENTER);
  textFont(title);
  text("You", width / 2, (height / 4) - 100);
  text("crashed", width / 2, (height / 4) + 50);
  fill(255);
  textFont(smallBody);
  text("Your " + prevCarName + " has been destroyed.", width / 2, (height - height/ 5) + 30);
  fill(160, 0, 0);
  textFont(prompts);
  text("press space to win it back.", width / 2, height - height/12);
  for (Traffic aTraffic : trafficList) {
    aTraffic.reset();
  }
}

void finalWinScreen() {
  image(finalScreen, width / 2, height / 2);
  score = 0;
  fill(160, 0, 0);
  textAlign(CENTER);
  textFont(title);
  text("Well done.", width / 2, (height / 4) - 50);
  fill(255);
  textFont(smallBody);
  text("You've beaten Smokey Nagata at his ", width / 2, (height / 2) - 90);
  text("own game!  You are now the fastest", width / 2, (height / 2) - 20);
  text("street racer in all of Japan. Adults", width / 2, (height / 2) + 50);
  text("and children alike know your name.", width / 2, (height / 2) + 120);
  text("But it's lonely at the top...", width / 2, (height / 2) + 190);
  fill(160, 0, 0);
  text("X to play again?", width / 2, height - height/12);
  for (Traffic aTraffic : trafficList) {
    aTraffic.reset();
  }
}

void tutorialScreen() {
  background(0);
  score = 0;
  fill(160, 0, 0);
  textAlign(CENTER);
  textFont(title);
  text("How to", width / 2, (height / 4) - 75);
  text("Play", width / 2, (height / 4) + 75 );
  fill(255);
  textFont(smallBody);
  text("This is a two player game. One player (left),", width / 2, (height / 2) - 90);
  text("controls the main player with the WASD keys. The", width / 2, (height / 2) - 20);
  text("other player (right) controls Smokey Nagata, the", width / 2, (height / 2) + 50);
  text("opponent, with the O, K, L, and ; keys.  Avoid the", width / 2, (height / 2) + 120);
  text("traffic and beat the other player to the finish line!", width / 2, (height / 2) + 190);
  fill(160, 0, 0);
  textFont(prompts);
  text("press P to return", width / 2, height - height/12);
  
}

void updateLevel() {
  if (playing == false) {
    if (nextLevel == 7) {
      state = 0;
      nextLevel = 1;
    } else {
      state = nextLevel;
      nextLevel++;
    }
  }
}

void prevLevel() {
  println(nextLevel);
  if (playing == false) {
    if (nextLevel == 2) {
      state = 1;
      nextLevel = 2;
    } else {
      state = nextLevel - 2;
      nextLevel--;
    }
  }
}

void playerReset() {
  score = 0;
  enemy.y = height - 100;
  enemy.x = 610 + laneWidth + laneWidth/2;
  player.y = height - 100;
  player.x = 75 + laneWidth + laneWidth/2;
  finish.y = 0;
  playing = false;
}

void changeCarName () {
  if (state == 1) {
    carName = "Mazda RX-7";
    prevCarName = "Datsun 280Z";
  } else if (state == 2) {
    carName = "Mitsubishi Evo VI";
    prevCarName = "Mazda RX-7";
  } else if (state == 3) {
    carName = "Nissan GT-R";
    prevCarName = "Mitsubishi Evo VI";
  } else if (state == 4) {
    carName = "Porsche 911 Turbo";
    prevCarName = "Nissan GT-R";
  } else if (state == 5) {
    carName = "Toyota Supra";
    prevCarName = "Porsche 911 Turbo";
  }
}
