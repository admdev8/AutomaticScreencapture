
// this code should be uploaded to the Arduino board - schematic below

/*
 AUTOMATIC SCREEN-CAPTURE BUTTON
 Jeff Thompson
 
 Simple touch sensor for capturing screenshots in VLC - uses the CapSense
 library (www.arduino.cc/playground/Main/CapSense).
 
 Created for a project commissioned by Rhizome.org (thanks!)
 
 SCHEMATIC:
                 |----------------------------------------------------
 D10  --- 1k ----|---
                 |      both ends attached under/soldered to a piece of copper tape
 D11  --- 10M ---|---
                 |----------------------------------------------------
 
 For further details, see the build-log.
 
 www.jeffreythompson.org
 */

/*
 #include <CapSense.h>
 
 int threshold = 300;             // value at which the button is considered pressed/on
 int interval = 200;              // number of reading the CapSense averages
 boolean buttonState = false;     // on/off button state
 boolean prevState = false;       // previous (for sensing edge)
 int ledPin = 13;                 // led connected from pin 13 to ground (or internal led)
 
 CapSense cs = CapSense(11,10);   // 1k protection resistor on pin 11, 10M sensing resistor on pin 10
 
 void setup() {
   pinMode(ledPin, OUTPUT);       // set led pin to output
   Serial.begin(9600);            // start serial communication
 }
 
 void loop() {
 
   // read touch sensor
   long val =  cs.capSense(interval);
   
   // if above the threshold, set as on; if not, set as off
   if (val >= threshold) {
     buttonState = true;
   }
   else {
     buttonState = false;
   }
   
   // set led high or low if the state of the button has changed
   // we don't just do this every time, as it would cause flickering
   if (buttonState != prevState) {        // if different....
     if (buttonState == true) {           // and true...
       digitalWrite(ledPin, HIGH);        // set high/on
       Serial.print(1);                   // and send a 1 over USB
     }
     else {                               // ditto low
       digitalWrite(ledPin, LOW);
     }      
     prevState = buttonState;
   }
   
   // a short delay to prevent overload (especially for
   // sending data via serial connection)
   delay(10);
 }
 
*/
