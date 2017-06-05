import java.util.Calendar;

final int SCREENWIDTH, SCREENHEIGHT;

Calendar cal;

int year, month, day, dayOfWeek;
int dayYCoords, dayXCoords;
EventCollection events;
ArrayList<Day> days;

void setup() {
  
  SCREENWIDTH = 960;
  SCREENHEIGHT = 600;
  cal = new GregorianCalendar();
  year = cal.YEAR;
  month = cal.MONTH;
  day = cal.DATE;
  dayOfWeek = cal.DAY_OF_WEEK;
  dayYCoords = 0;
  dayXCoords = 0;
  size( SCREENWIDTH, SCREENHEIGHT );
  events = new EventCollection();
  if(month % 2 == 0){
    days = events.getEventsInRange(new Date(year, month-1, 30 - dayOfWeek + 1), 
                                   new Date(year, month+1, 42 - (31 + dayOfWeek)));
  }else if(month == 1){
    if(year % 400 == 0){
      days = events.getEventsInRange(new Date(year, month-1, 31 - dayOfWeek + 1)), new Date(year, month+1, 42 - (29 + dayOfWeek));
    }else{
      days = events.getEventsInRange(new Date(year, month-1, 31 - dayOfWeek + 1)), new Date(year, month+1, 42 - (28 + dayOfWeek));
    }
  }else{
    days = events.getEventsInRange(new Date(year, month-1, 31 - dayOfWeek + 1)), new Date(year, month+1, 42 - (30 + dayOfWeek));
  }
  
  for(int x = 0; x < SCREENWIDTH; x += SCREENWIDTH / 7) {
    day.dsplay(x, y);
    
  }
    
                                 
  
  /*
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
  */
}

int findDay(int m) {
  int[] monthKeyVals = {1, 4, 4, 0, 2, 5, 0, 3, 6, 1, 4, 6};
  int d = (((cal.YEAR % 100) / 4) + day + monthKeyVals[month] + 6 + (cal.YEAR % 100)) % 7;  
  if(cal.YEAR % 400 == 0){
    d = d - 1;
  }
  return d;
}

void drawDay(int x, int y, int z) {}