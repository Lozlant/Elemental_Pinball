void gamingPage(){
    background(255);
    drawBackground();

    settingButton.show();

    timer.show();
    if(timer.isTimeEnd())state=GameState.END;//Temporarily set the game to restart when the time runs out

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
            if(currentBalls.size()==0){isBallMoving=false;state=GameState.END;}//If all the balls are gone, it's over. and restarted.

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

void drawBackground(){

    //draw score
    rectMode(CORNER);
    stroke(0);strokeWeight(1);fill(255);
    rect(300,74,95,40.5);
    
    textSize(25);fill(0);textAlign(CENTER);
    text(score.count,347.5,105);

    howToPlay();
    drawPlayField();
}

void drawPlayField(){
    stroke(0);strokeWeight(0);fill(190);
    rectMode(CORNERS);rect(playfield_Topleft.x,playfield_Topleft.y,playfield_Bottomright.x,playfield_Bottomright.y);
}
