
Tri trii = new Tri(0, 0, 50, 50, 100, 100);


PVector[] savedMouse = new PVector[3];
int step  = 0;

ArrayList<PVector> allMousePos;
ArrayList<Tri> triangles;

PImage myImage;


void setup() {  // setup() runs once
  size(325, 600);
  frameRate(30);
  smooth();

  allMousePos = new ArrayList<PVector>();
  triangles = new ArrayList<Tri>();

  myImage = loadImage("test.jpg");
}

void draw() {
  background(255);
  image(myImage, 0, 0);
 

  //triangle creation
  fill(255);
  noStroke();
  trii.update();

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
    Tri newTri = new Tri(savedMouse[0].x, savedMouse[0].y, savedMouse[1].x, savedMouse[1].y, savedMouse[2].x, savedMouse[2].y);
    newTri.getColor();
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

