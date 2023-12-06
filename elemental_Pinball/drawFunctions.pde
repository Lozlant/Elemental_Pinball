void drawRemainingBalls() {
    //the code for drawing the remaining balls 画出剩余的球的逻辑
}

void drawBackground(){
    image(settingButton,333,25,32,33);
    image(elementsShow,68,329.5,165,22.5);
    drawPlayField();
}

void drawPlayField(){
    stroke(0);strokeWeight(0);fill(190);
    rectMode(CORNERS);rect(playfield_Topleft.x,playfield_Topleft.y,playfield_Bottomright.x,playfield_Bottomright.y);
    fill(256);
    stroke(0);strokeWeight(1);fill(256);rectMode(CORNER);
    rect(13,326,290,70);
}