import java.util.*;
class Day {

  int year, month, date;
  int xpos, ypos;
  EventCollection events;

  Day(int year, int month, int date) {
    this.year = year;
    this.month = month;
    this.date = date;
    events = new EventCollection();
  }
  
  void display(int i, int layout) {
      //for month layout
    if(layout == 0){
      xpos = (i % 7) * SCREENWIDTH / 7;
      ypos = 120 + ((i / 7) * (SCREENHEIGHT - 120) / 6);
      rect(xpos, ypos, SCREENWIDTH / 7, SCREENHEIGHT / 6);
      fill(50);
      textSize(20);
      text(Integer.toString(date), xpos + 20, ypos + 30);
      fill(255);
      
      //for week layout
    }else if(layout == 1){
      
      //for day layout
    }else{
      
    }
  }

  void addEvent(Event e) {
    events.add(e);
  }

}