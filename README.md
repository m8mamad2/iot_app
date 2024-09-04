
# IoT LED Control Application using Flutter, ESP8266 and MQTT 

## Overview
This project is an IoT solution that allows you to control an LED connected to an ESP8266 board using a Flutter mobile application. The communication between the app and the ESP8266 is facilitated by MQTT (Message Queuing Telemetry Transport), using the mqtt_client package in Flutter and the Mosquitto broker running on a Linux machine. The ESP8266 subscribes to MQTT topics and toggles the LED's state based on the messages it receives.



## Features

- **MQTT Communication:** Utilizes MQTT protocol for lightweight and efficient message exchange between the mobile app and ESP8266.
- **LED Control:** Allows users to turn an LED on and off remotely using a mobile application.



## Components

- **Flutter App:** get MQTT Connection to Broker & Provides a UI to control the LED by sending MQTT messages to the broker.
- **ESP8266 Board:** Receives MQTT messages and turns the LED on or off based on the message.
- **Mosquitto Broker:** An MQTT broker running on a Linux machine (mosquitto_pub is used for publishing).


## Hardware Requirements

- ESP8266 Board (e.g., NodeMCU)
- LED and appropriate resistors
- Breadboard and jumper wires
- Power source (USB or external power supply)

## Circuit Diagram
## Installation

#### 1 - Setup Mosquitto Broker (Linux):

Install Mosquitto:
```bash
    sudo apt update
    sudo apt install mosquitto mosquitto-clients
```
Run Mosquitto:
```bash
    sudo systemctl start mosquitto
    sudo systemctl enable mosquitto	
```
Publish a test message:
```bash
    First Terminal : mosquitto_pub -h localhost -t "test/topic" -m "Hello MQTT"
    Second Terminal : mosquitto_sub -h localhost -t "test/topic"
``` 

#### 2. Setup the ESP8266 (Arduino IDE)

Install the ```ESP8266 Board Package``` in the Arduino IDE.

Install the necessary libraries in the Arduino IDE ```PubSubClient``` &```ESP8266WiFi```

Upload the provided ESP8266 code to your board.

#### 3 - Setup the Flutter App:

Clone the Flutter project::
```bash
    git clone https://github.com/m8mamad2/iot_app.git
```
Navigate to the project directory:
```bash
    cd iot_flutter
```
Install dependencies::
```bash
    flutter pub get
``` 
Change ip in ```iot_flutter/lib/service/mqtt_connection_service.dart```:
```bash
  final client = MqttServerClient(<ip>, '');
```
Run the app: 
```bash
    flutter run
``` 
## How It Works

- **Background Service:** The Flutter app runs a background service that maintains a connection with the server using Socket.IO. This connection is crucial for receiving incoming call notifications in real-time.

- **Incoming Call Notification:** When the server detects an incoming call for the user, it sends a notification through Socket.IO. The app receives this notification and displays it to the user, allowing them to accept or decline the call.

- **WebRTC Connection:** If the user accepts the call, the app initiates a WebRTC connection, facilitating a direct peer-to-peer communication channel for high-quality audio and video transmission.
