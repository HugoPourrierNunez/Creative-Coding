class Particle {

  PVector velocity;
  float lifespan = 255;
  boolean fading;
  PShape part;
  float partSize;
  Shape shape;

  PVector gravity = new PVector(0, 1);
  int[] tint;
  int[] targetPos;
  float x, y;

  Particle() {
    shape = new Shape();
    this.targetPos = new int[2];
    gravity = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));
    partSize = random(10, 60);
    part = createShape();
    part.beginShape(QUAD);
    part.noStroke();
    part.texture(sprite);
    part.normal(0, 0, 1);
    part.vertex(-partSize/2, -partSize/2, 0, 0);
    part.vertex(+partSize/2, -partSize/2, sprite.width, 0);
    part.vertex(+partSize/2, +partSize/2, sprite.width, sprite.height);
    part.vertex(-partSize/2, +partSize/2, 0, sprite.height);
    tint = new int[] {color(random(lifespan), 0, random(lifespan))};
    part.endShape();

    lifespan = random(255);
  }

  PShape getShape() {
    return part;
  }

  void rebirth(float x, float y) {
    float a = random(TWO_PI);
    float speed = random(0.5, 4);
    velocity = new PVector(cos(a), sin(a));
    velocity.mult(speed);
    lifespan = 255;   
    part.resetMatrix();
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
    //if(
    distanceToTarget();/* > 1){
      fading = true;
    }
    if(fading == true){
        lifespan = lifespan - 255;
    }*/
    
    velocity.add(gravity);
    
    part.setTint(color(tint[0], 255));
    part.translate(velocity.x, velocity.y);
    x += velocity.x;
    y += velocity.y;
  }
  
  float distanceToTarget(){
    gravity.x = (this.targetPos[0]-x)/100;
    gravity.y = (this.targetPos[1]-y)/100;
    println(targetPos);
    return (this.targetPos[1]-y)/(this.targetPos[0]-x);
  }
}