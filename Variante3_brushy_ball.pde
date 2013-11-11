// ws 2012-2013
//IG2 Franklin Hernandez-Castro
//Student: Ma,Yujia

//Title: brushy_ball

import traer.physics.*;
Particle mouse;            // particle on mouse position
Particle[] particles;      // the moving particle
Particle[] orgParticles;   // original particles - fixed
Spring [] mySprings;
ParticleSystem myParticleSystem;    // the particle system

// initial parameters
//int xCount = 50;
//int yCount = 30;
//int totalNodes = xCount * yCount;
//float gridSizeX, gridSizeY, gapX, gapY, border;
int radio = 4; // point size

int maxPoints = 10000;
PVector[] points = new PVector[maxPoints];
float rotX, rotY = 0.0;

void setup() { //---------------------------------------------------------------------------
  size(650, 800,P3D);
  smooth();
 

  /*gridSizeX = width -2*border;
  gridSizeY = height-2*border;
  gapX = gridSizeX / (xCount-1);
  gapY = gridSizeY / (yCount-1);*/

  myParticleSystem = new ParticleSystem(0, 0.05);
  mouse = myParticleSystem.makeParticle();            // create a particle for the mouse
  mouse.makeFixed();                         // don't let forces move it
  particles    = new Particle[maxPoints]; // particle array
  orgParticles = new Particle[maxPoints]; // fixed particle array
  mySprings = new Spring [maxPoints]; // spring array
  
  //int a;

 //for (int y=0; y<yCount; y++) {        // go through all columns
    //for (int x=0; x<xCount; x++) {           // go through all rows
      //a = y*xCount+x; // 2D to 1D transformation
      for (int ni=0; ni<maxPoints; ni++){
      points[ni] = randomSpherePoint(200);
      
      float xPos = points[ni].x;
      float yPos = points[ni].y;
      float zPos = points[ni].z;
      
      particles[ni]    = myParticleSystem.makeParticle(0.8, xPos, yPos, zPos);
      orgParticles[ni] = myParticleSystem.makeParticle(0.8, xPos, yPos, zPos);
      orgParticles[ni].makeFixed();
      // making springs between both arrays
      mySprings[ni]= myParticleSystem.makeSpring(particles[ni], orgParticles[ni], 0.2, 0.1, 0 );
      // make interaction between mouse and particles
      //myParticleSystem.makeAttraction(particles[a], mouse, -10000, 0.1);
      myParticleSystem.makeAttraction(particles[ni], mouse, 80000, 100); // 50000, 100
    }
    }

 // end setup

void draw() { 
  background(250);
  noStroke();
   
  translate(width/2, height/2);
   rotateX (rotX);
   rotateY (rotY); 
   
  //println("framerate: " + frameRate); //if you want to tracking efficiency
  mouse.position().set(mouseX-width/2, mouseY-height/2, 0 ); // tracking mouse
  myParticleSystem.tick(); 
  
   
  
  //int a;
  float posx, posy,posz;
  
  for (int ni=0; ni<maxPoints; ni++){
    point (points[ni].x, points[ni].y, points[ni].z);// 1D to 2D
    
      /*posx = particles[ni].position().x();
      posy = particles[ni].position().y();
      posz = particles[ni].position().y();
      
      //float w = map(dist(posx, posy, mouseX, mouseY), 0, sqrt(width*width + height*height), 200, 50);
      fill(#689DBC); 
      //fill(w);   
      noStroke();
      translate (posx, posy, posz);
      sphere(radio);*/
      
     if (mousePressed){
     rotY += (pmouseX - mouseX) * -0.000001;
     rotX += (pmouseY - mouseY) * +0.000001;
  }
  rotY += 0.000001;
}
  
  // drawing springs
  for (int n =0; n < mySprings.length; n++){
   float x1 = mySprings[n].getOneEnd().position().x();
   float y1 = mySprings[n].getOneEnd().position().y();
   float z1 = mySprings[n].getOneEnd().position().z();
   float x2 = mySprings[n].getTheOtherEnd().position().x();
   float y2 = mySprings[n].getTheOtherEnd().position().y();
   float z2 = mySprings[n].getOneEnd().position().z();
   stroke(#342502,200);
   line (x2,y2,z2,x1,y1,z1);
  }
} 
// end draw
PVector randomSpherePoint(float radius)
{
  float a=0, b=0, c=0, d=0, k=99;
  while (k >= 1.0)
  {
    a = random (-1.0, 1.0);
    b = random (-1.0, 1.0);
    c = random (-1.0, 1.0);
    d = random (-1.0, 1.0);
    k = a*a +b*b +c*c +d*d;
    //print('.');
  }
  //println ("s");
  k = k/radius;
  return new PVector
    ( 2*(b*d + a*c) / k
    , 2*(c*d - a*b) / k 
    , (a*a + d*d - b*b - c*c) / k);
}
