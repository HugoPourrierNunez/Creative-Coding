class Analyser {

  Analyser() {
    
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
  
}