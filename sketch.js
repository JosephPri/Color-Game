// Joseph Priatel - Sept 27, 2022
// Color Game (web port of the Processing sketch to p5.js)

// ---------- Palette ----------
const RED = '#FF595E';
const ORANGE = '#FF924C';
const YELLOW = '#FFCA3A';
const GREEN = '#8AC926';
const BLUE = '#1982C4';
const PURPLE = '#6A4C93';
const WHITE = 255;
const PASTELWHITE = '#E9E9E9';

const words = ['RED', 'ORANGE', 'YELLOW', 'GREEN', 'BLUE', 'PURPLE'];
const colors = [RED, ORANGE, YELLOW, GREEN, BLUE, PURPLE];

// ---------- State ----------
let leftx, rightx, vtimer, wordscale;
let mode, score = 0, best = 0, timer = 0;
let f = 0;
let split, randomWord, randomColor;
let correct = false;

const INTRO = 0;
const GAME = 1;
const GAMEOVER = 3;

const rImageCount = 71;
let rainbow = [];
let monument;

// ---------- Audio (plain HTML audio so there are no extra libraries) ----------
let song, correctsound, gameoversound;
let audioStarted = false;

function startAudio() {
  // Browsers only allow sound after a click/keypress, so we start on the first one.
  if (audioStarted) return;
  audioStarted = true;
  song.loop = true;
  song.play().catch(() => { audioStarted = false; });
}

function playSfx(a) {
  a.currentTime = 0;
  a.play().catch(() => {});
}

// ---------- p5 lifecycle ----------
function preload() {
  for (let i = 0; i < rImageCount; i++) {
    rainbow[i] = loadImage('data/frame_' + i + '_delay-0.01s.gif');
  }
  monument = loadFont('data/MonumentExtended-Ultrabold.otf');
}

function setup() {
  const c = createCanvas(800, 800);
  c.parent('game');
  pixelDensity(1);
  frameRate(60);

  song = new Audio('data/8bit2.mp3');
  correctsound = new Audio('data/8bit_correct.mp3');
  gameoversound = new Audio('data/8bit_gameover.mp3');

  split = int(random(0, 2));
  randomWord = int(random(0, 6));
  randomColor = int(random(0, 6));

  timer = 0;
  vtimer = 0;
  wordscale = 0;
  leftx = -440;
  rightx = 1240;
  mode = INTRO;
}

function draw() {
  if (mode === INTRO) intro();
  else if (mode === GAME) game();
  else if (mode === GAMEOVER) gameover();
}

function drawBackground() {
  image(rainbow[f], 0, 0, 800, 800);
  if (frameCount % 6 === 0) f = f + 1;
  if (f === rImageCount) f = 0;
}

// ---------- INTRO ----------
function intro() {
  drawBackground();

  noStroke();
  fill(WHITE);
  textFont(monument);
  textSize(175);
  textAlign(CENTER, CENTER);
  text('COLOR', leftx, 300);
  text('TONE', rightx, 450);

  if (leftx < 400) leftx = leftx + 10;
  if (rightx > 400) rightx = rightx - 10;

  doubleTactileCircle(612.5, 662.5, 175, WHITE, PASTELWHITE, 187.2, 662.5, 187.5, 575, 425, 175);
}

function introClicks() {
  if (doubleMouseTouchingCircle(612.5, 662.5, 87.5, 187.2, 662.5) || mouseTouchingRect(187.5, 575, 425, 175)) {
    playButton();
  }
}

function introKeys() {
  if (key === ' ') playButton();
}

// ---------- GAME ----------
function game() {
  // 50/50 odds
  if (split === 1) { // Matching
    randomColor = randomWord;
  }
  if (split === 0) { // Not matching
    while (randomColor === randomWord) {
      randomColor = int(random(0, 6));
      randomWord = int(random(0, 6));
    }
  }

  correct = (randomWord === randomColor);

  // Timers
  if (timer < 75) timer = timer + 1;
  if (timer === 75) {
    mode = GAMEOVER;
    playSfx(gameoversound);
  }
  if (vtimer < 800) vtimer = vtimer + 10.67;

  // Word scaler
  if (wordscale < 135) wordscale = wordscale + 1.75;

  // Reset intro text positions
  leftx = -440;
  rightx = 1240;

  drawBackground();

  // Buttons
  noStroke();
  fill(WHITE);
  textFont(monument);
  textAlign(CENTER, CENTER);
  textSize(65);
  text('CORRECT', 565, 55);
  text('INCORRECT', 275, 730);
  transTactileRect(0, 0, 800, 385);
  transTactileRect(0, 415, 800, 385);

  // Visual timer
  strokeWeight(30);
  stroke(255, 125);
  line(0, 400, 800, 400);
  line(0, 400, vtimer, 400);

  // Random word / color
  noStroke();
  textAlign(CENTER, CENTER);
  textSize(wordscale);
  fill(colors[randomColor]);
  text(words[randomWord], 400, 390);
}

function gameClicks() {
  if (mouseTouchingRect(0, 0, 800, 385)) { // top = "CORRECT"
    if (correct) correctChoice(); else incorrectChoice();
  } else if (mouseTouchingRect(0, 415, 800, 385)) { // bottom = "INCORRECT"
    if (!correct) correctChoice(); else incorrectChoice();
  }
}

function gameKeys() {
  if (keyCode === UP_ARROW) {
    if (correct) correctChoice(); else incorrectChoice();
  } else if (keyCode === DOWN_ARROW) {
    if (!correct) correctChoice(); else incorrectChoice();
  }
}

function correctChoice() {
  randomColor = int(random(0, 6));
  randomWord = int(random(0, 6));
  split = int(random(0, 2));
  playSfx(correctsound);
  score = score + 1;
  timer = 0;
  vtimer = 0;
  wordscale = 0;
}

function incorrectChoice() {
  mode = GAMEOVER;
  playSfx(gameoversound);
  timer = 0;
  vtimer = 0;
  wordscale = 0;
}

// ---------- GAME OVER ----------
function gameover() {
  drawBackground();

  if (score > best) best = score;

  noStroke();
  fill(WHITE);
  textFont(monument);
  textSize(175);
  textAlign(CENTER, CENTER);
  text('GAME', 400, 150);
  text('OVER', 400, 300);

  textSize(60);
  text('SCORE: ' + score, 275, 437.5);
  text('BEST: ' + best, 250, 502.5);

  overHDoubleTactileCircle(137.5, 662.5, 175, WHITE, PASTELWHITE, 287.5, 662.5, 137.5, 575, 150, 175); // Home
  overPDoubleTactileCircle(512.5, 662.5, 175, WHITE, PASTELWHITE, 662.5, 662.5, 512.5, 575, 150, 175); // Play
}

function gameoverClicks() {
  if (doubleMouseTouchingCircle(137.5, 662.5, 87.5, 287.5, 662.5) || mouseTouchingRect(137.5, 575, 150, 175)) {
    homeButton();
  } else if (doubleMouseTouchingCircle(512.5, 662.5, 87.5, 662.5, 662.5) || mouseTouchingRect(512.5, 575, 150, 175)) {
    playButton();
  }
}

function gameoverKeys() {
  if (key === ' ') playButton();
  if (keyCode === BACKSPACE) homeButton();
}

function playButton() {
  randomColor = int(random(0, 6));
  randomWord = int(random(0, 6));
  split = int(random(0, 2));
  mode = GAME;
  score = 0;
  timer = 0;
  vtimer = 0;
  wordscale = 0;
}

function homeButton() {
  mode = INTRO;
}

// ---------- INPUT ----------
function mouseTouchingRect(x, y, w, h) {
  return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
}

function doubleMouseTouchingCircle(x, y, r, x2, y2) {
  return dist(x, y, mouseX, mouseY) < r || dist(x2, y2, mouseX, mouseY) < r;
}

function mouseClicked() {
  startAudio();
  if (mode === INTRO) introClicks();
  else if (mode === GAME) gameClicks();
  else if (mode === GAMEOVER) gameoverClicks();
  return false;
}

function keyPressed() {
  startAudio();
  if (mode === INTRO) introKeys();
  else if (mode === GAME) gameKeys();
  else if (mode === GAMEOVER) gameoverKeys();
  // stop arrows / space / backspace from scrolling or navigating the page
  if (keyCode === UP_ARROW || keyCode === DOWN_ARROW || key === ' ' || keyCode === BACKSPACE) return false;
}

// ---------- BUTTON DRAWING ----------
function transTactileRect(x, y, w, h) {
  noStroke();
  if (mouseTouchingRect(x, y, w, h)) fill(255, 80);
  else fill(255, 0);
  rect(x, y, w, h);
}

// Intro play button
function doubleTactileCircle(x, y, scale, fillCol, highlight, x2, y2, x3, y3, w3, h3) {
  const hover = doubleMouseTouchingCircle(x, y, scale / 2, x2, y2) || mouseTouchingRect(x3, y3, w3, h3);
  const col = hover ? highlight : fillCol;
  fill(col);
  stroke(col);
  strokeWeight(1);
  circle(x, y, scale);
  circle(x2, y2, scale);
  beginShape();
  vertex(187.5, 575); vertex(612.5, 575); vertex(612.5, 750); vertex(187.5, 750);
  beginContour();
  vertex(450, 662.5); vertex(350, 612.5); vertex(350, 712.5);
  endContour();
  endShape(CLOSE);
}

// Game over: home button
function overHDoubleTactileCircle(x, y, scale, fillCol, highlight, x2, y2, x3, y3, w3, h3) {
  const hover = doubleMouseTouchingCircle(x, y, scale / 2, x2, y2) || mouseTouchingRect(x3, y3, w3, h3);
  const col = hover ? highlight : fillCol;
  fill(col);
  stroke(col);
  strokeWeight(1);
  arc(137.5, 662.5, 175, 175, radians(90), radians(270));
  arc(287.5, 662.5, 175, 175, radians(270), radians(450));
  beginShape();
  vertex(137.5, 575); vertex(287.5, 575); vertex(287.5, 750); vertex(137.5, 750);
  beginContour();
  vertex(165, 652.5); vertex(165, 714.5); vertex(198.75, 714.5); vertex(198.75, 675);
  vertex(226.25, 675); vertex(226.25, 714.5); vertex(260, 714.5); vertex(260, 652.5);
  vertex(212.5, 610);
  endContour();
  endShape(CLOSE);
}

// Game over: play button
function overPDoubleTactileCircle(x, y, scale, fillCol, highlight, x2, y2, x3, y3, w3, h3) {
  const hover = doubleMouseTouchingCircle(x, y, scale / 2, x2, y2) || mouseTouchingRect(x3, y3, w3, h3);
  const col = hover ? highlight : fillCol;
  fill(col);
  stroke(col);
  strokeWeight(1);
  arc(512.5, 662.5, 175, 175, radians(90), radians(270));
  arc(662.5, 662.5, 175, 175, radians(270), radians(450));
  beginShape();
  vertex(512.5, 575); vertex(662.5, 575); vertex(662.5, 750); vertex(512.5, 750);
  beginContour();
  vertex(632.5, 662.5); vertex(542.5, 612.5); vertex(542.5, 712.5);
  endContour();
  endShape(CLOSE);
}
