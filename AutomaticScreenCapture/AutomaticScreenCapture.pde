import java.awt.Robot;               // "robot" and screencapture
import java.awt.AWTException;
import java.awt.event.KeyEvent;
import java.awt.Frame;
import processing.serial.*;          // for connection to Arduino

/*
AUTOMATIC SCREENCAPTURE
 Jeff Thompson | 2012-13 | www.jeffreythompson.org
 
 Created as part of a commission by Rhizome.org (a big 'thank you!')
 
 Automatically takes control of VLC using a single button connected
 to an Arduino (for source code and schematic, see the 'ArduinoCode' tab.
 
 Works by pausing your movie, takes a screenshot, advances by N frames
 (taking screenshots along the way), and starts the movie again!
 
 This sketch uses the Java AWT 'robot' class, which allows you to
 create virtual keystrokes (automatic keyboard shortcuts in VLC).
 */

int numFrames = 5;                // how many frames to automatically capture
int pause = 500;                  // time between pause/next-frame events (ms)
boolean fastjump = false;         // jump lots of frames (default off)
int keyIn = 49;                   // value to look for - when received, starts capture process (1 = 49 in ascii)
boolean minify = false;           // automatically minimize when opened?

boolean captureIt = false;        // flag for running screencapture
boolean serialConnected = false;  // is there something connected to the serial port?
Robot robot;                      // robot object for virtual keyboard
Serial serialPort;                // serial object for communication with Arduino
String portName;                  // serial port when initializing
NumberBox numberBox;              // custom number box object to change the number of frames

PFont headlineFont, detailsFont, numberFont;    // fonts for UX

void setup() {

  // basic setup
  size(950, 200);
  smooth();
  frame.setTitle("Automatic Screen Capture");

  // fonts
  headlineFont = loadFont("LetterGothicStd-48.vlw");
  detailsFont = loadFont("LetterGothicStd-14.vlw");
  numberFont = loadFont("LetterGothicStd-72.vlw");

  // create robot and serial objects
  try {
    robot = new Robot();
  }
  catch (AWTException e) {
    println("Couldn't create robot...");
  }

  try {
    portName = Serial.list()[0];
    serialPort = new Serial(this, portName, 9600);
    serialConnected = true;
  }
  catch (Exception e) {
    println("Error creating serial connection - perhaps no device connected?");
  }

  // numberBox for # of frames (arguments are x/y position)
  numberBox = new NumberBox(35, 5);
  numberBox.y = (height - numberBox.h) / 2;    // center vertically
  numberBox.printNumFrames();                  // let us know how many frames will be captured
}


void draw() {

  // if an Arduino is connected via serial (usb), run as usual
  if (serialConnected) {

    // print text and check number box
    textDetails();
    numberBox.checkState();
    numberBox.display();

    // read serial port for a button pressed
    if (serialPort.available() > 0 && captureIt == false) {   // is there a byte waiting to be received?
      int val = serialPort.read();                            // yes? read it
      if (val == keyIn ) {                                    // if it's the one we're looking for
        captureIt = true;                                     // ...do your thing!
      }
    }

    // run capture routine
    if (captureIt) {
      capture();
      captureIt = false;
    }
  }

  // if we couldn't connect to a serial device (the Arduino), try again and let us know
  else {
    try {
      portName = Serial.list()[0];
      serialPort = new Serial(this, portName, 9600);
      serialConnected = true;
    }
    catch (Exception e) {
      noSerialText();        // if it doesn't work again, show a text saying so
    }
  }
}

// minify on open: www.javacoffeebreak.com/faq/faq0055.html
public void init() {
  if (minify) {
    frame.setState(Frame.ICONIFIED);
  }
  super.init();
}

// keypress > number change
void keyPressed() {
  if (numberBox.active) {
    numberBox.changeValue(key);
  }
}

// end serial communication on exit
public void dispose() {
  serialPort.clear();
  serialPort.stop();
}
