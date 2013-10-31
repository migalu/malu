// ws 2012-2013
//IG2 Franklin Hernandez-Castro
//Student: Ma,Yujia

//Title: ig2

import traer.physics.*; 

int pixelDensity = 10;      // only each nth pixel will get into the particle system

int ELLIPSE_W = 8;  // ellipse size
int MIN_ELLIPSE_W = 8;
int MAX_ELLIPSE_W = 10;
/*
int LINE_W = 5;
int Min_LINE_W = 5;
int MAX_LINE_W = 20;
*/


Particle mouse;            // particle on mouse position
Particle[] particles;      // the moving particle
Particle[] orgParticles;   // original particles - fixed
//color[] colors;            // color values from the image
ParticleSystem physics;    // the particle system

String bildName = "ig2.jpg";

float[] pixelX = new float[0];
float[] pixelY = new float[0];

PImage img;                // the original image
//int numPixelsSmall;        // the number of pixels in the scaled-down-version of the image
//int widthSmall;            // width of the scaled-down-version of the image
//int heightSmall;           // height of the scaled-down-version of the image
//int a;



void setup() { //--------------------------------------------------------------------------
  img = loadImage("ig2.jpg"); // image file
  
  //widthSmall = img.width/pixelDensity;
  //heightSmall = img.height/pixelDensity;
  //numPixelsSmall = widthSmall * heightSmall; 
  
  // Processing Setup
  size(img.width, img.height);
  noStroke();
 
  smooth();

  // Particle System + Detect Colors
  physics = new ParticleSystem(0, 0);// border
                // create a particle for mouse
  //mouse.makeFixed();                            // don't let forces move it
  
  //colors = new color[numPixelsSmall];
  //img.loadPixels();
  
  //int a;
  for(float i = 0; i < img.width; i+=8) {           
    for(float j = 0; j < img.height; j+=8) { 
      color c = img.get(int(i),int(j));
      float r = red(c);

      if(r < 100) {
 
        pixelX = (float[]) append(pixelX, i);
        pixelY = (float[]) append(pixelY, j);

      }
    }
  }
    
     particles = new Particle[pixelX.length];     // create first particle array
     orgParticles = new Particle[pixelX.length];  // create second particle array
     mouse = physics.makeParticle(); 
    
      for(int i = 0; i < pixelX.length; i++) {
     
      //colors[i] = img.pixels[y*pixelDensity*img.width+x*pixelDensity];
      particles[i]    = physics.makeParticle(0.8, pixelX[i], pixelY[i], 0);
      orgParticles[i] = physics.makeParticle(0.8, pixelX[i], pixelY[i], 0);
      orgParticles[i].makeFixed();
      // creates springs between the two arrays with identical positions
      physics.makeSpring(particles[i], orgParticles[i], 0.05, 0.1, 0 );
      // make interaction between mouse and particles
      //physics.makeAttraction(particles[a], mouse, -10000, 0.1);
      physics.makeAttraction(particles[i], mouse, 1000, 20);
    }
  }


void draw() { //--------------------------------------------------------------------------
  imageMode(CENTER);
  background(255);
  noStroke();
  println("framerate: " + frameRate);  //if you want to tracking efficiency
  
  mouse.position().set(mouseX, mouseY, 0 );
  physics.tick(1); 
  
  float w;
  float posx, posy;
  
  for(int m=0; m < pixelX.length; m++) {
      posx = particles[m].position().x();
      posy = particles[m].position().y();
      float currentDist = dist(posx, posy, mouseX, mouseY);
      float screenDiagonal = sqrt(width*width + height*height);
      w = map(currentDist, 0, screenDiagonal, MIN_ELLIPSE_W, MAX_ELLIPSE_W);
      //w = map(currentDist, 0, screenDiagonal, Min_LINE_W, MAX_LINE_W);
      fill(#6a0c0c);  // fill with the colour on this position from the image
      noStroke();
      ellipse(posx, posy, w, w);
   
      
    }
}

