void mousePressed(){
    switch(state){
        case START:
            startButton.clicked();
            break;
        case GAMING:
            settingButton.clicked();
            break;
        case SETTING:
            backButton.clicked();
            mainMenuButton.clicked();
            break;
    }
}

void mouseReleased() {
    switch(state){
        case START:
            startButton.released();
            reset();
            break;
        case GAMING:
            settingButton.released();
            break;
        case SETTING:
            backButton.released();
            mainMenuButton.released();
            break;
    }
}