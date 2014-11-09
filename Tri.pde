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

    PVector bc = new PVector(
    allMousePos.get(points[1]).x+(allMousePos.get(points[2]).x-allMousePos.get(points[1]).x)/2, 
    allMousePos.get(points[1]).y+(allMousePos.get(points[2]).y-allMousePos.get(points[1]).y)/2);

    centerPos = new PVector(int( allMousePos.get(points[0]).x+(bc.x-allMousePos.get(points[0]).x)*twothird), int(allMousePos.get(points[0]).y+(bc.y-allMousePos.get(points[0]).y)*twothird) );

    triangleColor = ed.getColor(int(centerPos.x), int(centerPos.y), carreSize);
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
      allMousePos.get(triPoints[0]).x, allMousePos.get(triPoints[0]).y,
      allMousePos.get(triPoints[1]).x, allMousePos.get(triPoints[1]).y,
      allMousePos.get(triPoints[2]).x, allMousePos.get(triPoints[2]).y);

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

}