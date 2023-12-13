class Button{
    PImage img;
    GameState toState;
    float x,y,w,h;

    ButtonState buttonState;

    Button(PImage i,GameState s,float _x, float _y,float _w, float _h){
        img=i;
        toState=s;
        x=_x;y=_y;w=_w;h=_h;
    }

    void show(){
        rectMode(CORNER);noStroke();
        checkHovering();
        switch(buttonState){
            case NORMAL:
                image(img,x,y,w,h);
                break;
            case HOVER:
                image(img,x,y,w,h);
                fill(255,80);rect(x,y,w,h);
                break;
            case CLICKED:
                image(img,x,y,w,h);
                break;

        }
    }
    void checkHovering(){
        if(mouseX>=x && mouseY>=y && mouseX<=x+w && mouseY<=y+h && buttonState!=ButtonState.CLICKED)buttonState=ButtonState.HOVER;
        else if(buttonState!=ButtonState.CLICKED)buttonState=ButtonState.NORMAL;
    }
    void clicked(){
        if(buttonState==ButtonState.HOVER)
            buttonState=ButtonState.CLICKED;
    }
    void released(int i){
        if(buttonState==ButtonState.CLICKED){
            state=toState;
            switch(toState){
                case GAMING:
                    if(i==1)resetGame();
                    break;
            }
            buttonState=ButtonState.NORMAL;
        }
    }

}

class Button_withText extends Button{
    PImage img_text;
    float tx,ty,tw,th;
    Button_withText(PImage i,GameState s,float _x, float _y,float _w, float _h,PImage t,float _tx, float _ty,float _tw, float _th){
        super(i,s,_x,_y,_w,_h);
        tx=_tx;ty=_ty;tw=_tw;th=_th;
        img_text=t;
    }
    void show(){
        super.show();
        switch(buttonState){
            case NORMAL:
                image(img_text,tx,ty,tw,th);
                break;
            case HOVER:
                image(img_text,tx,ty,tw,th);
                break;
            case CLICKED:
                break;
        }
    }
}


Button backButton;
Button settingButton;

Button_withText startButton;
Button_withText howToPlayButton;
Button_withText mainMenuButton;
Button_withText endTheGameButton;

void initializeButtons(){
    backButton=new Button(backButtun_Show,GameState.GAMING,22.5,22.5,79.5,54.5);
    settingButton=new Button(settingButton_Show,GameState.SETTING,333,25,32,33);

    startButton=new Button_withText(startButton_Show,GameState.GAMING,73,329,268,30.5,startText,141,333.5,134.5,23.5);
    howToPlayButton=new Button_withText(settingMenuButton_Show,GameState.INTRO,72,125,257,50.5,howToPlayText,98,132,196,38);
    mainMenuButton=new Button_withText(settingMenuButton_Show,GameState.START,72,199.5,257,50.5,mainMenuText,102,210.5,199.5,30);
    endTheGameButton=new Button_withText(settingMenuButton_Show,GameState.END,72,274,257,50.5,endTheGameText,109.5,282.5,208,34);

}