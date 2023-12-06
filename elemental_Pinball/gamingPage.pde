void gamingPage(){
    background(255);
    drawBackground();
    drawRemainingBalls();//Draw the remaining balls.画出剩余的球

    settingButton.show();

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

void drawRemainingBalls() {
    //the code for drawing the remaining balls 画出剩余的球的逻辑
}

void drawBackground(){
   
    howToPlay();
    drawPlayField();
}

void drawPlayField(){
    stroke(0);strokeWeight(0);fill(190);
    rectMode(CORNERS);rect(playfield_Topleft.x,playfield_Topleft.y,playfield_Bottomright.x,playfield_Bottomright.y);
}