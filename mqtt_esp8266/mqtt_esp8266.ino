#include <ESP8266WiFi.h>
#include <PubSubClient.h>

// Update these with values suitable for your network.

const char* ssid = ":/";
const char* password = "cvlb00513";
const char* mqtt_server = "192.168.199.143";

WiFiClient espClient;
PubSubClient client(espClient);
unsigned long lastMsg = 0;
#define MSG_BUFFER_SIZE	(50)
char msg[MSG_BUFFER_SIZE];
int value = 0;
const int led = 2;
const int ledPin = 13;
const int ledX = D1;

void setup_wifi() {

  delay(10);
  // We start by connecting to a WiFi network
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  randomSeed(micros());

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void callback(char* topic, byte* payload, unsigned int length) {
  Serial.print("Message arrived [");
  Serial.print(topic);
  Serial.print("] ");
  for (int i = 0; i < length; i++) {
    Serial.print((char)payload[i]);
  }
  Serial.println();

  // Switch on the LED if an 1 was received as first character
  if ((char)payload[0] == '1') {
    digitalWrite(BUILTIN_LED, LOW);
    digitalWrite(led, LOW);
    digitalWrite(ledPin, LOW);
    digitalWrite(ledX, LOW);
  } else {
    digitalWrite(BUILTIN_LED, HIGH);
    digitalWrite(ledPin, HIGH);
    digitalWrite(led, HIGH);  
    digitalWrite(ledX, HIGH);
  }

}

void reconnect() {
  // Loop until we're reconnected
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Create a random client ID
    String clientId = "ESP8266Client-";
    clientId += String(random(0xffff), HEX);
    // Attempt to connect
    if (client.connect(clientId.c_str())) {
      
      Serial.println("connected");

      // Once connected, publish an announcement...
      client.publish("device/temp", "MQTT Server Connnected ---");
      
      // ... and resubscribe
      client.subscribe("device/led");
    
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Wait 5 seconds before retrying
      delay(5000);
    }
  }
}

void setup() {
  pinMode(BUILTIN_LED, OUTPUT);
  pinMode(led, OUTPUT);
  pinMode(ledPin, OUTPUT);
  pinMode(ledX, OUTPUT);
  Serial.begin(115200);
  setup_wifi();
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
}

void loop() {

  if (!client.connected()) {
    reconnect();
  }
  client.loop();

  unsigned long now = millis();
  if (now - lastMsg > 2000) {
    lastMsg = now;
    // ++value;
    value = analogRead(A0) * 0.32; 
    snprintf (msg, MSG_BUFFER_SIZE, "Temp is ----> #%ld", value);
    Serial.print("Publish message: ");
    Serial.println(msg);
    client.publish("device/temp", msg);
  }
}
