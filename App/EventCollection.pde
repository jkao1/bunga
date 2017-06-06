import java.util.*;

class EventCollection {

    ArrayList<Event> events;

    EventCollection() {
        events = new ArrayList<Event>();
    }

    void add(Event e) {
        events.add(e);
    }
    
    ArrayList<Event> getEventsOnDay(Date date)
    {
      ArrayList<Event> output = new ArrayList<Event>();
      for (Event e : events) {
        if ( e.onDate( date )) {
          output.add( e );
        }
      }
      return output;          
    }

    // do iterator
}