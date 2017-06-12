// 
// THE CP5TWO IN HELPER2 CONTROLS THE GUI ELEMENTS OF HELPER.
//


class Helper2 extends PApplet {
  ControlP5 cp5Two;
  Helper2(PApplet pApplet) {
    cp5Two = new ControlP5(pApplet);
    cp5Two.addButton("Day")
     .setValue(0)
     .setPosition(0, 10)
     .setSize(navButtonWidth, navButtonHeight);
  }

  void settings() {
  }
  void setup() {
  }
    
  void showFocusedEvent() {
  }
        //public Event(String name, int year, int month, int date, int duration, String description, int type, int startTime) {

  void draw() {
  }

  void mousePressed() {
    println("mousePressed in Helper2");
  }
}