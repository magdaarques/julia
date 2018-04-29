class Malla {
  int fons;
  int w, h, scl;
  float ff, f;
  int c;
  float rotateSpeedX=0.01;
  float rotateSpeedY=0.01;
  float rotateSpeedZ=0.01;
  //float rotateSpeedX, rotateSpeedY, rotateSpeedZ;
  //float zoom=1;
  float zzum;
  float eentrada;
  float eeixida;

  /*modificar la malla per a que siga editable desde la gui*/
  Malla(int sc_l, int ample, int alt, float flying) {
    w=ample;
    h=alt;
    scl=sc_l;
    ff=flying;
    cols = ample/scl;
    rows =alt/scl;
    terrain =new float[cols][rows];
  }

  /*crear un void config(int sc_l, int ample, int alt, float flying){
   
   }*/

  void movement(int x, int y, int z, int zum) {

    //int zum - zoom no progressiu
    /*angle i punt de vista de la malla quan comença es carrega*/
    //controlar els 3 eixos per separat de cada malla pel moviment en l'espai
    float tx= midi.value(x, 0.0, 8.0);
    float ty= midi.value(y, 0.0, 8.0);
    float tz= midi.value(z, 0.0, 8.0);
    float tzum=midi.value(zum, 0.5, 5); 

    zzum=lerp(zzum, tzum, 0.05);

    rotateSpeedX=tx+rotateSpeedX;
    rotateSpeedY=ty+rotateSpeedY;
    rotateSpeedZ=tz+rotateSpeedZ;
    rotateX(radians(rotateSpeedX));
    rotateY(radians(rotateSpeedY));
    rotateZ(radians(rotateSpeedZ));
    scale(zzum);

    translate(-w/2, -h/2, 10);
  }

  void update(int e, int ei, int mov_cols) {
    /*velocitat dels canvis de la malla*/
    f+=ff;
    /*lights();
     ambientLight(0, 255, 0);
     directionalLight(0, 255, 0, 0, 0.5, -1);
     spotLight(255, 0, 0, width/2, height/2, 400, 0, 0, -1, PI/4, 0);*/
    float entrada= midi.value(e, -10, 15);
    eentrada=lerp(eentrada, entrada, 0.02);
    float eixida = midi.value(ei, -5.4, 4);
    eeixida=lerp(eeixida, eixida, 0.015);

    //float entrada, eixida;
    float movement_cols= midi.value(mov_cols, -0.9, 3.0);
    float movement_files= 0.9;
    //float movement_files= mov_cols;
    float yoff=f;
    int i=0;
    if (i<in.bufferSize()-1) {
      i++;
      //entrada=midi.value(e, in.left.get(i)*-4, 15+in.right.get(i+1)*2 );
      //eixida = midi.value(ei, in.left.get(i)*-4, 10+in.right.get(i+1)*2);
      strokeWeight(grosor_malla);
      for (int y=0; y<rows; y++) {
        float xoff=0;
        for (int x=0; x<cols; x++) { 
          /*càlculs dels moviments de la malla.*/
          terrain[x][y]=map(noise(xoff, yoff), eentrada, eeixida, -650, 650);
          /*modifiques este número canvia el tipo de moviment de les ones que es dibuixen exemple 0.09*/
          xoff+=movement_cols;
        }
        yoff+=movement_files;
      }
    }
    pushMatrix();
    for (int y=0; y<rows-1; y++) {
      beginShape(TRIANGLE_STRIP);
      for (int x=0; x<cols; x++) {
        vertex(x*scl, y*scl, terrain[x][y]);
        vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
        //rect(x*scl, y*scl, scl, scl);
        //fill(255);
        noFill();
      }
      endShape();
    }
    popMatrix();
  }

  // COLORS MALLA 
  void colors_malla(int x, int y, int v) {
    //opacitat traçat
    float m= midi.value(v, 0, 255);//
    for (int i=0; i<200; i++) {
      color[][] colm = {
        {color(184, 40, 111), color(255, 255, 255)}, /*Pròxima B*/
        {color(122, 101, 168), color(191, 224, 39)}, /*Menta*/
        {color(191, 224, 39), color(229, 117, 57)}, /*Mapes*/
        {color(219, 160, 58), color(51, 147, 119)}, /*Bisons*/
        {color(229, 117, 57), color(47, 221, 219)}, /*Matèria*/
        {color(47, 221, 219), color(205, 148, 215)}, /*Diumenges*/
        {color(234, 236, 27), color(47, 221, 219)}, /*Fractals*/
        {color(205, 148, 215), color(255, 255, 255)}, /*Festa al terrat*/
        {color(53, 146, 119), color(248, 177, 53)}, /*No t'ho mereixes*/
        {color(47, 221, 219), color(255, 255, 255)}, /*Índica*/
        {color(sin(i*0.01 + millis())*240, sin(i*0.059 + millis())*200, sin(i*0.01 + millis())*255), color(sin(i*0.01 + millis())*240, sin(i*0.059 + millis())*200, sin(i*0.01 + millis())*255) }, /*Seahorses, verds_violetes_colors*/
        {color(234, 236, 27), color(184, 40, 111)}, /*Cap Parat*/
        {color(0, 0, 0), color(0, 0, 0)}}; /*Negre*/
      /*{color(255, 255, 255), color(184, 40, 71)}, Era Glacial*/
      /*{color(144, 247, 53), color(184, 40, 111)}, SeaHorses*/

      stroke(colm[x][y], m);
    }
  }
}