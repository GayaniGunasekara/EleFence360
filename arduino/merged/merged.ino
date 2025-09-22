#include <WiFi.h>
#include <Firebase_ESP_Client.h>
#include <Wire.h>
#include <DFRobot_BMI160.h>
#include <math.h>

// Firebase Addons
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

// WiFi Credentials
#define WIFI_SSID "Gayani"
#define WIFI_PASSWORD "gayani123@"

// Firebase Credentials
#define API_KEY "AIzaSyDQkYnYMYAwNCLs3_aBdhPpu4zAYol9fyQ"
#define DATABASE_URL "https://eleguardian-772d5-default-rtdb.firebaseio.com/"

// Firebase objects
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;

// Pins
constexpr uint8_t VIB_PIN      = 13;
constexpr uint8_t BUZZER_PIN   = 12;
constexpr uint8_t RELAY_IN_PIN = 25;
constexpr uint8_t VOLT_LED_PIN = 33;
constexpr uint8_t TILT_LED_PIN = 2;
constexpr uint8_t SDA_PIN      = 21;
constexpr uint8_t SCL_PIN      = 22;

// Vibration
volatile bool vibrFlag = false;
bool buzzerActive = false;
unsigned long buzzerUntilMs = 0;

// BMI160
DFRobot_BMI160 bmi160;
const int8_t I2C_ADDR = 0x68;
struct Vec3 { float x, y, z; };
Vec3 gRef = {0, 0, 0};
bool refOK = false;

// Tilt settings
const unsigned long CAL_TIME_MS = 2000;
const float TILT_LIMIT_DEG = 30.0;

// Math helpers
float dot(const Vec3& a, const Vec3& b) { return a.x*b.x + a.y*b.y + a.z*b.z; }
float mag(const Vec3& v) { return sqrtf(dot(v, v)); }

Vec3 readAccel() {
  int16_t raw[6];
  bmi160.getAccelGyroData(raw);
  return { raw[3] / 16384.0f, raw[4] / 16384.0f, raw[5] / 16384.0f };
}

// Vibration interrupt
void IRAM_ATTR onVibration() {
  vibrFlag = true;
}

void setup() {
  Serial.begin(115200);

  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(VIB_PIN, INPUT_PULLUP);
  pinMode(RELAY_IN_PIN, INPUT);
  pinMode(VOLT_LED_PIN, OUTPUT);
  pinMode(TILT_LED_PIN, OUTPUT);
  digitalWrite(VOLT_LED_PIN, LOW);
  digitalWrite(TILT_LED_PIN, LOW);

  // Startup buzz
  for (uint8_t i = 0; i < 4; ++i) {
    digitalWrite(BUZZER_PIN, HIGH); delay(300);
    digitalWrite(BUZZER_PIN, LOW); delay(300);
  }

  attachInterrupt(digitalPinToInterrupt(VIB_PIN), onVibration, FALLING);

  Wire.begin(SDA_PIN, SCL_PIN);
  if (bmi160.softReset() != BMI160_OK) { Serial.println("BMI160 reset failed"); while (1); }
  if (bmi160.I2cInit(I2C_ADDR) != BMI160_OK) { Serial.println("BMI160 init failed"); while (1); }

  Serial.println("Keep the stick perfectly vertical for 2 s…");

  // Wi-Fi
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi connected");

  // Firebase config
  config.api_key = API_KEY;
  config.database_url = DATABASE_URL;
  config.token_status_callback = tokenStatusCallback;

  auth.user.email = "";
  auth.user.password = "";

  if (Firebase.signUp(&config, &auth, "", "")) {
    Serial.println("Anonymous sign-up successful.");
  } else {
    Serial.printf("Sign-up failed: %s\n", config.signer.signupError.message.c_str());
  }

  Firebase.begin(&config, &auth);
  Firebase.reconnectWiFi(true);
}

void loop() {
  unsigned long now = millis();

  // Vibration handling
  static bool lastVibration = false;
  bool currentVibration = false;

  if (vibrFlag && !buzzerActive) {
    vibrFlag = false;
    buzzerActive = true;
    buzzerUntilMs = now + 1000;
    digitalWrite(BUZZER_PIN, HIGH);
    currentVibration = true;
  }
  if (buzzerActive && now >= buzzerUntilMs) {
    buzzerActive = false;
    digitalWrite(BUZZER_PIN, LOW);
  }

  if (currentVibration != lastVibration && Firebase.ready()) {
    if (Firebase.RTDB.setBool(&fbdo, "/sensors/vibration", currentVibration)) {
      Serial.println("Firebase: vibration updated");
    } else {
      Serial.println(fbdo.errorReason());
    }
    lastVibration = currentVibration;
  }

  // Voltage monitor
  static bool lastVoltage = true;
  bool powerOK = digitalRead(RELAY_IN_PIN); // HIGH = voltage OK
  digitalWrite(VOLT_LED_PIN, powerOK ? LOW : HIGH);
  if (powerOK != lastVoltage && Firebase.ready()) {
    if (Firebase.RTDB.setBool(&fbdo, "/sensors/voltage", powerOK)) {
      Serial.println("Firebase: voltage updated");
    } else {
      Serial.println(fbdo.errorReason());
    }
    lastVoltage = powerOK;
  }

  // Tilt sensor
  static unsigned long t0 = now;
  static float lastTilt = -999.0;

  if (!refOK) {
    static Vec3 sum = {0, 0, 0};
    static uint16_t n = 0;
    Vec3 g = readAccel();
    sum.x += g.x; sum.y += g.y; sum.z += g.z; ++n;

    if (now - t0 >= CAL_TIME_MS) {
      gRef.x = sum.x / n; gRef.y = sum.y / n; gRef.z = sum.z / n;
      refOK = true;
      Serial.println("Reference locked");
      digitalWrite(TILT_LED_PIN, HIGH); delay(150); digitalWrite(TILT_LED_PIN, LOW);
    }
  } else {
    Vec3 g = readAccel();
    float cosTh = dot(g, gRef) / (mag(g) * mag(gRef));
    cosTh = constrain(cosTh, -1.0f, 1.0f);
    float angleDeg = acosf(cosTh) * 180.0f / PI;
    bool tiltAlarm = angleDeg > TILT_LIMIT_DEG;
    digitalWrite(TILT_LED_PIN, tiltAlarm ? HIGH : LOW);

    if (abs(angleDeg - lastTilt) > 2.0 && Firebase.ready()) {
      if (Firebase.RTDB.setFloat(&fbdo, "/sensors/tilt", angleDeg)) {
        Serial.printf("Firebase: tilt = %.1f°\n", angleDeg);
      } else {
        Serial.println(fbdo.errorReason());
      }
      lastTilt = angleDeg;
    }
  }

  delay(100);
}
