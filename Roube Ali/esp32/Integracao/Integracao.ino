
#include <WiFi.h>

#define ledred 22
#define ledgreen 23
#define Ypin 32
#define Xpin 35

int x_value;
int y_value;
int flag = 0;

const char* ssid = "Andar_superior";
const char* password =  "BragaDias852456";

WiFiServer wifiServer(80);

void setup() {

  Serial.begin(9600);
  pinMode(ledgreen, OUTPUT);
  pinMode(ledred, OUTPUT);
  delay(1000);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting..");
  }

  Serial.print("Connected to WiFi. IP:");
  Serial.println(WiFi.localIP());

  wifiServer.begin();
}

void loop() { // O que faz enquanto ainda não está conectado

  WiFiClient client = wifiServer.available();

  if (client) {

    while (client.connected()) { // O que vai fazer enquanto está conectado, porém não recebeu mensagem
     
        x_value = analogRead(Xpin);
        y_value = analogRead(Ypin);
//  Serial.println("Valor de x: " + String(x_value));
//  Serial.println("Valor de y: " + String(y_value));

        if (x_value > 2500 && flag == 0) {
          client.print("Mover: 1 0\n");
//          Serial.println("Mover: 1 0\n");
          flag = 1;
        }
        if (x_value < 1000 && flag == 0) {
          client.print("Mover: -1 0\n");
//          Serial.println("Mover: -1 0\n");
          flag = 1;
        }
        if (y_value > 2000 && flag == 0) {
          client.print("Mover: 0 -1\n");
//          Serial.println("Mover: 0 -1\n");
          flag = 1;
        }
        if (y_value < 1000 && flag == 0) {
         client.print("Mover: 0 1\n");
//          Serial.println("Mover: 0 1\n");
          flag = 1;
        }
        if (x_value < 2000 && x_value > 1400 && y_value < 2000 && y_value > 1400 && flag == 1) {
          client.print("Mover: 0 0\n");
//          Serial.println("Mover: 0 0\n");
          flag = 0;
        }
  
      while (client.available() > 0) { // O que vai fazer enquanto está conectado e receber alguma mensagem

        String c = client.readStringUntil('\n');
        if (c == "Morreu") {
          digitalWrite(ledred, HIGH);
          delay(500);
          Serial.println("Morreu");
          digitalWrite(ledred, LOW);
        }
        if (c == "Olhando") {
          digitalWrite(ledred, HIGH);
          digitalWrite(ledgreen, LOW);
          Serial.println("Olhando");
        }
        if (c == "Ok") {
          digitalWrite(ledgreen, HIGH);
          digitalWrite(ledred, LOW);
          Serial.println("Ok");
        }
        if ( c == "Desligar") {
          digitalWrite(ledgreen, LOW);
          digitalWrite(ledred, LOW);
          Serial.println("Desligou");
        }
      }

      delay(10);
    }

    client.stop();
    Serial.println("Client disconnected");

   }
 }
