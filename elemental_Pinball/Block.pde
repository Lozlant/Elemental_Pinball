class Block{
    Element element;
    PVector pos;
    boolean exist;
    float size=blocksize;

    Block(float i,float j,boolean f){
        pos=new PVector(i*size+size/2+playfield_Topleft.x,j*size+size/2+playfield_Topleft.y);// Convert the position of the block to coordinates.
        exist=f;
        element=Element._NULL;
    }
    void show(){
        if(!exist)return;
        stroke(0);strokeWeight(1);
        switch (element) {
            case _NULL:fill(255);break;
            case FIRE:fill(232,65,109);break;
            case ICE:fill(99,127,191);break;
            case THUNDER:fill(170,85,157);break;
        }
        rectMode(CORNER);rect(pos.x,pos.y,size,size);
    }
    React react(Ball ball){
        if(element==Element._NULL){
            element=ball.element; return React._NULL;
        }            
        else if(element==Element.FIRE && ball.element==Element.THUNDER
        || element==Element.THUNDER && ball.element==Element.FIRE){
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
    
