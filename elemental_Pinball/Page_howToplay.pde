void howToPlay() {
  background(255); 
  fill(0); 
  textSize(12); 

  String instructions = "How to Play:\n" +
                        "Players use 'A' and 'D' to move the Paddle left and right.\n" +
                        "Use 'J' and 'L' to change the Paddle's attributes.\n" +
                        "Fire + Lightning = Explosion, which destroys blocks within a cross range.\n" +
                        "Fire + Ice = Melting, which dyes the blocks within a cross range with the ice element.\n" +
                        "Lightning + Ice = Superconductivity, which destroys blocks in the adjacent straight range.\n\n" +
                        "Every time you hit the ball 3 times, an extra ball will split off.\n" +
                        "Players can go to the settings menu and click 'End The Game' to end the game manually.";

  textAlign(LEFT);
  text(instructions, 10, 100, 380, 340); 

  backButton.show();
}