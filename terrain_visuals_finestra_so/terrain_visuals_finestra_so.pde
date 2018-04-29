import controlP5.*;
import processing.pdf.*;
import java.awt.Frame;
import java.util.*;

import ddf.minim.*;

Minim minim;
AudioInput in;


/*GUI*/
ControlFrame cf;
int myCurrentIndex = 0;
//canviar opacitat del negre de fons per a deixar rastre
int cnt =0;
float trans_fons;
int grosor_malla;
boolean toggle_fons=false;
int level_f;
int una_malla;

int num;
boolean record;
int c;
int cols, rows;
/*amples dels espais rectaculars o siga de les cel·les*/
/*amplària en pixels de la malla*/

/*VALORS tamany malla*/
float entrada, eixida;
float mov_cols, mov_files;

float [][] terrain;

float turnSpeed = radians(0.8);
int w, h;

Malla m1;
Malla m2;


long maxMemory;
long allocatedMemory;
long freeMemory; 
void settings() {
  //fullScreen(P3D,2);
  /*fullScreen(display)
   fullScreen(renderer)
   fullScreen(renderer, display)*/
  size(displayWidth, displayHeight, P3D);
}

void setup() {
  initKNC2();
  int num;

  minim = new Minim(this);
  in = minim.getLineIn();

  m1 = new Malla(50, 800, 500, 0.01);
  m2 = new Malla(20, 800, 500, 0.009);

  cf = new ControlFrame(this, 400, 800, "Controls");
  surface.setLocation(420, 10);
  //frameRate(50);
}

void draw() {
maxMemory = Runtime.getRuntime().maxMemory();
allocatedMemory = Runtime.getRuntime().totalMemory();
freeMemory = Runtime.getRuntime().freeMemory();
  updateKNC2();
  smooth();
  if (toggle_fons==false) {
    noStroke();
    fill(0, trans_fons);
    rect(0, 0, level_f, displayWidth, displayHeight);
  } else {
    background(0);
  }
  translate(width/2, height/2);

  switch(num) {
  case 0: 
    break;
  case 1:
    m1.movement(16, 17, 18, 19);
    m1.colors_malla(myCurrentIndex, 1, 0);
    m1.update(1, 2, 3);
    break;
  case 2:
    m2.movement(20, 21, 22, 23);
    m2.colors_malla(myCurrentIndex, 0, 4);
    m2.update(5, 6, 7);
    break;
  case 3:
    pushMatrix();
    m1.movement(16, 17, 18, 19);
    m1.colors_malla(myCurrentIndex, 1, 0);
    m1.update(1, 2, 3);
    popMatrix();
    pushMatrix();
    m2.movement(20, 21, 22, 23);
    m2.colors_malla(myCurrentIndex, 0, 4);
    m2.update(5, 6, 7);
    popMatrix();
    break;
  }

  /*if (record) {
   beginRaw(PDF, "output_quad"+c+".pdf");
   }*/
  //noFill();

  /*if (keyPressed) {
   if (keyCode == LEFT) {
   ty +=turnSpeed;
   } else if (keyCode == RIGHT) {
   ty -=turnSpeed;
   }
   if (keyCode == UP) {
   //tx = max(tx-turnSpeed, -PI/2);
   tx +=turnSpeed;
   } else if (keyCode == DOWN) {
   //tx = min(tx+turnSpeed, PI/2);
   tx -=turnSpeed;
   }
   }*/

  if (record) {
    endRaw();
    record = false;
  }
}


void keyPressed() {
  if (key == 'r') {
    record = true;
    c=c+1;
  }
  //passar als botons de la controladora

  //malles colocar
  if (key == '6') {
    num=0;
  } else if (key == '7') {
    num=1;
  } else if (key == '8') {
    num=2;
  } else if (key == '9') {
    num=3;
  }
}