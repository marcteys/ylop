class Tri { 

  float[] positions = { 
    0, 0, 0, 0, 0, 0
  };

  color triangleColor;
  PVector centerPos ;
  int x, y, yinc;


  Tri (float x1, float y1, float x2, float y2, float x3, float y3) {  
    //positions = { x1, y1, x2, y2, x3, y3 };
    positions[0] = x1;
    positions[1] = y1;
    positions[2] = x2;
    positions[3] = y2;
    positions[4] = x3;
    positions[5] = y3;


    centerPos = new PVector(int(round((x1+x2+x3)/3)), int(round((y1+y2+y3)/3)));
  } 

  void update() { 
    fill(triangleColor);

    triangle(positions[0], positions[1], positions[2], positions[3], positions[4], positions[5]);
  }

  void getColor()
  {

    //triangleColor = get(int(centerPos.x),int(centerPos.y));
  }
} 

