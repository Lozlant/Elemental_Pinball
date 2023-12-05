//Elemental Pinball by Yunhao Chen, Nov 21, 2023
//The Chinese after each comment serves as the translation of the comment, 
//intended for the convenience of the author's personal reading.

Paddle paddle;
Block[][] blocks = new Block[9][8];//9 blocks per line, 8 lines
Timer timer;

enum Element {_NULL,FIRE,ICE,THUNDER}
enum React {_NULL,EXPLOSION,MELTING,SUPERCON}

int score;
int combo;
int currentBallsID;//The ID of the current activated ball.已经激活的球的编号
ArrayList<Ball> currentBalls= new ArrayList<Ball>();
 
boolean isBallMoving=false;

PVector playfield_Topleft=new PVector(23.5,25);
PVector playfield_Bottomright=new PVector(291,313);//The coordinates of the top-left and bottom-right corners of the game field.游戏区左上角和右下角的坐标

float ballRadius=7;
float blocksize;

PImage settingButton;
PImage elementsShow;

void setup(){
    size(400,400);
    
    blocksize=(playfield_Bottomright.x-playfield_Topleft.x)/10;// Initialization must occur before constructing the block group.
    isBallMoving=false;
    paddle=new Paddle('A', 'D', 'J', 'L');
    timer=new Timer(0,10);

    imageLoad();

    reset();
    startANewTurn();
}

void draw(){
    background(255);
    drawPlayField();
    drawBackground();
    drawRemainingBalls();//Draw the remaining balls.画出剩余的球
    timer.show();
    if(timer.isTimeEnd())reset();//Temporarily set the game to restart when the time runs out

    for(int i=0;i<9;i++){
        for(int j=0;j<8;j++){
            //if(blocks[i][j].exist)println("Success to draw",i," ",j," ",blocks[i][j].element.name());
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

            ball.move();
            ball.show();

            if(ball.directionOfHitBlock>0){//Must be after the ball.move()
                //println("hit");
                int bi=int(ball.hitblock.x),bj=int(ball.hitblock.y);
                React reaction=blocks[bi][bj].react(ball);
                switch(reaction){
                    case EXPLOSION://destroys blocks in a cross-shaped range.
                        blocks[bi][bj].exist
                        =blocks[constrain(bi-1, 0, 8)][bj].exist
                        =blocks[constrain(bi+1, 0, 8)][bj].exist
                        =blocks[bi][constrain(bj-1, 0, 7)].exist
                        =blocks[bi][constrain(bj+1, 0, 7)].exist
                        =false;
                        break;

                    case MELTING://turns surrounding adjacent blocks into ice elements.
                        blocks[bi][bj].element
                        =blocks[constrain(bi-1, 0, 8)][bj].element
                        =blocks[constrain(bi+1, 0, 8)][bj].element
                        =blocks[bi][constrain(bj-1, 0, 7)].element
                        =blocks[bi][constrain(bj+1, 0, 7)].element
                        =Element.ICE;
                        break;

                    case SUPERCON:// Eliminate the three blocks horizontally.消除水平的三个方块
                        blocks[bi][bj].exist
                        =blocks[constrain(bi-1, 0, 8)][bj].exist
                        =blocks[constrain(bi+1, 0, 8)][bj].exist
                        =false;
                        break;
                }

            }
        }
        
        if(combo>=3){// Split when achieving a combo of 5.连击达到5，分裂
            combo=0;
            currentBalls.add(new Ball(currentBalls.get(0).pos.x,currentBalls.get(0).pos.y,ballRadius));// Split a ball at the position of the ball in sequence 0.
        }
        
        
    }
    else{
        Ball ball=currentBalls.get(0);
        ball.pos.x=paddle.middleX;
        ball.element=paddle.element;
        ball.show();

    }

    paddle.move();
    paddle.show();//paddle shows in front of balls
     
}

void keyPressed(){
    if(key==' ' && !isBallMoving){//Launch the ball by pressing the space bar. 按空格发射球
        //println("Shooting Success");
        currentBalls.get(0).move();
        isBallMoving=true;
    }
    paddle.elementDirection(key);
    paddle.direction(key);
}
void keyReleased(){
    paddle.stop(key);

}
void drawRemainingBalls() {
    //the code for drawing the remaining balls 画出剩余的球的逻辑
} 
void drawPlayField(){
    stroke(0);strokeWeight(0);fill(190);
    rectMode(CORNERS);rect(playfield_Topleft.x,playfield_Topleft.y,playfield_Bottomright.x,playfield_Bottomright.y);
    fill(256);
    stroke(0);strokeWeight(1);fill(256);rectMode(CORNER);
    rect(13,326,290,70);
}
void drawBackground(){
    image(settingButton,333,25,32,33);
    image(elementsShow,68,329.5,165,22.5);
}
void startANewTurn(){//start a new shooting turn
    timer.timeStart();
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

void imageLoad(){
    settingButton=loadImage("settingButton.png");
    elementsShow=loadImage("elementShow.png");
}