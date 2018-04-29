class ControlFrame extends PApplet {
  int w, h;
  PApplet parent;
  boolean b;
  ControlP5 cp5;
  String[] cansons={"Proxima B","Menta","Mapes","Bisons","Matèria","Diumenges","Fractals","Festa al terrat","No tho mereixes","Indica","Seahorses","Cap parat","NEGRE"};

  public ControlFrame(PApplet _parent, int _w, int _h, String _name) {
    super();   
    parent = _parent;
    w=_w;
    h=_h;
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }

  public void settings() {
    size(w, h);
  }
  public void setup() {
    cp5 = new ControlP5(this);
    List l = Arrays.asList(cansons[0],cansons[1],cansons[2],cansons[3],cansons[4],cansons[5],cansons[6],cansons[7],cansons[8],cansons[9],cansons[10],cansons[11],cansons[12]);
    
    cp5.addScrollableList("dropdown")
      .setPosition(100, 100)
      .setSize(200, 200)
      .setBarHeight(20)
      .setItemHeight(20)
      .addItems(l)
      .setType(ScrollableList.DROPDOWN) // currently supported DROPDOWN and LIST
      ;

    cp5.addSlider("trans_fons")
      .plugTo(parent, "trans_fons")
      .setRange(0, 255)
      .setValue(0)
      .setPosition(100, 450)
      .setSize(200, 20);

    cp5.addSlider("grosor_malla")
      .plugTo(parent, "grosor_malla")
      .setRange(1, 15)
      .setValue(1)
      .setPosition(100, 500)
      .setSize(200, 20);

    cp5.addSlider("level_f")
      .plugTo(parent, "level_f")
      .setRange(-100, displayWidth)
      .setValue(0)
      .setPosition(100, 550)
      .setSize(200, 20);

    cp5.addToggle("toggle_fons")
      .plugTo(parent, "toggle_fons")
      .setPosition(40, 450)
      .setSize(50, 20)
      .setValue(true)
      .setMode(ControlP5.SWITCH)
      .setLabel("ActivaFons")
      ;

    cp5.addButton("OO")
      .plugTo(parent, "num")
      .setValue(0)
      .setPosition(100, 580)
      .setSize(200, 19)
      ;

    cp5.addButton("IO")
      .plugTo(parent, "num")
      .setValue(1)
      .setPosition(100, 600)
      .setSize(200, 19)
      ;

    cp5.addButton("OI")
      .plugTo(parent, "num")
      .setValue(2)
      .setPosition(100, 620)
      .setSize(200, 19)
      ;

    cp5.addButton("II")
      .plugTo(parent, "num")
      .setValue(3)
      .setPosition(100, 640)
      .setSize(200, 19)
      ;
    /*cp5.addBang("zero")
     .plugTo(parent, "zero")
     .setPosition(100, 600)
     .setTriggerEvent(Bang.RELEASE)
     .setSize(40, 40)
     .setId(40)
     ;*/
  }
  public void draw() {
    background(200);
    if (myCurrentIndex >= 0) {
      text(cansons[myCurrentIndex], 200, 40);
    }
  }

  public void dropdown(int n) {
    //println(n + cansons[n]);  
    myCurrentIndex = n;
  }
}