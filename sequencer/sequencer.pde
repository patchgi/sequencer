import ddf.minim.*;
import ddf.minim.signals.*;

int timeCount=-1, Width=36, add=1, timeSpeed=6;
;
boolean [][]Key=new boolean [Width][5];
int []posX=new int[Width];
int []posY=new int[5];
boolean playstart=false, playstop=false;

Minim minim;
AudioOutput out;
SineWave wave1, wave2, wave3, wave4, wave5;


void setup() {
  size(1800, 250);
  stroke(255);
  for (int i=0;i<Width;i++) {
    for (int j=0;j<5;j++) {
      Key[i][j]=false;
    }
    frameRate(timeSpeed);
  }


  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);
  wave1 = new SineWave(523.23, 0.5, out.sampleRate());
  wave2 = new SineWave(587.34, 0.5, out.sampleRate());
  wave3 = new SineWave(659.25, 0.5, out.sampleRate());
  wave4 = new SineWave(783.98, 0.5, out.sampleRate());
  wave5 = new SineWave(879.99, 0.5, out.sampleRate());
}



void draw() {
  background(0, 0, 0, 50);

  frameRate(timeSpeed);
  DrawingKey();
  DrawingTimeCount();
}

void DrawingKey() {

  for (int i = 0; i < Width; i++ ) {
    for (int j = 0 ; j < 5 ; j++ ) {

      posX[i]=i*50;
      posY[j]=j*50;

      if ( Key[i][j] ) {

        fill(0, 255, 255);

        if (posX[i]==50*timeCount) {

          if (!playstop) {
            if (j==0)out.addSignal(wave1);
            else if (j==1)out.addSignal(wave2);
            else if (j==2)out.addSignal(wave3);
            else if (j==3)out.addSignal(wave4);
            else if (j==4)out.addSignal(wave5);
          }
        }
      }
      else {

        fill(0, 0, 0, 50);

        if (!playstop) {

          if (j==0)out.removeSignal(wave1);
          else if (j==1)out.removeSignal(wave2);
          else if (j==2)out.removeSignal(wave3);
          else if (j==3)out.removeSignal(wave4);
          else if (j==4)out.removeSignal(wave5);
        }
      }

      rect(posX[i], posY[j], 50, 50 );
    }
  }
}


void DrawingTimeCount() {

  if (playstart) {

    fill(255, 0, 0, 125);
    rect(50*timeCount, 0, 50, 250);

    timeCount+=add;
    if (timeCount>Width-1) {
      timeCount=0;
    }
  }

  else {

    timeCount=-1;
  }
}



void mousePressed() {

  for (int i=0;i<Width;i++) {
    for (int j=0;j<5;j++) {

      if (posX[i]<mouseX&&
        posX[i]+50>mouseX&&
        posY[j]<mouseY&&
        posY[j]+50>mouseY) {

        Key[i][j]=!Key[i][j];
      }
      
    }
  }
}

void keyPressed() {

  switch(keyCode) {

  case 80:

    playstart=!playstart;
    add=1;
    break;

  case 77:

    playstop=!playstop;
    add=1-add;
    break;

  case 82:

    for (int i=0;i<Width;i++) {
      for (int j=0;j<5;j++) {
        Key[i][j]=false;
      }
    }
    break;

  case UP:

    timeSpeed++;
    if (timeSpeed>60) {
      timeSpeed=60;
    }
    break;

  case DOWN :

    timeSpeed--;
    if (timeSpeed<1) {
      timeSpeed=1;
    }
    break;
  }
}

void stop() {
  out.close();
  minim.stop();
  super.stop();
}

