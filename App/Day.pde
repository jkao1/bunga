import java.util.*;
class Day {

  int year, month, date;
  int xpos, ypos;
  EventCollection events;
  
  Day(int year, int month, int date) {
    this.year = year;
    this.month = month;
    this.date = date;
  }
  
  void display(int i) {
    xpos = (i % 7) * SCREENWIDTH / 7;
    ypos = (i / 7) * SCREENHEIGHT / 6;
    rect(xpos, ypos, SCREENWIDTH / 7, SCREENHEIGHT / 6);
    text("hi", 0, 0); // doesnt work lmao
  }

  void addEvent(Event e) {
    events.add(e);
  }

}