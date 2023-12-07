void check_Paddle_Collid(Ball ball){//Check for collision between ball and paddle
    if(ball.isBallCollidWithPaddle() && !ball.isCollidingWithPaddle){
        ball.element=paddle.element;
        combo++;
        ball.isCollidingWithPaddle=true;
    } else if(!ball.isBallCollidWithPaddle())ball.isCollidingWithPaddle=false;
}

void check_Ball_Out(Ball ball,int i){//Check if the ball falls out of bounds
    if(ball.isBallOutsideBounds()){
        currentBalls.remove(i);
        combo=0;
    }
}

void check_Block_Collid(Ball ball){
    if(ball.directionOfHitBlock!=Direction._NULL){
        int bi=ball.hitblock.x,bj=ball.hitblock.y;
        score.count++;
        React reaction=blocks[bi][bj].react(ball);
        switch(reaction){
            case EXPLOSION://destroys blocks in a cross-shaped range.
                score.count+=5;

                blocks[bi][bj].exist
                =blocks[constrain(bi-1, 0, 8)][bj].exist
                =blocks[constrain(bi+1, 0, 8)][bj].exist
                =blocks[bi][constrain(bj-1, 0, 7)].exist
                =blocks[bi][constrain(bj+1, 0, 7)].exist
                =false;

                break;

            case MELTING://turns surrounding adjacent blocks into ice elements.
                blocks[bi][bj].element
                =blocks[constrain(bi-1, 0, 8)][bj].element
                =blocks[constrain(bi+1, 0, 8)][bj].element
                =blocks[bi][constrain(bj-1, 0, 7)].element
                =blocks[bi][constrain(bj+1, 0, 7)].element
                =Element.ICE;
                break;

            case SUPERCON:// Eliminate the three blocks horizontally.消除水平的三个方块
                score.count+=3;

                blocks[bi][bj].exist
                =blocks[constrain(bi-1, 0, 8)][bj].exist
                =blocks[constrain(bi+1, 0, 8)][bj].exist
                =false;
                break;
        }

    }
}