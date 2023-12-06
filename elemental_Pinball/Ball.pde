class Ball{
    PVector pos;
    PVector speed;
    
    float radius;

    Element element;

    Direction directionOfHitBlock;
    // 1 indicates collision from above, 2 indicates collision from below, 3 indicates collision from the left, 4 indicate
    PVector_Int hitblock=new PVector_Int(0,0);

    boolean isCollidingWithPaddle;
    Ball(float x,float y,float r){
        pos=new PVector(x,y);
        radius=r;
        element=paddle.element;
        speed=new PVector(0,-5);

        isCollidingWithPaddle=isBallCollidWithPaddle();
    }
    void move(){
        pos.add(speed);
        directionOfHitBlock=collidBlocks();//Return the direction of the hit and calculate which block was impacted.返回hit的方向，并且计算出碰到了哪个块
        if(isBallCollidWithTopWall() || isBallCollidWithPaddle() || directionOfHitBlock==Direction.UP || directionOfHitBlock==Direction.DOWN){ //Collid with the top or the paddle
            speed.y*=-1;
            speed.x+=random(-1,1);//Give the speed horizontal component a perturbation给水平分量一个扰动
        }
        if(isBallCollidWithVerticalWall() || directionOfHitBlock==Direction.LEFT || directionOfHitBlock==Direction.RIGHT){//hit the vertical wal
            speed.x*=-1;
        }

        pos.x=constrain(pos.x,playfield_Topleft.x+radius,playfield_Bottomright.x-radius);
        pos.y=constrain(pos.y,playfield_Topleft.y+radius,playfield_Bottomright.y-radius);//to ensure the ball doesn't go out of bounds
    }
    void show(){
        stroke(0);strokeWeight(1);
        switch (element) {
            case _NULL:fill(255);break;
            case FIRE:fill(180,47,47);break;
            case ICE:fill(75,177,255);break;
            case THUNDER:fill(72,0,92);break;
        }
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

    Direction collidBlocks(){// Return 1 for collision from above, 2 for collision from below, 3 for collision from the left, and 4 for collision from the right.
        if(collidBlocks_Direction(0,-radius)){pos.y=blocks_position[hitblock.x][hitblock.y].y+blocksize+radius+0.1;return Direction.UP;}
        if(collidBlocks_Direction(0,+radius)){pos.y=blocks_position[hitblock.x][hitblock.y].y-radius-0.1;return Direction.DOWN;}
        if(collidBlocks_Direction(-radius,0)){pos.x=blocks_position[hitblock.x][hitblock.y].x+blocksize+radius+0.1;return Direction.LEFT;}
        if(collidBlocks_Direction(+radius,0)){pos.x=blocks_position[hitblock.x][hitblock.y].x-radius-0.1;return Direction.RIGHT;}
        else return Direction._NULL;
    }

    boolean collidBlocks_Direction(float dx,float dy){
        hitblock=inwhichBlock(pos.x+dx,pos.y+dy);
//        println("A",i,j);
        if(hitblock.x<9 && hitblock.x>=0 && hitblock.y<8  && hitblock.y>=0)return blocks[hitblock.x][hitblock.y].exist;
        return false;
    }

    PVector_Int inwhichBlock(float x, float y){//Calculate which block contains this coordinate.
        for(int i=0;i<9;i++){//遍历bloks的坐标，查看坐标在哪个block上
            float bx=blocks_position[i][0].x;
            
            if(x>bx && x<=bx+blocksize){
                for(int j=0;j<8;j++){
                    float by=blocks_position[i][j].y;
                    //fill(150);rect(bx,by,blocksize,blocksize);
                    //println(by,y,blocksize);
                    if(y>by && y<=by+blocksize){
                        //println("aaa",x,y,i,j,blocks_position[i][j]);
                        //fill(150);rect(bx,by,blocksize,blocksize);
                        return new PVector_Int(i,j);
                    }
                }
            }
        }
        //println("ball position error",x,y);stop();
        return new PVector_Int(-1,-1);
        
    }

}