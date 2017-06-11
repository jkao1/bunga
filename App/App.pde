import controlP5.*;
import java.util.*;
import java.text.*;
import java.io.*;

final int CAL_WIDTH = 1050;
final int CAL_HEIGHT = 740;
final int HEADER_HEIGHT = 140;
final int navButtonWidth = 80;
final int navButtonHeight = 20;

PFont font24;
PFont font12;
import controlP5.*;
Calendar testCal; // for rolling & adding when drawing the layouts (like a test charge xd we use it to do relative stuff)
Date now;
EventCollection events;
DayCollection days;
int startYear, startMonth, startDay;
int mouseClicks, mouseDubClickStartTime, mouseDubClickEndTime;
String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
String[] daysOfWeek = {"Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"};
String[] daysOfWeekFull = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
ControlP5 cp5;

int layout;


void setup() {
  size(1050, 740);
  days = new DayCollection();
  cp5 = new ControlP5(this);
  layout = 0; // default is month layout
  mouseClicks = 0;
  
  font24 = loadFont("ArialHebrew-24.vlw");
  font12 = loadFont("ArialHebrew-12.vlw");
  
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
  drawDaysInMonth( startYear, startMonth, startDay );
}

void drawHeader(int layout){
  Calendar cal = new GregorianCalendar();
  fill(0);
  PFont font = loadFont("ArialHebrew-120.vlw");
  textFont(font, 40);
  if (layout == 0){ //month
    text(months[cal.get(Calendar.MONTH)] + " " + cal.get(Calendar.YEAR), 10, 55 + navButtonHeight);
    textFont(font, 20);
    String space = "                 ";
    text("Sun"+space+"  Mon"+space+" Tues"+space+"  Wed"+space+"  Thurs"+space+"Fri"+space+"    Sat", 10, 90 + navButtonHeight);
  } else if (layout == 1){ //week
    text(months[cal.get(Calendar.MONTH)] + " " + cal.get(Calendar.YEAR), 0, 50 + navButtonHeight);
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
    text(months[cal.get(Calendar.MONTH)] + " " + cal.get(Calendar.DAY_OF_MONTH), 0, 50 + navButtonHeight);
    textFont(font, 30);
    text(daysOfWeekFull[cal.get(Calendar.DAY_OF_WEEK)-1], 0, 80 + navButtonHeight);
  } else if (layout == 3) { // year
    text(cal.get(Calendar.YEAR) + " ", 0, 50 + navButtonHeight);
    textFont(font, 30);
    text(cal.get(Calendar.DATE), 0, 90 + navButtonHeight);
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
  textFont(font, 10);
  text("S        M        T        W        T        F        S", 0, HEADER_HEIGHT);
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
  
  int dayX = 0;
  int dayY = HEADER_HEIGHT + 20;
  boolean switched = false;
  int col = 150;
  for(int t = 0; t < 42; t++){
    if ( cal.get(Calendar.DATE) == 1 ) {
      if (switched) {
        col = 150;
      } else {
        col = 0;
        switched = true;
      }
    }
    fill(col);
    text(cal.get(Calendar.DATE), dayX, dayY);
    dayX += 30;
    if(t % 7 == 6){
      dayX = 0;
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

void drawYear(int y, int m, int d){
  //System.out.println(y);
  background(255);
  drawHeader(3);
  int xpos = 40;
  int ypos = 120;
  int monthWidth = (CAL_WIDTH - 40) / 4;
  int monthHeight = (CAL_HEIGHT - HEADER_HEIGHT) / 3;
  boolean switched = false;
  int col = 150;
  PFont font = loadFont("ArialHebrew-120.vlw");
  Calendar cal = new GregorianCalendar();
  stroke(255);
  for(int i = 0; i < 12; i++){
    rect(xpos, ypos, monthWidth, monthHeight);
    fill(0);
    textFont(font, 20);
    text(months[i], xpos, ypos);
    textFont(font, 10);
    text("S        M        T        W        T        F        S", xpos, ypos + 20);
    
    //finding right dates
    cal.set(y, i, 1);
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
    
    
    //drawing dates
    textFont(font, 15);
    int dayX = xpos;
    int dayY = ypos + 40;
    for(int t = 0; t < 42; t++){
      if ( cal.get(Calendar.DATE) == 1 ) {
        if (switched) {
          col = 150;
        } else {
          col = 0;
          switched = true;
        }
      }
      fill(col);
      text(cal.get(Calendar.DATE), dayX, dayY);
      dayX += 30;
      if(t % 7 == 6){
        dayX = xpos;
        dayY += 20;
      }
      cal.add(Calendar.DATE, 1);
    }  
    switched = false;
    fill(255);
    xpos += monthWidth;
    if(i % 4 == 3){
      xpos = 40;
      ypos += monthHeight;
    }
  }
}

void initCalendar() {
  events = new EventCollection("data.in");
  Calendar calendar = Calendar.getInstance();               
  SimpleDateFormat sdf = new SimpleDateFormat("MMM/dd/YYYY");
  calendar.set(Calendar.MONTH,Calendar.JUNE);
  calendar.set(Calendar.DAY_OF_MONTH,1);          
  int day = (Calendar.SUNDAY-calendar.get(Calendar.DAY_OF_WEEK));            
  if(day<0){
    calendar.add(Calendar.DATE,7+(day));
  }else{
      calendar.add(Calendar.DATE,day);
  }
  // calendar is now at first Sunday of the month
  calendar.add(Calendar.DAY_OF_MONTH, - 7);
  Date startDate = calendar.getTime();
  startYear = startDate.getYear();
  startMonth = startDate.getMonth();
  startDay = startDate.getDate();
  now = Calendar.getInstance().getTime();
}

void draw() {
  fill(255);
}

void mousePressed() {
  if (mouseClicks == 0) {
    mouseDubClickStartTime = millis();
  }
  mouseClicks++;
  if (mouseClicks == 2) {
    mouseDubClickEndTime = millis();
  }  
}

void mouseReleased() {
  if (mouseClicks == 2 && mouseDubClickEndTime - mouseDubClickStartTime < 1000) {
    Day editMe = findDay();
    if (editMe.hasMouseOnEvent()) {
      editMe.editEvent();
    } else {
      editMe.newEventWindow();
    }
    mouseClicks = 0;
    editMe.display(editMe.i, editMe.col);
  }  
}

// precondition: mouseY > HEADER_HEIGHT
Day findDay() {
  int calCol = mouseX / (CAL_WIDTH / 7);
  if (layout == 0) {
    int calRow = (mouseY - HEADER_HEIGHT) / ((CAL_HEIGHT - HEADER_HEIGHT)/ 6);
    return days.get(calRow * 7 + calCol);
  } else {
    return days.get(calCol);
  }
}

void drawDaysInMonth(int y, int m, int d) {
  background(255);
  drawHeader(0);
  layout = 0;
  testCal = new GregorianCalendar( y, m, d );
  Event[] theseEvents = events.getEventsInMonth(y, m);
  println(theseEvents.length);
  boolean switched = false;
  int col = 150;
  
  int dayNum = 0;
  int eventTracker = 0;
  
  while (dayNum < 42) {
    
    Day day = new Day( testCal.get(Calendar.YEAR), testCal.get(Calendar.MONTH), testCal.get(Calendar.DATE) );
    while (eventTracker < theseEvents.length && theseEvents[eventTracker].onDay( day.getYear(), day.getMonth(), day.getDate() )) {
      day.addEvent( theseEvents[eventTracker] );
      eventTracker++;
    }
     
    if ( day.getDate() == 1 ) {
      if (switched) {
        col = 150;
      } else {
        col = 0;
        switched = true;
      }
    }     

    day.display(dayNum, col); // position i, layout 0, color 0
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
    drawDaysInMonth(startYear, startMonth, startDay);
  }
  
  if(theEvent.controller().getName() == "Year"){
    layout = 3;
    drawYear(startYear, startMonth, startDay);
    System.out.println(" " + startYear + " " + startMonth + " " + startDay);
  }
}

void stop() {
  events.close();
}


/*
a list of all methods available for the Button Controller
use ControlP5.printPublicMethodsFor(Button.class);
to print the following list into the console.

You can find further details about class Button in the javadoc.

Format:
ClassName : returnType methodName(parameter type)


controlP5.Button : Button activateBy(int) 
controlP5.Button : Button setOff() 
controlP5.Button : Button setOn() 
controlP5.Button : Button setSwitch(boolean) 
controlP5.Button : Button setValue(float) 
controlP5.Button : Button update() 
controlP5.Button : String getInfo() 
controlP5.Button : String toString() 
controlP5.Button : boolean getBooleanValue() 
controlP5.Button : boolean isOn() 
controlP5.Button : boolean isPressed() 
controlP5.Controller : Button addCallback(CallbackListener) 
controlP5.Controller : Button addListener(ControlListener) 
controlP5.Controller : Button bringToFront() 
controlP5.Controller : Button bringToFront(ControllerInterface) 
controlP5.Controller : Button hide() 
controlP5.Controller : Button linebreak() 
controlP5.Controller : Button listen(boolean) 
controlP5.Controller : Button lock() 
controlP5.Controller : Button plugTo(Object) 
controlP5.Controller : Button plugTo(Object, String) 
controlP5.Controller : Button plugTo(Object[]) 
controlP5.Controller : Button plugTo(Object[], String) 
controlP5.Controller : Button registerProperty(String) 
controlP5.Controller : Button registerProperty(String, String) 
controlP5.Controller : Button registerTooltip(String) 
controlP5.Controller : Button removeBehavior() 
controlP5.Controller : Button removeCallback() 
controlP5.Controller : Button removeCallback(CallbackListener) 
controlP5.Controller : Button removeListener(ControlListener) 
controlP5.Controller : Button removeProperty(String) 
controlP5.Controller : Button removeProperty(String, String) 
controlP5.Controller : Button setArrayValue(float[]) 
controlP5.Controller : Button setArrayValue(int, float) 
controlP5.Controller : Button setBehavior(ControlBehavior) 
controlP5.Controller : Button setBroadcast(boolean) 
controlP5.Controller : Button setCaptionLabel(String) 
controlP5.Controller : Button setColor(CColor) 
controlP5.Controller : Button setColorActive(int) 
controlP5.Controller : Button setColorBackground(int) 
controlP5.Controller : Button setColorCaptionLabel(int) 
controlP5.Controller : Button setColorForeground(int) 
controlP5.Controller : Button setColorValueLabel(int) 
controlP5.Controller : Button setDecimalPrecision(int) 
controlP5.Controller : Button setDefaultValue(float) 
controlP5.Controller : Button setHeight(int) 
controlP5.Controller : Button setId(int) 
controlP5.Controller : Button setImages(PImage, PImage, PImage) 
controlP5.Controller : Button setImages(PImage, PImage, PImage, PImage) 
controlP5.Controller : Button setLabelVisible(boolean) 
controlP5.Controller : Button setLock(boolean) 
controlP5.Controller : Button setMax(float) 
controlP5.Controller : Button setMin(float) 
controlP5.Controller : Button setMouseOver(boolean) 
controlP5.Controller : Button setMoveable(boolean) 
controlP5.Controller : Button setPosition(PVector) 
controlP5.Controller : Button setPosition(float, float) 
controlP5.Controller : Button setSize(PImage) 
controlP5.Controller : Button setSize(int, int) 
controlP5.Controller : Button setStringValue(String) 
controlP5.Controller : Button setUpdate(boolean) 
controlP5.Controller : Button setValueLabel(String) 
controlP5.Controller : Button setView(ControllerView) 
controlP5.Controller : Button setVisible(boolean) 
controlP5.Controller : Button setWidth(int) 
controlP5.Controller : Button show() 
controlP5.Controller : Button unlock() 
controlP5.Controller : Button unplugFrom(Object) 
controlP5.Controller : Button unplugFrom(Object[]) 
controlP5.Controller : Button unregisterTooltip() 
controlP5.Controller : Button update() 
controlP5.Controller : Button updateSize() 
controlP5.Controller : CColor getColor() 
controlP5.Controller : ControlBehavior getBehavior() 
controlP5.Controller : ControlWindow getControlWindow() 
controlP5.Controller : ControlWindow getWindow() 
controlP5.Controller : ControllerProperty getProperty(String) 
controlP5.Controller : ControllerProperty getProperty(String, String) 
controlP5.Controller : Label getCaptionLabel() 
controlP5.Controller : Label getValueLabel() 
controlP5.Controller : List getControllerPlugList() 
controlP5.Controller : PImage setImage(PImage) 
controlP5.Controller : PImage setImage(PImage, int) 
controlP5.Controller : PVector getAbsolutePosition() 
controlP5.Controller : PVector getPosition() 
controlP5.Controller : String getAddress() 
controlP5.Controller : String getInfo() 
controlP5.Controller : String getName() 
controlP5.Controller : String getStringValue() 
controlP5.Controller : String toString() 
controlP5.Controller : Tab getTab() 
controlP5.Controller : boolean isActive() 
controlP5.Controller : boolean isBroadcast() 
controlP5.Controller : boolean isInside() 
controlP5.Controller : boolean isLabelVisible() 
controlP5.Controller : boolean isListening() 
controlP5.Controller : boolean isLock() 
controlP5.Controller : boolean isMouseOver() 
controlP5.Controller : boolean isMousePressed() 
controlP5.Controller : boolean isMoveable() 
controlP5.Controller : boolean isUpdate() 
controlP5.Controller : boolean isVisible() 
controlP5.Controller : float getArrayValue(int) 
controlP5.Controller : float getDefaultValue() 
controlP5.Controller : float getMax() 
controlP5.Controller : float getMin() 
controlP5.Controller : float getValue() 
controlP5.Controller : float[] getArrayValue() 
controlP5.Controller : int getDecimalPrecision() 
controlP5.Controller : int getHeight() 
controlP5.Controller : int getId() 
controlP5.Controller : int getWidth() 
controlP5.Controller : int listenerSize() 
controlP5.Controller : void remove() 
controlP5.Controller : void setView(ControllerView, int) 
java.lang.Object : String toString() 
java.lang.Object : boolean equals(Object) 


*/