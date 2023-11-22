class Paddle{
    PVector pos;
    float width_;
    float speed;
    float middleX;

    char element;
    char leftKey,rightKey;

    boolean goLeft,goRight;

    Paddle(char e, char key1, char key2){
        leftKey=key1;rightKey=key2;
        element=e;

        width_=64;
        pos=new PVector((playfield_Topleft.x+playfield_Bottomright.x-width_)/2,287);//comfirm the coordinate
        
        speed=5;
        middleX=pos.x+width_/2;
    }
    void move(){
        if(goRight)
            pos.x=constrain(pos.x+speed, playfield_Topleft.x+5, playfield_Bottomright.x-width_-5);
        if(goLeft)
            pos.x=constrain(pos.x-speed, playfield_Topleft.x+5, playfield_Bottomright.x-width_-5);
        middleX=pos.x+width_/2;//update the middleX更新中心位置
    }

    void direction(char key){
        if(key==leftKey || key==leftKey+'a'-'A')goLeft=true;
        else if(key==rightKey || key==rightKey+'a'-'A')goRight=true;//Both upper and lower case pressing will work
    }

    void stop(char key){
        if(key==leftKey || key==leftKey+'a'-'A')goLeft=false;
        else if(key==rightKey || key==rightKey+'a'-'A')goRight=false;
    }
    
    void show(){
        stroke(0);strokeWeight(1);fill(27);
        rectMode(CORNER);rect(pos.x,pos.y,width_,14.5);
    }
}