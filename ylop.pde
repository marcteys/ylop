// CP5

import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;
import processing.pdf.*;

private ControlP5 cp5;
ControlFrame cf;


boolean setPosition = false;
PVector pointDragged = null;
int pointToDelete = -1;


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
public int mode = 0;

// values construction
float minDistCollapse = 15;

//values visual
public int epicenterX = 150;
public int epicenterY = 200;
public int alphaDist = 20;
public int randomAlpha = 50;

//pdf
boolean recordPDF = false;


//end settings

int[] savedIds = new int[3];
int step  = 0;

public ArrayList<PVector> allPointsPos;
ArrayList<Tri> triangles;
PImage baseImage;


void setup() {  // setup() runs once
  size(1200, 800);
  frameRate(30);
  smooth();
  rectMode(CENTER);

  allPointsPos = new ArrayList<PVector>();
  triangles = new ArrayList<Tri>();
  baseImage = loadImage("base.jpg");

  // CP5
  cp5 = new ControlP5(this);
  cf = addControlFrame("Settings", 200, 629);
}

void draw() {
  // CP5 set position
  if (!setPosition) {
    frame.setLocation(310, 100);
    setPosition = true;
  }


  if (recordPDF) {
    beginRecord(PDF, "frame-####.pdf"); 
  }

  background(255);
  image(baseImage, 0, 0);

  //mode
  switch(mode){
      case 0 : // DRAW TRIANGLES
        trianglesCreation();
        break;
      case 1 :
        trianglesCreationAuto();
        break;
      case 2 : // MOVE CIRCLES
        movePoints();
        break;
      case 3 :
       deletePoint();
        break;  
    }

  //update triangles
  updateTriangles();

  if (recordPDF) {
    endRecord();
    recordPDF = false;
  }
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


void deletePoint() {

   // draw cursor
    pushStyle();
    stroke(0, 200, 140);
    fill(0, 200, 140,50);
    rect(mouseX, mouseY, minDistCollapse, minDistCollapse);
    popStyle();

    debugCircles();
}

void movePoints()
{

    // draw cursor
    pushStyle();
    noStroke();
    fill(20, 20, 255);
    ellipse(mouseX, mouseY, 5, 5);
    fill(20, 20, 255, 50);
    ellipse(mouseX, mouseY, minDistCollapse, minDistCollapse);
    popStyle();

    debugCircles();
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
    line(allPointsPos.get(savedIds[step-1]).x, allPointsPos.get(savedIds[step-1]).y, mouseX, mouseY);
  } 
  else if (step == 2)
  {
    stroke(255, 20, 20);
    strokeWeight(1);
    line(allPointsPos.get(savedIds[step-1]).x, allPointsPos.get(savedIds[step-1]).y, allPointsPos.get(savedIds[step-2]).x, allPointsPos.get(savedIds[step-2]).y);
    line(allPointsPos.get(savedIds[step-1]).x, allPointsPos.get(savedIds[step-1]).y, mouseX, mouseY);
    fill(255, 20, 20, 100);
    triangle(allPointsPos.get(savedIds[step-1]).x, allPointsPos.get(savedIds[step-1]).y, allPointsPos.get(savedIds[step-2]).x, allPointsPos.get(savedIds[step-2]).y, mouseX, mouseY);
  }
  popStyle();


    // draw cursor
    pushStyle();
    noStroke();
    fill(255, 20, 20);
    ellipse(mouseX, mouseY, 5, 5);
    fill(255, 20, 20, 50);
    ellipse(mouseX, mouseY, minDistCollapse, minDistCollapse);
    popStyle();
}


void trianglesCreationAuto()
{
  pushStyle();
    // draw cursor
    pushStyle();
    noStroke();
    fill(255, 20, 20);
    ellipse(mouseX, mouseY, 5, 5);
    fill(255, 20, 20, 50);
    ellipse(mouseX, mouseY, minDistCollapse, minDistCollapse);
    popStyle();
}





void debugCircles()
{
  pushStyle();
  fill(255, 20, 20);
  noStroke();
  for (int i = allPointsPos.size ()-1; i>= 0; i--)
  {
    PVector circlePos = allPointsPos.get(i);
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
    switch(mode){
      case 0 :
        mouseTriangleCreation();
        break;
      case 1 :
        mouseTriangleCreationAuto();
        break;
      case 2 :
        mouseMovePoint();
        break;
      case 3 :
      mouseDeletePoint();
        break;  
    }
  }
}

void mouseDragged()
{
     switch(mode){
      case 2 :
        if(pointDragged != null)
        {
          pointDragged.x = mouseX;
          pointDragged.y = mouseY;

          //update triangles
          for (int i = triangles.size ()-1; i >= 0; i--)
          {
            Tri tri = triangles.get(i);
            tri.moveTriangle();
          }
        }
        break;
    }
}

void mouseReleased() {
  //update triangle pos
   switch(mode){
      case 2 :
        if(pointDragged != null)
        {
            // if its near ?
        }
        break;
    }
}



void mouseDeletePoint()
{
    for (int i = allPointsPos.size ()-1; i>= 0; i--)
    {
      PVector pointPos = allPointsPos.get(i);
      if(inside(mouseX,mouseY,pointPos.x,pointPos.y))
      {
        pointToDelete = i;
      }
    } 

    //if there is a point to delete
    if(pointToDelete >= 0)
    {
      //remove triangles connected to the specifi point
      for (int i = triangles.size ()-1; i >= 0; i--)
      {
        Tri tri = triangles.get(i);

        for(int j = 0; j < 3; j++) {
          if(tri.triPoints[j] == pointToDelete)
          {
              println("delete point: "+ i);
              if(tri != null) triangles.remove(i);
          }
        }
      }
      //remove the point;
      allPointsPos.remove(pointToDelete);
      pointToDelete = -1;
    }
}

void mouseMovePoint(){

    for (int i = allPointsPos.size ()-1; i>= 0; i--)
    {
      PVector pointPos = allPointsPos.get(i);
      if(inside(mouseX,mouseY,pointPos.x,pointPos.y))
      {
        pointDragged = pointPos;
      }
    }    
}


void mouseTriangleCreationAuto()
{
    if(allPointsPos.size() <= 2 )
    {
      //we do nothing if there is not enough points
    }
    else
    {
        step = 0;

        int newPointID = addANewPoint();

        int nearestOne = -1;
        int nearestTwo = -1;
        float nearDistOne = 5000;
        float nearDistTwo = 5000;

        /* TO DO : Optmize in one loop */
        //nearest point
        for (int i = allPointsPos.size ()-1; i>= 0; i--)
        {
          PVector pointPos = allPointsPos.get(i);
          if (i != newPointID && pointPos.dist(allPointsPos.get(newPointID)) < nearDistOne)
          {  
            nearDistOne = pointPos.dist(allPointsPos.get(newPointID));
            nearestOne = i;
          }
        }
       
         //second nearest point
        for (int i = allPointsPos.size ()-1; i>= 0; i--)
        {
          PVector pointPos = allPointsPos.get(i);
          if (i != newPointID && i != nearestOne && pointPos.dist(allPointsPos.get(newPointID)) < nearDistTwo)
          {  
            nearDistTwo = pointPos.dist(allPointsPos.get(newPointID));
            nearestTwo = i;
          }
        }
        
      int[] triPos = {newPointID, nearestOne, nearestTwo};
       
      Tri newTri = new Tri(baseImage, triPos);
      triangles.add(newTri);
      step = 0 ;

    }

}


// mode  0
void mouseTriangleCreation()
{

    addANewPoint();

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


int addANewPoint()
{
    PVector newpointPos = new PVector(mouseX,mouseY);
    int pointID = -1;
    
    boolean isNear = false;
    //calculate if there is a point near
    for (int i = allPointsPos.size ()-1; i>= 0; i--)
    {
      PVector pointPos = allPointsPos.get(i);
      if (minPoint(pointPos, newpointPos))
      {
        savedIds[step] =  i;
        pointID = i;
        isNear = true;
      }
    }
    //if it's not near, we add a new point in the canvas
    if(!isNear)
    {
       allPointsPos.add(newpointPos);
      savedIds[step] =  allPointsPos.size()-1;
      pointID =  allPointsPos.size()-1;
    }

  return pointID;
}


void ResetCanvas()
{


triangles.clear();
allPointsPos.clear();
/*
  for (int i = triangles.size ()-1; i >= 0; i--)
  {
   triangles.remove(i);
    tri.update();

    //debug stuff
    if (displayColor) tri.debugColor = true;
    else tri.debugColor = false;

    if (trianglesOnly) tri.trianglesOnly = true;
    else tri.trianglesOnly = false;
  }


  for (int i = allPointsPos.size ()-1; i>= 0; i--)
    {
      PVector pointPos = allPointsPos.get(i);
      if (minPoint(pointPos, newpointPos))
      {
        savedIds[step] =  i;
        isNear = true;
      }
    }
*/
}


public void LoadData()
{

  ResetCanvas();
  xml = loadXML("points.xml");
  XML[] pointsChildren = xml.getChildren("points");
  XML[] pointChildren = pointsChildren[0].getChildren("point");

  allPointsPos = new ArrayList<PVector>();

  for (int i = pointChildren.length-1; i >=0; i--) {
    int id = pointChildren[i].getInt("id");
    PVector position = new PVector(pointChildren[i].getFloat("x"), pointChildren[i].getFloat("y"));
    allPointsPos.add(id,position);
  }


  XML[] trianglesChildren = xml.getChildren("triangles");
  XML[] triangleChildren = trianglesChildren[0].getChildren("triangle");

  triangles = new ArrayList<Tri>();
  for (int i = triangleChildren.length-1; i >=0; i--) {
    int id = triangleChildren[i].getInt("id");
    int[] idPoints = new int[3];
    idPoints[0] = triangleChildren[i].getInt("a");
    idPoints[1] = triangleChildren[i].getInt("b");
    idPoints[2] = triangleChildren[i].getInt("c");
    Tri newTri = new Tri(baseImage, idPoints);
    triangles.add(id,newTri);
  }

  println("XML loaded ");

}
