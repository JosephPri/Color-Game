void gameover() {
  //Background GIF
  image(rainbow[f], 0, 0, 800, 800);
  if (frameCount % 6 == 0) f = f + 1;
  if (f == rImageCount) f = 0;

  //"Best" If Statement
  if (score > best) {
    best = score;
  }

  //"GAMEOVER" Text
  fill(white);
  textFont(monument);
  textSize(175);
  textAlign(CENTER, CENTER);
  text("GAME", 400, 150);
  text("OVER", 400, 300);

  //Stats
  textSize(60);
  text("SCORE: "+score+"", 275, 437.5);
  text("BEST: "+best+"", 250, 502.5);

  //Button Highlights
  overHDoubleTactileCircle(137.5, 662.5, 175, white, pastelwhite, 287.5, 662.5, 137.5, 575, 150, 175); //Home Button
  overPDoubleTactileCircle(512.5, 662.5, 175, white, pastelwhite, 662.5, 662.5, 512.5, 575, 150, 175); //Play Button
}

void gameoverClicks() {
  if ((doubleMouseTouchingCircle(137.5, 662.5, 87.5, 287.5, 662.5)) && mode == GAMEOVER || mouseTouchingRect(137.5, 575, 150, 175) && mode == GAMEOVER) { //Home Button
    mode = INTRO;
    println("mode is now intro");
  }
  if ((doubleMouseTouchingCircle(512.5, 662.5, 87.5, 662.5, 662.5)) && mode == GAMEOVER || mouseTouchingRect(512.5, 575, 150, 175) && mode == GAMEOVER) { //Play Button
    randomColor = int(random(0, 6));
    randomWord = int(random(0, 6));
    split = int(random(0, 2));
    mode = GAME; //replaybutton
    score = 0;
    timer = 0;
    vtimer = 0;
    wordscale= 0;
    println("mode is now game");
  }
}
