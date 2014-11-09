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
boolean displayEpicenter = false;


// modes
boolean drawTriangle = true;
boolean moveCircle = false;
boolean deleteTriangle = false;
int mode = 0;

// values construction
float minDistCollapse = 15;

//values visual
public int epicenterX = 150;
public int epicenterY = 200;
public int alphaDist = 20;
public int randomAlpha = 50;


//end settings

int[] savedIds = new int[3];
int step  = 0;

public ArrayList<PVector> allMousePos;
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
  cf = addControlFrame("Settings", 200, 629);
}

void draw() {
  // CP5 set position
  if (!setPosition) {
    frame.setLocation(310, 100);
    setPosition = true;
    fakeTris();
  }

  background(255);
  image(baseImage, 0, 0);

  //mode
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

  //debug
  if (displayCircle) debugCircles();
  if (displayEpicenter)
  {
    pushStyle();
    noStroke();
    fill(0, 200, 140);
    ellipse(epicenterX, epicenterY, 5, 5);
    fill(0, 200, 140, 30);
    ellipse(epicenterX, epicenterY, alphaDist*2, alphaDist*2);
    popStyle();
  }
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
    line(allMousePos.get(savedIds[step-1]).x, allMousePos.get(savedIds[step-1]).y, mouseX, mouseY);
  } 
  else if (step == 2)
  {
    stroke(255, 20, 20);
    strokeWeight(1);
    line(allMousePos.get(savedIds[step-1]).x, allMousePos.get(savedIds[step-1]).y, allMousePos.get(savedIds[step-2]).x, allMousePos.get(savedIds[step-2]).y);
    line(allMousePos.get(savedIds[step-1]).x, allMousePos.get(savedIds[step-1]).y, mouseX, mouseY);
    fill(255, 20, 20, 100);
    triangle(allMousePos.get(savedIds[step-1]).x, allMousePos.get(savedIds[step-1]).y, allMousePos.get(savedIds[step-2]).x, allMousePos.get(savedIds[step-2]).y, mouseX, mouseY);
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

    //debug stuff

    if (displayColor) tri.debugColor = true;
    else tri.debugColor = false;

    if (trianglesOnly) tri.trianglesOnly = true;
    else tri.trianglesOnly = false;
  }
}


void mousePressed() {
  if (mouseButton == LEFT) {

    PVector newMousePos = new PVector(mouseX,mouseY);

    boolean isNear = false;
    //calculate if there is a point near
    for (int i = allMousePos.size ()-1; i>= 0; i--)
    {
      PVector mousePos = allMousePos.get(i);
      if (minPoint(mousePos, newMousePos))
      {
        savedIds[step] =  i;
        isNear = true;
      }
    }
    //if it's not near, we add a new point in the canvas
    if(!isNear)
    {
     allMousePos.add(newMousePos);
    savedIds[step] =  allMousePos.size()-1;
    }

    if (step == 2)
    {
      Tri newTri = new Tri(baseImage, savedIds);
      triangles.add(newTri);
      step = 0 ;
      savedIds = new int[3];
    } 
    else
    {
      step++;
    }
  }
}


void fakeTris()
{
/*
  int marginX = 100;
  int marginY = 100;

  for (int i =0; i < 6; i++ ) {
    for (int j =0; j < 10; j++ ) {

      int x = (marginX + (i*30));
      int y = marginY + (j*30);
      allMousePos.add(new PVector(x, y));
      allMousePos.add(new PVector(x-30, y+15));
      allMousePos.add(new PVector(x-30, y-15));

   //   Tri newTri = new Tri(baseImage, x, y, x-30, y+15, x-30, y-15);
    //  triangles.add(newTri);
    }
  }*/
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

