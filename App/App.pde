import java.util.Calendar;

Calendar cal;
int month;
int startDay;
int dayYCoords, dayXCoords;

void setup() {
  cal = new GregorianCalendar();
  month = cal.MONTH;
  dayYCoords = 0;
  dayXCoords = 0;
  size(960, 600);
  startDay = findFirstDay(month);
  //months with 31 days
  if(month % 2 == 0){
    int date = startDay;
    int count = 0;
    //previous month
    for(int n = 0; n < startDay; n++){
      drawDay(dayXCoords, dayYCoords, 31 - n);
      dayXCoords += 137;
      count++;
      if(count % 7 == 0){
        dayYCoords += 80;
      }
    }
    //this month
    for(int i = 1; i <= 31; i++){
      drawDay(dayXCoords, dayYCoords, i);
      dayXCoords += 137;
      count++;
      if(count % 7 == 0){
        dayYCoords += 80;
      }
    }
    //next month
    int daysLeft = 42 - (31 + startDay);
    for(int p = 0; p <= daysLeft; p++){
      drawDay(dayXCoords, dayYCoords, p);
      dayXCoords += 137;
      count++;
      if(count % 7 == 0){
        dayYCoords += 80;
      }
    }
    //don't forget to account for leap year !
  }else if(month == 1) {}
}

int findFirstDay(int m) {
  int[] monthKeyVals = {1, 4, 4, 0, 2, 5, 0, 3, 6, 1, 4, 6};
  int d = (((cal.YEAR % 100) / 4) + 1 + monthKeyVals[month] + 6 + (cal.YEAR % 100)) % 7;  
  if(cal.YEAR % 400 == 0){
    d = d - 1;
  }
  return d;
}

void drawDay(int x, int y, int z) {}