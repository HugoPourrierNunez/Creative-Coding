import http.requests.*;
import ddf.minim.*;
 
Minim minim;
AudioPlayer song;

//Windows values
int w=800;
int h=800;

//Text field values 
String myText="D:/PC/Documents/GitHub/Creative-Coding/Programme/data/Test3.wav";
int heightTextField = 50;
int widthTextField = 350;
int spaceTextField = 220;

//Button send values
int buttonWidth=150;
int buttonHeight=40;
int buttonX=w/2-buttonWidth/2;
int buttonY=w-spaceTextField+buttonHeight*2;
int button2X=w/2-buttonWidth/2;
int button2Y=w-spaceTextField+buttonHeight*3+10;
int buttonBorder=2;
boolean buttonOver=false;
boolean button2Over=false;
int isbuttonClicked = 0;
String buttonText = "Analyse";

//Mood values
String[] moodTab = {};
int[] durationTab = {};
float r,g,b;
int lastTime;
int indexMood=0;
boolean inStartMenu = true;
boolean resultFound = false;
boolean isPlaying = false;
boolean isEnding = false;

Analyser analyser;
ParticleSystem ps;
PImage sprite;  
Shape shape ;

void setup()
{
    shape = new Shape();
    frameRate(30);
    sprite = loadImage("sprite.png");
    ps = new ParticleSystem(10000,width/2, height/2);
    size(800, 800, P3D);
    colorMode(RGB,256);
    analyser = new Analyser();
    
    minim = new Minim(this);
    
}

void draw()
{
  update(mouseX,mouseY);
  
  if(!isPlaying)
  {
     background( 255 ); 
  }
  else
  {
    background( 0 ); 
  }
  
  if(isPlaying)
  {
    float max=-1;
    for(int i = 0; i < song.bufferSize() - 1; i++)
    {
      if (song.left.get(i)>max)
        max = song.left.get(i);
      if (song.right.get(i)>max)
        max = song.right.get(i);
    }
    //println("max=",max);
    
    shape.changeSize(2+4*max, -1);
    
    if(indexMood==0)
    {
      emotionChange();
    }
    
    if(millis()-lastTime>durationTab[indexMood] && indexMood<moodTab.length-1)
    {
      indexMood++;
      emotionChange();
      lastTime = millis();
      println(moodTab[indexMood]);
    }
    else if (indexMood==moodTab.length-1)
    {
      indexMood = 0;
      isEnding = true;
      inStartMenu = true;
      isPlaying = false;
      song.close();
    }
    
    shape.update();
    //shape.display();
    ps.update();
    ps.display();
    
    
  }
  else if (inStartMenu)
  {
    
    textSize(30);
    textAlign(CENTER);
    fill(0);
    text("Creative Coding",w/2,55);
    
    fill(128);
    rect( (w-widthTextField)/2, w-spaceTextField,widthTextField, heightTextField);
    
    textSize(15);
    
    if(myText.length()==0)
     {
       fill(100);
       textAlign(CENTER,CENTER);
       text("Path audio file .wav", (w-widthTextField)/2 , w-spaceTextField , widthTextField , heightTextField);
     }
     else
     {
       fill(0);
       textAlign(CENTER, CENTER);
       text(myText, (w-widthTextField)/2 , w-spaceTextField , widthTextField , heightTextField);
     }
     
     textSize(30);
  }
  
  if(!isPlaying)
  {
    if(resultFound)
    {
        buttonText = "Play";
    }
    else if(isbuttonClicked>0)
    {
      buttonText = "Analysing";
    }
    else 
    {
      buttonText = "Analyse";
    }
    
    fill(0);
    rect(buttonX,buttonY,buttonWidth,buttonHeight);
    if(isbuttonClicked>0)
    {
        isbuttonClicked++;
        fill(0);
    }
    else if(buttonOver)
    {
      fill(180);
    }
    else
    {
      fill(255);
    }
    
    rect(buttonX+buttonBorder,buttonY+buttonBorder,buttonWidth-2*buttonBorder,buttonHeight-2*buttonBorder);
    textAlign(CENTER);
    
    if(isbuttonClicked>0)
    {
        fill(255);
        text(buttonText, buttonX, buttonY , buttonWidth , buttonHeight);
    }
    else
    {
      fill(0);
      text(buttonText, buttonX, buttonY , buttonWidth , buttonHeight);
    }
    
    if(isEnding)
    {
      fill(0);
      rect(button2X,button2Y,buttonWidth,buttonHeight);

      if(button2Over)
      {
        fill(180);
      }
      else
      {
        fill(255);
      }
      
      rect(button2X+buttonBorder,button2Y+buttonBorder,buttonWidth-2*buttonBorder,buttonHeight-2*buttonBorder);
      textAlign(CENTER);
      
      fill(0);
      text("Replay", button2X, button2Y , buttonWidth , buttonHeight);
      
    }
    
    if(isbuttonClicked>5)
    {
      isbuttonClicked = 0;
      send();
    }
  
  }
  
}

void emotionChange()
{
  //a faire en fonction de moodTab[indexMood]
  String mood = moodTab[indexMood];
  float r=0;
  float g=0;
  float b=0;
  int forme=0;
   if(mood=="UNDEFINED")
   {
     return;
   }
     
   String[] moods = split(mood,", ");
   
   for(int i=0; i<1; i++)
   {
       println(moods[i]);
       if(moods[i].equals("Friendly"))
       {
         r+=253;
         g+=130;
         b+=67;
         forme=5;
       }
       else if(moods[i].equals("Self-Control"))
       {
         r+=209;
         g+=207;
         b+=213;
         forme=0;
       } 
       else if(moods[i].equals("Criticism"))
       {
         r+=255;
         forme=1;
       } 
       else if(moods[i].equals("Leadership"))
       {
         r+=0;
         g+=124;
         b+=219;
         forme=2;
       } 
       else if(moods[i].equals("Cynicism"))
       {
         r+=200;
         g+=200;
         b+=200;
         forme=6;
       } 
       else if(moods[i].equals("Supremacy"))
       {
         r+=128;
         g+=128;
         b+=255;
         forme=6;
       } 
       else if(moods[i].equals("Arrogance"))
       {
         r+=198;
         forme=3;
       } 
       else if(moods[i].equals("Love"))
       {
         r+=255;
         g+=0;
         b+=0;
         forme=5;
       } 
       else if(moods[i].equals("Happiness"))
       {
         r+=248;
         g+=189;
         b+=200;
         forme=4;
       } 
       else if(moods[i].equals("Defensivness"))
       {
         r+=72;
         g+=72;
         b+=255;
         forme=6;
       } 
       else if(moods[i].equals("Warm"))
       {
         r+=255;
         g+=0;
         b+=0;
         forme=0;
       } 
       else if(moods[i].equals("Anxiety"))
       {
         r+=185;
         g+=122;
         b+=87;
         forme=3;
       } 
       else if(moods[i].equals("Practicality"))
       {
         r+=205;
         g+=123;
         b+=221;
         forme=2;
       } 
       else if(moods[i].equals("Charisma"))
       {
         r+=251;
         g+=129;
         b+=69;
         forme=5;
       } 
       else if(moods[i].equals("Sadness"))
       {
         r+=13;
         g+=7;
         b+=214;
         forme=3;
       } 
       else if(moods[i].equals("Sorrow"))
       {
         r+=0;
         g+=0;
         b+=255;
         forme=0;
       } 
       else if(moods[i].equals("Creative"))
       {
         r+=205;
         g+=122;
         b+=221;
         forme=6;
       } 
       else if(moods[i].equals("Passionate"))
       {
         r+=240;
         g+=0;
         b+=48;
         forme=5;
       } 
       else if(moods[i].equals("Charisma"))
       {
         r+=138;
         g+=195;
         b+=61;
         forme=2;
       }
       else 
       {
         r=random(0,255);
         g=random(0,255);
         b=random(0,255);
       }
   }
   
   shape.changeShape(forme);
   ps.setColor(new PVector(r,g,b));
  
}

void update(int x, int y) {
  if ( overRect(buttonX, buttonY, buttonWidth, buttonHeight) ) {
    buttonOver = true;
  } else {
    buttonOver = false;
  }
  
  if ( overRect(button2X, button2Y, buttonWidth, buttonHeight) ) {
    button2Over = true;
  } else {
    button2Over = false;
  }
  
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void keyPressed() {
  if(inStartMenu)
  {
     if (keyCode == BACKSPACE) {
       if (myText.length() > 0 ) {
         myText = myText.substring( 0 , myText.length()- 1 );
       }
     } else if (keyCode == DELETE) {
       myText = "" ;
     } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
       myText = myText + key;
     }
  }
}

void mousePressed() {
  if (buttonOver) {
    if(resultFound)
    {
      println("test1");
      resultFound=false;
      isPlaying = true;      
      inStartMenu = false;
      
      song = minim.loadFile(myText);
      song.rewind();
      song.play();
    }
    else if(myText.length()>0)
    {
      moodTab= new String[0];
      durationTab= new int[0];
      isbuttonClicked = 1;
      isEnding= false;
    }
  }
  if (button2Over) {
      resultFound=false;
      isPlaying = true;      
      inStartMenu = false;
      
      song = minim.loadFile(myText);
      song.rewind();
      song.play();
  }
}

void send()
{
    println("ANALYSE");
    analyser.analyseBeyondVerbal(myText, "72591e54-5852-4a65-93c6-d8227b77d570");
    
    println("RESULTS");
    for(int i =0; i<moodTab.length && i<durationTab.length;i++)
    {
        println( i + ")   Mood = "+moodTab[i]+ "   Duration = "+ durationTab[i]);
    }
    lastTime = millis();
    
    resultFound = true;
    
}