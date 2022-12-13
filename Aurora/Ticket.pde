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
    println("this isnt vscode lagging")
    println(calculatePrice());
  }

  private int calculatePrice() {
    int basePrice = 0;
    switch (this.seat.plane.title) { //Switch statement based on the selected seat class from the drop list menu.
      case "First Class":
        basePrice = 3500;
        for (int i=0; i<=fcCols; i++) {
          for (int j=0; j<=fcRows; j++) {
            try{
              if (fcSeats[i][j] == this.seat){
                if (j == 0 || j == fcRows) {
                  basePrice += int(random(50, 100));
                }
                else{
                  basePrice += int(random(25, 50));
                }
              }
            }
            catch (ArrayIndexOutOfBoundsException e){}
          }
        }

      case "Business Class":
        basePrice = 2000;
        for (int i=0; i<=bcCols; i++) {
          for (int j=0; j<=bcRows; j++) {
            try{
              if (bcSeats[i][j] == this.seat) {
                if (j == 0 || j == bcRows) {
                  basePrice += int(random(50, 100));
                }
                if (j == 1 || j == bcRows-1 ) {
                  basePrice += int(random(50, 75));
                }
                else{
                  basePrice += int(random(25, 50));
                }
              }
            }
            catch (ArrayIndexOutOfBoundsException e){}
          }
        }

      case "Economy Class":
        basePrice = 700; 
        for (int i=0; i<=ecCols; i++) {
          for (int j=0; j<=ecRows; j++) {
            try {
              if (ecSeats[i][j] == this.seat){
                if (j == 0 || j == ecRows){
                  basePrice += int(random(50, 100));
                }
                if (j == 1 || j == 2 || j == ecRows-1 || j == ecRows-2){
                  basePrice += int(random(50, 75));
                }
                else{
                  basePrice += int(random(25, 50));
                }
              }
            }
            catch (ArrayIndexOutOfBoundsException e){}
          }
        }
      }
    return basePrice;
  }
}
