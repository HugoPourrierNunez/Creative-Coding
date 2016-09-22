
// This boolean variable will control if we are morphing to a circle or square
int state = 1;
Shape shape ;

void setup() {
  size(1280, 720);

   shape = new Shape();
}

void draw() {
  background(51);
  noStroke();
  shape.drawGeometry();
  if(shape.isShapeComplete())
  {
    //shape.changeShape((int)random(0,7));
    shape.changeSize(random(1,3), .05);
  }
}