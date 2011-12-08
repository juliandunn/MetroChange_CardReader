void read_track1()
{

  String str = "";
  uint8_t clck = 1;
  uint8_t data_ = 1;
  uint8_t crd = 1;

  while (crd){
    crd = digitalRead(card);
    data_ = digitalRead(data);

  }

  uint8_t zeros = 0;
  uint8_t parityok = 0;

  for (uint8_t t1 = 0; t1 < 210; t1++) {
    track1[t1] = 0;
    for (uint8_t b=0; b < 7; b++) {

      while (digitalRead(clock) && ! digitalRead(card));
      // we sample on the falling edge!
      uint8_t x = digitalRead(data);
      if (!x) {
        // data is LSB and inverted!
        track1[t1] |= _BV(b);
      } 

      while (!digitalRead(clock) && !digitalRead(card));

    }
    if (!digitalRead(card)){

    }

  }

}


boolean check_sentinel(int* x, int* y){
  int n;
  for (n=0;n<5;n++) {
    if (x[n]!=y[n]) 
      return false;
  }
  return true;
}




int money_in_cents(int* money, int* track_reading){

  int money_index = 0;
  for (int i = 61; i<77; i++){
    money[money_index] = track_reading[i];
    money_index++;
  }
 // Serial.println("BINARY DOLLARS WHOA!::");
  for (int i = 0; i<16; i++){

//   Serial.print(money[i]);
  }  
 //   Serial.println("");

  int buffer_val2 = 0;    
  for (int i = 0; i<16; i++){
    int buffer_val = 0;
    buffer_val=money[i]*byte_conv[i];
    buffer_val2 = buffer_val2+buffer_val;

  }
  return buffer_val2;
}




void second_string() 
{
  
    char second_sentinel[6];
//  Serial.println("Here is the SECOND binary");
  for (int i = 118; i<300; i++){
    if (onezero[i]==0){
      second_read[i-118]='0';
    }
    else{
      second_read[i-118]='1';
    }
  }
  second_read[300-118]='\0';
//  Serial.print(second_read);
//  Serial.println("");
  for (int i = 0; i<5; i++){
    if (sentinel[i]==0){
      second_sentinel[i]='0';
    }
    else{
      second_sentinel[i]='1';
    }
  }
  second_sentinel[5]='\0';
  char* whoa = strstr(second_read, second_sentinel);
//  Serial.println("THIS IS SECONDREADING!");
  for (int i = 0; i<183; i++){
    if (whoa[i] == '0'){
      second_read_int[i] = 0;
    }
    else{
      second_read_int[i] = 1;
    }
//    Serial.print(second_read_int[i]);
  }
//  Serial.println("END OF SECONDDREADING");
  
 }
  
  
  
//TIMES USED: 
  
int times_used(int* time, int* track_reading){  
  int times_index = 0;
  for (int i = 29; i<35; i++){
    time[times_index] = track_reading[i];
    times_index++;
  }  
//      Serial.println("");
//   Serial.println("TIMES READ BINARY WHOA!::");
//  for (int i = 0; i<6; i++){

//        Serial.print(time[i]);
//  }  
//    Serial.println("");    
  int buffer_val2 = 0;
  int t = 0;  
  for (int i = 11;  i<16; i++){
    int buffer_val = 0;
    buffer_val=time[t]*byte_conv[i];
    buffer_val2 = buffer_val2+buffer_val;
    t++;
  }
  return buffer_val2;
}
  
  

