class Shape{
  
  int[] pos = new int[] {0, height/2};
  
  int[] getRandomPointOnTheShape(){
      switch ((int)random(4)){
         case 0:
           pos[0] = width/2 + 70;
           pos[1] = (int)random(height/2-70, height/2+70);
           break;
         case 1:
           pos[0] = width/2 - 70;
           pos[1] = (int)random(height/2-70, height/2+70);
           break;
         case 2:
           pos[1] = height/2 + 70;
           pos[0] = (int)random(width/2-70, width/2+70);
           break;
         case 3:
           pos[1] = height/2 - 70;
           pos[0] = (int)random(width/2-70, width/2+70);
           break;
      }
    return pos;
  }
  
}