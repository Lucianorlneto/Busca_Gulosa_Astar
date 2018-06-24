class Box {
  int x, y, w, h;
  int corA = 255;
  int corB = 255;
  int corC = 255;
  boolean parede;
  
  Box(int x, int y, int w, int h) {
     this.x = x;
     this.y = y;
     this.w = w;
     this.h = h;
     parede = false;
  }
  
  void draw() {
    stroke(0);
    fill(corA, corB, corC);
    rect(x, y, w, h); 
  }
  
  void changeColor(int A, int B, int C) {
    corA = A;
    corB = B;
    corC = C;
  }
  
}