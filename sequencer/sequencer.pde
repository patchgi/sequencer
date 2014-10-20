import ddf.minim.*;
import ddf.minim.signals.*;

int timeCount=-1, Width=32, add=1, timeSpeed=6;

int [][]Key=new int [Width][5];
String []saveKey=new String[Width*5];

String [][]loadKey=new String [Width][5];
String []tmp=new String[Width*5];

int []posX=new int[Width];
int []posY=new int[5];

SineWave []wave=new SineWave[5];

boolean playstart=false, playstop=false;

Minim minim;
AudioOutput out;


void setup() {
  size(1800, 250);
  stroke(255);
  for (int i=0;i<Width;i++) {
    for (int j=0;j<5;j++) {
      Key[i][j]=0;
    }
    frameRate(timeSpeed);
  }


  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO);

  wave[0] = new SineWave(523.23, 0.5, out.sampleRate());
  wave[1] = new SineWave(587.34, 0.5, out.sampleRate());
  wave[2]= new SineWave(659.25, 0.5, out.sampleRate());
  wave[3]= new SineWave(783.98, 0.5, out.sampleRate());
  wave[4]= new SineWave(879.99, 0.5, out.sampleRate());
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

      if ( Key[i][j]==1 ) {

        fill(0, 255, 255);

        if (posX[i]==50*timeCount) {

          if (!playstop) {

            if (j==0)out.addSignal(wave[0]);
            else if (j==1)out.addSignal(wave[1]);
            else if (j==2)out.addSignal(wave[2]);
            else if (j==3)out.addSignal(wave[3]);
            else if (j==4)out.addSignal(wave[4]);
          }
        }
      }
      else {

        fill(0, 0, 0, 50);

        if (!playstop) {

          if (j==0)out.removeSignal(wave[0]);
          else if (j==1)out.removeSignal(wave[1]);
          else if (j==2)out.removeSignal(wave[2]);
          else if (j==3)out.removeSignal(wave[3]);
          else if (j==4)out.removeSignal(wave[4]);
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

        Key[i][j]=1-Key[i][j];
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
        Key[i][j]=0;
      }
    }
    break;

  case 9:
    int k=0;

    for (int i=0;i<Width;i++) {
      for (int j=0;j<5;j++) {

        saveKey[k]=str(Key[i][j]);
        k++;
      }
    }
    saveStrings("data.txt", saveKey);
    break;

  case 76:
    int l=0;
    for (int i=0;i<Width*5;i++) {
      tmp=loadStrings("data.txt");
    }
    for (int i=0;i<Width;i++) {
      for (int j=0;j<5;j++) {

        loadKey[i][j]=tmp[l];
        Key[i][j]= int(loadKey[i][j]);
        l++;
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

