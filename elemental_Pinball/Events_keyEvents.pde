void keyPressed(){
    switch(state){
        case GAMING:
            if(key==' ' && !isBallMoving){//Launch the ball by pressing the space bar. 
                println("Shooting Success");
                currentBalls.get(0).move();
                isBallMoving=true;
            }
            paddle.elementDirection(key);
            paddle.direction(key);
    }

}

void keyReleased(){
    switch(state){
        case GAMING:
            paddle.stop(key);
    }

}