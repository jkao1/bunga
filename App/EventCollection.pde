import java.util.*;

class EventCollection {
  
  TreeSet<Event> events;
  
  EventCollection(String filename) {
    events = new TreeSet<Event>();
    String[] lines = loadStrings(filename);
    for (String line : lines) {
      String[] ary = line.split(",");      
      String name;        
      int year, month, date;
      String description =  "";
      int duration = 60;
      int type = (int) (Math.random() * 4);
      name = ary[0];
      year = Integer.parseInt(ary[1]) - 1900;
      month = Integer.parseInt(ary[2]) - 1;
      date = Integer.parseInt(ary[3]);
      if (ary.length > 4) {
        duration = Integer.parseInt(ary[4]);
      }
      if (ary.length > 5) {
        description = ary[5];
      }
      if (ary.length > 6) {
        type = Integer.parseInt(ary[6]);
      }
      events.add( new Event( name, year, month, date, duration, description, type));
    }    
  }
  
  Event[] getEventsInMonth(int y, int m) {
    Set<Event> temp = events.subSet( new Event( "", y, m, 1 ), new Event( "", y, m + 1, 1 ));
    Event[] output = temp.toArray( new Event[ temp.size() ]);
    return events.toArray(new Event[events.size()]);
  }
  
  Event[] getEventsInWeek(int y, int m, int d) {
    Set<Event> temp = events.subSet( new Event( "", y, m, d ), new Event( "", y, m, d + 8 ));
    Event[] output = temp.toArray( new Event[ temp.size() ]);
    return output;
  }
  
  Event[] getEventsInDay(int y, int m, int d) {
    Set<Event> temp = events.subSet( new Event( "", y, m, d ), new Event( "", y, m, d + 1 ));
    Event[] output = temp.toArray( new Event[ temp.size() ]);
    return output;
  }
  
  String toString() {
    return events.toString();
  }
  
}