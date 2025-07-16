/*  ESP32 – Combined sketch (fixed)
    ----------------------------------------------
    • Interrupt‑driven vibration → 1 s buzzer
    • Relay voltage monitor      → loss‑of‑voltage LED
    • BMI160 tilt alarm          → tilt LED
    ----------------------------------------------

    ── Pin map ───────────────────────────────────
      Vibration sensor OUT      → GPIO13 (input, LOW pulse)
      Buzzer (+)                → GPIO12 (output, active‑HIGH)

      Relay monitor OUT         → GPIO25 (input)          // HIGH = fence OK
      Voltage‑loss LED (+)      → GPIO33 (output, HIGH = LED on)

      BMI160                    → I²C  SDA 21, SCL 22, addr 0x68
      Tilt‑alarm LED (+)        → GPIO2  (output, active‑HIGH)
    ───────────────────────────────────────────────
*/

#include <Wire.h>
#include <DFRobot_BMI160.h>
#include <math.h>

/* ───── Pin definitions ───────────────────────── */
constexpr uint8_t VIB_PIN        = 13;   // vibration sensor (LOW pulse)
constexpr uint8_t BUZZER_PIN     = 12;   // buzzer ⚠️ strapping pin
constexpr uint8_t RELAY_IN_PIN   = 25;   // relay monitor
constexpr uint8_t VOLT_LED_PIN   = 33;   // voltage‑loss LED
constexpr uint8_t TILT_LED_PIN   = 2;    // tilt alarm LED
constexpr uint8_t SDA_PIN        = 21;   // I²C
constexpr uint8_t SCL_PIN        = 22;

/* ───── Vibration / buzzer state ──────────────── */
volatile bool  vibrFlag        = false;  // set by ISR
bool           buzzerActive    = false;
unsigned long  buzzerUntilMs   = 0;

/* ───── BMI160 setup ──────────────────────────── */
DFRobot_BMI160 bmi160;
const int8_t   I2C_ADDR        = 0x68;

struct Vec3 { float x, y, z; };
Vec3 gRef     = {0,0,0};
bool refOK    = false;

const unsigned long CAL_TIME_MS   = 2000; // 2 s upright hold
const float         TILT_LIMIT_DEG = 30.0;

/* ───── Helper maths ─────────────────────────── */
float dot(const Vec3& a, const Vec3& b) { return a.x*b.x + a.y*b.y + a.z*b.z; }
float mag(const Vec3& v)               { return sqrtf(dot(v,v)); }

Vec3 readAccel()                       // 1 g ≈ 16 384 LSB
{
  int16_t raw[6];
  bmi160.getAccelGyroData(raw);        // Ax Ay Az Gx Gy Gz
  return { raw[3] / 16384.0f,
           raw[4] / 16384.0f,
           raw[5] / 16384.0f };
}

/* ───── Vibration ISR ─────────────────────────── */
void IRAM_ATTR onVibration()           // fires on each LOW pulse
{
  vibrFlag = true;
}

/* ───── Arduino setup ─────────────────────────── */
void setup()
{
  Serial.begin(115200);

  pinMode(BUZZER_PIN,   OUTPUT);
  pinMode(VIB_PIN,      INPUT_PULLUP);           // open‑collector → pull‑up
  pinMode(RELAY_IN_PIN, INPUT);                  // INPUT_PULLUP if needed
  pinMode(VOLT_LED_PIN, OUTPUT);
  pinMode(TILT_LED_PIN, OUTPUT);

  digitalWrite(VOLT_LED_PIN, LOW);
  digitalWrite(TILT_LED_PIN, LOW);

  /* Startup beep pattern (4 × ½ s) */
  for (uint8_t i = 0; i < 4; ++i) {
    digitalWrite(BUZZER_PIN, HIGH); delay(500);
    digitalWrite(BUZZER_PIN, LOW ); delay(500);
  }

  /* Attach vibration interrupt (LOW‑going pulse) */
  attachInterrupt(digitalPinToInterrupt(VIB_PIN),
                  onVibration, FALLING);

  /* I²C + BMI160 */
  Wire.begin(SDA_PIN, SCL_PIN);
  if (bmi160.softReset()    != BMI160_OK) { Serial.println("BMI160 reset failed"); while (1); }
  if (bmi160.I2cInit(I2C_ADDR) != BMI160_OK) { Serial.println("BMI160 init failed");  while (1); }

  Serial.println("Keep the stick perfectly vertical for 2 s…");
}

/* ───── Main loop ─────────────────────────────── */
void loop()
{
  unsigned long now = millis();

  /* ---------- Handle vibration events ---------- */
  if (vibrFlag && !buzzerActive) {         // new vibration detected
    vibrFlag      = false;                 // clear flag
    buzzerActive  = true;
    buzzerUntilMs = now + 1000;            // 1 s beep
    digitalWrite(BUZZER_PIN, HIGH);
  }
  if (buzzerActive && now >= buzzerUntilMs) {
    buzzerActive = false;
    digitalWrite(BUZZER_PIN, LOW);
  }

  /* ---------- Relay / voltage check ---------- */
  bool relayOK = digitalRead(RELAY_IN_PIN);        // HIGH = fence energized
  digitalWrite(VOLT_LED_PIN, relayOK ? LOW : HIGH);

  /* ---------- BMI160 tilt alarm ---------- */
  static unsigned long t0 = now;

  if (!refOK) {                                    // calibration phase
    static Vec3 sum = {0,0,0};
    static uint16_t n = 0;

    Vec3 g = readAccel();
    sum.x += g.x;  sum.y += g.y;  sum.z += g.z;  ++n;

    if (now - t0 >= CAL_TIME_MS) {                 // lock reference
      gRef.x = sum.x / n;  gRef.y = sum.y / n;  gRef.z = sum.z / n;
      refOK = true;
      Serial.println("Reference locked");
      digitalWrite(TILT_LED_PIN, HIGH); delay(150); digitalWrite(TILT_LED_PIN, LOW);
    }
  }
  else {                                           // normal operation
    Vec3 g = readAccel();
    float cosTh = dot(g, gRef) / (mag(g) * mag(gRef));
    cosTh = constrain(cosTh, -1.0f, 1.0f);
    float angleDeg = acosf(cosTh) * 180.0f / PI;

    bool tiltAlarm = angleDeg > TILT_LIMIT_DEG;
    digitalWrite(TILT_LED_PIN, tiltAlarm ? HIGH : LOW);

    /* Optional debug output */
    Serial.print("Tilt: "); Serial.print(angleDeg, 1);
    Serial.print(" °   LED: "); Serial.println(tiltAlarm ? "ON" : "OFF");
  }

  /* ---------- loop pacing ---------- */
  delay(1);            // 1 kHz loop → won’t miss quick events
}
