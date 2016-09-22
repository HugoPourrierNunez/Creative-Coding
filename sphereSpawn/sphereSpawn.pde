
ParticleSystem ps;
PImage sprite;  


int sphereCounter;
int sphereBundleSize = 1;

void setup() {
  frameRate(30);
  sprite = loadImage("sprite.png");
  ps = new ParticleSystem(1000);  
  
  sphereCounter = 0;
  size(640, 360, P3D);
  noStroke();
  colorMode(RGB, 1);
  fill(0.4);
}

void draw() {  
  background(0);  
  
  ps.update();
  ps.display();
  
  ps.setEmitter(width/2, height/2);
  
  textSize(16);
  text("Frame rate: " + int(frameRate), 10, 20);
}