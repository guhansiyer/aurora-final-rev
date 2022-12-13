class Ticket {

  Seat seat;
  String origin;
  String destination;
  String flightCode;
  int price;

  //Constructor
  Ticket(Seat s, String f) {
    this.seat = s;
    this.origin = originTextfield.getText();
    this.destination = destTextfield.getText();
    this.flightCode = f;
    this.price = calculatePrice();
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

  //Calculates the price of a ticket based on factors such as if the corresponding seat is a window or aisle seat, and a seat's overall proximity to the windows.
  private int calculatePrice() { 
    int basePrice = 0;
    switch (this.seat.plane.title) { //Switch statement based on the seat's origin plane.
      case "First Class":
        println("condition one");
        basePrice = 3500;
        for (int i=0; i<=fcCols; i++) {
          for (int j=0; j<=fcRows; j++) {
            try{
              if (fcSeats[i][j] == this.seat){ 
                if (j == 0 || j == fcRows) { //If the reserved seat is a window seat in first class
                  basePrice += int(random(100, 200)); //The base price is increased by a value between 100 and 200.
                }
                else{ 
                  basePrice += int(random(50, 100));
                }
              }
            }
            catch (ArrayIndexOutOfBoundsException e){}
          }
        }
        break;

      case "Business Class":
        println("condition two");
        basePrice = 2000;
        for (int i=0; i<=bcCols; i++) {
          for (int j=0; j<=bcRows; j++) {
            try{
              if (bcSeats[i][j] == this.seat) {
                if (j == 0 || j == bcRows) {
                  basePrice += int(random(100, 150));
                }
                if (j == 1 || j == bcRows-1 ) { //If the reserved seat is one away from a window in business class;
                  basePrice += int(random(50, 100)); //The base price is increased by a value between 50 and 100.
                }
                else{
                  basePrice += int(random(25, 50));
                }
              }
            }
            catch (ArrayIndexOutOfBoundsException e){}
          }
        }
        break;

      case "Economy Class":
        println("condition three");
        basePrice = 700; 
        for (int i=0; i<=ecCols; i++) {
          for (int j=0; j<=ecRows; j++) {
            try {
              if (ecSeats[i][j] == this.seat){
                if (j == 0 || j == ecRows){
                  basePrice += int(random(50, 100));
                }
                if (j == 1 || j == 2 || j == ecRows-1 || j == ecRows-2){ //If the reserved seat is one or two seats away from a window in economy class;
                  basePrice += int(random(25, 50)); //The base price is increased by a value between 25 and 50. 
                }
                else{
                  basePrice += int(random(1, 25)); //If it is a seat in economy class in the middle of the plane, it's price is increased by a value between 1 and 25.
                }
              }
            }
            catch (ArrayIndexOutOfBoundsException e){}
          }
        }
        break;
      }
    return basePrice;
  }
}
