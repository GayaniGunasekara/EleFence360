/*  ESP32 – vibration sensor + BUZZER
 *
 *  Connections
 *  ───────────────────────────────
 *   Sensor OUT   →  GPIO13 (D13) – INPUT
 *   Buzzer (+)   →  GPIO12 (D12) – OUTPUT
 *   Buzzer (–)   →  GND
 *
 *  ⚠️ Note on GPIO12
 *  -----------------
 *  GPIO12 is a “strapping pin”; its level at reset selects boot mode.
 *  Keeping it LOW during boot avoids flashing issues.  We therefore
 *  leave it LOW until `setup()` finishes the startup beep sequence.
 */

constexpr uint8_t VIB_PIN     = 13;   // vibration sensor
constexpr uint8_t BUZZER_PIN  = 12;   // buzzer

void setup() {
  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(VIB_PIN, INPUT);            // use INPUT_PULLUP if your sensor is open‑collector

  // Startup beep pattern (4× ½‑second) — matches your original logic
  for (uint8_t i = 0; i < 4; ++i) {
    digitalWrite(BUZZER_PIN, HIGH);
    delay(500);
    digitalWrite(BUZZER_PIN, LOW);
    delay(500);
  }
}

void loop() {
  // If the sensor pulls the line LOW → sound buzzer for 1 s
  if (digitalRead(VIB_PIN) == LOW) {
    digitalWrite(BUZZER_PIN, HIGH);
    delay(1000);
  } else {
    digitalWrite(BUZZER_PIN, LOW);
  }
}
