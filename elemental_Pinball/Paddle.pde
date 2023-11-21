class Paddle{
    PVector pos;
    float width_;

    char element;
    char leftKey,rightKey;

    boolean goLeft,goRight;

    Paddle(char e, char key1, char key2){
        leftKey=key1;rightKey=key2;
        element=e;

        width_=64;
        pos=new PVector((playfield_Topleft.x+playfield_Bottomright.x-width_)/2,287);//comfirm the coordinate
        
    }

    void direction(char key){
        if(key==leftKey)goLeft=true;
        else if(key==rightKey)goRight=true;
    }

    void stop(char key){
        if(key==leftKey)goLeft=false;
        else if(key==rightKey)goRight=false;
    }
    
    void show(){
        fill(27);
        rectMode(CORNER);rect(pos.x,pos.y,width_,14.5);
    }
}