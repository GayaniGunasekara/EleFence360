#include <DFRobot_BMI160.h>
#include <Wire.h>
#include <math.h>

DFRobot_BMI160 bmi160;
const int8_t i2c_addr = 0x69;

// Buzzer pin
const int buzzerPin = 6;

// Orientation variables
float ax, ay, az;
float gx, gy, gz;
float pitch = 0, roll = 0, yaw = 0;
unsigned long lastTime;
float dt;

// Complementary filter coefficient
const float alpha = 0.98;
const float tiltThreshold = 30.0;  // Degrees

void setup() {
  Serial.begin(115200);
  delay(100);

  pinMode(buzzerPin, OUTPUT);
  digitalWrite(buzzerPin, LOW);

  // Reset and initialize BMI160
  if (bmi160.softReset() != BMI160_OK) {
    Serial.println("BMI160 Reset failed!");
    while (1);
  }

  if (bmi160.I2cInit(i2c_addr) != BMI160_OK) {
    Serial.println("BMI160 Init failed!");
    while (1);
  }

  lastTime = millis();
}

void loop() {
  unsigned long currentTime = millis();
  dt = (currentTime - lastTime) / 1000.0;
  lastTime = currentTime;

  int16_t data[6] = {0};  // [gyroX, gyroY, gyroZ, accelX, accelY, accelZ]

  if (bmi160.getAccelGyroData(data) == 0) {
    // Convert raw data
    ax = data[3] / 16384.0;
    ay = data[4] / 16384.0;
    az = data[5] / 16384.0;

    gx = data[0] / 131.0;
    gy = data[1] / 131.0;
    gz = data[2] / 131.0;

    // Calculate accelerometer-based angles
    float accelPitch = atan2(ay, az) * 180.0 / PI;
    float accelRoll  = atan2(-ax, sqrt(ay * ay + az * az)) * 180.0 / PI;

    // Integrate gyro to estimate angles
    pitch += gx * dt;
    roll  += gy * dt;
    yaw   += gz * dt;

    // Complementary filter
    pitch = alpha * pitch + (1 - alpha) * accelPitch;
    roll  = alpha * roll + (1 - alpha) * accelRoll;

    // Print for debugging
    Serial.print("Pitch: "); Serial.print(pitch);
    Serial.print("  Roll: "); Serial.print(roll);
    Serial.print("  Yaw: "); Serial.println(yaw);

    // Buzzer logic
    if (abs(pitch) > tiltThreshold || abs(roll) > tiltThreshold) {
      digitalWrite(buzzerPin, HIGH);
      Serial.println("!!! ALERT: Fence Tilt Detected !!!");
    } else {
      digitalWrite(buzzerPin, LOW);
    }

  } else {
    Serial.println("Sensor read error");
  }

  delay(10);  // loop at 100 Hz
}
