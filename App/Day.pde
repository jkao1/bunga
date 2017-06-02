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

    int compareTo(Day d)
    {
        return date.compareTo(d.date);
    }
    
    
}