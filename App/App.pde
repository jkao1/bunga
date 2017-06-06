import java.util.*;
import java.text.*;

final int CAL_WIDTH = 150 * 7;
final int CAL_HEIGHT = 660;

Calendar c;
EventCollection events;
ArrayList<Day> days;
int startYear, startMonth, startDay;
String[] months = {"January", "February", "March", "April", "May", "June", 
                   "July", "August", "September", "October", "November", "December"};
String[] daysOfWeek = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                       "Saturday"};

void setup() {
  surface.setSize( CAL_WIDTH, 120 + CAL_HEIGHT );
  Calendar calendar = Calendar.getInstance();               
  SimpleDateFormat sdf = new SimpleDateFormat("MMM/dd/YYYY");
  drawButtonLayouts();
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

//draws buttons to choose layout
void drawButtonLayouts(){
  fill(0);
  font = loadFont("ArialHebrew-120.vlw");
  textFont(font, 20);
  rect(CAL_WIDTH / 2 - 120, 30, 30, 60, 5, 0, 0, 5);
  text("Day", 25, CAL_WIDTH / 2 - 120 + 20);
  rect(CAL_WIDTH / 2 - 60, 30, 30, 60);
  text("Week", 25, CAL_WIDTH / 2 - 60 + 20);
  rect(CAL_WIDTH / 2, 30, 30, 60);
  text("Month", 25, CAL_WIDTH / 2 + 20); 
  rect(CAL_WIDTH / 2 + 60, 30, 30, 60, 0, 5, 5, 0);
  text("Year", 25, CAL_WIDTH / 2 + 60 + 20);
  fill(0);
}

//draws days according to actual day
void drawDaysInMonth(int y, int m, int d) {
  Calendar testCal = new GregorianCalendar( y, m, d );
  
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