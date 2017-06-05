import java.util.*;
class Day {

  Date date;
  EventCollection events;
  
  Day(Date date) {
    this.date = date;
  }

  void addEvent(Event e) {
    events.add(e);
  }

  int compareTo(Day d) {
    return date.compareTo(d.date);
  }
  
  void display(int x, int y){
    rect(x, y, Calendar.SCREENWIDTH, Calendar.SCREENHEIGHT);
    fill(255);
    text((String)date.getDate(), x+10, y+10);
  }
   
  
}