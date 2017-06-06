import java.util.*;
import java.text.*;

final int SCREENWIDTH = 150 * 7;
final int SCREENHEIGHT = 720;

Calendar c;
EventCollection events;
ArrayList<Day> days;
int startYear, startMonth, startDay;
String[] months = {"January", "February", "March", "April", "May", "June", 
                   "July", "August", "September", "October", "November", "December"};
String[] daysOfWeek = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                       "Saturday"};

void setup() {
  surface.setSize( SCREENWIDTH, SCREENHEIGHT );
  Calendar calendar = Calendar.getInstance();               
  SimpleDateFormat sdf = new SimpleDateFormat("MMM/dd/YYYY");
  calendar.set(Calendar.MONTH,Calendar.JUNE);
  calendar.set(Calendar.DAY_OF_MONTH,1);          
  int day = (Calendar.SUNDAY-calendar.get(Calendar.DAY_OF_WEEK));            
  if(day<0){
    calendar.add(Calendar.DATE,7+(day));
  }else{
      calendar.add(Calendar.DATE,day);
  }
  // calendar is now at first Sunday of the month
  calendar.add(Calendar.DAY_OF_MONTH, - 7);
  Date startDate = calendar.getTime();
  startYear = startDate.getYear();
  startMonth = startDate.getMonth();
  startDay = startDate.getDate();
}

//draws days according to actual day
void drawDaysInMonth(int y, int m, int d) {
  Calendar testCal = new GregorianCalendar( y, m, d );
  /*
  for (int i = Calendar.DAY_OF_WEEK; i >= 0; i++){
    Day day;
    if(Calendar.MONTH == 2){
      if(Calendar.YEAR % 400 == 0){
        day = new Day(y, m - 1, 29 - i);
      }else{
        day = new Day(y, m - 1, 28 - i);
      }
    }else if(Calendar.MONTH % 2 == 0){
      day = new Day(y, m - 1, 30 - i);
    }else{
      day = new Day(y, m - 1, 31 - i);
    }
    day.display(i, 0);
  }
    */
    boolean switched = false;
    int col = 150;
  for (int i = 0; i < 42; i++) {
    Day day = new Day( testCal.get(Calendar.YEAR), testCal.get(Calendar.MONTH), testCal.get(Calendar.DATE) );
    
    if ( day.getDate() == 1 ) {
      if (switched) {
        col = 150;
      } else {
        col = 0;
        switched = true;
      }
    }
    day.display(i, 0, col); // position i, layout 0, color 0
    testCal.add( Calendar.DATE, 1 );
  }
}
void draw() {
  drawDaysInMonth( startYear, startMonth, startDay );
}