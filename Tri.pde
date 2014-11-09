class Tri { 

  float[] positions = { 
    0, 0, 0, 0, 0, 0
  };

  color triangleColor;
  PVector centerPos ;
  int x, y, yinc;

  float twothird = 2.0/3.0;
  
  EyeDropper ed;


  int carreSize = 10;
  
  Tri (PImage baseImg, float x1, float y1, float x2, float y2, float x3, float y3) {  
    //a
    positions[0] = x1;
    positions[1] = y1;
    //b
    positions[2] = x2;
    positions[3] = y2;
    //c
    positions[4] = x3;
    positions[5] = y3;

    ed = new EyeDropper(baseImg);


    PVector bc = new PVector(
                positions[2]+(positions[4]-positions[2])/2, 
                  positions[3]+(positions[5]-positions[3])/2);
                  
    centerPos = new PVector(int( positions[0]+(bc.x-positions[0])*twothird), int(positions[1]+(bc.y-positions[1])*twothird) );


    triangleColor = ed.getColor(int(centerPos.x), int(centerPos.y),carreSize);
  } 

  void update() { 
    pushStyle();
    fill(triangleColor);
    stroke(255);
    triangle(positions[0], positions[1], positions[2], positions[3], positions[4], positions[5]);
    ed.update();
    popStyle();
  }

  void getColor()
  {

    // triangleColor = ed.getColor(int(centerPos.x),int(centerPos.y),5);
    //triangleColor = get();
  }
} 

