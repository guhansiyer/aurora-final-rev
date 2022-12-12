//Subclass of Plane
class firstClassPlane extends Plane {
  firstClassPlane(float xi, float yi, float xs, float ys, String t) {
    super(xi, yi, xs, ys, t);
  }

  //Draws the economy class plane with different proportions and shapes than the other two subclasses.
  void drawPlane() {
    stroke(planeColour);
    fill(planeColour);
    rect(this.xInitial, this.yInitial, this.xSize, this.ySize);
    ellipse(this.xInitial, this.yInitial+75, 1.5*this.xSize, this.ySize);
    stroke(0);
    line(this.xInitial, this.yInitial+10, this.xInitial, (this.yInitial + this.ySize)-10);
  }
}
