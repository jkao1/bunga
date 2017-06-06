import java.util.*;

public class Event {

    private int year, month, date;
    private int duration; // in minutes
    private String name, description;
    private Location loc;
    private int type;
    
    public Event(String name, int year, int month, int date) {
        this.name = name;
        this.year = year;
        this.month = month;
        this.date = date;
    }
    
    public Event(String name, int year, int month, int date, int duration, String description, int type) {
        this( name, year, month, date );
        this.duration = duration;
        this.description = description;
        this.type = type;
    }

    public int compareTo(Event e)
    {
        if (date == e.date && month == e.month && year == e.year) {
            return name.compareTo( e.name );
        } else {
            return ( new Date( year, month, date ).compareTo( new Date ( e.year, e.month ,e.date )));
        }
    }

}