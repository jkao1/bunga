import java.util.*;

public class Event {

    private int year, month, date;
    private int duration; // in minutes
    private String name, description;
    private Location loc;
    private int color;

    public Event(String name, Date date)
    {
        this.name = name;
        this.year = date.getYear();
        this.month = date.getMonth();
        this.date = date.getDate();
    }

    public Event(String name, Date date, int duration, String description)
    {
        this(name, date);
        this.duration = duration;
        this.description = description;
    }
    
    public boolean onDate(Date d) {
        return year == d.getYear() && month == d.getMonth() && date == d.getDate();
    }


}