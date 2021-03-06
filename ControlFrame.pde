ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}


public class ControlFrame extends PApplet {

  int w, h;

  int abc = 100;
  Accordion accordion;
  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    Group g1 = cp5.addGroup("Debug ")
      .setPosition(10, 20)
        .setSize(173, 50)
          .setBackgroundColor(color(255, 50))
            ;
    Group g2 = cp5.addGroup("Mode")
      .setPosition(10, 70)
        .setSize(173, 50)
          .setBackgroundColor(color(255, 50))
            ;
    Group g3 = cp5.addGroup("Properties")
      .setPosition(10, 70)
        .setSize(173, 50)
          .setBackgroundColor(color(255, 50))
            ;

  Group g4 = cp5.addGroup("Data load/save")
      .setPosition(10, 70)
        .setSize(173, 50)
          .setBackgroundColor(color(255, 50))
            ;


    accordion = cp5.addAccordion("acc")
      .setPosition(10, 10)
        .setWidth(173)
          .addItem(g1)
            .addItem(g2)
              .addItem(g3)
                .addItem(g4)
                  .setItemHeight(180)
                  ;


    accordion.open(0, 1,2,3);
    accordion.setCollapseMode(Accordion.MULTIPLES);




    cp5.addToggle("Display Circles").setPosition(10, 10).setSize(10, 10).setGroup(g1).plugTo(parent, "displayCircle").setValue(true);
    cp5.addToggle("Display Color").setPosition(10, 30).setSize(10, 10).setGroup(g1).plugTo(parent, "displayColor");
    cp5.addToggle("Triangles Only").setPosition(10, 50).setSize(10, 10).setGroup(g1).plugTo(parent, "trianglesOnly");
    cp5.addToggle("Display Epicenter").setPosition(10, 70).setSize(10, 10).setGroup(g1).plugTo(parent, "displayEpicenter").setValue(false);



  Slider s  =  cp5.addSlider("")
     .setRange(0, 5)
     .setPosition(10, 10)
     .setSize(100,10)
     .setNumberOfTickMarks(5)
     .setGroup(g2).setValue(0)
     .plugTo(parent, "mode")
     ;
  
/*
    cp5.addRadioButton("radioButton").setPosition(10, 10).setSize(10, 10).setItemsPerRow(1).setSpacingRow(10).setGroup(g2).plugTo(parent, "mode")
              .addItem("Draw Triangles", 0)
                .addItem("Move Circle", 1)
                  .addItem("Delete Triangle", 2)
                  .addItem("Set Epicenter", 3).activate(0)
                    ;

*/

    //settings 
    cp5.addSlider("Min dist").setPosition(10, 10).setRange(0, 30).setValue(15).setGroup(g3).plugTo(parent, "minDistCollapse");
    cp5.addSlider("X").setPosition(10, 30).setRange(0, 1200).setValue(0).setGroup(g3).plugTo(parent, "epicenterX");
    cp5.addSlider("Y").setPosition(10, 50).setRange(0, 1200).setValue(0).setGroup(g3).plugTo(parent, "epicenterY");
    cp5.addSlider("alphaDist").setPosition(10, 70).setRange(0, 800).setValue(100).setGroup(g3).plugTo(parent, "alphaDist");
    cp5.addSlider("distanceOffsetEpicenter").setPosition(10, 90).setRange(0, 255).setValue(50).setGroup(g3).plugTo(parent, "distanceOffsetEpicenter");
    cp5.addSlider("randomAlpha").setPosition(10, 110).setRange(0, 255).setValue(50).setGroup(g3).plugTo(parent, "randomAlpha");
    cp5.addSlider("linesDivisionFactor").setPosition(10, 130).setRange(0, 1).setValue(0.7).setGroup(g3).plugTo(parent, "linesDivisionFactor");
    cp5.addSlider("linesOffset").setPosition(10, 150).setRange(0, 255).setValue(50).setGroup(g3).plugTo(parent, "linesOffset");
  
    //save and load xml
  cp5.addButton("Save data").setValue(100).setPosition(10,10).setSize(150,20).setGroup(g4)
    .addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent event) {
          if (event.getAction() == ControlP5.ACTION_RELEASED) {
            SaveData();
          }
        }
      });

  cp5.addButton("Load Data ( data/points.xml ) ").setPosition(10,40).setSize(150,20).setGroup(g4)
    .addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        if (event.getAction() == ControlP5.ACTION_RELEASED) {
          LoadData();
        }
      }
    });
    
  cp5.addButton("Save canvas as PDF").setPosition(10,70).setSize(150,20).setGroup(g4)
    .addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        if (event.getAction() == ControlP5.ACTION_RELEASED) {
          recordPDF = true;
        }
      }
    });


 cp5.addButton("Exit").setPosition(40,130).setSize(80,20).setGroup(g4)
    .addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        if (event.getAction() == ControlP5.ACTION_RELEASED) {
          exit();
        }
      }
    });
  }


  public void draw() {
    background(abc);
  }

void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.captionLabel().set("dropdown");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  for (int i=0;i<40;i++) {
    ddl.addItem("item "+i, i);
  }
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}


  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }


  public ControlP5 control() {
    return cp5;
  }


  ControlP5 cp5;

  Object parent;
}
