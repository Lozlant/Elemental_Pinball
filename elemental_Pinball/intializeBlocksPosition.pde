void initializeBlocksPosition(){
    for(int i=0;i<9;i++){
        for(int j=0;j<8;j++){
            float x=i*blocksize+blocksize/2+playfield_Topleft.x;
            float y=j*blocksize+blocksize/2+playfield_Topleft.y;
            blocks_position[i][j]=new PVector(x,y);
        }
    }
}// Convert the position of the block to coordinates.
