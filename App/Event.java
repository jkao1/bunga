import java.util.*;

public class Event implements Comparable<Event> {

    public int year, month, date, startTime;
    public int duration; // in minutes
    public String name, description;
    public Location location;
    public int type;
    public boolean locked;
    
    public Event(String name, int year, int month, int date) {
        this.name = name;
        this.year = year;
        this.month = month;
        this.date = date;
        this.duration = 60;
        this.description = "";
        this.type = 0;
        locked = true;
    }
    
    public Event(String name, int year, int month, int date, int duration, String description, int type, int startTime) {
        this( name, year, month, date );
        this.duration = duration;
        this.description = description;
        this.type = type;
        this.startTime = startTime;
    }
    
    public boolean onDay(int y, int m, int d) {
        return year == y && month == m && date == d;
    }

    public int compareTo(Event e)
    {
        Date me = new Date(year, month, date);
        Date you = new Date(e.year, e.month, e.date);
        if (me.compareTo(you) == 0) {
            if ( startTime - e.startTime == 0 ) {
                return name.compareTo(e.name);
            } else {
                return startTime - e.startTime;
            }
        } else {
            return me.compareTo(you);
        }
    }

    public int compareDateTo(Event e) {
        Date me = new Date(year, month, date);
        Date you = new Date(e.year, e.month, e.date);
        return me.compareTo(you);
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getFormattedStartTime() {
        String hour;
        if (startTime < 60) {
            hour = "12";
        } else {
            hour = "" + startTime / 60;
        }
        String minute;
        if (startTime % 60 == 0) {
            minute = "00";
        } else if (startTime % 60 < 10) {
            minute = "0" + startTime % 60;
        } else {
            minute = "" + startTime % 60;
        }
        String meridiem;
        if (startTime < 720) {
            meridiem = "a";
        } else {
            meridiem = "p";
        }
        return hour + ":" + minute + meridiem;
    }
    
    public String getFormattedLocation() {
        return location.toString();
    }
    
    public String toString() { // DO NOT CHANGE, THIS IS FOR FILE WRITING
        return name + "," + year + "," + month + "," + date + ',' + duration + ',' + 
        description + ',' + type + ',' + startTime;
    }
    
    public String toString(boolean b) {
        if ( b ) { 
            return name + ": " + month + "/" + date + "/" + year;
        } else {
            return month + "/" + date + "/" + year;
        }
    }
    
    public int getType(){
        return type;
    }
}