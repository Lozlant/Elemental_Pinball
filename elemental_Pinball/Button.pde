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
        checkHovering();
        switch(buttonState){
            case NORMAL:
                image(img,x,y,w,h);
                break;
            case HOVER:
                image(img,x,y,w,h);
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
        buttonState=ButtonState.CLICKED;
    }
    void released(){
        state=toState;
        buttonState=ButtonState.NORMAL;
    }

} 


Button backButton;
Button settingButton;

void initializeButtons(){
    backButton=new Button(backButtun_Show,GameState.GAMING,22.5,22.5,79.5,54.5);
    settingButton=new Button(settingButton_Show,GameState.SETTING,333,25,32,33);
}