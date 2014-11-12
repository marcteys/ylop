boolean inside (int mousex, int mousey, float pointX, float pointY)
{
    return (mousex>pointX-5 && mousex<pointX+5 && mousey>pointY-5 && mousey<pointY+5);
}

boolean minPoint(PVector p1, PVector p2)
{
	boolean minpoint = false;
	if (p1.dist(p2) < minDistCollapse && p1.dist(p2) != 0)
	{
		minpoint = true;
	}
	return minpoint;
}





//save side
XML xml;

public void SaveData()
{

  String currentTime = ""+year() + month() + day() + hour() + minute() + second();

  xml = new XML("ylop");

  XML memo = xml.addChild("settings");
  XML newChild = memo.addChild("name");
  newChild.setContent("My custom name baseImage");
  
  //adding time
  newChild = memo.addChild("time");
  newChild.setString("year", year()+"");
  newChild.setString("month", month()+"");
  newChild.setString("day", day()+"");
  newChild.setString("hour", hour()+"");
  newChild.setString("minute", minute()+"");
  newChild.setString("second", second()+"");

  //insert the points
  XML pointsChild = xml.addChild("points");
  for (int i = allPointsPos.size ()-1; i>= 0; i--)
  {
    PVector pointPos = allPointsPos.get(i);
    newChild = pointsChild.addChild("point");
    newChild.setInt("id", i);
    newChild.setFloat("x", pointPos.x);
    newChild.setFloat("y", pointPos.y);
  }

  XML trianglesChild = xml.addChild("triangles");
  for (int i = triangles.size ()-1; i >= 0; i--)
  {
    Tri tri = triangles.get(i);

    newChild = trianglesChild.addChild("triangle");
    newChild.setInt("id", i);
    newChild.setInt("a", tri.triPoints[0]);
    newChild.setInt("b", tri.triPoints[1]);
    newChild.setInt("c", tri.triPoints[2]);
  }

  //create an unique save + replace the current "points" file
  saveXML(xml, "/data/points-"+currentTime+".xml");
  saveXML(xml, "/data/points.xml");
  println("XML Saved.");

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
