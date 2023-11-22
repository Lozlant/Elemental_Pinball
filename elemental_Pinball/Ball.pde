class Ball{
    PVector pos;
    PVector speed;
    
    float radius;

    char element;//Four types of element, ' ' for no attribute, 'T' equals thunder attribute, 'F' fire attribute, 'I' is ice attribute." //四种，‘ ’为无属性，‘T’等于雷属性，'F'火属性，‘I’是冰属性

    Ball(float x,float y,float r){
        pos=new PVector(x,y);
        radius=r;
        element=' ';
        speed=new PVector(0,-7);
    }
    void move(){
        pos.add(speed);
        if(isBallCollidWithTopWall() || isBallCollidWithPaddle()){ //Collid with the top or the paddle
            speed.y*=-1;
            speed.x+=random(-1,1);//Give the speed horizontal component a perturbation给水平分量一个扰动
        }
        if(isBallCollidWithVerticalWall()){//hit the vertical wal
            speed.x*=-1;
        }
        pos.x=constrain(pos.x,playfield_Topleft.x+radius,playfield_Bottomright.x-radius);
        pos.y=constrain(pos.y,playfield_Topleft.y+radius,playfield_Bottomright.y-radius);//to ensure the ball doesn't go out of bounds
    }
    void show(){
        stroke(0);strokeWeight(1);fill(255);
        ellipse(pos.x, pos.y, radius*2, radius*2);
    }
    boolean isBallOutsideBounds(){
        return pos.y>=playfield_Bottomright.y-radius-5;//Out of bounds is judged when there is a little bit of distance to the bottom end 离底端还有一点距离的时候就判断为出界
    }
    boolean isBallCollidWithPaddle(){
        boolean f_height= pos.y>=paddle.pos.y-radius && pos.y<=paddle.pos.y;//Determine if you are within the height of the counterattack
        boolean f_width= pos.x>=paddle.pos.x && pos.x<=paddle.pos.x+paddle.width_;//Determine if you are within the width of the counterattack
        return f_height && f_width;
    }
    boolean isBallCollidWithTopWall(){
        return pos.y<=playfield_Topleft.y+radius;
    }
    boolean isBallCollidWithVerticalWall(){
        boolean f_left= pos.x<=playfield_Topleft.x+radius;
        boolean f_right= pos.x>=playfield_Bottomright.x-radius;
        return f_left||f_right;
    }
}