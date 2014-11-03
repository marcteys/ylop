 class EyeDropper { 

  
  boolean debug = false;
  int nbrPixels;
float tr, tg, tb;

 color calculatedCol;
 
  PVector carrePos;
  int carreSize;

  PImage baseImg;
  
  EyeDropper (PImage baseImage) {
    
    baseImg = baseImage;
  } 


  color getColor(int posX, int posY, int size)
  {
     calculatedCol = color(0, 0, 0);
carrePos = new PVector(posX,posY);
size = size/2;
  carreSize = size;
  
    nbrPixels = 0;
    
    for(int i=posX-size; i<=posX+size;i++)
    {
      for(int j=posY - size ;j<=posY + size ;j++)
      {
        color tmp = baseImg.get(i,j);
       
        tr += red(tmp);
        tg += green(tmp);
        tb += blue(tmp);
      //noSmooth();

      point(i,j);
        nbrPixels++;
      }
    }
  
  
  
calculatedCol = color ( tr/nbrPixels, tg/nbrPixels, tb/nbrPixels);
  
  
  tr = 0;
  tg = 0;
  tb = 0;

    return calculatedCol;
  }
  
  void update()
  {
    if(debug)
    {
      fill(calculatedCol);
        
    for(int i=int(carrePos.x)-carreSize; i<=int(carrePos.x)+carreSize;i++)
    {
      for(int j=int(carrePos.y) - carreSize ;j<=int(carrePos.y) + carreSize ;j++)
      {
        
        if(i == int(carrePos.x)-carreSize || i == int(carrePos.x)+carreSize || j == int(carrePos.y) - carreSize  || j == int(carrePos.y) + carreSize ) stroke(255);
         else stroke(calculatedCol);
        
        color tmp = get(i,j);
       
        tr += red(tmp);
        tg += green(tmp);
        tb += blue(tmp);
      noSmooth();

      point(i,j);
      }
    }
  
    }
  }
}

