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

PImage data1;
PImage data2;
PImage data3;
PImage data4;
PImage data5;

void setup() {
  size(1870, 250);
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
  DrawingImage();
  DrawingSelectaction();
}
void DrawingSelectaction() {
  if (mouseX>1600) {
    if (mouseY>0&&mouseY<50) {
      fill(255, 255, 0, 100);
      rect(1600, 0, 320, 50);
    }
    else if (mouseY>50&&mouseY<100) {
      fill(255, 255, 0, 100);
      rect(1600, 50, 320, 50);
    }
    else if (mouseY>100&&mouseY<150) {
      fill(255, 255, 0, 100);
      rect(1600, 100, 320, 50);
    }
    else if (mouseY>150&&mouseY<200) {
      fill(255, 255, 0, 100);
      rect(1600, 150, 320, 50);
    }
    else if (mouseY>200&&mouseY<250) {
      fill(255, 255, 0, 100);
      rect(1600, 200, 320, 50);
    }
  }
}

void DrawingImage() {
  data1=loadImage("data1.jpg");
  data2=loadImage("data2.jpg");
  data3=loadImage("data3.jpg");
  data4=loadImage("data4.jpg");
  data5=loadImage("data5.jpg");

  image(data1, 1600, 0, 320, 50);
  image(data2, 1600, 50, 320, 50);
  image(data3, 1600, 100, 320, 50);
  image(data4, 1600, 150, 320, 50);
  image(data5, 1600, 200, 320, 50);
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
            switch(j) {
            case 0:
              out.addSignal(wave[0]);
              break;

            case 1:
              out.addSignal(wave[1]);
              break;

            case 2:
              out.addSignal(wave[2]);
              break;

            case 3:
              out.addSignal(wave[3]);
              break;

            case 4:
              out.addSignal(wave[4]);
              break;
            }
          }
        }
      }
      else {

        fill(0, 0, 0, 50);

        if (!playstop) {

          switch(j) {
          case 0:
            out.removeSignal(wave[0]);
            break;

          case 1:
            out.removeSignal(wave[1]);
            break;

          case 2:
            out.removeSignal(wave[2]);
            break;

          case 3:
            out.removeSignal(wave[3]);
            break;

          case 4:
            out.removeSignal(wave[4]);
            break;
          }
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
  if (mouseX<=1600) {
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
  else {
    LoadingData();
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

  case 112:
    int k=0;
    save("data1.jpg");
    for (int i=0;i<Width;i++) {
      for (int j=0;j<5;j++) {

        saveKey[k]=str(Key[i][j]);
        k++;
      }
    }
    saveStrings("data1.txt", saveKey);
    break;

  case 113:
    int m=0;
    save("data2.jpg");
    for (int i=0;i<Width;i++) {
      for (int j=0;j<5;j++) {

        saveKey[m]=str(Key[i][j]);
        m++;
      }
    }
    saveStrings("data2.txt", saveKey);
    break;

  case 114:
    int n=0;
    save("data3.jpg");
    for (int i=0;i<Width;i++) {
      for (int j=0;j<5;j++) {

        saveKey[n]=str(Key[i][j]);
        n++;
      }
    }
    saveStrings("data3.txt", saveKey);
    break;

  case 115:
    int o=0;
    save("data4.jpg");
    for (int i=0;i<Width;i++) {
      for (int j=0;j<5;j++) {

        saveKey[o]=str(Key[i][j]);
        o++;
      }
    }
    saveStrings("data4.txt", saveKey);
    break;
  case 116:
    int p=0;
    save("data5.jpg");
    for (int i=0;i<Width;i++) {
      for (int j=0;j<5;j++) {

        saveKey[p]=str(Key[i][j]);
        p++;
      }
    }
    saveStrings("data5.txt", saveKey);
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

void LoadingData(){
  if (mouseY>0&&mouseY<50) {
      int l=0;
      for (int i=0;i<Width*5;i++) {
        tmp=loadStrings("data1.txt");
      }
      for (int i=0;i<Width;i++) {
        for (int j=0;j<5;j++) {

          loadKey[i][j]=tmp[l];
          Key[i][j]= int(loadKey[i][j]);
          l++;
        }
      }
    }
    
    else if(mouseY>50&&mouseY<100){
       int q=0;
      for (int i=0;i<Width*5;i++) {
        tmp=loadStrings("data2.txt");
      }
      for (int i=0;i<Width;i++) {
        for (int j=0;j<5;j++) {

          loadKey[i][j]=tmp[q];
          Key[i][j]= int(loadKey[i][j]);
          q++;
        }
      }
      
    }
    else if(mouseY>100&&mouseY<150){
       int r=0;
      for (int i=0;i<Width*5;i++) {
        tmp=loadStrings("data3.txt");
      }
      for (int i=0;i<Width;i++) {
        for (int j=0;j<5;j++) {

          loadKey[i][j]=tmp[r];
          Key[i][j]= int(loadKey[i][j]);
          r++;
        }
      }
      
    }
    else if(mouseY>150&&mouseY<200){
       int s=0;
      for (int i=0;i<Width*5;i++) {
        tmp=loadStrings("data4.txt");
      }
      for (int i=0;i<Width;i++) {
        for (int j=0;j<5;j++) {

          loadKey[i][j]=tmp[s];
          Key[i][j]= int(loadKey[i][j]);
          s++;
        }
      }
      
    }
    
    else if(mouseY>200&&mouseY<250){
       int t=0;
      for (int i=0;i<Width*5;i++) {
        tmp=loadStrings("data5.txt");
      }
      for (int i=0;i<Width;i++) {
        for (int j=0;j<5;j++) {

          loadKey[i][j]=tmp[t];
          Key[i][j]= int(loadKey[i][j]);
          t++;
        }
      }
      
    }
}

void stop() {
  out.close();
  minim.stop();
  super.stop();
}

