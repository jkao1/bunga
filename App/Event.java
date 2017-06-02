import java.util.*;

public class Event {
  
    private Date start;
    private int duration; // in minutes
    private String name, description;
    private Location loc;
    private int color;

    public Event(String name) {
        this.name = name;
    }

    public Event(Date start, int duration, String name, String description) {
        this.start = start;
        this.duration = duration;
        this.name = name;
        this.description = description;
    }

}