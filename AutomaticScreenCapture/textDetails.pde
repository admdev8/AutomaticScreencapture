
// display details about this program

void textDetails() {

  background(0);
  fill(255);
  textAlign(LEFT, CENTER);

  textFont(headlineFont, 48);
  text("AUTOMATIC SCREENCAPTURE", numberBox.w + numberBox.x + 30, 90);

  textFont(detailsFont, 14);
  text("hit the button - pauses video - automatically captures frames - starts playing again", numberBox.w + numberBox.x + 30, 130);
}

