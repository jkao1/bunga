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
      int type = 0;
      int col = 0;
      name = ary[0];
      year = Integer.parseInt(ary[1]);
      month = Integer.parseInt(ary[2]);
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
      if (ary.length > 7) {
        col = Integer.parseInt(ary[7]);
      }
      events.add( new Event( name, year, month, date, duration, description, type, col ));
      println('h');
    }
    println(this);
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