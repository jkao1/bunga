class Day {

  int year, month, date;
  int xpos, ypos;
  int dayNum, col;
  ArrayList<Event> todayEvents;
  
  int boxWidth = (CAL_WIDTH - labelWidth) / 7;
  int boxHeight = CAL_HEIGHT / 27; // 24 time slots + 3 slots for all-day
  
  Day(int year, int month, int date) {
    this.year = year;
    this.month = month;
    this.date = date;
    todayEvents = events.findEvents( year, month, date );
  }
  
  Day(int year, int month, int date, int dayNum, int col) {
    this( year, month, date );
    this.dayNum = dayNum;
    this.col = col;
  }
  
  void display() {
    todayEvents = events.findEvents( year, month, date );
    this.dayNum = dayNum; // used for position tracking
    this.col = col; // used for text colors

    fill(255);
    stroke(200);
    
    if (layout == 0) { // month layout
      xpos = (dayNum % 7) * CAL_WIDTH / 7;
      ypos = HEADER_HEIGHT + (dayNum / 7) * (CAL_HEIGHT / 6);
      
      if ( dayNum % 7 == 0 || dayNum % 7 == 6) { // if weekday, then shade in box
        fill(247);
      }
      
      stroke(226);
      rect(xpos, ypos, CAL_WIDTH / 7, CAL_HEIGHT / 6) ;
      
      int relX = xpos;
      int relY = ypos;
      textFont(font24, 20);
      fill(col);
      int originalYear = testCal.get( Calendar.YEAR );
      int originalMonth = testCal.get( Calendar.MONTH );
      int originalDate = testCal.get( Calendar.DATE );
      
      if( year == todayCal.get( Calendar.YEAR ) && month == todayCal.get( Calendar.MONTH ) && date == todayCal.get( Calendar.DATE )){
        fill(255, 0, 0);
        
        if (date < 10) { 
          ellipse(xpos + CAL_WIDTH / 7 - 20 + 5, ypos + 30 - 8, 24, 24);
        }else{
          ellipse(xpos + CAL_WIDTH / 7 - 20 + 3, ypos + 30 - 8, 25, 25);
        }
        fill(255);
        stroke(226);
      }if (date < 10) {
        text(Integer.toString(date), // draw numbers on each day
             xpos + CAL_WIDTH / 7 - 20,
             ypos + 29);
      } else {
        text(Integer.toString(date), // draw numbers on each day
             xpos + CAL_WIDTH / 7 - 27,
             ypos + 29);
      }
      textFont(font12, 12);
      relY += 37;
      noStroke();
      
      // draw all the events
      for ( int eventNum = 0; eventNum < todayEvents.size(); eventNum++ ) {
        Event e = todayEvents.get( eventNum );
        if ( eventNum > 2 ) {
          fill(0);
          text( todayEvents.size() - eventNum + " more...", relX + 20, relY + 14);
          break;
        }
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
        relY += MONTH_EVENT_HEIGHT;
      }      
      
      fill(255);
            
    } else if(layout == 1) { // week layout
      int relX = labelWidth + dayNum * (CAL_WIDTH - labelWidth) / 7;
      int relY = HEADER_HEIGHT;
      
      textFont(font24, 15);
      stroke(226);
      fill(255);
      
      rect(relX, relY, boxWidth, 3 * boxHeight); // the all-day box
      
      relY += 3 * boxHeight;
      fill(247);
      for(int hour = 0; hour < 24; hour++){
        rect(relX, relY + hour * boxHeight, boxWidth, boxHeight);
      }
      int allDayY = relY - 3 * boxHeight;
      int allDayEvents = 0;
      for (int i = 0; i < todayEvents.size(); i++) {
        Event e = todayEvents.get( i );
        if (e.getType() == 0) {
          fill(220, 240, 210); // pale green
        } else if (e.getType() == 1) {
          fill(210, 230, 230); // pale blue
        } else {
          fill(210, 220, 210); // dark green
        }
        
        textFont( fontbold15, 15);
        int textX = relX + 10;
        if (e.duration == 1440) {
          if (allDayEvents == 3) {
            fill(255);
            rect(relX, allDayY - boxHeight, boxWidth, boxHeight);
            textFont(font12, 12);
            fill(0);
            text("more...", relX + 10, allDayY - 5);
          } else {
            rect(relX, allDayY, boxWidth, boxHeight);
            fill(0);
            text( e.name, textX, allDayY + boxHeight- 5); // first is the name
            allDayY += boxHeight;
            allDayEvents++;
          }
          continue;
        }
        rect(relX, relY + e.startTime / 60.0 * boxHeight, boxWidth, e.duration / 60.0 * boxHeight);
        fill( 0 );
        
        if ( e.duration / 60.0 >= 4 ) { // if four slots, then put time and name and address
          textFont( font15, 15);          
          text( e.getFormattedStartTime(), textX, relY + e.startTime * boxHeight/ 60.0 + boxHeight - 5); // start time
          textFont( fontbold15, 15);
          text( e.name, textX, relY + e.startTime * boxHeight / 60.0 + 2 * boxHeight - 5); // first is the name
          textFont( font15, 15);
          text( e.getFormattedLocation(), textX, relY + e.startTime * boxHeight / 60.0 + 3 * boxHeight - 5); // first is the name
        } 
        else if ( e.duration / 60.0 >= 2 ) { // if two slots, then put time and name
          textFont( font15, 15);          
          text( e.getFormattedStartTime(), textX, relY + e.startTime * boxHeight / 60.0 + boxHeight - 5); // start time
          textFont( fontbold15, 15);
          text( e.name, textX, relY + e.startTime * boxHeight / 60.0 + 2 * boxHeight - 5); // first is the name
        } 
        else if (e.duration / 60.0 < 2 ) {
          text( e.name, textX, relY + e.startTime * boxHeight / 60.0 + boxHeight - 5); // first is the name
        } 
        
      }
      
      fill(188);
      //rect(55, HEADER_HEIGHT + 18 + boxHeight, CAL_WIDTH - 75, 5);      
    } else if (layout == 2 ){ // day layout
      
      textFont(font24, 15);
      stroke(226);
      fill(255);
      int relX = sideMonthWidth + 3 * labelWidth / 2;
      int relY = HEADER_HEIGHT;
      int originalBoxWidth = boxWidth;
      boxWidth = CAL_WIDTH - relX - 20;
      rect(relX, relY, boxWidth, 3 * boxHeight); // the all-day box
      
      relY += 3 * boxHeight;
      fill(247);
      for(int hour = 0; hour < 24; hour++){
        rect(relX, relY + hour * boxHeight, boxWidth, boxHeight);
      }
      int allDayY = relY - 3 * boxHeight;
      int allDayEvents = 0;
      for (int i = 0; i < todayEvents.size(); i++) {
        Event e = todayEvents.get( i );
        
        if (e.getType() == 0) {
          fill(220, 240, 210); // pale green
        } else if (e.getType() == 1) {
          fill(210, 230, 230); // pale blue
        } else {
          fill(210, 220, 210); // dark green
        }
        textFont( fontbold15, 15);
        int textX = relX + 10;
        if (e.duration == 1440) {
          if (allDayEvents == 3) {
            fill(255);
            rect(relX, allDayY - boxHeight, boxWidth, boxHeight);
            textFont(font12, 12);
            fill(0);
            text("more...", relX + 10, allDayY - 5);
          } else {
            rect(relX, allDayY, boxWidth, boxHeight);
            fill(0);
            text( e.name, textX, allDayY + boxHeight- 5); // first is the name
            allDayY += boxHeight;
            allDayEvents++;
          }
          continue;
        }
        rect(relX, relY + e.startTime / 60.0 * boxHeight, boxWidth, e.duration / 60.0 * boxHeight);
        textFont( fontbold15, 15);
        fill( 0 );
        
        if ( e.duration / 60.0 >= 4 ) { // if four slots, then put time and name and address
          textFont( font15, 15);          
          text( e.getFormattedStartTime(), textX, relY + e.startTime * boxHeight/ 60.0 + boxHeight - 5); // start time
          textFont( fontbold15, 15);
          text( e.name, textX, relY + e.startTime * boxHeight / 60.0 + 2 * boxHeight - 5); // first is the name
          textFont( font15, 15);
          text( e.getFormattedLocation(), textX, relY + e.startTime * boxHeight / 60.0 + 3 * boxHeight - 5); // first is the name
        } 
        else if ( e.duration / 60.0 >= 2 ) { // if two slots, then put time and name
          textFont( font15, 15);          
          text( e.getFormattedStartTime(), textX, relY + e.startTime * boxHeight / 60.0 + boxHeight - 5); // start time
          textFont( fontbold15, 15);
          text( e.name, textX, relY + e.startTime * boxHeight / 60.0 + 2 * boxHeight - 5); // first is the name
        } 
        else if (e.duration / 60.0 < 2 ) {
          text( e.name, textX, relY + e.startTime * boxHeight / 60.0 + boxHeight - 5); // first is the name
        } 
        
      }
      boxWidth = originalBoxWidth;
      fill(188);
    }
  }
  
  void newEventWindow() {
    if (layout == 0) {
      stroke(0);
      String eventName = JOptionPane.showInputDialog("Event Name:");
      if (eventName != null && eventName.length() > 0) {
        events.insert( new Event( eventName, year, month, date ));
      }
    } else if (layout == 1) {
      String eventName = JOptionPane.showInputDialog("Event Name:");
      if (eventName != null && eventName.length() > 0) {
        int duration = 120; // default
        if (mouseY - HEADER_HEIGHT < 3 * boxHeight) {
          duration = 1440; // all day
        }
        events.insert( new Event( eventName, year, month, date, duration, "", 0, getStartTime() ));
      }
    }
  }
  
  int getStartTime() {
    int relY = mouseY - HEADER_HEIGHT - 3 * boxHeight;
    if (relY <= 0) { // in all day
      return 0;
    }
    return relY * 60 / boxHeight;
  }
  
  void add(ArrayList<Event> ary) {
    for (Event e : ary) {
      todayEvents.add(e);
    }
  }
  
  boolean hasMouseOnWindow() {
    return mouseY >= ypos && mouseY <= ypos + CAL_HEIGHT / 6;
  }
  
  /*
   * returns 0 if mouse is not on an event, 1 otherwise
   * returns 2 if mouse is on "N more...", in which case the program will move to day layout
   */
  int hasMouseOnEvent() {
    if (layout == 0) { // month
      if ( todayEvents.size() > 3 ) {
        return 2;
      }
      int topY = ypos + 35;
      int botY = ypos + 35 + (todayEvents.size()) * MONTH_EVENT_HEIGHT;
      if ( mouseY >= topY && mouseY <= botY ) {
        return 1;
      }
    }
    return 0;
  }
  
  void editEvent() {  
    if (layout == 0) {
      int eventNumber = 0;
      int topY = ypos + 35;
      fill(0);
      while (ypos + 35 + eventNumber * (MONTH_EVENT_HEIGHT) > topY) {
        topY += MONTH_EVENT_HEIGHT;
        eventNumber++;
      }    
      Event editMe = todayEvents.get(eventNumber);
      String newName = JOptionPane.showInputDialog("New name for event " + editMe);
      if (newName != null && newName.length() > 0) {
        editMe.setName(newName);
      }
    }
  }
  
  boolean tryEditingEvent() {
    if (layout == 1) { // week
      int allDayEvents = 0;
      for (Event e : todayEvents) {
        int relY = HEADER_HEIGHT;
        if (e.duration == 1440) {
          allDayEvents++;
          if (mouseY >= HEADER_HEIGHT + (allDayEvents - 1) * boxHeight && 
              mouseY <= HEADER_HEIGHT + allDayEvents * boxHeight) {
            String newName = JOptionPane.showInputDialog("New name for event " + e);
            if (newName != null) {
              e.setName(newName);
            }
            return true;
          }
        }
        else if (mouseY >= HEADER_HEIGHT + 3 * boxHeight + boxHeight * e.startTime / 60.0 && 
                 mouseY <= HEADER_HEIGHT + 3 * boxHeight + boxHeight * e.startTime / 60.0 + 
                           e.duration / 60.0 * boxHeight) {
          String newName = JOptionPane.showInputDialog("New name for event " + e);
          if (newName != null) {
            e.setName(newName);
          }
          return true;
        }
      }
    }
    if (layout == 2) { // day
    
    }
    return false;
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
    return month + "/" + date + "/" + year;
  }

}