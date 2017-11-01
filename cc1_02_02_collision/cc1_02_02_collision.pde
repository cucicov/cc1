// modified from http://processingjs.org/learning/topic/collision/

// Global variables for the ball

float ball_x;
float ball_y;
float ball_dir = 1;
float ball_size = 5;  // Radius
float dy = 0;  // Direction
float paddle_y;
float py;

// Global variables for the paddle

int paddle_width = 5;
int paddle_height = 20;

int dist_wall = 15;

void setup(){
  size(200, 200);
  rectMode(RADIUS);
  ellipseMode(RADIUS);

  noStroke();

  smooth();

  ball_y = height/2;
  ball_x = 1;
}

void draw() {

  background(51);  

  ball_x += ball_dir;
  ball_y += dy;
// Constrain paddle to screen
  paddle_y = constrain(mouseY, paddle_height, height-paddle_height);
  // Test to see if the ball is touching the paddle
  py = width-dist_wall-paddle_width-ball_size;
  
  if(ball_x > width+ball_size) {
    resetGame();
  }

  if(ball_x == py 
     && ball_y > paddle_y - paddle_height - ball_size 
     && ball_y < paddle_y + paddle_height + ball_size) {
    ball_dir *= -1;
    dy = getYDeviation();
  } 

  // If ball hits paddle or back wall, reverse direction
  if(ball_x < ball_size && ball_dir == -1) {
    ball_dir *= -1;
  }

  // If the ball is touching top or bottom edge, reverse direction
  if(ball_y > height-ball_size || ball_y < ball_size) {
    dy *= -1;
  }

  drawBall();
  drawPaddle();
}

float getYDeviation() {
  float deviation = 0;
  if(mouseY != pmouseY) {
    deviation = (mouseY-pmouseY)/2.0;
    deviation = constrain(deviation, -5, 5);
  }
  
  return deviation;
}

void resetGame() {
  ball_x = -width/2 - ball_size;
  ball_y = random(0, height);
  dy = 0;
}

void drawBall() {
  fill(255);
  ellipse(ball_x, ball_y, ball_size, ball_size);
}

void drawPaddle() {
  fill(153);
  rect(width-dist_wall, paddle_y, paddle_width, paddle_height);  
}