import java.util.*;

public class Event implements Comparable<Event> {

    private int year, month, date;
    private int duration; // in minutes
    private String name, description;
    private Location loc;
    private int type;
    private int col;
    
    public Event(String name, int year, int month, int date) {
        this.name = name;
        this.year = year;
        this.month = month;
        this.date = date;
        col = 0;
    }
    
    public Event(String name, int year, int month, int date, int duration, String description, int type) {
        this( name, year, month, date );
        this.duration = duration;
        this.description = description;
        this.type = type;
        this.col = col;
    }
    
    public boolean onDay(int y, int m, int d) {
        return year == y && month == m && date == d;
    }

    public int compareTo(Event e)
    {
        Date me = new Date(year, month, date);
        Date you = new Date(e.year, e.month, e.date);
        if (me.compareTo(you) == 0) {
            return name.compareTo(e.name);
        } else {
            return me.compareTo(you);
        }
    }
    
    public String toString() {
        return name;
    }
    
    public int col(){
      return col;
    }
}