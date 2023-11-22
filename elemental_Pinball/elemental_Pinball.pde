//Elemental Pinball by Yunhao Chen, Nov 21, 2023
//The Chinese after each comment serves as the translation of the comment, 
//intended for the convenience of the author's personal reading.

Paddle paddle;
Block[][] blocks = new Block[9][8];//9 blocks per line, 8 lines
Timer timer;

int score;
int combo;
int currentBallsID;//The ID of the current activated ball.已经激活的球的编号
ArrayList<Ball> currentBalls= new ArrayList<Ball>();

boolean isBallMoving=false;

PVector playfield_Topleft=new PVector(23.5,25);
PVector playfield_Bottomright=new PVector(291,313);//The coordinates of the top-left and bottom-right corners of the game field.游戏区左上角和右下角的坐标

float ballRadius=7;

void setup(){
    size(400,400);
    reset();
    startANewTurn();
    isBallMoving=false;
}


void draw(){
    background(255);
    drawPlayField();
    drawRemainingBalls();//Draw the remaining balls.画出剩余的球
    
    

    for(int i=0;i<9;i++){
        for(int j=0;j<8;j++){
            //if(blocks[i][j].exist)println("Success to draw",i," ",j);
            blocks[i][j].show();//Display the level.显示关卡
        }
    }
    if(isBallMoving){
        for(int i=0;i<currentBalls.size();i++){
            Ball ball=currentBalls.get(i);

            if(ball.isBallCollidWithPaddle()){
                ball.element=paddle.element;
                combo++;
            }
            
            if(ball.isBallOutsideBounds()){
                currentBalls.remove(i);
                combo=0;
                if(currentBalls.size()==0){isBallMoving=false;startANewTurn();}//If all the balls are gone, it's over. and restarted.
            }

            if(collidBlocks()>=0){
            //Element reaction.元素反应
            
            }

            ball.move();
            ball.show();
        }
        
        
    }
    else{
        Ball ball=currentBalls.get(0);
        ball.pos.x=paddle.middleX;
        ball.show();

    }

    paddle.move();
    paddle.show();//paddle shows in front of balls
     
}

void reset(){
    currentBallsID=0;
    score=0;
    combo=0;

    paddle=new Paddle(' ', 'A', 'D');
    
    //初始化block;
    String level1 = "315 2232 414 41112";//See the first draft for understand, more levels will be designed later!图详见初版草稿，关卡会后续设计更多
    initializeLevel(level1);
}

void keyPressed(){
    if(key==' ' && !isBallMoving){
        println("Shooting Success");
        currentBalls.get(0).move();
        isBallMoving=true;
    }
    paddle.direction(key);
}
void keyReleased(){
    paddle.stop(key);

}
void drawRemainingBalls() {
    //the code for drawing the remaining balls 画出剩余的球的逻辑
} 
void drawPlayField(){
    stroke(0);strokeWeight(0);fill(97);
    rectMode(CORNERS);rect(playfield_Topleft.x,playfield_Topleft.y,playfield_Bottomright.x,playfield_Bottomright.y);
}
int collidBlocks(){
    return 0;
}  
void startANewTurn(){//start a new shooting turn
    currentBalls.add(new Ball(paddle.middleX,paddle.pos.y-ballRadius,ballRadius));
}
void initializeLevel(String s){//Decode the string that represents a level 解码代表关卡的代码
    for(int i=0;i<9;i++){
        for(int j=0;j<8;j++){
            blocks[i][j]=new Block(i,j,false);
        }
    }//Initialize the blocks to blank

    boolean exist=true;
    int line=0,column=0;
   // println("solve:", s);
    for(int i=0;i<s.length();i++){
        //print("Current solve",s.charAt(i));
        if(s.charAt(i)==' '){line++;column=0;exist=true;continue;}//Open a new line when a space is encountered 遇到空格开启新一行
        if(s.charAt(i)=='0'){exist=false;continue;}//A zero at the beginning of the number set means that the line starts with a blank.以0打头代表这行开头是空的
        //println(" ",exist);
        for(int j=0;j<s.charAt(i)-'1'+1;j++){
            //println(" ",line," ",column);
            blocks[column][line].exist=exist;
            column++;
        }
        exist=!exist;//The next number in the same set of numbers represents, contrary to the present, the null or exist.同一组数字中的下一个数字代表，与现在相反的空或者有
    }

    /*for(int i=0;i<9;i++){
        for(int j=0;j<8;j++){
            print(blocks[i][j].pos," ");
            //if(blocks[i][j].exist)print("T"," ");
            //else print("F"," ");
        }
        println();
    }*/
}