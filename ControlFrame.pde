

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

    accordion = cp5.addAccordion("acc")
      .setPosition(10, 10)
        .setWidth(173)
          .addItem(g1)
            .addItem(g2)
              .addItem(g3)
                .setItemHeight(80)
                  ;
    accordion.open(0, 1,2);
    accordion.setCollapseMode(Accordion.MULTI);

    cp5.addToggle("Display Circles").setPosition(10, 10).setSize(10, 10).setGroup(g1).plugTo(parent, "displayCircle");
    cp5.addToggle("Display Color").setPosition(10, 30).setSize(10, 10).setGroup(g1).plugTo(parent, "displayColor");
    cp5.addToggle("Triangles Only").setPosition(10, 50).setSize(10, 10).setGroup(g1).plugTo(parent, "trianglesOnly");

    cp5.addRadioButton("radioButton")
      .setPosition(10, 10)
        .setSize(10, 10)
          .setItemsPerRow(1)
            .setSpacingRow(10)
              .addItem("Draw Triangles", 0).activate(0)
                .addItem("Move Circle", 1)
                  .addItem("Delete Triangle", 2).setGroup(g2).plugTo(parent, "mode")
                    ;

    cp5.addSlider("Min dist")
      .setPosition(10, 10)
        .setRange(0, 30)
        .setValue(15)
        .setGroup(g3)
        .plugTo(parent, "minDistCollapse")
          ;
  }

  public void draw() {
    background(abc);
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

