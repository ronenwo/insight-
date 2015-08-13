import processing.video.*;
import SimpleOpenNI.*;

SimpleOpenNI  context;
Movie myMovie;

PImage imgKinect, imgMov;

PGraphics g, dest, back;


void setup() {
  size(1920, 1080, P2D);
//  size(800, 600, P2D);
  frameRate(30);
//  myMovie = new Movie(this, "800600a.mov");
  myMovie = new Movie(this, "800600b.mov");
//  myMovie = new Movie(this, "stars4.mp4");
  //  myMovie.speed(4.0);
  myMovie.frameRate(30);
  myMovie.loop();

  context = new SimpleOpenNI(this);
  context.enableDepth();
  context.setMirror(false);
  context.enableUser();
  if (context.isInit() == false)
  {
    println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
    exit();
    return;
  }

  g = createGraphics(width, height, P2D);
//  g = createGraphics(640,480, P2D);
  dest = createGraphics(width, height, P2D);



  imgKinect = new PImage(640, 480); 
  imgKinect.loadPixels();

  imgMov = createImage(width, height, RGB);
}

void draw() {
  if (myMovie.available()) {
    myMovie.read();
  }

  background(0, 0);
  context.update();

  int[] u = context.userMap();
  for (int i =0; i<u.length; i++) {
    if (u[i]==0) {
      imgKinect.pixels[i] = color(0);
    } else {
      imgKinect.pixels[i] = color(255);
    }
  }

  imgKinect.updatePixels(); 
  g.beginDraw();
  g.background(0);
  g.imageMode(CENTER);
  g.image(imgKinect, width/2, height/2);
  g.endDraw();

  dest.beginDraw();
//  dest.imageMode(CENTER);
  dest.image(myMovie, 0, 0, width, height);
  dest.blend(g,0,0, width,height, 0,0,width,height,MULTIPLY);
//  dest.blend(g,0, 0, 640,480, 0, 0,width,height,MULTIPLY);
  dest.endDraw();


    
  image(dest,0,0);




//  image(myMovie, 0, 0);
}

