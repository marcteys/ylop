// CP5

import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

private ControlP5 cp5;
ControlFrame cf;
int def;

boolean setPosition = false;



PVector[] savedMouse = new PVector[3];
int step  = 0;

ArrayList<PVector> allMousePos;
ArrayList<Tri> triangles;
PImage baseImage;


void setup() {  // setup() runs once
  size(325, 600);
  frameRate(30);
  smooth();

  allMousePos = new ArrayList<PVector>();
  triangles = new ArrayList<Tri>();

  baseImage = loadImage("test.jpg");
  
  
  // CP5
    cp5 = new ControlP5(this);

  cf = addControlFrame("Debug", 200,200);
  
}

void draw() {
  
  // CP5 set position
   if (!setPosition) {
    frame.setLocation(310, 100);
    setPosition = true;
  }
  
  background(255);
  image(baseImage, 0, 0);

  //triangle creation
  fill(255);
  noStroke();

  if (step == 0)
  {
  } else if (step == 1)
  {
    stroke(255, 20, 20);
    strokeWeight(1);
    line(savedMouse[step-1].x, savedMouse[step-1].y, mouseX, mouseY);
  } else if (step == 2)
  {
    stroke(255, 20, 20);
    strokeWeight(1);
    line(savedMouse[step-1].x, savedMouse[step-1].y, savedMouse[step-2].x, savedMouse[step-2].y);
    line(savedMouse[step-1].x, savedMouse[step-1].y, mouseX, mouseY);
  }

  //update triangles
  stroke(255, 255, 255, 255);
  strokeWeight(1);
  fill(255, 20, 20);
  updateTriangles();
  ellipse(mouseX, mouseY, 5, 5);
}


void updateTriangles()
{
  fill(255, 20, 20);
  for (int i = triangles.size ()-1; i >= 0; i--)
  {
    Tri tri = triangles.get(i);
    tri.update();
  }
}


void mousePressed() {

  savedMouse[step] =  new PVector(mouseX, mouseY);
  allMousePos.add(new PVector(mouseX, mouseY));

  //calculate if there is a point near

  for (int i = allMousePos.size ()-1; i>= 0; i--)
  {
    PVector mousePos = allMousePos.get(i);
    if (minPoint(mousePos, savedMouse[step]))
    {
      savedMouse[step] =  mousePos;
    }
  }

  if (step == 2)
  {
    Tri newTri = new Tri(baseImage, savedMouse[0].x, savedMouse[0].y, savedMouse[1].x, savedMouse[1].y, savedMouse[2].x, savedMouse[2].y);
    triangles.add(newTri);
    step = 0 ;
  } else
  {
    step++;
  }
}


boolean minPoint(PVector p1, PVector p2)
{
  boolean minpoint = false;

  if (p1.dist(p2) < 10)
  {

    minpoint = true;
  }
  return minpoint;
}


ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}


// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {

  int w, h;

  int abc = 100;
  
  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    cp5.addSlider("abc").setRange(0, 255).setPosition(10,10);
    cp5.addSlider("def").plugTo(parent,"def").setRange(0, 255).setPosition(10,30);
  }

  public void draw() {
      background(abc);
  }
  
  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;
  }
  
  
  ControlP5 cp5;

  Object parent;

  
}



