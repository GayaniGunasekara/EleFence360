Version 1.0 of The Automated Elephant Detection and Deterrence System for Enhanced Elephant Fencing

### 📦 Key Features Included:
- 🔐 **User Registration & Login**  
  - User identity is verified using **NIC and mobile number** for uniqueness.
  - Ensures that each user has a traceable and secure login session.

- 📡 **Real-Time Sensor Alerts**  
  - Firebase Realtime Database integration for detecting events from connected sensors.
  - Immediate push-style in-app notifications when vibration, tilt, or voltage events are triggered.

- 📍 **Location Tracking & Mapping**  
  - Google Maps API integration to display event locations.
  - Location information tied to each notification for better context.

- ⏱️ **Smart Notification System**  
  - Notifications appear when a sensor detects an event and remain visible for 1 hour.
  - If the **same location** triggers another event within that hour, the notification's countdown resets.
  - If a **different location** detects an event, a **new notification** is generated

### 🚀 Purpose:
This is the first production-ready release. It sets the foundation for a secure, real-time IoT monitoring system with user access and location-aware, time-sensitive alerting.