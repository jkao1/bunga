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
  events = new EventCollection("data.in");
  print(events);
}

//draws buttons to choose layout
void drawButtonLayouts(){
  font = loadFont("ArialHebrew-120.vlw");
  textFont(font, 20);
  fill(0);
  rect(CAL_WIDTH / 2 - 200, 10, 100, 30, 10, 0, 0, 10);
  rect(CAL_WIDTH / 2 - 100, 10, 100, 30);
  rect(CAL_WIDTH / 2, 10, 100, 30);
  rect(CAL_WIDTH / 2 + 100, 10, 100, 30, 0, 10, 10, 0);
  fill(100);
  text("Day", CAL_WIDTH / 2 - 200 + 20, 30);
  text("Week", CAL_WIDTH / 2 - 100 + 20, 30);
  text("Month",CAL_WIDTH / 2 + 20, 30); 
  text("Year", CAL_WIDTH / 2 + 100 + 20, 30);
}

//draws days according to actual day
void drawDaysInMonth(int y, int m, int d) {
  Calendar testCal = new GregorianCalendar( y, m, d );
  Event[] theseEvents = events.getEventsInMonth(y, m);
  boolean switched = false;
  int col = 150;
  
  int dayNum = 0;
  int eventTracker = 0;
  
  while (dayNum < 42) {
    
    Day day = new Day( testCal.get(Calendar.YEAR), testCal.get(Calendar.MONTH), testCal.get(Calendar.DATE) );
    while (eventTracker < theseEvents.length && theseEvents[eventTracker].onDay( day.getYear(), day.getMonth(), day.getDate() )) {
      day.addEvent( theseEvents[eventTracker] );
      eventTracker++;
    }
    if ( day.getDate() == 1 ) {
      if (switched) {
        col = 150;
      } else {
        col = 0;
        switched = true;
      }
    }
    day.display(dayNum, 0, col); // position i, layout 0, color 0
    testCal.add( Calendar.DATE, 1 );
    dayNum++;
  }
}

void draw() {
  drawDaysInMonth( startYear, startMonth, startDay );
  drawButtonLayouts();
}