void mousePressed(){
    switch(state){
        case GAMING:
            if(settingButton.buttonState==ButtonState.HOVER)settingButton.clicked();
            break;
        case SETTING:
            if(backButton.buttonState==ButtonState.HOVER)backButton.clicked();
            break;
    }
}

void mouseReleased() {
    switch(state){
        case GAMING:
            if(settingButton.buttonState==ButtonState.CLICKED)settingButton.released();
            break;
        case SETTING:
            if(backButton.buttonState==ButtonState.CLICKED)backButton.released();
            break;
    }
}