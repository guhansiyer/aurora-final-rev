//Airplane seat identifiers work as follows for the purposes of this program.
//Every seat in a column shares the same numerical identifier, and every seat in a row shares the same alphabetical identifier.

//All assignIdentifier() functions utilize the same logic to assign identifiers to the seats as it does to draw them.
public void assignFCSeatIdentifiers(int i, int j) {
  if (j%3 != 1 && i%2 != 0) { 
    stringIdentifier = rowsList[j];
  }
  if (i == 0) {
    numIdentifier = 1; //The first value in the init for-loop defaults to 1.
  } else {
    numIdentifier = (i+1)/2; //Every value after i=0 is incrememnted and halved.
  }
  //After computing a seat's identifier, the variables used to make up the identifier are nulled.
  //This is done to prevent undrawn seats from receiving an identifier.
  fcSeats[i][j].identifier = String.valueOf(numIdentifier) + stringIdentifier; 
  numIdentifier = null;
  stringIdentifier = null;
}

public void assignBCSeatIdentifiers(int i, int j) {
  if (j%4 != 2 && i%2 != 0) {
    stringIdentifier = rowsList[j];
  }
  if (i == 0) {
    numIdentifier = 3; //Since assignFCSeatIdentifiers() only assigns seats upto a numIdentifier of 2, i = 0 will default to 3 for consistency. 
  } else {
    numIdentifier = (i+5)/2; //Every subsequent value afterwards is added to by five and halved, in order to keep increasing by one from column to column.
  }
  bcSeats[i][j].identifier = String.valueOf(numIdentifier) + stringIdentifier;
  numIdentifier = null;
  stringIdentifier = null;
}

public void assignECSeatIdentifiers(int i, int j) {
  if (j%4 != 3 && i%2 != 0) {
    stringIdentifier = rowsList[j];
    if (i == 0) {
      numIdentifier = 7; //Similarly for economy class seats, i = 0 will default to 7 for consistency with the other two seat classes.
    } else {
      numIdentifier = (i+15)/2; //Every subsequent value is now added to by 15 and halved, in order to keep increasing by one from column to column.
    }
    ecSeats[i][j].identifier = String.valueOf(numIdentifier) + stringIdentifier;
    numIdentifier = null;
    stringIdentifier = null;
  }
}

//The initialization functions for each seat classes array must be done separately.
//Each seating class has a different number of rows and columns, which cannot be accounted for in one array.
public void initFC() {
  for (int i=0; i<=fcCols; i++) {
    for (int j=0; j<=fcRows; j++) {
      try {
        fcSeats[i][j] = new Seat((i*fcSize)+fc.xInitial, (j*fcSize)+fc.yInitial+15, fc, fcSize);
      }
      catch (ArrayIndexOutOfBoundsException e) {
      }
    }
  }
}


public void initBC() {
  for (int i=0; i<=bcCols; i++) {
    for (int j=0; j<=bcRows; j++) {
      try {
        bcSeats[i][j] = new Seat((i*bcSize)+bc.xInitial, (j*bcSize)+bc.yInitial+10, bc, bcSize);
      }
      catch (ArrayIndexOutOfBoundsException e) {
      }
    }
  }
}

public void initEC() {
  for (int i=0; i<=ecCols; i++) {
    for (int j=0; j<=ecRows; j++) {
      try {
        ecSeats[i][j] = new Seat((i*ecSize)+ec.xInitial, (j*ecSize)+ec.yInitial+15, ec, ecSize);
      }
      catch (ArrayIndexOutOfBoundsException e) {
      }
    }
  }
}

public boolean isWithinSeat(int i, int j) {
  try { //Checks if the mouse is within the boundaries of a seat, and if the seat has a valid identifier, to prevent undrawn seats from being reserved. 
    if (seatClassList.getSelectedText().equals("First Class")) {
      if ((fcSeats[i][j].xPos <= mouseX && mouseX <= fcSeats[i][j].xPos + fcSeats[i][j].size) &&
        (fcSeats[i][j].yPos <= mouseY && mouseY <= fcSeats[i][j].yPos + fcSeats[i][j].size) && fcSeats[i][j].identifier != null) {
        return true;
      }
    }
    if (seatClassList.getSelectedText().equals("Business Class")) {
      if ((bcSeats[i][j].xPos <= mouseX && mouseX <= bcSeats[i][j].xPos + bcSeats[i][j].size) &&
        (bcSeats[i][j].yPos <= mouseY && mouseY <= bcSeats[i][j].yPos + bcSeats[i][j].size) && bcSeats[i][j].identifier != null) {
        return true;
      }
    }
    if (seatClassList.getSelectedText().equals("Economy Class")) {
      if ((ecSeats[i][j].xPos <= mouseX && mouseX <= ecSeats[i][j].xPos + ecSeats[i][j].size) &&
        (ecSeats[i][j].yPos <= mouseY && mouseY <= ecSeats[i][j].yPos + ecSeats[i][j].size) && ecSeats[i][j].identifier != null) {
        return true;
      }
    }
  }
  catch (ArrayIndexOutOfBoundsException e) {
  }
  return false;
}

public void mouseClicked() { //Function called on every mouse click.
  switch (seatClassList.getSelectedText()) { //Switch statement based on the selected seat class from the drop list menu.
  case "Pick a seat class.":
    break;
  case "First Class":
    for (int i=0; i<=fcCols; i++) {
      for (int j=0; j<=fcRows; j++) {
        if (isWithinSeat(i, j) == true && numTickets > 0) {
          fcSeats[i][j].reserveSeat(); //Reserved the current seat if isWithinSeat() = true and you have at least one ticket.
          reservedSeats.add(fcSeats[i][j]); //Add the current seat to an array list of all reserved seats.
          showSelectedSeat.setText(fcSeats[i][j].identifier); //Show the identifier of the currently selected seat in the GUI.
        }
      }
    }
    break;

  case "Business Class":
    for (int i=0; i<=bcCols; i++) {
      for (int j=0; j<=bcRows; j++) {
        if (isWithinSeat(i, j) == true && numTickets > 0) {
          bcSeats[i][j].reserveSeat();
          reservedSeats.add(bcSeats[i][j]);
          showSelectedSeat.setText(bcSeats[i][j].identifier);
        }
      }
    }
    break;

  case "Economy Class":
    for (int i=0; i<=ecCols; i++) {
      for (int j=0; j<=ecRows; j++) {
        if (isWithinSeat(i, j) == true && numTickets > 0) {
          ecSeats[i][j].reserveSeat();
          reservedSeats.add(ecSeats[i][j]);
          showSelectedSeat.setText(ecSeats[i][j].identifier);
        }
      }
    }
    break;
  }
}

public void reset() { //Function called on every click of the reset button.

  clear(); //Clear the screen.
  seatClassList.setSelected(0); //Set the seat class drop list to row 0, which displays the Aurora logo.

  //Set all fields to 0 or empty. If the submit button or ticket list are visible, reverse their visibility.
  originTextfield.setText(""); 
  destTextfield.setText("");
  numAdults.setValue(0);
  numChildren.setValue(0);
  showSelectedSeat.setText("");
  submitButton.setVisible(false);
  ticketList.setVisible(false);
  numTickets = 0;
  numA = 0;
  numC = 0;

  //Empty the ticket droplist, and unreserve all reserved seats.
  for (int i=0; i < reservedSeats.size(); i++) {
    Seat l = reservedSeats.get(i);
    l.unreserveSeat();
    ticketList.removeItem(i);
  }
}
