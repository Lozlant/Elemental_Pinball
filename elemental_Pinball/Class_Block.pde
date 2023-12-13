class Block{
    Element element;
    PVector pos;
    boolean exist;
    float size=blocksize;

    Block(int i,int j,boolean f){//Get the number and state of the Block
        pos=blocks_position[i][j];
        exist=f;
        element=Element._NULL;
    }
    void show(){
        if(!exist)return;//If the block does not exist, it doesn't show
        stroke(0);strokeWeight(1);
        switch (element) {// Display blocks of different colors depending on the element
            case _NULL:fill(255);break;
            case FIRE:fill(232,65,109);break;
            case ICE:fill(99,127,191);break;
            case THUNDER:fill(170,85,157);break;
        }
        rectMode(CORNER);rect(pos.x,pos.y,size,size);
    }
    React react(Ball ball){// The ball reacts with the block
        if(element==Element._NULL){
            element=ball.element; return React._NULL;//If the block has no elements, it gets the elements of the ball
        }            
        else if(element==Element.FIRE && ball.element==Element.THUNDER
        || element==Element.THUNDER && ball.element==Element.FIRE){//Three elemental reactions were recorded
            return React.EXPLOSION;
        }
        else if(element==Element.FIRE && ball.element==Element.ICE
        || element==Element.ICE && ball.element==Element.FIRE){
            return React.MELTING;
       }
        else if(element==Element.THUNDER && ball.element==Element.ICE
        || element==Element.ICE && ball.element==Element.THUNDER){
                return React.SUPERCON;
        }
        else return React._NULL;
    }


}
    
