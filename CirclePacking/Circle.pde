class Circle {
  float x;
  float y;
  float r;
  boolean growing = true;

  Circle(float x_, float y_) {
    x = x_;
    y = y_;
    r = 0.5;
  }

  void grow() {
    if (growing) {
      r += 1;
    }
  }
  
  boolean edges(){
   return (x+r>width || x-r<0 || y+r>height || y-r<0); 
  }
  
  void show(){
    noFill();
    strokeWeight(2);
    stroke(255);
   ellipse(x, y, r*2, r*2); 
  }
}
