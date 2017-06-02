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

}
