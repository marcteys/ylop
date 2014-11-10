boolean inside (int mousex, int mousey, int pointX, int pointY)
{
    return (mousex>pointX-5 && mousex<pointX+5 && mousey>pointY-5 && mousey<pointY+5);
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

