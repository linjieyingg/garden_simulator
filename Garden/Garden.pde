/*         
GARDEN SIMULATOR
WASD to move 
1 to equip hoe, 2 to equip watering can, 3 to equip seed
E to fill watering can ( MUST BE NEAR WATER )
Click area next to player to use hoe/water 
*/
int fseeds;
int cseeds;
int fruit;
int corn;
int money;
Land[][] map = new Land[35][25];
int curItem;
int size = 32;
int w, h;

PImage river;
PImage grass;
PImage border;
PImage coin;
Player me;

PImage[] itemPics ; 
Land area;
PFont chandas;

void setup(){
  background(169,206,150);
  size(1120,800);
  chandas = createFont("Bold", 12);
  w = width/size;
  h = height/size;
  river = loadImage("Water.png");
  grass = loadImage("Grass.png");
  border = loadImage("grassborder.png");
  coin = loadImage("coin.png");
  fseeds = 3;
  cseeds = 3;
  corn = 0;
  fruit = 0;
  money = 50;
  me = new Player();
  itemPics = new PImage[]{loadImage("hoe.png"),loadImage("water bucket.png"),
                              loadImage("fruit seeds.png"), loadImage("corn seeds.png"),
                              loadImage("fruit icon.png"), loadImage("corn icon.png")};
  area = new Land();
}

void draw(){
  drawRiver();
  area.plot();
  drawBorder();
  drawGrid();
  drawPlayer();
  drawItems();
  drawMoney();
  frameRate(20);
  
}

void drawItems(){
  fill(255);
  strokeWeight(3);
  stroke(149,104,47);
  rect(size * 22, 704 , size * 12, size * 2);
   for (int i = 0; i < 6; i++){
    image(itemPics[i], size * (22.2 + 2* i), 712, size * 1.5, size * 1.5);
  }
  noFill();
  strokeWeight(3);
  stroke(255,247,0);
  textFont(chandas);
  if(me.nothing != true){
    float tempx = 0;
    if(me.hoe == true)
      tempx = 22.1;
    else if(me.can == true){
      tempx = 24;
      fill(0, 0, 0);
      text(me.getWater(), 814, 762);
    }
    else if(me.fseed == true){
      tempx = 26;
      fill(0);
      text(fseeds, 880, 762);
    }
    else if(me.cseed == true){
      tempx = 28;
      fill(0);
      text(cseeds, 944, 762); 
    }
    noFill();
    rect(size * tempx, 707 , size * 1.8, size * 1.8);
  }
  
  //SELL BUTTON
  stroke(249,224,85);
  strokeWeight(5);
  fill(247,230,134);
  rect(size * 2, size * 22, size * 4, size * 2);
  fill(255);
  textSize(25);
  text("sell fruit", size * 2.3, size * 23.4);
}

void drawMoney(){
  image(coin, 16, 640, 32,32);
  text(money, 18, 638);
}

void drawPlayer(){
  me.drawPlayer();
}

void drawRiver(){
  for(int x = 0 ; x < width; x+= 128){
    for(int y = 546; y < height; y += 32){
      image(river, x, y, 128, 32);
    }
  }
}

void drawBorder(){
  /*for(int x = 0 ; x < width; x+= 32){
    for(int y = 0; y < 576; y += 32){
      image(grass, x, y, 96, 32);
    }
  }*/
  for(int x = 0; x < width; x += 2080){
    image(border, x, 576, 3000, 15);
  }
}


void drawGrid(){
  for(int x = 0; x < width; x += size){ 
      stroke(255);
      strokeWeight(1);
      line(x, 0, x, height);
  }
  for(int y = 0; y < height; y += size){
    stroke(255);
    line(0,y,width, y);
  }
}

void mouseClicked(){
    //*MAKE THE GRASS INTO DIRT
    int col = mouseX / size;
    int row = mouseY / size;
    if ( row < 18 && col < 35){
      if( me.inRange(row, col) &&
          me.getHoe() && area.returnPlot(row,col) == 0){
            area.changePlot(row,col);
            //area.plot();
      }
      if ( me.inRange(row,col) && me.getfSeed() && fseeds > 0 && area.returnPlot(row,col) == 1){
        area.changePlot(row,col);
        fseeds--;
        //area.plot();
      }
      if ( me.inRange(row,col) && me.getcSeed() && cseeds > 0 && area.returnPlot(row,col) == 1){
        area.changePlotCorn(row,col);
        cseeds--;
      }
      if(me.getCan() && (area.returnPlot(row,col) > 1 && area.returnPlot(row,col) < 5) 
        && me.getWater() > 0 && me. inRange(row,col)){
        area.changePlot(row,col);
        //area.plot();
        me.useWater();
      }
      if(me.getCan() && (area.returnPlot(row,col) > 5 && area.returnPlot(row,col) < 9) 
        && me.getWater() > 0 && me.inRange(row,col)){
        area.changePlotCorn(row,col);
        me.useWater();
      }
      
      if(me.getN() && area.returnPlot(row,col) == 5){
         area.changePlot(row,col);
         fruit++;
      }
      
      if(me.getN() && area.returnPlot(row,col) == 9){
         area.changePlot(row,col);
         corn++;
      }
    }
   if(row > 22 && row <=24 && col > 2 && col < 7){
     if (fruit > 0){
       fruit--;
       money += 20;
     }
     else if (corn > 0){
       corn--;
       money += 45;
     }
   }
}

void keyPressed (){
  if((key == 'W' || key == 'w') && me.getPos().y > 0){
    me.direction(0); // up
    area.stepOn( me.getGridPos());
  }
  if((key == 'S' || key == 's') && me.getPos().y <= 512){
    me.direction(1); // down
    area.stepOn( me.getGridPos());
  }
  if((key == 'A' || key == 'a') && me.getPos().x > 0){
    me.direction(2); //left
    area.stepOn( me.getGridPos());
  }
  if((key == 'D' || key == 'd') && me.getPos().x < width - size){
    me.direction(3); //right
    area.stepOn( me.getGridPos());
  }
  if(key == '1'){
    me.equip(1);
  } 
  if(key == '2'){
    me.equip(2);
  }
  if(key == '3'){
    me.equip(3);
  }
  if(key == '4'){
    me.equip(4); 
  }
  if(key == 'e' || key == 'E'){
    if(me.getCan() && me.getPos().y == 544){
      me.fillWater();
    }
  }
}
