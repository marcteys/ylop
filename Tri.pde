class Tri { 

  float[] positions = { 
    0, 0, 0, 0, 0, 0
  };


  Tri (float x1, float y1, float x2, float y2, float x3, float y3) {  
    //positions = { x1, y1, x2, y2, x3, y3 };
    positions[0] = x1;
    positions[1] = y1;
    positions[2] = x2;
    positions[3] = y2;
    positions[4] = x3;
    positions[5] = y3;
  } 

  void update() { 
    triangle(positions[0], positions[1], positions[2], positions[3], positions[4], positions[5]);
  }
} 

