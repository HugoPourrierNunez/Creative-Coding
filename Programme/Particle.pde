
// An individual Particle

class Particle {

  // Velocity
  PVector velocity;
  // Lifespane is tied to alpha
  float lifespan;

  // The particle PShape
  PShape part;
  // The particle size
  float partSize;
  
  PVector target;
  
  PVector pos = new PVector(width/2, height/2);
  
  boolean touchTarget = false;
  
  PVector myColor = new PVector(255,255,255); 
  

  Particle(int x,int y) {    
    partSize = 10;
    // The particle is a textured quad
    part = createShape();
    part.beginShape(QUAD);
    part.noStroke();
    part.texture(sprite);
    part.normal(0, 0, 1);
    part.vertex(-partSize/2, -partSize/2, 0, 0);
    part.vertex(+partSize/2, -partSize/2, sprite.width, 0);
    part.vertex(+partSize/2, +partSize/2, sprite.width, sprite.height);
    part.vertex(-partSize/2, +partSize/2, 0, sprite.height);
    part.endShape();
    
    // Set the particle starting location
    rebirth(x, y,myColor);
  }

  PShape getShape() {
    return part;
  }

  void rebirth(float px, float py, PVector aColor) {
    myColor=aColor;
    pos = new PVector(width/2, height/2);
    
    float speed = random(0.5, 4);
    // A velocity with random angle and magnitude
    
    target = shape.getPointOnShape();
    target.x+=width/2;
    target.y+=height/2;
    
    velocity = new PVector(target.x-px, target.y-py);
    velocity.normalize();
    velocity.mult(speed*2);
    // Set lifespan
    lifespan = 255;
    // Set location using translate
    part.resetMatrix();
    touchTarget=false;
  }

  // Is it off the screen, or its lifespan is over?
  boolean isDead() {
    if (lifespan <= 0) {
      //println("dead");
      return true;
    } 
    else {
      return false;
    }
  }

  void update() {
    
    if(abs(pos.x-target.x)<5 && abs(pos.y-target.y)<5 )
    {
      touchTarget=true;
    }
    if(touchTarget)
    {
       lifespan=0;
    }
    
    lifespan-=2;
    part.setTint(color(myColor.x ,myColor.x,myColor.z, lifespan));
    // Move the particle according to its velocity
    part.translate(velocity.x, velocity.y);
    pos.x+=velocity.x;
    pos.y+=velocity.y;
  }
  
  float distanceToTarget(){
    return sqrt(pow(target.y-pos.y,2)/pow(target.x-pos.x,2));
  }
}