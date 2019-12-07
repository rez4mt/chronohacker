
class Ball {
  float x;
  float y;
 
  float balldiam;
 
  float velx;
  float vely;
 
  color colorBall;
  //
  //auxiliar para cambiar valores
  Ball(int xini, int yini, 
    float diamini, 
    color colorBallini) {
    // constructor 
    x=xini;
    y=yini;
 
    velx=random(2);
    vely=random(1);
 
    balldiam=diamini;
 
    colorBall=colorBallini;
  } // constructor
} // class 
//
