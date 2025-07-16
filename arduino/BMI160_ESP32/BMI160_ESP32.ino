/*
  ESP32 ▸ BMI160 ▸ Vertical‑stick tilt alarm
  -----------------------------------------
  Wiring
    BMI160      ESP32
    3V3      →  3V3
    GND      →  GND
    SDA      →  GPIO 21
    SCL      →  GPIO 22
    SA0-GND  →  I²C addr 0x68

    LED +    →  GPIO 2   (active‑HIGH)
*/

#include <DFRobot_BMI160.h>
#include <Wire.h>
#include <math.h>

/* Pins */
#define SDA_PIN   21
#define SCL_PIN   22
#define LED_PIN    2      // active‑HIGH LED

/* IMU */
DFRobot_BMI160 bmi160;
const int8_t I2C_ADDR = 0x68;

/* Behaviour */
const unsigned long CAL_TIME_MS = 2000; // ms to hold the stick upright
const float         TILT_LIMIT_DEG = 30.0; // alarm threshold

/* Vectors */
struct Vec3 { float x, y, z; };
Vec3 gRef   = {0,0,0};   // reference gravity vector
bool refOK  = false;     // set true after calibration

/* ─── Helper maths ─────────────────────────────────────────── */
float dot(const Vec3& a, const Vec3& b)
{ return a.x*b.x + a.y*b.y + a.z*b.z; }

float mag(const Vec3& v)
{ return sqrtf(v.x*v.x + v.y*v.y + v.z*v.z); }

Vec3 readAccel()                      // 1 g ≈ 16384 LSB
{
  int16_t raw[6];
  bmi160.getAccelGyroData(raw);
  return { raw[3] / 16384.0f,
           raw[4] / 16384.0f,
           raw[5] / 16384.0f };
}

/* ─── Arduino setup ────────────────────────────────────────── */
void setup()
{
  Serial.begin(115200);
  Wire.begin(SDA_PIN, SCL_PIN);

  pinMode(LED_PIN, OUTPUT);           // active‑HIGH
  digitalWrite(LED_PIN, LOW);

  if (bmi160.softReset()   != BMI160_OK) { Serial.println("BMI160 reset failed"); while (1); }
  if (bmi160.I2cInit(I2C_ADDR)!= BMI160_OK) { Serial.println("BMI160 init failed");  while (1); }

  Serial.println("Keep the stick perfectly vertical for 2 s…");
}

/* ─── Main loop ────────────────────────────────────────────── */
void loop()
{
  static unsigned long t0 = millis();

  /* -------- Calibration phase -------- */
  if (!refOK)
  {
    static Vec3 sum = {0,0,0};
    static uint16_t n = 0;

    Vec3 g = readAccel();
    sum.x += g.x;  sum.y += g.y;  sum.z += g.z;  ++n;

    if (millis() - t0 >= CAL_TIME_MS)
    {
      gRef.x = sum.x / n;
      gRef.y = sum.y / n;
      gRef.z = sum.z / n;
      refOK  = true;

      Serial.println("Reference locked");
      digitalWrite(LED_PIN, HIGH); delay(150); digitalWrite(LED_PIN, LOW);
    }
    delay(10);
    return;                      // wait for calibration to finish
  }

  /* -------- Normal operation -------- */
  Vec3 g = readAccel();

  float cosTheta = dot(g, gRef) / (mag(g) * mag(gRef));   // [-1,1]
  cosTheta = constrain(cosTheta, -1.0f, 1.0f);            // numerical safety
  float angleDeg = acosf(cosTheta) * 180.0f / PI;

  bool alarm = angleDeg > TILT_LIMIT_DEG;
  digitalWrite(LED_PIN, alarm ? HIGH : LOW);

  /* Debug print */
  Serial.print("Tilt: ");
  Serial.print(angleDeg, 1);
  Serial.print(" °   LED: ");
  Serial.println(alarm ? "ON" : "OFF");

  delay(10);   // ~100 Hz loop
}
