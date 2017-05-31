import java.util.*;

public class EventCollection implements Iterable<Event> {

    private ArrayList<Event> events;

    public EventCollection() {
        events = new ArrayList<Event>();
    }



    public addEvent(Event e) {}

    public deleteEvent(Event e) {}
    
    public Iterator iterator() {
        return this;
    }
}
