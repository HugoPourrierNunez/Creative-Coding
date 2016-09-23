class Shape {

  ArrayList<PVector> circle = new ArrayList<PVector>();
  ArrayList<PVector> square = new ArrayList<PVector>();
  ArrayList<PVector> triangle = new ArrayList<PVector>();
  ArrayList<PVector> star = new ArrayList<PVector>();
  ArrayList<PVector> losange = new ArrayList<PVector>();
  ArrayList<PVector> octogone = new ArrayList<PVector>();
  ArrayList<PVector> fleur = new ArrayList<PVector>();
  
  ArrayList<ArrayList<PVector>> allShape = new ArrayList<ArrayList<PVector>>();
  
  ArrayList<PVector> morph = new ArrayList<PVector>();
  ArrayList<PVector> actualShape;
  
  boolean shapeComplete = false;
  float size=1;
  float actualSize=1;
  float speedChangeSize = .05;

  int state = 0;
  
  Shape() {
    InitGeometry();
  }

  public void changeShape(int aState)
  {
    state = aState;
  }
  
  
  public void changeSize(float aSize, float aSpeed)
  {
     size = aSize; 
     speedChangeSize= aSpeed;
  }
  
  void update()
  {
      // We will keep how far the vertices are from their target
    float totalDistance = 0;
    
    // Look at each vertex
    for (int i = 0; i < circle.size(); i++) {
      
      PVector v1 = allShape.get(state).get(i);
      
      // Get the vertex we will draw
      PVector v2 = morph.get(i);
      
      // Lerp to the target
      v2.lerp(v1, 0.1);
      
      // Check how far we are from target
      totalDistance += PVector.dist(v1, v2);
     }
      
      // If all the vertices are close, switch shape
      
      
      if(size>actualSize) actualSize+=speedChangeSize;
      else if(size<actualSize) actualSize-=speedChangeSize;
      
      if(abs(actualSize-size) <.1)
        actualSize=size;

     shapeComplete=(totalDistance < 0.1 && actualSize==size);
     
      // Draw relative to center
      translate(width/2, height/2);
      strokeWeight(4);
      // Draw a polygon that makes up all the vertices
      
      actualShape = morph;
      
  }
  
  public void display()
  {
     beginShape();
      noFill();
      //stroke(random(0,256), random(0, 256), random(0, 256));
      stroke(255);
      for (PVector v : morph) {
        vertex(v.x*actualSize, v.y*actualSize);
      }
      endShape(CLOSE); 
  }
  
  
  public boolean isShapeComplete()
  {
     return shapeComplete; 
  }
  
  public ArrayList<PVector> getActualShape()
  {
     return actualShape; 
  }
  
  void InitGeometry()
  {
    // Circle
    for (int angle = 0; angle < 360; angle += 9) {
      // Note we are not starting from 0 in order to match the
      // path of a circle.  
      PVector v = PVector.fromAngle(radians(angle-135));
      v.mult(100);
      circle.add(v);
      // Let's fill out morph ArrayList with blank PVectors while we are at it
      morph.add(new PVector());
    }
    
    allShape.add(circle);
    
    // Triangle 
    for(int i = 0; i < 10; i++)
    {
     triangle.add(new PVector(0, -50));
     triangle.add(new PVector(50, -50));
     triangle.add(new PVector(0, 50));
     triangle.add(new PVector(-50, -50));
    }  
    
    allShape.add(triangle);
    
    // Square
    // Top of square
    for (int x = -50; x < 50; x += 10) {
      square.add(new PVector(x, -50));
    }
    // Right side
    for (int y = -50; y < 50; y += 10) {
      square.add(new PVector(50, y));
    }
    // Bottom
    for (int x = 50; x > -50; x -= 10) {
      square.add(new PVector(x, 50));
    }
    // Left side
    for (int y = 50; y > -50; y -= 10) {
      square.add(new PVector(-50, y));
    }
    
    allShape.add(square);
    
    // Losange
    for(int w = 0; w < 10; w++)
    {
      losange.add(new PVector(-50, 0));
      losange.add(new PVector(0, 70));
      losange.add(new PVector(50, 0));
      losange.add(new PVector(0, -70));
    }
    
    allShape.add(losange);
    
    // Fleur
    for(int r = 0; r < 3; r++)
    {
      fleur.add(new PVector(-70, 0));
      fleur.add(new PVector(-40, 20));
      fleur.add(new PVector(-40, 50));
      fleur.add(new PVector(-15, 45));
      fleur.add(new PVector(0, 70));
      fleur.add(new PVector(15, 45));
      fleur.add(new PVector(40, 50));
      fleur.add(new PVector(40, 20));
      fleur.add(new PVector(70, 0));
      fleur.add(new PVector(40, -20));
      fleur.add(new PVector(40, -50));
      fleur.add(new PVector(15, -45));
      fleur.add(new PVector(0, -70));
      fleur.add(new PVector(-15, -45));
      fleur.add(new PVector(-40, -50));
      fleur.add(new PVector(-40, -20));
    }
    fleur.add(new PVector(-70, 0));
    fleur.add(new PVector(-40, 20));
    fleur.add(new PVector(-40, 50));
    fleur.add(new PVector(-15, 45));
    fleur.add(new PVector(0, 70));
    fleur.add(new PVector(15, 45));
    fleur.add(new PVector(40, 50));
    fleur.add(new PVector(40, 20));
    
    allShape.add(fleur);
    
    // Star
    for(int p = 0; p < 5; p++)
    {
      star.add(new PVector(-60, -30));
      star.add(new PVector(-15, -30));
      star.add(new PVector(0, -70));
      star.add(new PVector(15, -30));
      star.add(new PVector(60, -30));
      star.add(new PVector(25, 0));
      star.add(new PVector(40, 40));
      star.add(new PVector(0, 10));
      star.add(new PVector(-40, 40));
      star.add(new PVector(-25, 0));
    }
    
    allShape.add(star);
    
    // Octogone
    for(int l =0; l < 10; l++)
    {
      octogone.add(new PVector(-50, 0));
      octogone.add(new PVector(-40, 37));
      octogone.add(new PVector(0, 50));
      octogone.add(new PVector(40, 37));
      octogone.add(new PVector(50, 0));
      octogone.add(new PVector(40, -37));
      octogone.add(new PVector(0, -50));
      octogone.add(new PVector(-40, -37));
    }
    
    allShape.add(octogone);
    
    actualShape=circle;
  }
  
  public PVector getPointOnShape()
  {
      int i = (int) random(0,actualShape.size()-2);
      int j=i+1;
      while(actualShape.get(i).x==actualShape.get(j).x && actualShape.get(i).y==actualShape.get(j).y)
      {
        delay(100);
        j++;
        if(j==actualShape.size())
          j=0;
      }
      
      PVector p1,p2;
      if(actualShape.get(i).x>actualShape.get(j).x)
      {
        p1=actualShape.get(j);
        p2=actualShape.get(i);
      }
      else
      {
         p1=actualShape.get(i);
         p2=actualShape.get(j); 
      }
      
      int nb = 1;
      
      //Acception de la droite verticale
      if(p1.x==p2.x)
      {
        if(p1.y<p2.y)
          return new PVector(p1.x*nb, random(p1.y, p2.y)*nb);
        return new PVector(p1.x*nb, random(p2.y, p1.y)*nb);
      }
      //Acception de la droite horizontale
      if(p1.y==p2.y)
      {
        return new PVector(random(p1.x, p2.x)*nb,p1.y*nb);
      }
      
      float a=(p2.y-p1.y)/(p2.x-p1.x);
      float b = p1.y - a*p1.x;
      float randX = random(p1.x, p2.x);
      
      return new PVector(randX*nb, a*randX+b*nb);
  }
}