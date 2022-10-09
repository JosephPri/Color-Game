//Joseph Priatel
//Sept 27, 2022
//Color Game


//Minim Setup
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim minim;
AudioPlayer song;
AudioPlayer correctsound;
AudioPlayer gameoversound;


//Palette
//coolors.co/palette/ff595e-ff924c-ffca3a-8ac926-1982c4-6a4c93
color red = #FF595E;
color orange = #FF924C;
color yellow = #FFCA3A;
color green = #8AC926;
color blue = #1982C4;
color purple = #6A4C93;
color white = 255;
color pastelwhite = #E9E9E9;
color playbutton = white;


//Arrays
String[] words = {"RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "PURPLE"}; //{0, 1, 2, 3, 4}
color[] colors = {red, orange, yellow, green, blue, purple}; //{0, 1, 2, 3, 4}


//Floats
float leftx;
float rightx;
float vtimer;
float wordscale;


//Ints
int mode;
int score;
int best;
int timer;
int rImageCount;
int f;
int split = (int) random(0, 2);
int randomWord = (int) random(0, 6);
int randomColor = (int) random(0, 6);

final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;


//P-Values
PShape a;
PShape b;
PShape c;
PImage[] rainbow;
PFont monument;

//Booleans
boolean correct;



void setup() {
  size(800, 800, P2D);


  //Background GIF
  rImageCount = 71;
  rainbow = new PImage[rImageCount];
  int i = 0;
  while (i < rImageCount) {
    rainbow[i] = loadImage("frame_"+i+"_delay-0.01s.gif");
    i = i + 1;
  }


  //Minim
  minim = new Minim(this);
  song = minim.loadFile("8bit2.mp3");
  correctsound = minim.loadFile("8bit_correct.mp3");
  gameoversound = minim.loadFile("8bit_gameover.mp3");
  song.play();


  //Custom Font
  monument = createFont("MonumentExtended-Ultrabold.otf", 175); //Font


  //Integer Presets
  timer = 0;
  vtimer = 0;
  wordscale = 0;
  leftx = -440;
  rightx = 1240;
  mode = INTRO;


  //Debug
  println(split);
}



void draw() {
  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == GAMEOVER) {
    gameover();
  } else {
    println("Mode Error: Mode is " + mode);
  }
}
