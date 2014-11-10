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

  XML memo = xml.addChild("customData");
  XML newChild = memo.addChild("name");
  newChild.setContent("My custom name baseImage");

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


}
