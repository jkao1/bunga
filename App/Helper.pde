// 
// THE CP5 IN HELPER CONTROLS THE GUI ELEMENTS OF THE MAIN APPLICATION.
// THE GUI ELEMENTS OF HELPER ARE CONTROLLED IN HELPER 2.
//


class Helper extends PApplet {
  
  ControlP5 cp5;

  Helper(PApplet pApplet) {
    cp5 = new ControlP5(pApplet);    
    makeButtons();
    //PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);    
  }

  void settings() {
    size(300, 500);
  }
  void setup() {
    size(300, 500);
  }
  
  void showFocusedEvent() {
    
  }
  
  void draw() {
  }

  void mousePressed() {
  }
  
  void makeButtons() {
    cp5.addButton("Day")
     .setValue(0)
     .setPosition((CAL_WIDTH / 2) - (2 * navButtonWidth), 10)
     .setSize(navButtonWidth, navButtonHeight)
     .setColorBackground(0);
  cp5.addButton("Week")
     .setValue(100)
     .setPosition((CAL_WIDTH / 2) - navButtonWidth, 10)
     .setSize(navButtonWidth, navButtonHeight)
     .setColorBackground(247);
  cp5.addButton("Month")
     .setValue(90)
     .setPosition(CAL_WIDTH / 2, 10)
     .setSize(navButtonWidth, navButtonHeight)
     .setColorBackground(247);
  cp5.addButton("Year")
     .setValue(03)
     .setPosition((CAL_WIDTH / 2) + navButtonWidth, 10)
     .setSize(navButtonWidth, navButtonHeight)
     .setColorBackground(247);
   cp5.addButton("Previous")
     .setValue(03)
     .setPosition(CAL_WIDTH - (3 * navButtonWidth) - 60, 10)
     .setSize(navButtonWidth, navButtonHeight)
     .setColorBackground(247);   
   cp5.addButton("Next")
     .setValue(03)
     .setPosition(CAL_WIDTH - navButtonWidth - 60, 10)
     .setSize(navButtonWidth, navButtonHeight)
     .setColorBackground(247);
   cp5.addButton("Today")
     .setValue(03)
     .setPosition(CAL_WIDTH - (2 * navButtonWidth) - 60, 10)
     .setSize(navButtonWidth, navButtonHeight)
     .setColorBackground(247);
  }
}