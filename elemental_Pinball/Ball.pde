class Ball{
    PVector pos;
    PVector speed;
    char element;//Four types of element, ' ' for no attribute, 'T' equals thunder attribute, 'F' fire attribute, 'I' is ice attribute." //四种，‘ ’为无属性，‘T’等于雷属性，'F'火属性，‘I’是冰属性

    Ball(){

    }
    void move(){
        pos.x+=speed.x;pos.y+=speed.y;
        //if(isBallCollidWithTopWall() && isBallCollidWithPaddle())speed.y*=-1;
        //if(isBallCollidWithVerticalWall())speed.x*=-1;

    }
    boolean isBallOutsideBounds(){
        return false;
    }
    boolean isBallCollidWithPaddle(){
        return false;
    }
}