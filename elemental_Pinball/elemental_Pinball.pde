//Elemental Pinball by Yunhao Chen, Nov 21, 2023
//The Chinese after each comment serves as the translation of the comment, 
//intended for the convenience of the author's personal reading.

Paddle paddle;
Block[][] blocks = new Block[9][8];//9 blocks per line, 8 lines
PVector[][] blocks_position=new PVector[9][8];//记录block的坐标
Timer timer;
Level[] levels= new Level[3];
Score score;

enum Element {_NULL,FIRE,ICE,THUNDER}//enum球或者板的属性
enum React {_NULL,EXPLOSION,MELTING,SUPERCON}//enum元素反应的类型
enum Direction{_NULL,UP,DOWN,LEFT,RIGHT}//enum 球的碰撞方向
enum GameState{START,GAMING,SETTING,INTRO,END}//enum 游戏的阶段
enum ButtonState{NORMAL,HOVER,CLICKED}//enum Button的状态

int combo;//记录连击数
ArrayList<Ball> currentBalls= new ArrayList<Ball>();//记录球的队列

PVector playfield_Topleft=new PVector(23.5,25);
PVector playfield_Bottomright=new PVector(291,313);//The coordinates of the top-left and bottom-right corners of the game field.

float ballRadius=7;//记录球的半径
float blocksize;//记录block的大小

GameState state;//记录游戏阶段

void setup(){
    size(400,400);
    imageLoad();//Load all image
    
    blocksize=(playfield_Bottomright.x-playfield_Topleft.x)/10;// Initialization must occur before constructing the block group.
    
    paddle=new Paddle('A', 'D', 'J', 'L');//'A '' D' is used to move the paddle left and right, and 'J''L' is used to modify the elements of the paddle
    timer=new Timer(2,0);//Set the timer countdown to 2 minutes 0 seconds
    score=new Score();//Construct the score
    levels[0] = new Level("315 2232 414 41112");//Use codes to edit the level, how to code see document'Code and Decode level introduction'
    levels[1] = new Level("1224 81 4311 018 414 531");
    levels[2] = new Level("324 1341 0432 18 3123 0351 81");
    startBall=new StartBall(width/2,250,30);

    initializeBlocksPosition();// Convert the position of the block to coordinates.
    
    initializeButtons();
    
    state=GameState.START;
    resetGame();
}

void draw(){
    switch(state){//What state the game is in and the corresponding page the content is displayed
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
            howToPlay();
            break;
        case END:
            endPage();
            break;

    }
     
}

