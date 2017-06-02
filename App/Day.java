import java.util.*;

public class Day {

    private Date date;
    private EventCollection events;

    public Day(Date date) {
        this.date = date;
    }

    public void addEvent(Event e) {
        events.add(e);
    }

    public int compareTo(Day d)
    {
        return date.compareTo(d.date);
    }
}
