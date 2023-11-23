class Ball{
    PVector pos;
    PVector speed;
    
    float radius;

    char element;//Four types of element, ' ' for no attribute, 'T' equals thunder attribute, 'F' fire attribute, 'I' is ice attribute." //四种，‘ ’为无属性，‘T’等于雷属性，'F'火属性，‘I’是冰属性

    int directionOfHitBlock;
    // 1 indicates collision from above, 2 indicates collision from below, 3 indicates collision from the left, 4 indicate
    PVector hitblock;
    Ball(float x,float y,float r){
        pos=new PVector(x,y);
        radius=r;
        element=' ';
        speed=new PVector(0,-7);
    }
    void move(){
        pos.add(speed);
        directionOfHitBlock=collidBlocks();//返回hit的方向，并且计算出碰到了哪个块
        if(isBallCollidWithTopWall() || isBallCollidWithPaddle() || directionOfHitBlock==1 || directionOfHitBlock==2){ //Collid with the top or the paddle
            speed.y*=-1;
            speed.x+=random(-1,1);//Give the speed horizontal component a perturbation给水平分量一个扰动
        }
        if(isBallCollidWithVerticalWall() || directionOfHitBlock==3 || directionOfHitBlock==4){//hit the vertical wal
            speed.x*=-1;
        }
        directionOfHitBlock=collidBlocks();

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
    int collidBlocks(){// Return 1 for collision from above, 2 for collision from below, 3 for collision from the left, and 4 for collision from the right.
        //Above
        hitblock=calculateWhichBlockIsIn(pos.x,pos.y-radius);
        int i=int(hitblock.x),j=int(hitblock.y);
        if(i>=9 || j>=8)return 0;
        if(blocks[i][j].exist)return 1;
        //Below
        hitblock=calculateWhichBlockIsIn(pos.x,pos.y+radius);
        i=int(hitblock.x);j=int(hitblock.y);
        if(i>=9 || j>=8)return 0;
        if(blocks[i][j].exist)return 2;
        //Left
        hitblock=calculateWhichBlockIsIn(pos.x-radius,pos.y);
        i=int(hitblock.x);j=int(hitblock.y);
        if(i>=9 || j>=8)return 0;
        if(blocks[i][j].exist)return 3;
        //Right
        hitblock=calculateWhichBlockIsIn(pos.x+radius,pos.y);
        i=int(hitblock.x);j=int(hitblock.y);
        if(i>=9 || j>=8)return 0;
        if(blocks[i][j].exist)return 4;
        return 0;
    }
    PVector calculateWhichBlockIsIn(float x, float y){//Calculate which block contains this coordinate.
        int i=int((x-playfield_Topleft.x)/blocksize-0.5);
        int j=int((y-playfield_Topleft.y)/blocksize-0.5);
        PVector p=new PVector(i,j);
        return p;
    }
}