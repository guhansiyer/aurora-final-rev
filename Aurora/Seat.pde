//Seat class
class Seat {
  //Fields
  boolean isReserved = false;
  float xPos, yPos;
  color seatColour;
  String identifier;
  float size;
  Plane plane;


  //Constructor
  Seat(float x, float y, Plane p, float s) {
    this.seatColour = defaultSeatColour;
    this.xPos = x;
    this.yPos = y;
    this.plane = p;
    this.size = s;
    
  }

  //Method to draw seats on the plane according to the plane's dimmensions.
  void drawSeat() {
    stroke(this.seatColour);
    square(this.xPos, this.yPos, this.size);
  }

  //Reserves a seat.
  void reserveSeat() {
    this.isReserved = true; 
    this.seatColour = reservedSeatColour; 
    this.drawSeat(); //With the colour changed, the seat is redrawn.
    if (this.identifier != null) { //If the seat you are trying to reserve has a valid identifier, decrement the total tickets you have after reserving a seat.
      numTickets -= 1;
    }
  }

  //Unreserves a seat.
  void unreserveSeat() {
    this.isReserved = false;
    this.seatColour = defaultSeatColour;
    this.drawSeat(); 
    if (this.identifier != null) {
      numTickets += 1;
    }
    reservedSeats.remove(this); //Remove the current seat from the reservedSeats array list. 
  }
}
