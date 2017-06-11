import controlP5.*;
import java.util.*;
import java.text.*;
import java.io.*;
import javax.swing.*;

final int CAL_WIDTH = 1050;
final int CAL_HEIGHT = 720;
final int HEADER_HEIGHT = 120;
final int navButtonWidth = 80;
final int navButtonHeight = 20;
final int MONTH_EVENT_HEIGHT = 17;
final int gray = 120; // red is rgb(234, 76, 60)

PFont font24, font20, font15, font12, font10;
String fontName = "Avenir-Light";

Calendar testCal; // for rolling & adding when drawing the layouts (like a test charge xd we use it to do relative stuff)
ControlP5 cp5;
Date now;
EventCollection events;
DayCollection days;

int layout;
int startYear, startMonth, startDay;

String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
String[] daysOfWeekLetter = {"S", "M", "T", "W", "T", "F", "S"};
String[] daysOfWeek = {"Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"};
String[] daysOfWeekFull = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

void setup() {
  size(1050, 720);
  days = new DayCollection();
  cp5 = new ControlP5(this);
  layout = 0; // default is month layout
  
  font24 = loadFont(fontName + "-24.vlw");
  font20 = loadFont(fontName + "-20.vlw");
  font15 = loadFont(fontName + "-15.vlw");
  font12 = loadFont(fontName + "-12.vlw");
  font10 = loadFont(fontName + "-10.vlw");
  
  // create a new button with name 'buttonA'
  cp5.addButton("Day")
     .setValue(0)
     .setPosition(0, 10)
     .setSize(navButtonWidth, navButtonHeight);
  cp5.addButton("Week")
     .setValue(100)
     .setPosition(navButtonWidth + 10, 10)
     .setSize(navButtonWidth, navButtonHeight);    
  cp5.addButton("Month")
     .setValue(90)
     .setPosition(2 * navButtonWidth + 20, 10)
     .setSize(navButtonWidth, navButtonHeight);
  cp5.addButton("Year")
     .setValue(03)
     .setPosition(3 * navButtonWidth + 30, 10)
     .setSize(navButtonWidth, navButtonHeight);
     
  initCalendar();
  drawDaysInMonth();
}

void drawHeader(int layout){
  fill(0);
  PFont font = loadFont("ArialHebrew-120.vlw");
  textFont(font, 40);
  if (layout == 0){ //month
    text( months[ testCal.get( Calendar.MONTH ) + 1 ] + " " + testCal.get(Calendar.YEAR), 10, 55 + navButtonHeight);
    textFont(font, 20);
    String space = "                 ";
    text("Sun"+space+"  Mon"+space+" Tues"+space+"  Wed"+space+"  Thurs"+space+"Fri"+space+"    Sat", 10, 90 + navButtonHeight);
  } else if (layout == 1){ //week
    text(months[testCal.get(Calendar.MONTH)] + " " + testCal.get(Calendar.YEAR), 0, 50 + navButtonHeight);
    textFont(font, 20);
    String space = "                ";
    SimpleDateFormat sdf = new SimpleDateFormat("MM dd yyyy");
    Calendar tempCal = Calendar.getInstance();
    tempCal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
    int weekDate = tempCal.get(Calendar.DATE);
    int xChange = (CAL_WIDTH - 75) / 7 + 5;
    int xpos = 75;
    int ypos = 80 + navButtonHeight;
    for(int i = 0; i < 7; i++){
      text(daysOfWeek[i] + "  " + (weekDate + i), xpos, ypos);
      xpos += xChange;
    }
} else if (layout == 2) { // day
    text(months[testCal.get(Calendar.MONTH)] + " " + testCal.get(Calendar.DAY_OF_MONTH), 0, 50 + navButtonHeight);
    textFont(font, 30);
    text(daysOfWeekFull[testCal.get(Calendar.DAY_OF_WEEK)-1], 0, 80 + navButtonHeight);
  } else if (layout == 3) { // year
    text(testCal.get(Calendar.YEAR) + " ", 0, 50 + navButtonHeight);
    textFont(font, 30);
    text(testCal.get(Calendar.DATE), 0, 90 + navButtonHeight);
  }
  fill(255);
}

void drawDay(int y, int m, int d){
  background(255);
  drawHeader(2);
  fill(255);
  Calendar cal = new GregorianCalendar();
  fill(0);
  PFont font = loadFont("ArialHebrew-120.vlw");
  
  //finding right dates
  cal.set(y, m, 1);
  int dYear = (Calendar.SUNDAY-cal.get(Calendar.DAY_OF_WEEK));            
  if(dYear < 0){
    cal.add(Calendar.DATE, 7 + dYear);
  }else{
    cal.add(Calendar.DATE, dYear);
  }
  // calendar is now at first Sunday of the month
  cal.add(Calendar.DAY_OF_MONTH, - 7);
  Date startDate = cal.getTime();
  startYear = startDate.getYear();
  startMonth = startDate.getMonth();
  startDay = startDate.getDate();
  
  int dayX = 50;
  int dayY = HEADER_HEIGHT + 20;
  boolean switched = false;
  int col = gray;
  textFont( font12, 12 );
  fill( gray );
  for (int dayOfWeek = 0; dayOfWeek < 7; dayOfWeek++) {
    text( daysOfWeekLetter[ dayOfWeek ], dayX + (dayOfWeek * 30), dayY );
  }
  dayY += 30;
  dayX = 50;
  //f
  for(int t = 0; t < 42; t++){
    if ( cal.get(Calendar.DATE) == 1 ) {
      if (switched) {
        col = gray;
      } else {
        col = 0;
        switched = true;
      }
    }
    if(cal.get(Calendar.MONTH) == startMonth && cal.get(Calendar.DATE) == startDay){
      fill(255, 0, 0);
      ellipse(dayX + 6, dayY - 5, 20, 20);
      fill(255);
      text(cal.get(Calendar.DATE), dayX, dayY);
    }else{
      fill(col);
      text(cal.get(Calendar.DATE), dayX, dayY);
    }
    dayX += 30;
    if(t % 7 == 6){
      dayX = 50;
      dayY += 20;
    }
    cal.add(Calendar.DATE, 1);  
  }
  //rect(0, HEADER_HEIGHT, 350, CAL_HEIGHT - HEADER_HEIGHT);
  fill(255);
  Day day = new Day(y, m, d);
  Event[] e = events.getEventsInDay(y, m, d);
  day.display(d, 255); //change col
} 

void drawDaysInWeek(int y, int m, int d){
  background(255);
  drawHeader(1);
  Event[] e = events.getEventsInWeek(y, m, d);
  SimpleDateFormat sdf = new SimpleDateFormat("MM dd yyyy");
  Calendar tempCal = Calendar.getInstance();
  tempCal.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
  for(int i = 0; i < 7; i++){ //covers year and month rollovers
    int dayNum = Integer.parseInt(sdf.format(tempCal.getTime()).substring(3, 5));
    int monthNum = Integer.parseInt(sdf.format(tempCal.getTime()).substring(0, 2));
    int yearNum = Integer.parseInt(sdf.format(tempCal.getTime()).substring(6));
    Day day = new Day(yearNum, monthNum, dayNum);
    day.display(dayNum, 255);
    tempCal.roll(Calendar.DAY_OF_WEEK, 1);
  }
}

void drawYear(){ // just removed parameters and have not ajdusted

  background(255);
  drawHeader(3);
  
  int xpos = 40;
  int ypos = HEADER_HEIGHT;
  
  int monthWidth = (CAL_WIDTH - 40) / 4;
  int monthHeight = (CAL_HEIGHT - HEADER_HEIGHT) / 3;  
  
  Calendar trackerCal = Calendar.getInstance();
  while (trackerCal.get(Calendar.MONTH) > 0) {
    trackerCal.add( Calendar.MONTH, -1 );
  }
  while (trackerCal.get(Calendar.DATE) > 1) {
    trackerCal.add( Calendar.DATE, -1 );
  }
  stroke(255);
  
  int trackerY, trackerM, trackerD;
  
  for(int monthNum = 0; monthNum < 12; monthNum++) {
    
    boolean colorSwitched = false;
    int currentColor = gray;
    
    int relX = xpos + (monthNum % 4) * monthWidth;
    int relY = ypos + (monthNum / 4) * monthHeight;

    fill( 234, 76, 60 );
    textFont( font20, 20 );
    text( months[ monthNum ], relX, relY ); // write month name
    
    // begin drawing numbers
    relY += 20;
    textFont( font12, 12 );
    fill( gray );
    for (int dayOfWeek = 0; dayOfWeek < 7; dayOfWeek++) {
      text( daysOfWeekLetter[ dayOfWeek ], relX + dayOfWeek * 30, relY );
    }
    
    // setting calendar to the first Sunday of the month
    while ( trackerCal.get( Calendar.MONTH ) == monthNum ) {
      trackerCal.add( Calendar.DATE, -1 );
    }
    while ( trackerCal.get( Calendar.DAY_OF_WEEK ) != 1 ) {
      trackerCal.add( Calendar.DATE, -1 );
    }
    
    trackerY = trackerCal.get( Calendar.YEAR );
    trackerM = trackerCal.get( Calendar.MONTH );
    trackerD = trackerCal.get( Calendar.DATE );
    
    // drawing dates    
    fill( 0 );
    relY += 20;
    for(int dayNum = 0; dayNum < 42; dayNum++){
      if ( trackerCal.get(Calendar.DATE) == 1 ) {
        if ( colorSwitched ) {
          currentColor = gray;
        } else {
          currentColor = 0;
          colorSwitched = true;
        }
      }
      fill(currentColor);
      text( trackerCal.get(Calendar.DATE), relX + (dayNum % 7) * 30, relY + (dayNum / 7) * 20 );
      trackerCal.add(Calendar.DATE, 1);
    }    
    fill(255);
  }
}

void printCal(Calendar c) {
  println(c.get(Calendar.DAY_OF_WEEK)+", " + c.get(Calendar.MONTH)+"/"+c.get(Calendar.DATE)+"/"+c.get(Calendar.YEAR));
}

void initCalendar() {
  events = new EventCollection("data.in");
  testCal = Calendar.getInstance();   
  
  int focusMonth = testCal.get( Calendar.MONTH );
  // set start month to the month before
  while ( testCal.get( Calendar.MONTH ) == focusMonth ) {
    testCal.add( Calendar.DATE, -1 );
  }
  // set start day to a Sunday
  while (  testCal.get( Calendar.DAY_OF_WEEK ) != 1 ) {
    testCal.add( Calendar.DATE, -1 );
  }
}

void draw() {
  fill(255);
}

void mousePressed() {
  if (layout == 0) {
    Day editMe = findDay();
    if (editMe.hasMouseOnEvent()) {
      editMe.editEvent();
    } else if (editMe.hasMouseOnWindow()) {
      editMe.newEventWindow();
    }
    editMe.display(editMe.i, editMe.col);
  }  
}

void mouseReleased() {
}

// precondition: mouseY > HEADER_HEIGHT
Day findDay() {
  int calCol = mouseX / (CAL_WIDTH / 7);
  if (mouseY > HEADER_HEIGHT && layout == 0) {
    int calRow = (mouseY - HEADER_HEIGHT) / ((CAL_HEIGHT)/ 6);
    return days.get(calRow * 7 + calCol);
  } else {
    return days.get(calCol);
  }
}

void drawDaysInMonth() {
  int currentYear, currentMonth, currentDate;
  background(255);
  drawHeader(0);
  layout = 0;
  
  Event[] theseEvents = events.getEventsInMonth( testCal.get( Calendar.YEAR ), testCal.get( Calendar.MONTH ) );
  
  boolean onFocusMonth = false;  
  int currentColor = gray;  
  int dayNum = 0;
  int eventTracker = 0;
  
  while ( dayNum < 42) {
    currentYear = testCal.get( Calendar.YEAR );
    currentMonth = testCal.get( Calendar.MONTH );
    currentDate = testCal.get( Calendar.DATE );
    Day day = new Day( currentYear, currentMonth, currentDate );
    while (eventTracker < theseEvents.length && theseEvents[eventTracker].onDay( currentYear, currentMonth, currentDate )) { // add all events on day to day
      day.addEvent( theseEvents[eventTracker] );
      eventTracker++;
    }
    if ( currentDate == 1 ) { // the beginning of the month
      if ( onFocusMonth ) {
        currentColor = gray; // out of focus month, so change back to gray
      } else {
        currentColor = 0; // in focus month now, so change to black
        onFocusMonth = true;
      }
    }
    day.display( dayNum, currentColor );
    days.add(day);
    testCal.add( Calendar.DATE, 1 );
    dayNum++;
  }
}

public void controlEvent(ControlEvent theEvent) {
  if(theEvent.controller().getName() == "Day"){
    layout = 2;
    drawDay(startYear, startMonth, startDay);
  }
  
  if(theEvent.controller().getName() == "Week"){
    layout = 1;
    drawDaysInWeek(startYear, startMonth, startDay);
  }
  
  if(theEvent.controller().getName() == "Month"){
    layout = 0;
    drawDaysInMonth();
  }
  
  if(theEvent.controller().getName() == "Year"){
    layout = 3;
    drawYear();
  }
}

void stop() {
  events.close();
}