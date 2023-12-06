//Elemental Pinball by Yunhao Chen, Nov 21, 2023
//The Chinese after each comment serves as the translation of the comment, 
//intended for the convenience of the author's personal reading.

Paddle paddle;
Block[][] blocks = new Block[9][8];//9 blocks per line, 8 lines
PVector[][] blocks_position=new PVector[9][8];
Timer timer;
Level level1;

enum Element {_NULL,FIRE,ICE,THUNDER}
enum React {_NULL,EXPLOSION,MELTING,SUPERCON}
enum Direction{_NULL,UP,DOWN,LEFT,RIGHT}

int score;
int combo;
int currentBallsID;//The ID of the current activated ball.已经激活的球的编号
ArrayList<Ball> currentBalls= new ArrayList<Ball>();
 
boolean isBallMoving=false;

PVector playfield_Topleft=new PVector(23.5,25);
PVector playfield_Bottomright=new PVector(291,313);//The coordinates of the top-left and bottom-right corners of the game field.游戏区左上角和右下角的坐标

float ballRadius=7;
float blocksize;

PImage settingButton;
PImage elementsShow;

void setup(){
    size(400,400);
    
    blocksize=(playfield_Bottomright.x-playfield_Topleft.x)/10;// Initialization must occur before constructing the block group.
    isBallMoving=false;
    paddle=new Paddle('A', 'D', 'J', 'L');
    timer=new Timer(2,0);
    level1 = new Level("315 2232 414 41112");//See the first draft for understand, more levels will be designed later!图详见初版草稿，关卡会后续设计更多

    initializeBlocksPosition();// Convert the position of the block to coordinates.
    imageLoad();

    reset();
    startANewTurn();
}

void draw(){
    background(255);

    drawBackground();
    drawRemainingBalls();//Draw the remaining balls.画出剩余的球

    timer.show();
    if(timer.isTimeEnd())reset();//Temporarily set the game to restart when the time runs out

    for(int i=0;i<9;i++){
        for(int j=0;j<8;j++){
            blocks[i][j].show();//Display the level.显示关卡
        }
    }
    
    if(isBallMoving){
        for(int i=0;i<currentBalls.size();i++){//Go through all the balls
            Ball ball=currentBalls.get(i);
            
            check_Paddle_Collid(ball);
            check_Ball_Out(ball,i);
            if(currentBalls.size()==0){isBallMoving=false;startANewTurn();}//If all the balls are gone, it's over. and restarted.

            ball.move();

            check_Block_Collid(ball);//Must be after the ball.move()

            ball.show();
        } 

        if(combo>=3){// Split when achieving a combo of 5.
            combo=0;
            currentBalls.add(new Ball(currentBalls.get(0).pos.x,currentBalls.get(0).pos.y,ballRadius));// Split a ball at the position of the ball in sequence 0.
            
        }    
    }
    else{//If the ball hasn't been launched yet
        Ball ball=currentBalls.get(0);

        ball.pos.x=paddle.middleX;//Update the ball's x position to the center of the paddle
        ball.element=paddle.element;//The ball element is updated to the paddle element
        
        ball.show();
    }

    paddle.move();

    paddle.show();//paddle shows in front of balls
     
}
void startANewTurn(){//start a new shooting turn
    timer.timeStart();
    currentBalls.add(new Ball(paddle.middleX,paddle.pos.y-ballRadius,ballRadius));
}


