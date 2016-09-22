// The Particle System

class ParticleSystem {
  // It's just an ArrayList of particle objects
  ArrayList<Particle> particles;

  // The PShape to group all the particle PShapes
  PShape particleShape;
  
  int emitX,emitY;

  ParticleSystem(int n, int x, int y) {
    emitX=x;
    emitY=y;
    
    particles = new ArrayList<Particle>();
    // The PShape is a group
    particleShape = createShape(GROUP);

    // Make all the Particles
    for (int i = 0; i < n; i++) {
      Particle p = new Particle(x,y);
      particles.add(p);
      // Each particle's PShape gets added to the System PShape
      particleShape.addChild(p.getShape());
    }
  }

  void update() {
    for (Particle p : particles) {
      p.update();
      if (p.isDead()) {
        p.rebirth(emitX, emitY);
      }
    }
  }

  void display() {
    shape(particleShape);
  }
}