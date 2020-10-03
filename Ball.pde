class Ball{
  int centerX, centerY, maxWidth;
  color fillColor;
  String material = "glass";
  
  Ball(int _centerX, int _centerY, int _maxWidth, color _myc){
    centerX = _centerX;
    centerY = _centerY;
    maxWidth = _maxWidth;
    fillColor = _myc;
  }
  
  void draw(){
    fill(fillColor);
    jr.fill(material, red(fillColor), green(fillColor), blue(fillColor));
    pushMatrix();
    translate(centerX, centerY);
   sphere(maxWidth/2);
    popMatrix();
  }
}
