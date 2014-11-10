class Tri { 

  color triangleColor;
  PVector centerPos ;

  int x, y, yinc;

  float twothird = 2.0/3.0;

  EyeDropper ed;

  public boolean debugColor = false;
  public boolean trianglesOnly = false;

  int carreSize = 10;

  float distanceFromEpicenter = 10000;

  long randSeed = (long)random(0, 5000); 

  int[] triPoints = new int[6];

  Tri (PImage baseImg, int[] points) {  

    
    triPoints = points;

    ed = new EyeDropper(baseImg);

    moveTriangle();

  } 

  void update() { 
    pushStyle();
    if (trianglesOnly) {
      noFill();
      stroke(0);
    }
    else {
      fill(triangleColor,triangleAlpha());/*
      stroke(255,0,0);
      line(epicenterX,epicenterY,centerPos.x,centerPos.y);*/
      stroke(255);
    }
    triangle(
      allPointsPos.get(triPoints[0]).x, allPointsPos.get(triPoints[0]).y,
      allPointsPos.get(triPoints[1]).x, allPointsPos.get(triPoints[1]).y,
      allPointsPos.get(triPoints[2]).x, allPointsPos.get(triPoints[2]).y);

    if (debugColor) ed.debug = true;
    else if (!debugColor) ed.debug = false;

    ed.update();
    popStyle();
  }

  float triangleAlpha()
  {
    float alpha;
    
    float distanceFromEpicenter =  dist(centerPos.x, centerPos.y, epicenterX, epicenterY);
    alpha = constrain(map(distanceFromEpicenter,0+alphaDist,50+alphaDist,255,0),0,255);

    //adding random

    randomSeed(randSeed);
    float rand = random(-randomAlpha/3, randomAlpha);
    alpha = constrain(alpha+rand, 0, 255);

   return alpha; 
  }


  void moveTriangle()
  {
    PVector bc = new PVector(
      allPointsPos.get(triPoints[1]).x+(allPointsPos.get(triPoints[2]).x-allPointsPos.get(triPoints[1]).x)/2, 
      allPointsPos.get(triPoints[1]).y+(allPointsPos.get(triPoints[2]).y-allPointsPos.get(triPoints[1]).y)/2);


    centerPos = new PVector(int( allPointsPos.get(triPoints[0]).x+(bc.x-allPointsPos.get(triPoints[0]).x)*twothird), int(allPointsPos.get(triPoints[0]).y+(bc.y-allPointsPos.get(triPoints[0]).y)*twothird) );

    triangleColor = ed.getColor(int(centerPos.x), int(centerPos.y), carreSize);

  }
  
}