import java.util.Calendar;

final int SCREENWIDTH = 1040;
final int SCREENHEIGHT = 720;

Calendar c;
int year, month, day, dayOfWeek;
int dayYCoords, dayXCoords;
EventCollection events;
ArrayList<Day> days;
String[] months = {"January", "February", "March", "April", "May", "June", 
                   "July", "August", "September", "October", "November", "December"};
String[] daysOfWeek = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                       "Saturday"};

void setup() {
  surface.setSize( SCREENWIDTH, SCREENHEIGHT );
  c = Calendar.getInstance();
  c.set( 2017, 7, 1 );
  print(c.get(Calendar.DAY_OF_WEEK));
}

void draw() {
  for (int i = 0; i < 42; i++) {
    Day d = new Day( c.get(Calendar.YEAR), c.get(Calendar.MONTH), c.get(Calendar.DATE) + i );
    d.display(i);    
  }
}

void drawDay(int x, int y, int z) {}