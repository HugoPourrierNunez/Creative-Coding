
ParticleSystem ps;
PImage sprite;  
Shape shape ;

void setup() {
  
  shape = new Shape();
  frameRate(30);
  sprite = loadImage("sprite.png");
  ps = new ParticleSystem(3000,width/2, height/2);
  size(640, 360, P3D);
}

void draw() {
  background(0);  
  
  shape.update();
  //shape.display();
  
  ps.update();
  ps.display();
  
  if(shape.isShapeComplete())
  {
    shape.changeShape((int)random(0,7));
  
    //shape.changeSize(2, .02);
  }
}