class Timer{
    int startTimeCount,totalTimeCount;
    int minute,second;
    Timer(int t){
        totalTimeCount=t;
    }
    void timeStart(){
        startTimeCount=second();
    }
    boolean isTimeEnd(){
        return second()-startTimeCount>=totalTimeCount;
    }
    void show(){
        int countDown=totalTimeCount+startTimeCount-second();
        
        minute=countDown/60;
        second=countDown%60;
        //println("showtime",minute,second);
        textSize(25);fill(0);
        text(minute,324,121);
        text(second,350,121);
        text(":", 337,121);
    }
}