// CP5

import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

private ControlP5 cp5;
ControlFrame cf;


boolean setPosition = false;

////Settings

//display
public boolean displayCircle = false;
boolean displayColor = false;
boolean trianglesOnly = false;

// modes
boolean drawTriangle = true;
boolean moveCircle = false;
boolean deleteTriangle = false;
int mode = 0;

// values
float minDistCollapse = 15;

//end settings

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
  cf = addControlFrame("Settings", 200, 600);
}

void draw() {
  // CP5 set position
  if (!setPosition) {
    frame.setLocation(310, 100);
    setPosition = true;
  }

  background(255);
  image(baseImage, 0, 0);

  trianglesCreation();

  //update triangles
  updateTriangles();


  // draw cursor
  pushStyle();
  noStroke();
  fill(255, 20, 20);
  ellipse(mouseX, mouseY, 5, 5);
  fill(255, 20, 20, 50);
  ellipse(mouseX, mouseY, minDistCollapse, minDistCollapse);
  popStyle();

  if (displayCircle) debugCircles();
}


void trianglesCreation()
{
  pushStyle();
  //triangle creation
  fill(255);
  noStroke();
  if (step == 0)
  {
  } 
  else if (step == 1)
  {
    stroke(255, 20, 20);
    strokeWeight(1);
    line(savedMouse[step-1].x, savedMouse[step-1].y, mouseX, mouseY);
  } 
  else if (step == 2)
  {
    stroke(255, 20, 20);
    strokeWeight(1);
    line(savedMouse[step-1].x, savedMouse[step-1].y, savedMouse[step-2].x, savedMouse[step-2].y);
    line(savedMouse[step-1].x, savedMouse[step-1].y, mouseX, mouseY);
    fill(255, 20, 20, 100);
    triangle(savedMouse[step-1].x, savedMouse[step-1].y, savedMouse[step-2].x, savedMouse[step-2].y, mouseX, mouseY);
  }
  popStyle();
}

void debugCircles()
{
  pushStyle();
  fill(255, 20, 20);
  noStroke();
  for (int i = allMousePos.size ()-1; i>= 0; i--)
  {
    PVector circlePos = allMousePos.get(i);
    ellipse(circlePos.x, circlePos.y, 5, 5);
  }
  popStyle();
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
      allMousePos.set(allMousePos.size()-1, mousePos);
    }
  }

  if (step == 2)
  {
    Tri newTri = new Tri(baseImage, savedMouse[0].x, savedMouse[0].y, savedMouse[1].x, savedMouse[1].y, savedMouse[2].x, savedMouse[2].y);
    triangles.add(newTri);
    step = 0 ;
  } 
  else
  {
    step++;
  }
}


boolean minPoint(PVector p1, PVector p2)
{
  boolean minpoint = false;

  if (p1.dist(p2) < minDistCollapse)
  {

    minpoint = true;
  }
  return minpoint;
}

