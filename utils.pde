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

