class Paddle{
    PVector pos;
    float width_;
    float speed;
    float middleX;

    Element element;
    char leftKey,rightKey;
    char e_leftKey,e_rightKey;

    boolean goLeft,goRight;

    Paddle(char key1, char key2,char key3, char key4){
        leftKey=key1;rightKey=key2;e_leftKey=key3;e_rightKey=key4;
        element=Element.ICE;

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
        middleX=pos.x+width_/2;//update the middleX 更新中心位置
    }

    void direction(char key){
        if(key==leftKey || key==leftKey+'a'-'A')goLeft=true;
        else if(key==rightKey || key==rightKey+'a'-'A')goRight=true;//Both upper and lower case pressing will work
    }

    void stop(char key){
        if(key==leftKey || key==leftKey+'a'-'A')goLeft=false;
        else if(key==rightKey || key==rightKey+'a'-'A')goRight=false;
    }
    void elementDirection(char key){
        //Switch the paddle's element using the 'J' and 'L' keys. 用'J''L'键 更换板的元素
        if(key==e_leftKey){
            //print((paddle.element.ordinal() - 2)%3+1);
            element=Element.values()[(paddle.element.ordinal() +4)%3+1];
            //println(element);
        }
        else if(key==e_rightKey){
            element=Element.values()[paddle.element.ordinal()%3+1];
        }
    }
    
    void show(){
        stroke(0);strokeWeight(1);
        switch (element) {
            case _NULL:fill(27);break;
            case FIRE:fill(232,65,109);break;
            case ICE:fill(99,127,191);break;
            case THUNDER:fill(170,85,157);break;
        }
        rectMode(CORNER);rect(pos.x,pos.y,width_,14.5);
    }
}