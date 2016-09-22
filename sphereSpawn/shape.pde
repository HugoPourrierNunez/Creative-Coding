class Shape{
  
  PVector pos;
  
  Shape() {
    pos = new PVector(0, 0);
  }
  
  PVector getRandomPointOnTheShape(){
      switch ((int)random(4)){
         case 0:
           pos.x = width/2 + 70;
           pos.y = (int)random(height/2-70, height/2+70);
           break;
         case 1:
           pos.x = width/2 - 70;
           pos.y = (int)random(height/2-70, height/2+70);
           break;
         case 2:
           pos.y = height/2 + 70;
           pos.x = (int)random(width/2-70, width/2+70);
           break;
         case 3:
           pos.y = height/2 - 70;
           pos.x = (int)random(width/2-70, width/2+70);
           break;
      }
    return pos;
  }
  
}