void resetGame(){
    score.clear();
    combo=0;
    timer.timeStart();
    paddle=new Paddle('A', 'D', 'J', 'L');
    isBallMoving=false;
    
    currentBalls.add(new Ball(paddle.middleX,paddle.pos.y-ballRadius,ballRadius));
    
    
    // Initialize the blocks
    levels[int(random(0,3))].initialize();
}