import http.requests.*;

//Windows values
int w=800;
int h=800;

//Text field values 
String myText="D:/PC/Téléchargements/Test2.wav";
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

void setup()
{
    size(800,800);
}

void draw()
{
  update(mouseX,mouseY);
  
  if(!isPlaying)
  {
     background( 255 ); 
  }
  
  if(isPlaying)
  {
    if(indexMood==0)
      setColorFromMood(moodTab[indexMood]);
    
    if(millis()-lastTime>durationTab[indexMood]/10 && indexMood<moodTab.length-1)
    {
      indexMood++;
      setColorFromMood(moodTab[indexMood]);
      lastTime = millis();
    }
    else if (indexMood==moodTab.length-1)
    {
      indexMood = 0;
      isEnding = true;
      inStartMenu = true;
      isPlaying = false;
    }
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
    }
    else if(myText.length()>0)
    {
      println("test2");
      while(moodTab.length>0)
      {
        shorten(moodTab);
      }
      while(durationTab.length>0)
      {
        shorten(durationTab);
      }
      isbuttonClicked = 1;
    }
  }
  if (button2Over) {
      resultFound=false;
      isPlaying = true;      
      inStartMenu = false;
  }
}

void send()
{
    println("ANALYSE");
    analyseBeyondVerbal(myText, "72591e54-5852-4a65-93c6-d8227b77d570");
    
    println("RESULTS");
    for(int i =0; i<moodTab.length && i<durationTab.length;i++)
    {
        println( i + ")   Mood = "+moodTab[i]+ "   Duration = "+ durationTab[i]);
    }
    lastTime = millis();
    
    resultFound = true;
    
}

void analyseBeyondVerbal(String filePath, String apiKey)
{
    String startUrl = "https://apiv3.beyondverbal.com/v3/recording/";
  
    PostRequest authPost = new PostRequest("https://token.beyondverbal.com/token");
    authPost.addData("apiKey", apiKey);
    authPost.addData("grant_type", "client_credentials");
    authPost.addHeader("Content-Type", "x-www-form-urlencoded");
    authPost.send();
    
    JSONObject response = parseJSONObject(authPost.getContent());
    String token = response.getString("access_token");
    //println("access_token: " + token);
    
    PostRequest startPost = new PostRequest(startUrl+"start");
    startPost.setEntity("{ dataFormat: { type:\"WAV\" } } ");
    startPost.addHeader("content-type", "application/json");
    startPost.addHeader("Authorization", "Bearer " + token);
    startPost.send();
    
    String recordingId = parseJSONObject(startPost.getContent()).getString("recordingId");
    
    //println("recordingId: "+recordingId);
    
    PostRequest upStreamPost = new PostRequest(startUrl+recordingId);
    upStreamPost.addHeader("Authorization", "Bearer " + token);
    upStreamPost.setByteFileUpload(filePath);
    upStreamPost.send();
    
    JSONObject json = parseJSONObject(upStreamPost.getContent());
    JSONArray jsonArray = json.getJSONObject("result").getJSONArray("analysisSegments");
    
    int lastOffset = 0;
    int lastDuration = 0;
    int offset,duration;
    String mood;
    
    for(int i=0;i<jsonArray.size();i++) {
      JSONObject j = jsonArray.getJSONObject(i);
      offset = j.getInt("offset");
      if(offset>lastOffset+lastDuration)
      {
         moodTab = splice( moodTab, "UNDEFINED", moodTab.length);
         durationTab  = splice( durationTab, offset-(lastOffset+lastDuration), durationTab.length);
      }
      duration = j.getInt("duration");
      mood = j.getJSONObject("analysis").getJSONObject("Mood").getJSONObject("Group11").getJSONObject("Primary").getString("Phrase");
      
      moodTab = splice( moodTab, mood, moodTab.length);
      durationTab  = splice( durationTab, duration, durationTab.length);
      lastDuration = duration;
      lastOffset = offset;
    }
}

void setColorFromMood(String mood)
{
  r=0;
  g=0;
  b=0;
   if(mood=="UNDEFINED")
   {
     r+=128;
     b+=128;
     g+=128;
     background(r,g,b);
     return;
   }
     
   String[] moods = split(mood,", ");
   
   for(int i=0; i<1; i++)
   {
       println(moods[i]);
       if(moods[i].equals("Friendly"))
       {
         r+=255;
       }
       else if(moods[i].equals("Self-Control"))
       {
         g+=255;
       } 
       else if(moods[i].equals("Leadership"))
       {
         b+=255;
       }
       else 
         return;
   }
   /*r/=moods.length;
   g/=moods.length;
   b/=moods.length;*/
   
   background(r,g,b);
   
   
}