class Paddle {
  float x;
  float y;
  //float yMouse;
  float w = W/90;
  float h = H/7.5;
  float z = w*1.5;
  
  Paddle(boolean left, float W, float H) {
    if (left) {
      x = w*2; 
    } else {
      x = W - w*2;
    }
    y = H/2;//-(h/2)-ball.rad;
    //yMouse = mouseY;
    }
  
  //void update() {
    
  //}
  
  void show(){
   pushMatrix();
   translate(x, y,z/2);
   strokeWeight(1);
   stroke(50);
   box(w,h,z);
   popMatrix();
  }
  
  void move(float steps) {
      //{
      y = steps;
      y = constrain(steps,0+h/2,H-h/2);
      
   // }
  }
  
  void moveX(float steps) {
      //{
        if (x < W*0.5) {
      //x = steps;
      x = constrain(steps,(w*2),((width*0.1))); // left
        }
        else
        {
      //x = steps;
      x = constrain(steps,W-((width*0.1)),W-(w*2)); // right
        }
   // }
  }

}
