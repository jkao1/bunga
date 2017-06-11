class Day {

  int year, month, date;
  int xpos, ypos;
  int i, col;
  MyHeap todayEvents;

  Day(int year, int month, int date) {
    this.year = year;
    this.month = month;
    this.date = date;
    todayEvents = new MyHeap();
  }
  
  void display(int i, int col) {
    this.i = i;
    this.col = col;
    MyHeap clone = null;
    if (todayEvents.size() > 0) {
       clone = todayEvents.clone();
    }
    stroke(200);
    
    if (layout == 0) { // month layout
      xpos = (i % 7) * CAL_WIDTH / 7;
      ypos = HEADER_HEIGHT + ((i / 7) * (CAL_HEIGHT - HEADER_HEIGHT)) / 6;
      Calendar cal = new GregorianCalendar(year, month, date);
      if(cal.get(Calendar.DAY_OF_WEEK) - 1 == 0 || cal.get(Calendar.DAY_OF_WEEK) - 1 == 6){
        fill(247);
      }
      stroke(226);
      rect(xpos, ypos, CAL_WIDTH / 7, (CAL_HEIGHT) / 6) ;
      
      int relX = xpos;
      int relY = ypos;
      textFont(font24, 20);
      fill(col);
      int originalYear = testCal.get( Calendar.YEAR );
      int originalMonth = testCal.get( Calendar.MONTH );
      int originalDate = testCal.get( Calendar.DATE );
      
      //
      //BUG: every day is red; how to get today's date????
      //
      if(cal.get(Calendar.MONTH) == originalMonth && cal.get(Calendar.DATE) == originalDate){
        fill(255, 0, 0);
        stroke(255);
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
      while (todayEvents.size() > 0 && clone != null && !clone.isEmpty()) {
        Event e = clone.remove();
        if (todayEvents.size() - clone.size() > 3) {
          fill(0);
          text(clone.size() + 1 + " more...", relX + 20, relY + 14);
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
      textFont(font24, 15);
      ypos = HEADER_HEIGHT + 25 ;
      xpos = 7;
      int xChange = (CAL_WIDTH - 75) / 7;
      int yChange = (CAL_HEIGHT - HEADER_HEIGHT - 25) / 26 + 1;
      String noon = " AM";
      for(int n = 0; n <= 1; n++){
        if(n == 0){
          fill(0);
          text("12 AM", xpos, ypos + yChange);
          fill(255);
          ypos += yChange;
        }else if(n == 1){
          fill(0);
          text(" 12 PM", xpos, ypos + yChange);
          fill(255);
          ypos += yChange;
          noon = " PM";
        } 
        for(int t = 1; t < 12; t++){
          fill(0);
          if(t < 10){
            text("   " + t + noon, xpos, ypos + yChange);
          }else{
            text(" " + t + noon, xpos, ypos + yChange);
          }
          fill(255);
          ypos += yChange;
        }
      }
      ypos = HEADER_HEIGHT + 18;
      fill(0);
      text("all-day", xpos, ypos );
      for(int w = 0; w < 7; w++){
        stroke(226);
        fill(255);
        rect(xpos + 50, ypos - yChange, xChange, 2 * yChange);
        ypos += yChange;
        fill(247);
        for(int t = 0; t < 24; t++){
          rect(xpos + 50, ypos, xChange, yChange);
          ypos += yChange;
        }
        xpos += xChange;
        ypos = HEADER_HEIGHT + 18;
      }
      xpos = 5;
      fill(188);
      rect(xpos + 50, HEADER_HEIGHT + 18 + yChange, CAL_WIDTH - 75, 5);

      Date d = new Date();
      DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
      int currentHour = Integer.parseInt(dateFormat.format(d).substring(11, 13));
      int currentMin = Integer.parseInt(dateFormat.format(d).substring(14, 16));
      fill(255, 0, 0);
      stroke(255);
      rect(xpos + 50, (currentHour * yChange) + HEADER_HEIGHT + ((currentMin / 60.) * yChange), CAL_WIDTH - 75, 2);
      
    } else { // day layout
      textFont(font24, 15);
      ypos = navButtonHeight + 55;
      int sideMonth = 300;
      xpos = sideMonth;
      int yChange = (CAL_HEIGHT - ypos) / 25;
      int xChange = CAL_WIDTH - sideMonth - 40;

      String noon = " AM";
      for(int n = 0; n <= 1; n++){
        if(n == 0){
          fill(0);
          text("12 AM", xpos, ypos + yChange);
          fill(255);
          ypos += yChange;
        }else if(n == 1){
          fill(0);
          text(" 12 PM", xpos, ypos + yChange);
          fill(255);
          ypos += yChange;
          noon = " PM";
        } 
        for(int t = 1; t < 12; t++){
          fill(0);
          if(t < 10){
            text("   " + t + noon, xpos, ypos + yChange);
          }else{
            text(" " + t + noon, xpos, ypos + yChange);
          }
          fill(255);
          ypos += yChange;
        }
      }
      
      ypos = navButtonHeight + 50;
      stroke(226);
      fill(255);
      rect(xpos + 50, ypos - yChange, xChange, 2 * yChange);
      fill(0);
      text("all-day", xpos, ypos );
      ypos += yChange;
      fill(247);
      for(int t = 0; t < 24; t++){
        rect(xpos + 50, ypos, xChange, yChange);
        ypos += yChange;
      }
      fill(188);
      rect(xpos + 45, navButtonHeight + 45 + yChange, xChange + 50, 5);
      
      //draws event; Event needs a time variable
      ypos = navButtonHeight + 50;
      while (todayEvents.size() > 0 && clone != null && !clone.isEmpty()) {
        System.out.println("works monthly");
        Event e = clone.remove();
        if (todayEvents.size() - clone.size() > 3) {
          fill(0);
          text(clone.size() + 1 + " more...", xpos + 45, ypos + 14);
          break;
        }
        if (e.getType() == 0) {
          fill(220, 240, 210); // pale green
        } else if (e.getType() == 1) {
          fill(210, 230, 230); // pale blue
        } else {
          fill(210, 220, 210); // dark green
        }
        rect(xpos + 45 + 2, ypos + 2, xChange - 4, 15);
        fill(0);
        // write the event
        text(e.toString(), xpos + 45 + 5, ypos + 4);
        ypos += 15;
        resize(ypos);
      }      
            
      Date d = new Date();
      DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
      int currentHour = Integer.parseInt(dateFormat.format(d).substring(11, 13));
      int currentMin = Integer.parseInt(dateFormat.format(d).substring(14, 16));
      fill(181, 63, 63);
      rect(xpos + 50, ((1 + currentHour) * yChange) + navButtonHeight + 55 + ((currentMin / 60.) * yChange), xChange, 3);
      
    }
  }
  
  void resize(int ypos){
    
  }
  
  void newEventWindow() {
    println(todayEvents);
    stroke(0);
    String eventName = JOptionPane.showInputDialog("Event Name:");
    if (eventName != null) {
      addEvent(new Event(eventName, year, month, date));
    }
    println(todayEvents);
  }
  
  void addEvent(Event e) {
    todayEvents.add(e);  
  }
  
  boolean hasMouseOnWindow() {
    return mouseY >= ypos && mouseY <= ypos + CAL_HEIGHT / 6;
  }
  
  boolean hasMouseOnEvent() {
    int topY = ypos + 35;
    int botY = ypos + 35 + (todayEvents.size()) * MONTH_EVENT_HEIGHT;
    return mouseY >= topY && mouseY <= botY;
  }
  
  void editEvent() {    
    int eventNumber = 0;
    int topY = ypos + 35;
    while (mouseY > topY) {
      topY += MONTH_EVENT_HEIGHT;
      eventNumber++;
    }    
    Event editMe = todayEvents.get(eventNumber);
    String newName = JOptionPane.showInputDialog("New Name:");
    if (newName != null) {
      editMe.setName(newName);
      addEvent(new Event("hi", year, date, month));
    }
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