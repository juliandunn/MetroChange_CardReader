#define data 5
#define clock 6
#define card 7

#define power  3
#define ground  4

uint8_t track1[210];

int cents = 0;

int onezero[300];
int second_read_int[300];
char second_read[183];
int sentinel[] = {1,0,1,1,1};

int check[5];
int money1[16];
int money2[16];

int times[6];
int times0[6];

int byte_conv[]= {
  32768,16384,8192,4096,2048,1024,512,256,128,64,32,16,8,4,2,1};


void setup()
{
  pinMode(power, OUTPUT);
  pinMode(ground, OUTPUT);
  digitalWrite(3, HIGH);
  digitalWrite(4, LOW);

  Serial.begin(115200); // USB is always 12 Mbit/sec

}

void loop()
{
  read_track1();
  Serial.println("Swiped!");
  Serial.println("");

  uint8_t bit_check = 0;

  int f = 0;
  for (uint8_t i = 0; i < 41; i++) {

    for (uint8_t j = 0; j < 7; j++) {
      if (track1[i] & _BV(j)) {

        onezero[f] = 1;
        f++;

      } 
      else {
        onezero[f] = 0;
        f++;
      }

    }
  }

second_string();

  check[0] = onezero[0];
  check[1] = onezero[1];
  check[2] = onezero[2];
  check[3] = onezero[3];
  check[4] = onezero[4];

  Serial.println("");

  if (check_sentinel(check, sentinel) == true){
    int cents = money_in_cents(money1, onezero);
    int cents2 = money_in_cents(money2, second_read_int);
    
    if (cents != cents2) {
      int times1 = times_used(times, onezero);
      int times2 = money_in_cents(times0, second_read_int);    
     
      if (times1<times2){
      cents = cents2;
      } 
    }
        
    Serial.print("With evil laugh MTA is about to take ");
    Serial.print(cents);
    Serial.print(" cents from you!");
    Serial.println("");
    Serial.println("We know it is more complicated than that, but why not donate now and save some starving blind chldern?"); 
    Serial.println("");
  }
  else{
    Serial.println("SWIPE AGAIN, NOT TOO FAST!");
  }
}



