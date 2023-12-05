class Timer{
    int total_Minute,total_Second;
    int startMinute,startSecond;
    int minute,second;
    
    boolean minuteAct;
    Timer(int min,int sec){
        total_Second=sec;
        minute=total_Minute=min;
        minuteAct=sec!=59;// If the time is set to 59, the minutes will not be reduced the first time
    }
    void timeStart(){
        startSecond=second();
        minute=total_Minute;
        minuteAct=total_Second!=59;
    }
    boolean isTimeEnd(){
        return minute==0 && second==0;
    }

    void show(){
        second=(total_Second+startSecond-second()+60)%60;
        if(second==59 && minuteAct){minute-=1;minuteAct=false;}//If second is 0, decrease by 1 minute
        else if (second!=59)minuteAct=true;//minuteAct is used to prevent minute from being reduced multiple times within multiple frames of second 59
        //println("showtime",minute,second);
        textSize(25);fill(0);
        text(minute,324,121);
        if(second>=10)text(second,350,121);
        else text("0"+str(second),350,121);
        text(":", 337,121);
    }
}