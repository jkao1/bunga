import java.util.*;

class EventCollection {

    ArrayList<Event> events;

    EventCollection() {
        events = new ArrayList<Event>();
    }

    void add(Event e) {
        events.add(e);
    }

    void delete(Event e) {
        events.remove( indexOf( e ));
    }

    int indexOf(Event e)
    {
        for (int i = 0; i < events.size(); i++) {
            if ( events.get(i).compareTo( e ) == 0 ) {
                return i;
            }
        }
        return -1;
    }

    // do iterator
}