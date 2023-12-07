class Score{
    int count;
    int highest;


    Score(){
        highest=count=0;
    }
    
    void highestUpdate(){
        if(highest<count)highest=count;
    }

    void clear(){
        count=0;
    }

}