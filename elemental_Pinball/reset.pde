void resetGame(){
    currentBallsID=0;
    score.clear();
    combo=0;
    timer.timeStart();
    paddle=new Paddle('A', 'D', 'J', 'L');
    
    currentBalls.add(new Ball(paddle.middleX,paddle.pos.y-ballRadius,ballRadius));
    
    
    // Initialize the block.初始化block;

    level1.initialize();
}