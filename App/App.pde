import java.util.Calendar;

final int SCREENWIDTH = 1040;
final int SCREENHEIGHT = 720;

Calendar c;
EventCollection events;
ArrayList<Day> days;
String[] months = {"January", "February", "March", "April", "May", "June", 
                   "July", "August", "September", "October", "November", "December"};
String[] daysOfWeek = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                       "Saturday"};

void setup() {
  surface.setSize( SCREENWIDTH, SCREENHEIGHT );
  c = Calendar.getInstance();
  print(c);
}

void getDaysInMonth(int m, int y, int dayOfWeek) {
  Date s, e;
  if(m % 2 == 0){
    s = new Date(y, m-1, 30 - dayOfWeek + 1);
    e = new Date(y, m+1, 42 - (31 + dayOfWeek));
  }else if(m == 1){
    if(y % 400 == 0){
      s = new Date(y,m-1, 31 - dayOfWeek + 1);
      e = new Date(y, m+1, 42 - (29 + dayOfWeek));
    }else{
      s = new Date(y, m-1, 31 - dayOfWeek + 1); 
      e = new Date(y, m+1, 42 - (28 + dayOfWeek));
    }
  }else{
      s = new Date(y, m-1, 31 - dayOfWeek + 1);
      e = new Date(y, m+1, 42 - (30 + dayOfWeek));
  }
}
void draw() {
  for (int i = 0; i < 42; i++) {
    Day d = new Day( c.get(Calendar.YEAR), c.get(Calendar.MONTH), c.get(Calendar.DATE) + i );
    d.display(i);    
  }
}

void drawDay(int x, int y, int z) {}