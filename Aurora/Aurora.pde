import g4p_controls.*;

//Global Variables//

//Colours
color defaultSeatColour = #5357a3;
color reservedSeatColour = #04c71e;
color planeColour = #ffffff;
color ticketColour = #0a1e4c;

//Fonts
PFont tthdb; //TT Hoves Demibold
PFont tthm; //TT Hoves Medium
PFont tthr; //TT Hoves Regular 

//Logo image
PImage auroraLogo; 

//Plane and seat generation variables
Plane fc, bc, ec;

Seat[][] fcSeats;
Seat[][] bcSeats;
Seat[][] ecSeats;

ArrayList<Seat> reservedSeats = new ArrayList<Seat>();

int fcCols = 4;
int fcRows = 6;

int bcCols = 9;
int bcRows = 9;

int ecCols = 48;
int ecRows = 12;

int fcSize = 20;
int bcSize = 15;
int ecSize = 10;

ArrayList<Ticket> allTickets = new ArrayList<Ticket>();

//Seat identifier variables 
Integer numIdentifier = 0; //Integer type is used over int as it can be set to null.
String stringIdentifier = "";
String[] rowsList = {"A", "B", "C", "D",
  "E", "F", "G", "H",
  "I", "J", "K", "L"};


//GUI variables
String origin, destination, seatClass; 
int numA, numC, numTickets; 
String sampleCode;

void setup() {
  createGUI();
  size(600, 600);
  background(200);

  //Font initialization
  tthdb = createFont("tth-demibold.ttf", 38); 
  tthm = createFont("tth-medium.ttf", 30);
  tthr = createFont("tth-regular.ttf", 20);

  //Loading the logo image from ./data
  auroraLogo = loadImage("aurora_logo.png");

  submitButton.setVisible(false);
  ticketList.setVisible(false);
  ticketPrice.setVisible(false);

  //Plane initialization
  fc = new firstClassPlane(100, height/3, width-400, height/4, "First Class");
  bc = new businessClassPlane(250, height/3, width-460, height/4 + 10, "Business Class");
  ec = new economyClassPlane(75, height/3, width-200, height/4, "Economy Class");

  //Array definition
  fcSeats = new Seat[fcCols][fcRows]; 
  bcSeats = new Seat[bcCols][bcRows];
  ecSeats = new Seat[ecCols][ecRows];

  initFC();
  initBC();
  initEC();

  //Each seat class has a different amount of numbers alloted for seat identifiers due to varying column sizes, so they must be assigned seperately
  for (int i=0; i<=fcCols; i++) {
    for (int j=0; j<=fcRows; j++) {
      try {
        assignFCSeatIdentifiers(i, j);
      }
      catch (ArrayIndexOutOfBoundsException e ) {
      }
    }
  }

  for (int i=0; i<=bcCols; i++) {
    for (int j=0; j<=bcRows; j++) {
      try {
        assignBCSeatIdentifiers(i, j);
      }
      catch (ArrayIndexOutOfBoundsException e) {
      }
    }
  }

  for (int i=0; i<=ecCols; i++) {
    for (int j=0; j<=ecRows; j++) {
      try {
        assignECSeatIdentifiers(i, j);
      }
      catch (ArrayIndexOutOfBoundsException e) {
      }
    }
  }

  //Sample flight code generation for boarding passes
  //This is generated in setup because the code should stay consistent for all tickets and seats reserved
  if (random(0,1) >= 0.5){
      sampleCode = "AUS" + String.valueOf(int(random(10, 200))); 
    }
    else{
      sampleCode = "BOR" + String.valueOf(int(random(10, 200)));
    }
  
   //Easter Egg: 
      //"AUS" is the sample airline Air Australis, which references the aurora australis; the southern lights, which are visible in and around the Antarctic.
      //Likewise "BOR" is the sample airline Borealis Airlines, references the aurora borealis; the northern lights, which are visible in and around the Arctic.
}

void draw() {
  //Switch statement to draw different planes and seats (or the Aurora logo) depending on what the user selects in the seat class dropdown menu.
  switch (seatClassList.getSelectedText()) {
  case "Pick a seat class.":
    clear();
    background(200);
    image(auroraLogo, 50, 50);
    break;
  case "First Class":
    clear();
    background(200);
    fc.drawPlane();
    for (int i=0; i<=fcCols; i++) {
      for (int j=0; j<=fcRows; j++) {
        try {
          Seat s = fcSeats[i][j];
          if (j%3 != 1 && i%2 != 0) { //For every other column, draw a seat in a 1-2-1 pattern for that column. 
            s.drawSeat();
          }
        }
        catch (ArrayIndexOutOfBoundsException e) {
        }
      }
    }
    break;
  case "Business Class":
    clear();
    background(200);
    bc.drawPlane();
    for (int i=0; i<=bcCols; i++) {
      for (int j=0; j<=bcRows; j++) {
        try {
          Seat k = bcSeats[i][j];
          if (j%4 != 2 && i%2 != 0) { //For every other column, draw a seat in a 2-3-2 pattern for that column.
            k.drawSeat();
          }
        }
        catch (ArrayIndexOutOfBoundsException e) {
        }
      }
    }
    break;
  case "Economy Class":
    clear();
    background(200);
    ec.drawPlane();
    for (int i=0; i<=ecCols; i++) {
      for (int j=0; j<=ecRows; j++) {
        try {
          Seat b = ecSeats[i][j];
          if (j%4 != 3 && i%2 != 0) { //For every other column and every fourth row, draw a seat in that position.
            b.drawSeat();
          }
        }
        catch (ArrayIndexOutOfBoundsException e) {
        }
      }
    }
    break;
  }
  if (numTickets == 0 && originTextfield.getText() != "" && destTextfield.getText() != "") { //If all seats have been reserved, and there is data for the origin and destination of the passenger
    submitButton.setVisible(true);
  }
  if (ticketList.getSelectedText() != "See your tickets.") { //If any other item in the droplist is clicked
    for (int i=0; i < allTickets.size(); i++) {
      Ticket t = allTickets.get(i); //Each ticket in the allTickets arrayList
      if (ticketList.getSelectedText().equals("Ticket " + String.valueOf((i+1)))) { //If the user selects any ticket from the droplist
        clear();
        background(200);
        t.drawTicket();
        println(t.price);
        ticketPrice.setText("$" + String.valueOf(t.price));
      }
    }
  }
}
