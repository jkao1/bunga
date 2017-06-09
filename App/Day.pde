import javax.swing.*;

PFont font;

class Day {

  int year, month, date;
  int xpos, ypos;
  int i, layout, col;
  MyHeap events;

  Day(int year, int month, int date) {
    this.year = year;
    this.month = month;
    this.date = date;
    events = new MyHeap();
  }
  
  void display() {
    stroke(200);
    rect(xpos, ypos, CAL_WIDTH / 7, CAL_HEIGHT / 6);
      
      int relX = xpos;
      int relY = ypos;
      font = loadFont("ArialHebrew-120.vlw");
      textFont(font, 24);
      fill(col);
      if (date < 10) {
        text(Integer.toString(date), // draw numbers on each day
             xpos + CAL_WIDTH / 7 - 20,
             ypos + 30);
      } else {
        text(Integer.toString(date), // draw numbers on each day
             xpos + CAL_WIDTH / 7 - 32,
             ypos + 30);
      }
      textFont(font, 12);
      relY += 35;
      noStroke();
      // draw all the events
      println(events);
      while (!events.isEmpty()) {
        Event e = events.remove();
        if (e.getType() == 0) {
          fill(220, 240, 210); // pale green
        } else if (e.getType() == 1) {
          fill(210, 230, 230); // pale blue
        } else {
          fill(210, 220, 210); // dark green
        }
        rect(relX+10, relY, CAL_WIDTH / 7 - 20, 15);
        fill(0);
        // write the event
        text(e.toString(), relX + 20, relY + 12);
        relY += 17;
      }      
      fill(255);
      noStroke();
  }
  
  void display(int i, int layout, int col) {
    this.i = i;
    this.layout = layout;
    this.col = col;
    stroke(200);
    if (layout == 0) { // month layout
      xpos = (i % 7) * CAL_WIDTH / 7;
      ypos = HEADER_HEIGHT + ((i / 7) * (CAL_HEIGHT) / 6) - 20;
      rect(xpos, ypos, CAL_WIDTH / 7, CAL_HEIGHT / 6);
      
      int relX = xpos;
      int relY = ypos;
      font = loadFont("ArialHebrew-120.vlw");
      textFont(font, 24);
      fill(col);
      if (date < 10) {
        text(Integer.toString(date), // draw numbers on each day
             xpos + CAL_WIDTH / 7 - 20,
             ypos + 30);
      } else {
        text(Integer.toString(date), // draw numbers on each day
             xpos + CAL_WIDTH / 7 - 32,
             ypos + 30);
      }
      textFont(font, 12);
      relY += 35;
      noStroke();
      // draw all the events
      while (!events.isEmpty()) {
        Event e = events.remove();
        if (e.getType() == 0) {
          fill(220, 240, 210); // pale green
        } else if (e.getType() == 1) {
          fill(210, 230, 230); // pale blue
        } else {
          fill(210, 220, 210); // dark green
        }
        rect(relX+10, relY, CAL_WIDTH / 7 - 20, 15);
        fill(0);
        // write the event
        text(e.toString(), relX + 20, relY + 12);
        relY += 17;
      }      
      fill(255);
    } else if(layout == 1) { // week layout
      ypos = 120;
      xpos = (i % 7 ) * CAL_WIDTH / 7; 
      
    } else { // day layout
      
    }
  }
  
  void removeEventWindow() {
    display();
  }
  
  void newEventWindow() {
    String eventName;
    eventName = JOptionPane.showInputDialog("Name Your Event:");
    events.add(new Event(eventName, year, month, date));
    display();
  }
  
  void addEvent(Event e) {
    events.add(e);
  }
  
  boolean isDate(Date d) {
    return year == d.getYear() && month == d.getMonth() && date == d.getDay();
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
    return month + 1 + "/" + date + "/" + (year + 1900);
  }

}