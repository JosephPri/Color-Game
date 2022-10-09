//Booleans
boolean mouseTouchingCircle(float x, float y, float r) {
  if (dist(x, y, mouseX, mouseY) < r) {
    return true;
  } else {
    return false;
  }
}


boolean doubleMouseTouchingCircle(float x, float y, float r, float x2, float y2) {
  if ((dist(x, y, mouseX, mouseY ) < r) || (dist(x2, y2, mouseX, mouseY) < r)) {
    return true;
  } else {
    return false;
  }
}


boolean mouseTouchingRect(float x, float y, float w, float h) {
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
    return true;
  } else {
    return false;
  }
}



void mouseClicked() {
  if (mode == INTRO) {
    introClicks();
  } else if (mode == GAME) {
    gameClicks();
  } else if (mode == GAMEOVER) {
    gameoverClicks();
  }
}



void keyPressed() {
  if (mode == INTRO) {
    introKeys();
  } else if (mode == GAME) {
    gameKeys();
  } else if (mode == GAMEOVER) {
    gameoverKeys();
  }
}



void tactileRect(float x, float y, float w, float h, color fill, color highlight) {
  stroke(fill);
  fill(fill);
  if (mouseTouchingRect(x, y, w, h)) {
    fill(highlight);
  } else {
    fill(fill);
  }
  rect(x, y, w, h);
}



void transTactileRect(int x, int y, int w, int h, color fill) {
  if (mouseTouchingRect(x, y, w, h)) {
    strokeWeight(0);
    fill(fill, 80);
  } else {
    strokeWeight(0);
    fill(fill, 0);
  }
  rect(x, y, w, h);
}



void tactileCircle(float x, float y, float scale, color stroke, color fill, color highlight) {
  stroke(stroke);
  fill(fill);
  if (mouseTouchingCircle(x, y, scale/2)) {
    fill(highlight);
  } else {
    fill(fill);
  }
  circle(x, y, scale);
}



//Intro Play Button
void doubleTactileCircle(float x, float y, float scale, color fill, color highlight, float x2, float y2, float x3, float y3, float w3, float h3) {
  stroke(fill);
  fill(fill);
  if (doubleMouseTouchingCircle(x, y, scale/2, x2, y2) || mouseTouchingRect(x3, y3, w3, h3)) {
    fill(highlight);
    stroke(highlight);
    a = createShape();
    a.beginShape();
    a.fill(highlight);
    a.stroke(highlight);
    a.vertex(187.5, 575);
    a.vertex(612.5, 575);
    a.vertex(612.5, 750);
    a.vertex(187.5, 750);
    a.beginContour();
    a.vertex(450, 662.5);
    a.vertex(350, 612.5);
    a.vertex(350, 712.5);
    a.endContour();
    a.endShape(CLOSE);
  } else {
    fill(fill);
    a = createShape();
    a.beginShape();
    a.fill(white);
    a.stroke(white);
    a.vertex(187.5, 575);
    a.vertex(612.5, 575);
    a.vertex(612.5, 750);
    a.vertex(187.5, 750);
    a.beginContour();
    a.vertex(450, 662.5);
    a.vertex(350, 612.5);
    a.vertex(350, 712.5);
    a.endContour();
    a.endShape(CLOSE);
  }
  circle(x, y, scale);
  circle(x2, y2, scale);
  shape(a);
}



//Home Button Function
void overHDoubleTactileCircle(float x, float y, float scale, color fill, color highlight, float x2, float y2, float x3, float y3, float w3, float h3) {
  stroke(fill);
  fill(fill);
  if (doubleMouseTouchingCircle(x, y, scale/2, x2, y2) || mouseTouchingRect(x3, y3, w3, h3)) {
    fill(highlight);
    stroke(highlight);
    c = createShape();
    c.beginShape();
    c.fill(highlight);
    c.stroke(highlight);
    c.vertex(137.5, 575);
    c.vertex(287.5, 575);
    c.vertex(287.5, 750);
    c.vertex(137.5, 750);
    c.beginContour();
    c.vertex(165, 652.5); //9
    c.vertex(165, 714.5); //8
    c.vertex(198.75, 714.5); //7
    c.vertex(198.75, 675); //6
    c.vertex(226.25, 675); //5
    c.vertex(226.25, 714.5); //4
    c.vertex(260, 714.5); //3
    c.vertex(260, 652.5); //2
    c.vertex(212.5, 610); //1
    c.endContour();
    c.endShape(CLOSE);
  } else {
    fill(fill);
    c = createShape();
    c.beginShape();
    c.fill(white);
    c.stroke(white);
    c.vertex(137.5, 575);
    c.vertex(287.5, 575);
    c.vertex(287.5, 750);
    c.vertex(137.5, 750);
    c.beginContour();
    c.vertex(165, 652.5); //9
    c.vertex(165, 714.5); //8
    c.vertex(198.75, 714.5); //7
    c.vertex(198.75, 675); //6
    c.vertex(226.25, 675); //5
    c.vertex(226.25, 714.5); //4
    c.vertex(260, 714.5); //3
    c.vertex(260, 652.5); //2
    c.vertex(212.5, 610); //1
    c.endContour();
    c.endShape(CLOSE);
  }
  arc(137.5, 662.5, 175, 175, radians(90), radians(270));
  arc(287.5, 662.5, 175, 175, radians(270), radians(450));
  shape(c);
}



//Gameover Play Button
void overPDoubleTactileCircle(float x, float y, float scale, color fill, color highlight, float x2, float y2, float x3, float y3, float w3, float h3) {
  stroke(fill);
  fill(fill);
  if (doubleMouseTouchingCircle(x, y, scale/2, x2, y2) || mouseTouchingRect(x3, y3, w3, h3)) {
    fill(highlight);
    stroke(highlight);
    b = createShape();
    b.beginShape();
    b.fill(highlight);
    b.stroke(highlight);
    b.vertex(512.5, 575);
    b.vertex(662.5, 575);
    b.vertex(662.5, 750);
    b.vertex(512.5, 750);
    b.beginContour();
    b.vertex(632.5, 662.5);
    b.vertex(542.5, 612.5);
    b.vertex(542.5, 712.5);
    b.endContour();
    b.endShape(CLOSE);
  } else {
    fill(fill);
    b = createShape();
    b.beginShape();
    b.fill(white);
    b.stroke(white);
    b.vertex(512.5, 575);
    b.vertex(662.5, 575);
    b.vertex(662.5, 750);
    b.vertex(512.5, 750);
    b.beginContour();
    b.vertex(632.5, 662.5);
    b.vertex(542.5, 612.5);
    b.vertex(542.5, 712.5);
    b.endContour();
    b.endShape(CLOSE);
  }
  arc(512.5, 662.5, 175, 175, radians(90), radians(270));
  arc(662.5, 662.5, 175, 175, radians(270), radians(450));
  shape(b);
}
