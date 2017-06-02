import java.util.*;

public class Event {

    private Date date;
    private int duration; // in minutes
    private String name, description;
    private Location loc;
    private int color;

    public Event(String name, Date date) {
        this.name = name;
        this.date = date;
    }

    public Event(String name, Date date, int duration, String description) {
        this(name, date);
        this.duration = duration;
        this.description = description;
    }

    public boolean withinRange(Date d1, Date d2)
    {
        return date.after( d1 ) && date.before( d2 );
    }

    public int compareTo(Event e) {
        if ( date.compareTo( e.date ) == 0 ) {
            return name.compareTo( e.name );
        } else {
            return date.compareTo( e.date );
        }
    }
}
