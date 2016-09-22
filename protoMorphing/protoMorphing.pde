// Tableaux des positions des vertices des différentes formes
ArrayList<PVector> circle = new ArrayList<PVector>();
ArrayList<PVector> square = new ArrayList<PVector>();
ArrayList<PVector> triangle = new ArrayList<PVector>();
ArrayList<PVector> star = new ArrayList<PVector>();
ArrayList<PVector> losange = new ArrayList<PVector>();
ArrayList<PVector> octogone = new ArrayList<PVector>();
ArrayList<PVector> fleur = new ArrayList<PVector>();


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
}