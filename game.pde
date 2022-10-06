void game() {
  //If Statements
  //50/50 Odds
  if (split == 1) { //Matching
    randomColor = int(random(0, 6));
    randomColor = randomWord;
  }
  if (split == 0) { //Not Matching
    while (randomColor == randomWord) {
      randomColor = int(random(0, 6));
      randomWord = int(random(0, 6));
    }
  }

  //Correct or Incorrect Boolean
  if ( randomWord == randomColor) {
    correct = true;
  } else {
    correct = false;
  }

  //Timers
  if (timer < 75) { //Timer
    timer = timer + 1;
  }
  if (timer == 75) { //Timer
    mode = GAMEOVER;
    gameoversound.play();
    gameoversound.rewind();
  }
  if (vtimer < 800) { //Visual Timer
    vtimer = vtimer + 10.67;
  }

  //Word-Scaler
  if (wordscale < 135) {
    wordscale = wordscale + 1.75;
  }


  //Intro Text Presets
  leftx = -440;
  rightx = 1240;

  //Background GIF
  image(rainbow[f], 0, 0, 800, 800);
  if (frameCount % 6 == 0) f = f + 1;
  if (f == rImageCount) f = 0;

  //Buttons
  fill(white);
  textSize(65);
  text("CORRECT", 565, 55);
  text("INCORRECT", 275, 730);
  transTactileRect(0, 0, 800, 385, white);
  transTactileRect(0, 415, 800, 385, white);

  //Visual Timer
  strokeWeight(30);
  stroke(white, 125);
  line(0, 400, 800, 400);
  fill(white);
  line(0, 400, vtimer, 400);


  //Random Word/Color
  strokeWeight(1);
  textAlign(CENTER, CENTER);
  textSize(wordscale);
  fill(colors[randomColor]);
  text(words[randomWord], 400, 390);
}


void gameClicks() { //Button Functions
  //"Correct" Buttons
  if ((mouseTouchingRect(0, 0, 800, 385)) && mode == GAME && correct) { //Corect Choice
    correctChoice();
  }
  if ((mouseTouchingRect(0, 0, 800, 385)) && mode == GAME && !correct) { //Incorect Choice
    incorrectChoice();
  }

  //"Incorrect" Buttons
  if ((mouseTouchingRect(0, 415, 800, 385)) && mode == GAME && !correct) { //Correct Choice
    correctChoice();
  }
  if ((mouseTouchingRect(0, 415, 800, 385)) && mode == GAME && correct) { //Incorrect Choice
    incorrectChoice();
  }
}

void correctChoice() {
  randomColor = int(random(0, 6));
  randomWord = int(random(0, 6));
  split = int(random(0, 2));
  correctsound.play();
  correctsound.rewind();
  score = score + 1;
  timer = 0;
  vtimer = 0;
  wordscale= 0;
}

void incorrectChoice() {
  mode = GAMEOVER;
  gameoversound.play();
  gameoversound.rewind();
  timer = 0;
  vtimer = 0;
  wordscale= 0;
  println("mode is now gameover");
}
