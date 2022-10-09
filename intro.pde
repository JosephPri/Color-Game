void intro () {
  //Background GIF
  image(rainbow[f], 0, 0, 800, 800);
  if (frameCount % 6 == 0) f = f + 1;
  if (f == rImageCount) f = 0;


  //Title Screen (INTRO) Text
  fill(white);
  textFont(monument);
  textSize(175);
  textAlign(CENTER, CENTER);
  text("COLOR", leftx, 300);
  text("TONE", rightx, 450);


  //Moving Title Texts
  if (leftx < 400) {
    leftx = leftx + 10;
  }
  if (rightx > 400) {
    rightx = rightx - 10;
  }


  //PlayButton Highlight
  doubleTactileCircle(612.5, 662.5, 175, white, pastelwhite, 187.2, 662.5, 187.5, 575, 425, 175);
}



void introClicks() {
  if ((doubleMouseTouchingCircle(612.5, 662.5, 87.5, 187.2, 662.5)) && mode == INTRO || mouseTouchingRect(187.5, 575, 425, 175) && mode == INTRO) { //Playbutton
    playButton();
  }
}



void introKeys() {
  if (key == ' ') {
    playButton();
  }
}
