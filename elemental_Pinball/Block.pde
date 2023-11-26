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
            case FIRE:fill(255,0,0);break;
            case ICE:fill(0,0,255);break;
            case THUNDER:fill(192,69,215);break;
        }
        rectMode(CORNER);rect(pos.x,pos.y,size,size);
    }
    
}