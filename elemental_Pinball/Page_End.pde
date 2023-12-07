void endPage(){
    score.highestUpdate();

    background(255);
    image(endMenu_Show,0,0,400,400);

    startButton.show();
    
    textSize(100);fill(0);textAlign(CENTER);
    text(score.count,width/2,170);

    textSize(30);fill(255);
    text(score.highest,320,265);
    
    
}