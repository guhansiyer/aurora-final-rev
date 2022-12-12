//Subclass of Plane
class economyClassPlane extends Plane {
  economyClassPlane(float xi, float yi, float xs, float ys, String t) {
    super(xi, yi, xs, ys, t);
  }

  //Draws the economy class plane with different proportions and shapes than the other two subclasses.
  void drawPlane() {
    stroke(planeColour);
    fill(planeColour);
    rect(this.xInitial, this.yInitial, this.xSize, this.ySize);
    ellipse(this.xInitial+400, this.yInitial+75, 0.75*this.xSize, this.ySize);
  }
}
