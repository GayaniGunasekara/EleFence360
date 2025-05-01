// Pin configuration
const int relayInputPin = 4; // Relay input connected to pin 4
const int ledPin = 2;        // Output signal positive pin connected to pin 2

void setup() {
  // Configure pin modes
  pinMode(relayInputPin, INPUT); // Relay output as input to the Arduino
  pinMode(ledPin, OUTPUT);       // LED as output

  // Ensure the LED is off initially
  digitalWrite(ledPin, LOW);
}

void loop() {
  // Read the relay state 
  int relayState = digitalRead(relayInputPin);

  // If the relay is active 
  if (relayState == HIGH) {
    digitalWrite(ledPin, LOW);
  } 
  // If the relay is inactive 
  else {
    digitalWrite(ledPin, HIGH);
  }
}