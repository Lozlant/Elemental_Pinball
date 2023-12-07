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
            endTheGameButton.clicked();
            break;
        case END:
            startButton.clicked();
    }
}

void mouseReleased() {
    switch(state){
        case START:
            startButton.released(1);
            break;
        case GAMING:
            settingButton.released(0);
            break;
        case SETTING:
            backButton.released(0);
            mainMenuButton.released(0);
            endTheGameButton.released(0);
            break;
        case END:
            startButton.released(1);
    }
}