// ws 2012-2013
//IG2 Franklin Hernandez-Castro
//Student: Ma,Yujia

//Title: Bal l& Tau

import traer.physics.*;

ParticleSystem myParticleSystem;

Particle[] p;
Particle[] q;

float SPRING_STRENGTH = 0.2;
float SPRING_DAMPING = 0.1;

int i;
int j;
int a = 4;


 
void setup(){
  size(400,400);
  smooth();
  ellipseMode(CENTER);
   
   
  myParticleSystem=new ParticleSystem(1,0.05);
  
  float gridStepX = (float) ((width / 2) / a);
  float gridStepY = (float) ((height / 2) / a);
  
   p= new Particle[a];
   q= new Particle[a];

  
   p[0] = myParticleSystem.makeParticle( 0.2, width/4, 20, 0.0 );
   p[0].makeFixed();
   
   q[0] = myParticleSystem.makeParticle( 0.2, width/4, 20, 0.0 );
   q[0].makeFixed();
  
  for(int i=1;i<p.length;i++){
    p[i]=myParticleSystem.makeParticle(0.2,i * gridStepX + (width/4), i * gridStepY + 20, 0.0);
    myParticleSystem.makeSpring(p[i-1],p[i],SPRING_STRENGTH, SPRING_DAMPING, gridStepX);
    
    q[i]=myParticleSystem.makeParticle(0.2,i * gridStepX + (width/4), i * gridStepY + 20, 0.0);
    myParticleSystem.makeSpring(q[i-1],q[i],SPRING_STRENGTH, SPRING_DAMPING, gridStepX);
    
  }
    
    p[0].makeFixed();
    p[p.length-1].setMass( 2.0 );
  
    q[0].makeFixed();
    q[q.length-1].setMass( 2.0 );

}

 
void draw(){
  background(255);
  
  myParticleSystem.tick();
  
  p[0].position().set(width/2,20,0);
  
  q[0].position().set(p[p.length-1].position().x(),p[p.length-1].position().y(),0);
  
  q[q.length-1].position().set (width/2,height-20,0);
  
    fill(255);
    stroke(1);
    beginShape();
    curveVertex(p[0].position().x(),p[0].position().y());
    for ( int i = 0; i < p.length; ++i ){
      curveVertex( p[i].position().x(), p[i].position().y() );
    }
    curveVertex( p[p.length-1].position().x(), p[p.length-1].position().y() );
    
    curveVertex(q[0].position().x(),q[0].position().y());
    
    for ( int i = 0; i < q.length; ++i ){
      curveVertex( q[i].position().x(), q[i].position().y() );
    }
    curveVertex( q[q.length-1].position().x(), q[q.length-1].position().y());
    
    endShape();
    fill(0);
    noStroke();
    ellipse(p[p.length-1].position().x(),p[p.length-1].position().y(),40,40);
    
}


void mousePressed(){
  p[p.length-1].position().set(mouseX,mouseY,0);
 }
