int vib = 8;
int led = 9;

void setup()
{

pinMode(led, OUTPUT);
pinMode(vib, INPUT);

digitalWrite(led, HIGH);
delay(500);
digitalWrite(led, LOW);
delay(500);
digitalWrite(led, HIGH);
delay(500);
digitalWrite(led, LOW);
delay(500);


}

void loop()
{

if(digitalRead(vib)==LOW )
{
  digitalWrite(led, HIGH);
  delay(1000);

}

else
{
  digitalWrite(led,LOW);
}

}