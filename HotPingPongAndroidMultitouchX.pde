//import processing.sound.*;
import cassette.audiofiles.*;


// Este es el Mero Mero

//import peasy.*;
//import ddf.minim.*;

//PeasyCam cam;
//Minim minim;

SoundFile ping, pong, dingL, dingR, startDing;
SoundFile padL, padR, rightBounce, leftBounce;

Timer timer;

Ball ball;
Paddle left;
Paddle right;
Paddle aiLpad;
Paddle aiRpad;
boolean aiLbool = false;
boolean aiRbool = false;
boolean mouseRMove = true;
boolean mouseLMove = true;
boolean fire = false;
boolean tittle = true;
boolean[] keys = new boolean[12];
boolean standBy = true;
boolean viewSwitchA = true;
boolean viewSwitchB = false;
//boolean catchUpMas = false;
//boolean catchUpMenos = false;
boolean winnerBool = false;
boolean gotPoint = true;
boolean xMoveBool = true;
int leftScore, rightScore, aiLscore, aiRscore;
float W;
float H;
float xRotate = PI*0.16;
float yRotate = 0;
float zRotate = 0;
float xTranslate = 0;
float yTranslate = 0;
float zTranslate = 0;
float smallZrotate = PI/2;
float aiYspeedL;
float aiIncL = 0;
float aiYspeedR;
float iniXSpeed;
float iniYSpeed;
float iniPadSpeed;
float aiIncR = 0;
int level = 1;
int error = 5;
int constant = 20;
float moveLeft = H*0.5;
float moveRight = H*0.5;
float moveRightX;
float moveLeftX;
float mouseInc = H*0.5;
float padLInc = H*0.5;
float padRInc = H*0.5;
float randomIncL = 0.5;
float randomIncR = 0.5;
PImage floor;

//ParticleSystem ps;
//ChispaSystem cs;
//ParticleSystem ps1;
//Particle p1;
//PVector colLeft,colRight,colLai,colRai;


//int a, b, c, d;

void setup() {

  orientation(LANDSCAPE);
  size(displayWidth,displayHeight,P3D);

//  size(1600, 900, P3D);

W = width;
H = W*0.5;
//println(H);
yTranslate = height*0.5;
xTranslate = width*0.5;
zTranslate = -width*0.2;
floor = loadImage("WoodFloor1.jpg");
floor.resize(width,height);
  iniXSpeed = W*0.012;
  iniYSpeed = 0;
  iniPadSpeed = H*0.00938;
  aiYspeedL = H*0.5;
  aiYspeedR = H*0.5;
//println(iniPadSpeed);
  //zTranslate = width*0.1;
  for (int i = 0; i<4; i++) {
    keys[i] = false;
  }
  //cam = new PeasyCam(this, 520);
  //ps = new ParticleSystem();
  //cs = new ChispaSystem();
  // ps1 = new ParticleSystem();
  timer = new Timer(3);
  //minim = new Minim(this);
  ball = new Ball(W, H);
  left = new Paddle(true, W, H);
  right = new Paddle(false, W, H);
  aiLpad = new Paddle(true, W, H);
  aiRpad = new Paddle(false, W, H);
moveRightX = W-right.w*2;
moveLeftX = left.w*2;
  //ping = minim.loadFile("BallUp.mp3");
  //pong = minim.loadFile("BallDown.mp3");
  //padL = minim.loadFile("PaddleLeft.mp3");
  //padR = minim.loadFile("PaddleRight.mp3");
  //dingL = minim.loadFile("DingLeft.mp3");
  //dingR = minim.loadFile("DingRight.mp3");
  //leftBounce = minim.loadFile("leftBouncing.mp3");
  //rightBounce = minim.loadFile("rightBouncing.mp3");
  //startDing = minim.loadFile("StartDing.mp3");
  //startDing.setGain(-10);

  ping = new SoundFile(this, "BallUp.mp3");
  pong = new SoundFile(this, "BallDown.mp3");
  padL = new SoundFile(this, "PaddleLeft.mp3");
  padR = new SoundFile(this, "PaddleRight.mp3");
  dingL = new SoundFile(this, "DingLeft.mp3");
  dingR = new SoundFile(this, "DingRight.mp3");
  leftBounce = new SoundFile(this, "leftBouncing.mp3");
  rightBounce = new SoundFile(this, "rightBouncing.mp3");
  startDing = new SoundFile(this, "StartDing.mp3");
  //startDing.amp(-0.5);
}

void draw() {
  background(floor);//#221503);//#551B04
  textAlign(CENTER, CENTER);
  lights();
  //pushMatrix();
  //translate(0, 0, 0);
  //  if (tittle) {
  //textSize(18);
  //fill(200);
  //text("Press 'SPACE' for left serve or 'ENTER'for right serve at any time during standby. 'r' for standby and 'R' to standbu and reset score", width/2, height/35);
  //text("'.' or '>' rotates the table forward - ',' or '<' rotates it backward - 'z' or 'Z' zoom in - 'x' or 'X' zoom out", width/2, height/14);
  //text("Press shift + 1-3 for 3 levels of AI response - 'F1,F2,F3,F4' for players choice", width/2, height/9);
  ////text("( 0 - 2 )",width/1.8,height/8);
  ////fill(255);
  //} else {
//multiTouch();
if (winnerBool) {
  winner();
}
    
    textAlign(CENTER, CENTER);
  textSize(height*0.036);
  //textAlign(CENTER);
  switch (level) {
  case 4:
    fill(255, 0, 0);
    text("AI Level = Extreme", width*0.5, height*0.04);
    break;
  case 3:
    fill(255, 200, 0);
    text("AI Level = High", width*0.5, height*0.04);
    break;
  case 2:
    fill(0, 255, 0);
    text("AI Level = Medium", width*0.5, height*0.04);
    break;
  case 1:
    fill(0, 255, 255);
    text("AI Level = Low", width*0.5, height*0.04);
    break;
  }
  //  }

  if (aiLbool) {
    textSize(height*0.096);
    fill(0, 255, 50);
    text(leftScore, width*0.125, height*0.07);
    textSize(height*0.036);
    //fill(255);
    text("Human", width*0.125, height*0.02);
  } else 
  {
    textSize(height*0.096);
    fill(50, 200, 255);
    text(aiLscore, width*0.125, height*0.07);
    textSize(height*0.036);
    text("AI", width*0.125, height*0.02);
  }    

  if (aiRbool) {
    textSize(height*0.096);
    fill(255, 100, 50);
    text(rightScore, width*0.875, height*0.07);
    textSize(height*0.036);
    text("Human", width*0.875, height*0.02);
  } else 
  {
    textSize(height*0.096);
    fill(255, 0, 255);
    text(aiRscore, width*0.875, height*0.07);
    textSize(height*0.036);
    text("AI", width*0.875, height*0.02);
  }
  //popMatrix();

  //********* serve buttons
  
  strokeWeight(1);
  if (standBy) {
    fill(0, 120, 150);
    rectMode(CENTER);
    rect(width*0.25, height*0.98, width*0.07, height*0.04);
    rect(width*0.75, height*0.98, width*0.07, height*0.04);
    //ellipse(width*0.25, height*0.987, width*0.07, height*0.03);
    //ellipse(width*0.75, height*0.987, width*0.07, height*0.03);
    fill(255, 255, 0);
    textAlign(CENTER, CENTER);
    textSize(height*0.030);
    text("Serve L", width*0.25, height*0.977);
    text("Serve R", width*0.75, height*0.977);
    myPlayButtonD(width*0.46,height*0.977,height*0.02);
    text("ZOOM", width*0.5, height*0.977);
    myPlayButtonC(width*0.54,height*0.977,height*0.02);

    myPlayButtonA(width*0.01,height*0.47,height*0.02);
    text("Z", width*0.01, height*0.5);
    myPlayButtonB(width*0.01,height*0.53,height*0.02);

    myPlayButtonC(width*0.53,height*0.15,height*0.02);
    text("Y",  width*0.5, height*0.15);
    myPlayButtonD(width*0.47,height*0.15,height*0.02);

    //text("X", width*0.5, height*0.5);

    myPlayButtonA(width*0.98,height*0.47,height*0.02);
    text("Level",   width*0.98, height*0.5);
    myPlayButtonB(width*0.98,height*0.53,height*0.02);
  } else
  {
    fill(0, 120, 150);
    ellipseMode(CENTER);
    stroke(255);
    ellipse(width*0.375, height*0.04, width*0.07, height*0.05);
    ellipse(width*0.625, height*0.04, width*0.07, height*0.05);
    fill(255);
    textAlign(CENTER, CENTER);
    text("Reset", width*0.375, height*0.037);
    text("Pause", width*0.625, height*0.037);
  }

  fill(150);
  text("X = "+nf(xRotate, 0, 2), width*0.03, height*0.02);
  text("Y = "+nf(yRotate, 0, 2), width*0.97, height*0.02);
  text("Z = "+nf(zRotate, 0, 2), width*0.03, height*0.977);
  text("ZOOM = "+nf(zTranslate, 0, 2), width*0.95, height*0.977);
  text("X pan = "+nf(xTranslate, 0, 2), width*0.04, height*0.04);
  text("Y Level = "+nf(yTranslate, 0, 2), width*0.5, height*0.01);
  if (xMoveBool) {
  fill(255,0,0);
  rect(width*0.25, height*0.05, width*0.06, height*0.03);
  fill(255);
  text("X ON", width*0.25, height*0.05);
  } else
  {
  fill(0, 120, 150);
  rect(width*0.25, height*0.05, width*0.06, height*0.03);
  fill(255);
  text("X OFF", width*0.25, height*0.05);
  }
  textSize(height*0.032);
  text("View", width*0.75, height*0.05);
  textAlign(CENTER,CENTER);

  //fill(0, 120, 150);
  //ellipse(width*0.98,height*0.25,width*0.038,height*0.035);
  //fill(255);
  //if (!mouseRMove) {
  //text("Mouse",width*0.98,height*0.247);
  //} else
  //text("Keys",width*0.98,height*0.247);
                                                            // ****** smal table icon
  pushMatrix();
  translate(width*0.75, height*0.05, 0);
  //rotateX(xRotate);
  rotateZ(smallZrotate);
  //rotateY(yRotate);
  strokeWeight(1);
  stroke(255);
  fill(0, 200, 240, 50);
  rectMode(CENTER);
  rect(0, 0, W*0.05, H*0.05);
  fill(255);
  popMatrix();
                                                                        //**** big table
//pushMatrix();
  translate(xTranslate, yTranslate, zTranslate);
  rotateX(xRotate);
  rotateZ(zRotate);
  rotateY(yRotate);
  strokeWeight(9);
  stroke(150);
  fill(0, 50,50,150);
  rectMode(CENTER);
  rect(0, 0, W, H);
//popMatrix();
//pushMatrix();
  translate(-W*0.5, -H*0.5, 0);
  stroke(255,100);
  strokeWeight(3);
  line(0, H/2, W, H/2);
  //ellipse(W/2, H/2, 40, 40);
  stroke(255,25);
  line(W/2, 0, W/2, H);
//popMatrix();
  if (aiLbool && aiRbool) {
    if (mouseLMove) {
      left.move(moveLeft);
      left.moveX(moveLeftX);
    } else 
    {
      if (keys[0]) {
        if (padLInc > 0) padLInc -= 9;
        left.move(padLInc);
      } else if (keys[1]) {
        if (padLInc < H) padLInc += 9;
        left.move(padLInc);
      }
    }
  } else 
  if (aiLbool && !aiRbool) {
    if (mouseLMove) {
      left.move(moveLeft);
      left.moveX(moveLeftX);
    } else 
    {
      if (keys[0] || keys[2]) {
        if (padLInc > 0) padLInc -= 9;
        left.move(padLInc);
      } else if (keys[1] || keys[3]) {
        if (padLInc < H) padLInc += 9;
        left.move(padLInc);
      }
    }
  } else {
    aiLpad.move(moveLeftAI());
  }
  // right pad
  if (aiRbool && aiLbool) {
    if (mouseRMove) {
      right.move(moveRight);
      right.moveX(moveRightX);
    } else 
    {
      if (keys[2]) {
        if (padRInc > 0) padRInc -= 9;
        right.move(padRInc);
      } else if (keys[3]) {
        if (padRInc < H) padRInc += 9;
        right.move(padRInc);
      }
    }
  } else 
  if (aiRbool && !aiLbool) {
    if (mouseRMove) {
      right.move(moveRight);
      right.moveX(moveRightX);
    } else 
    {
      if (keys[2] || keys[0]) {
        if (padRInc > 0) padRInc -= 9;
        right.move(padRInc);
      } else if (keys[3] || keys[1]) {
        if (padRInc < H) padRInc += 9;
        right.move(padRInc);
      }
    }
  } else {
    aiRpad.move(moveRightAI());
  }


  if (aiLbool) {
    fill(0, 255, 50);
    left.show();
  } else {
    fill(50, 170, 255);
    aiLpad.show();
  }

  if (aiRbool) {
    fill(255, 60, 60);
    right.show();
  } else {
    fill(255, 0, 255);
    aiRpad.show();
  }

  if (aiLbool) {
    ball.hitPaddleLeft();
  } else
  {
    ball.hitLeftPaddleAI();
  }

  if (aiRbool) {
    ball.hitPaddleRight();
  } else
  {
    ball.hitRightPaddleAI();
  }

  if (keys[4]) {
    zTranslate += 1;
  } else if (keys[5]) {
    zTranslate -= 1;
  }

  if (keys[6]) {
    xRotate += 0.005;
  } else if (keys[7]) {
    xRotate -= 0.005;
  }

  if (keys[8]) {
    yRotate += 0.005;
  } else if (keys[9]) {
    yRotate -= 0.005;
  }

  if (keys[10]) {
    zRotate -= 0.005;
  } else if (keys[11]) {
    zRotate += 0.005;
  }

if (!winnerBool) {
if (aiRscore == 15 || aiLscore == 15 || rightScore == 15 || leftScore == 15) {
  winnerBool = true;
    standBy = true;
    ball.x = W/2;
    ball.y = H/2;
    ball.yspeed = H/50;
    ball.xspeed = 0;
    aiLpad.y = H/2;
    aiRpad.y = H/2;
    aiIncL = 0;
    aiIncR = 0;
}
}
  //}

  ball.edges();
  ball.update();
  ball.show();
  //popMatrix();


}

void mousePressed() {
  if ( mouseX > width*0.22 && mouseX < width*0.28 && mouseY < height*0.09) {
    xMoveBool =!xMoveBool;
  }
  
  if (winnerBool) {
  if (mouseX > width*0.4 && mouseX < width*0.6 && mouseY > height*0.55 && mouseY < height*0.65) { // Play Again
    gotPoint = true;
    winnerBool = false;
    standBy = true;
    leftScore = 0;
    rightScore = 0;
    aiLscore = 0;
    aiRscore = 0;
    ball.x = W/2;
    ball.y = H/2;
    ball.yspeed = H/50;
    ball.xspeed = 0;
    aiLpad.y = H/2;
    aiRpad.y = H/2;
    aiIncL = 0;
    aiIncR = 0;
    aiIncR = 0;
    if (!viewSwitchA && viewSwitchB) {
      xRotate = 1.21;
        xTranslate = width*0.5;
      yRotate = 0.26;
      yTranslate = height*0.15;
      zRotate = 1.57;
      zTranslate = -width*0.169;
      smallZrotate = 0;
} else
      if (viewSwitchA && viewSwitchB) {
        xRotate = 0;
        xTranslate = width*0.5;
        yRotate = 0;
      yTranslate = height*0.5;
        zRotate = 0;
        zTranslate = -width*0.2;
        smallZrotate = 1.57;
      }else
      if (!viewSwitchA && !viewSwitchB) {
        xRotate = 0;
        xTranslate = width*0.35;
        yRotate = 100.21;
      yTranslate = height*0.5;
        zRotate = 0;
        zTranslate = -width*0.1;
        smallZrotate = 1.57;
      }else
      if (viewSwitchA && !viewSwitchB) {
        xRotate = 0.5;
        xTranslate = width*0.5;
        yRotate = 0;
      yTranslate = height*0.48;
        zRotate = 0;
        zTranslate = -width*.2;
        smallZrotate = 1.57;
      }
  }
  }

  if (mouseX > width*0.72 && mouseX < width*0.78 && mouseY < height *0.09 && mouseY > height*0) { // changes views
    if (viewSwitchA && !viewSwitchB) {
      xRotate = 1.21;
        xTranslate = width*0.5;
      yRotate = 0.26;
      yTranslate = height*0.15;
      zRotate = 1.57;
      zTranslate = -width*0.169;
      smallZrotate = 0;
    viewSwitchA = false;
    viewSwitchB = true;
} else
      if (!viewSwitchA && viewSwitchB) {
        xRotate = 0;
        xTranslate = width*0.5;
        yRotate = 0;
      yTranslate = height*0.5;
        zRotate = 0;
        zTranslate = -width*0.2;
        smallZrotate = 1.57;
    viewSwitchA = true;
    viewSwitchB = true;
      }else
      if (viewSwitchA && viewSwitchB) {
        xRotate = 0;
        xTranslate = width*0.35;
        yRotate = 100.21;
      yTranslate = height*0.5;
        zRotate = 0;
        zTranslate = -width*0.1;
        smallZrotate = 1.57;
    viewSwitchA = false;
    viewSwitchB = false;
      }else
      if (!viewSwitchA && !viewSwitchB) {
        xRotate = 0.5;
        xTranslate = width*0.5;
        yRotate = 0;
      yTranslate = height*0.48;
        zRotate = 0;
        zTranslate = -width*.2;
        smallZrotate = 1.57;
    viewSwitchA = true;
    viewSwitchB = false;
      }

}


if (!standBy && !winnerBool) {
  if (mouseX > width*0.59 && mouseX < width*0.66 && mouseY < height*0.09) { // Standby
    standBy = true;
    ball.x = W/2;
    ball.y = H/2;
    ball.yspeed = H/50;
    ball.xspeed = 0;
    aiLpad.y = H/2;
    aiRpad.y = H/2;
    aiIncL = 0;
    aiIncR = 0;
  }

  if (mouseX > width*0.34 && mouseX < width*0.41 && mouseY < height*0.09) { // Reset
    standBy = true;
    leftScore = 0;
    rightScore = 0;
    aiLscore = 0;
    aiRscore = 0;
    ball.x = W/2;
    ball.y = H/2;
    ball.yspeed = H/50;
    ball.xspeed = 0;
    aiLpad.y = H/2;
    aiRpad.y = H/2;
    aiIncL = 0;
    aiIncR = 0;
  }
}

  if (mouseX > width*0.09 && mouseX < width*0.16 && mouseY < height*0.095) {
    aiLbool = !aiLbool;
  }   
  if (mouseX > width*0.84 && mouseX < width*0.91 && mouseY < height*0.09) {
    aiRbool = !aiRbool;
  }

  if (mouseX > width*0.43 && mouseX < width*0.57 && mouseY < height*0.09) {
    level++;
    if (level > 4) {
      level = 1;
    }
  }

if (standBy && !winnerBool) {
  if (mouseX > width*0.22 && mouseX < width*0.28 && mouseY > height*0.95) // serve left
  {
    standBy = false;
    ball.serve();  
    ball.xspeed = iniXSpeed;
    fire = true;

    if (level == 1) {
      aiIncR = random(iniPadSpeed*0.9, iniPadSpeed*1.1);
    } else if (level == 2) {
      aiIncR = random(iniPadSpeed*1.1, iniPadSpeed*1.3);
    } else if (level == 3) {
      aiIncR = random(iniPadSpeed*1.3, iniPadSpeed*1.6);
    } else if (level == 4) {
      aiIncR = random(iniPadSpeed*1.5, iniPadSpeed*1.9);
    }
      aiIncL = random(1, 3);
   
  }

  if (mouseX > width*0.72 && mouseX < width*0.78 && mouseY > height*0.95) // serve right
  {
    standBy = false;
    ball.serve();  
    ball.xspeed = -iniXSpeed;
    fire = true;

    if (level == 1) {
      aiIncL = random(iniPadSpeed*0.9, iniPadSpeed*1.1);
    } else if (level == 2) {
      aiIncL = random(iniPadSpeed*1.1, iniPadSpeed*1.3);
    } else if (level == 3) {
      aiIncL = random(iniPadSpeed*1.3, iniPadSpeed*1.6);
    } else if (level == 4) {
      aiIncL = random(iniPadSpeed*1.5, iniPadSpeed*1.9);
    }
      aiIncR = random(1, 3);
  }
}

}


void mouseDragged() {
//println(abs(pmouseX-mouseX));
  //if (!standBy || winnerBool) {                          // *** moves paddles right
  for (int i = 0; i < touches.length; i++) {
  if (zRotate < 1) {
    if (touches[i].x > width*0.5) {
      //moveRight = map(touches[i].y, 0, height, -(H-height)*0.5, height+(H-height)*0.5);
      moveRight = map(touches[i].y, 0, height, 0-(H*0.2), H+(H*0.2));
      if (xMoveBool){
     moveRightX = map(touches[i].x,width,0,W,W*0.5)-10;
      }
    }
    if (touches[i].x < width*0.4) {                      // *** moves paddles left
      moveLeft = map(touches[i].y, 0, height, 0-(H*0.2), H+(H*0.2));
      if (xMoveBool){
      moveLeftX = map(touches[i].x,0,width,0,W*0.5)+10;
      //moveLeft = map(touches[i].y, 0, height, 0, H);
      }
    }
  } else
    if (zRotate > 1) {
      if (touches[i].y > height*0.5) {
        moveRight = map(touches[i].x, 0, width, H+(H*0.2), 0-(H*0.2));
      if (xMoveBool){
        moveRightX = map(touches[i].y,height,0,W,W*0.5)-10;
      }
      }
      if (touches[i].y < height*0.5) {
        moveLeft = map(touches[i].x, width*0.5, width*0.6,H+(H*0.2), 0-(H*0.2));
      if (xMoveBool){
      moveLeftX = map(touches[i].x,0,height,0,W*0.5)+10;
      }
      }
    }
  }
  //}
                                                             // ********** moves and rotates the table
  //if (zRotate < 1) {
  //  if (mouseX > width*0.7) {
  //    moveRight = mouseY-H*0.2;
  //  }
  //  if (mouseX < width*0.3) {
  //    moveLeft = mouseY-H*0.2;
  //  }
  //} else
  //  if (zRotate > 1) {
  //    if (mouseY > height*0.7) {
  //      moveRight = map(mouseX, 0, width, H, 0);
  //    }
  //    if (mouseY < height*0.5) {
  //      moveLeft = map(mouseX, width*0.4, width*0.6, H, 0);
  //    }
  //  }

  if (standBy || winnerBool) {
    if (mouseX > width*0.3 && mouseX < width*0.7 && mouseY > height*0.25 && mouseY < height*0.5) {
      xRotate += (pmouseY - mouseY)*0.002;
    }
    if (mouseX > width*0.3 && mouseX < width*0.7 && mouseY > height*0.5 && mouseY < height*0.75) {
      xTranslate -= (pmouseX - mouseX)*0.5;
    }
    if (mouseX > width*0.3 && mouseX < width*0.7 && mouseY > height*0.11 && mouseY < height*0.2) {
      yRotate -= (pmouseX - mouseX)*0.002;
    }
    if (mouseX > 0 && mouseX < width*0.05 && mouseY > height*0.2 && mouseY < height*0.8) {
      zRotate += (pmouseY - mouseY)*0.002;
    }
    if (mouseX > width*0.3 && mouseX < width*0.7 && mouseY > height*0.9 && mouseY < height) {
      zTranslate -= (pmouseX - mouseX)*0.2;
    }
    if (mouseX > width*0.95 && mouseX < width && mouseY > height*0.2 && mouseY < height*0.8) {
      yTranslate -= (pmouseY - mouseY)*0.5;
    }
  }
}

float moveRightAI() {
if (!standBy){
  if (aiRpad.y < ball.y-(aiRpad.h*randomIncR) && aiRpad.y < ball.y+(aiRpad.h*randomIncR)) {
    aiYspeedR += aiIncR;
  } else if (aiRpad.y > ball.y-(aiRpad.h*randomIncR) && aiRpad.y > ball.y+(aiRpad.h*randomIncR)) { // (error*level)-constant  -  (error*level)+constant
    aiYspeedR -= aiIncR;
  }
}
  return aiYspeedR;

}

float moveLeftAI() {
if (!standBy) {
  if (aiLpad.y < ball.y-(aiLpad.h*randomIncL) && aiLpad.y < ball.y+(aiLpad.h*randomIncL)) {
    aiYspeedL += aiIncL;
  } else if (aiLpad.y > ball.y-(aiLpad.h*randomIncL) && aiLpad.y > ball.y+(aiLpad.h*randomIncL)) { // (error*level)-constant  -  (error*level)+constant
    aiYspeedL -= aiIncL;
  }
}
  return aiYspeedL;

}

//void mouseWheel(MouseEvent event) {  //zoom in zoom out
//  float wheel = event.getCount();
//  if (wheel < 0) {
//    zTranslate += 1;
//  }
//  if (wheel > 0) {
//    zTranslate -= 1;
//  }
//}

void myPlayButtonA(float x, float y, float size) {
  triangle(x-(size*0.5), y+(size*0.3), x, y-size*0.54, x+(size*0.5), y+(size*0.3));
}

void myPlayButtonB(float x, float y, float size) {
  triangle(x-(size*0.5), y-(size*0.3), x, y+size*0.54, x+(size*0.5), y-(size*0.3));
}

void myPlayButtonC(float x, float y, float size) {
  triangle(x-(size*0.3),y-(size*0.5),x+(size*0.54),y,x-(size*0.3),y+(size*0.5));
}

void myPlayButtonD(float x, float y, float size) {
  triangle(x+(size*0.3),y-(size*0.5),x-(size*0.54),y,x+(size*0.3),y+(size*0.5));
}

void winner() {
  //pushMatrix();
  //translate(0,0,width*0.25);
  fill(0,0,255);
  rect(width*0.5, height*0.4,width*0.4,height*0.08);
    //ellipse(width*0.5,height*0.60,width*0.1,height*0.05);
    ellipse(width*0.5,height*0.6,width*0.14,height*0.07);
  textSize(height*0.064);
  fill(255);
  if (aiRscore == 15){
    text("Right AI Wins!", width*0.5, height*0.4);
  } else
  if (aiLscore == 15){
    text("Left AI Wins!", width*0.5, height*0.4);
  }else
  if (rightScore == 15){
    text("Right Human Wins!", width*0.5, height*0.4);
  }else
  if (leftScore == 15){
    text("Left Human Wins!", width*0.5, height*0.4);
  }
    textSize(height*0.04);
  text("Play Again",width*0.5,height*0.6);
//popMatrix();  
zRotate += 0.01;
xRotate += 0.01;
//yRotate += 0.01;
}


                                                            //*********** OSO's fix
  
//if (zRotate < 1) {
//if (moveRight < mouseX) {
//  catchUpMas = true;
//  catchUpMenos = false;
//} else
//if (moveRight > mouseX) {
//  catchUpMenos = true;
//  catchUpMas = false;
//}
//  }else
//if (zRotate > 1) {
//if (moveRight < mouseY) {
//  catchUpMas = true;
//  catchUpMenos = false;
//} else
//if (moveRight > mouseY) {
//  catchUpMenos = true;
//  catchUpMas = false;
//}
//  }
  
