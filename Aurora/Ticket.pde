class Ticket {

  Seat seat;
  String origin;
  String destination;
  String flightCode;

  //Constructor
  Ticket(Seat s, String f) {
    this.seat = s;
    this.origin = originTextfield.getText();
    this.destination = destTextfield.getText();
    this.flightCode = f;
  }
  
  //Draws a ticket. The dimmensions are precise in order to accurately depict a boarding pass. 
  void drawTicket() {
    clear();
    background(200);
    stroke(ticketColour);
    fill(ticketColour);
    rect(5, 200, 590, 300);
    textSize(35);
    textFont(tthdb);
    fill(255);
    text("BOARDING PASS", 10, 240);
    textFont(tthr);
    text("Route", 10, 280);
    rect(10, 290, 150, 50);
    text("Flight Code", 170, 280);
    rect(170, 290, 120, 50);
    text("Seat", 300, 280);
    rect(300, 290, 70, 50);
    text("Class", 380, 280);
    rect(380, 290, 215, 50);
    fill(ticketColour);
    textFont(tthm);
    text(this.origin + " - " + this.destination, 13, 325);
    text(this.flightCode, 175, 325);
    text(this.seat.identifier, 305, 325);
    text(this.seat.plane.title, 385, 325);
  }
}
