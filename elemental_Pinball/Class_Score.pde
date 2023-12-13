class Score{
    int count;
    int highest;

    Score(){
        highest=count=0;
    }
    
    void highestUpdate(){//If the score count is greater than the highest score, update the highes score
        if(highest<count)highest=count;
    }

    void clear(){
        count=0;
    }

}