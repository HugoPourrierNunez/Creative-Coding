class Particle {

  PVector velocity;
  float lifespan = 255;
  boolean fading;
  PShape part;
  float partSize;
  Shape shape;

  PVector gravity = new PVector(0, 1);
  int[] tint;
  private PVector targetPos;
  private float x, y;

  Particle() {
    shape = new Shape();
    targetPos = new PVector(0, 0);
    gravity = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));
    partSize = random(10, 60);
    part = createShape();
    tint = new int[] {255, 0, 0};//(int)random(lifespan), (int)random(lifespan), (int)random(lifespan)};
    part.beginShape(QUAD);
    part.noStroke();
    part.texture(sprite);
    part.normal(0, 0, 1);
    part.vertex(-partSize/2, -partSize/2, 0, 0);
    part.vertex(+partSize/2, -partSize/2, sprite.width, 0);
    part.vertex(+partSize/2, +partSize/2, sprite.width, sprite.height);
    part.vertex(-partSize/2, +partSize/2, 0, sprite.height);
    part.endShape();

    lifespan = random(255);
  }

  PShape getShape() {
    return part;
  }

  void rebirth(float x, float y) {
    lifespan = 255;   
    fading = false;
    tint = new int[] {color(random(lifespan), 0, random(lifespan))};
    float a = random(TWO_PI);
    float speed = random(0.5, 4);
    velocity = new PVector(cos(a), sin(a));
    velocity.mult(speed);
    part.resetMatrix();
    part.setTint(color(0, 0, 255, lifespan));
    part.translate(x, y);
    this.x = x; 
    this.y = y;
  }

  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }

  public void update() {
    if(abs(distanceToTarget()) <= 0.1){
      fading = true;
    };
    if(fading){
      lifespan -= 40;
    }  
    
    velocity.add(gravity);
    
    part.setTint(color(100, 0, 255, lifespan));
    part.translate(velocity.x, velocity.y);
    x += velocity.x;
    y += velocity.y;
    println(x, y);
  }
  
  public void setTargetPosition(PVector t){
    targetPos.x = t.x;
    targetPos.y = t.y;
  }
  
  float distanceToTarget(){
    gravity.x = (targetPos.x-x)/1000;
    gravity.y = (targetPos.y-y)/1000;
    return (targetPos.y-y)/(targetPos.x-x);
  }
}