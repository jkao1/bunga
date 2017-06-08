import java.util.*;

PFont font;

class Day {

  int year, month, date;
  int xpos, ypos;
  MyHeap events;

  Day(int year, int month, int date) {
    this.year = year;
    this.month = month;
    this.date = date;
    events = new MyHeap();
  }
  
  void display(int i, int layout, int col) {
    stroke(200);
    if (layout == 0) { // month layout
      xpos = (i % 7) * CAL_WIDTH / 7;
      ypos = HEADER_HEIGHT + ((i / 7) * (CAL_HEIGHT) / 6) - 20;
      rect(xpos, ypos, CAL_WIDTH / 7, CAL_HEIGHT / 6);
      font = loadFont("ArialHebrew-120.vlw");
      textFont(font, 24);
      fill(col);
      if (date < 10) {
        text(Integer.toString(date), 
             xpos + CAL_WIDTH / 7 - 20,
             ypos + 30);
      } else {
        text(Integer.toString(date), 
             xpos + CAL_WIDTH / 7 - 35,
             ypos + 30);
      }
      textFont(font, 12);
      ypos += 35;
      noStroke();
      while (!events.isEmpty()) {
        Event e = events.remove();
        if (e.getType() == 0) {
          fill(220, 240, 210);
        } else if (e.getType() == 1) {
          fill(210, 230, 230);
        } else {
          fill(210, 220, 210);
        }
        rect(xpos+10, ypos, CAL_WIDTH / 7 - 20, 15);
        fill(0); //choose another color??
        text(e.toString(), xpos + 20, ypos + 12);
        ypos += 17;
      }      
      fill(255);
      
    } else if(layout == 1) { // week layout
      ypos = 120;
      xpos = (i % 7 ) * CAL_WIDTH / 7; 
      
    } else { // day layout
      
    }
  }
  
  void addEvent(Event e) {
    events.add(e);
  }
  
  int getYear() {
    return year;
  }
  
  int getMonth() {
    return month;
  }

  int getDate() {
    return date;
  }
  
  String toString() {
    return month + "/" + date + "/" + year;
  }

}