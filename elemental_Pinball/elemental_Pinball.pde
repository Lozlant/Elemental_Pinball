//Elemental Pinball by Yunhao Chen, Nov 21, 2023
//The Chinese after each comment serves as the translation of the comment, 
//intended for the convenience of the author's personal reading.

Paddle paddle;
Block[][] blocks = new Block[9][8];//9 blocks per line, 8 lines
PVector[][] blocks_position=new PVector[9][8];
Timer timer;
Level[] levels= new Level[3];
Score score;

enum Element {_NULL,FIRE,ICE,THUNDER}
enum React {_NULL,EXPLOSION,MELTING,SUPERCON}
enum Direction{_NULL,UP,DOWN,LEFT,RIGHT}
enum GameState{START,GAMING,SETTING,INTRO,END}
enum ButtonState{NORMAL,HOVER,CLICKED}

int combo;
int currentBallsID;//The ID of the current activated ball.已经激活的球的编号
ArrayList<Ball> currentBalls= new ArrayList<Ball>();
 
boolean isBallMoving=false;

PVector playfield_Topleft=new PVector(23.5,25);
PVector playfield_Bottomright=new PVector(291,313);//The coordinates of the top-left and bottom-right corners of the game field.游戏区左上角和右下角的坐标

float ballRadius=7;
float blocksize;

GameState state;



void setup(){
    size(400,400);
    imageLoad();
    
    blocksize=(playfield_Bottomright.x-playfield_Topleft.x)/10;// Initialization must occur before constructing the block group.
    isBallMoving=false;
    paddle=new Paddle('A', 'D', 'J', 'L');
    timer=new Timer(2,0);
    score=new Score();
    levels[0] = new Level("315 2232 414 41112");//See the first draft for understand, more levels will be designed later!图详见初版草稿，关卡会后续设计更多
    levels[1] = new Level("1224 81 4311 018 414 531");
    levels[2] = new Level("324 1341 0432 18 3123 0351 81");
    startBall=new StartBall(width/2,250,30);

    initializeBlocksPosition();// Convert the position of the block to coordinates.
    
    initializeButtons();
    
    state=GameState.START;
    resetGame();
}

void draw(){
    switch(state){
        case START:
            startPage();
            break;
        case GAMING:
            gamingPage();
            break;
        case SETTING:
            settingMenu();
            break;
        case INTRO:
            _howToPlay();
            break;
        case END:
            endPage();
            break;

    }
     
}

