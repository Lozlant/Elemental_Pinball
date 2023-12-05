void reset(){
    currentBallsID=0;
    score=0;
    combo=0;
    timer.timeStart();
    
    
    // Initialize the block.初始化block;
    String level1 = "315 2232 414 41112";//See the first draft for understand, more levels will be designed later!图详见初版草稿，关卡会后续设计更多
    initializeLevel(level1);
}