const uint8_t relayInputPin = 25;   
const uint8_t ledPin        = 33;   

void setup() {
  pinMode(relayInputPin, INPUT);     
  pinMode(ledPin, OUTPUT);

  digitalWrite(ledPin, LOW);         
}

void loop() {
  int relayState = digitalRead(relayInputPin);

  if (relayState == HIGH) {          // relay active
    digitalWrite(ledPin, LOW);       // LED off
  } else {                           // relay inactive
    digitalWrite(ledPin, HIGH);      // LED on
  }
}