class Level{
    String levelCode;
    Level(String s){
        levelCode=s;
        initialize();
    }

    void initialize(){//Decode the string that represents a level
        for(int i=0;i<9;i++){
            for(int j=0;j<8;j++){
                blocks[i][j]=new Block(i,j,false);
            }
        }//Initialize the blocks to blank

        boolean exist=true;
        int line=0,column=0;
        // println("solve:", s);
        for(int i=0;i<levelCode.length();i++){
            //print("Current solve",s.charAt(i));
            if(levelCode.charAt(i)==' '){line++;column=0;exist=true;continue;}//Open a new line when a space is encountered
            if(levelCode.charAt(i)=='0'){exist=false;continue;}//A zero at the beginning of the number set means that the line starts with a blank.
            //println(" ",exist);
            for(int j=0;j<levelCode.charAt(i)-'1'+1;j++){
                //println(" ",line," ",column);
                blocks[column][line].exist=exist;
                column++;
            }
            exist=!exist;//The next number in the same set of numbers represents, contrary to the present, the null or exist.
        }
    }

}