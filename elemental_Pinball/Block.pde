class Block{
    char element;
    PVector pos;
    boolean exist;
    float size=(playfield_Bottomright.x-playfield_Topleft.x)/10;
    Block(float i,float j,boolean f){
        pos=new PVector(i*size+size/2+playfield_Topleft.x,j*size+size/2+playfield_Topleft.y);
        exist=f;
        
    }
    void show(){
        if(!exist)return;
        stroke(0);strokeWeight(1);fill(255);
        rectMode(CORNER);rect(pos.x,pos.y,size,size);
    }
    void disappear(){
        exist=false;
    }
    
}