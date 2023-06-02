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
double priceF, priceC;
int money;
int curItem;
int size = 32;
int w, h;
Land[][] map = new Land[width/size][height/size];

PImage river;
PImage grass;
PImage border;
PImage coin;
Player me;

PImage[] itemPics ; 
Land area;
PFont chandas;
PImage box;

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
  box = loadImage("dialog.png");
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
  image(loadImage("inventory.png"), size * 11.1, 695, size * 14, size * 2.75);
   for (int i = 0; i < 6; i++){
    image(loadImage("item box.png"), size * (11.95 + 2 * i) , 705, size * 2, size * 2);
    image(itemPics[i], size * (12.2 + 2* i), 712, size * 1.5, size * 1.5);    //putting all the item icons
  }
  noFill();
  strokeWeight(3);
  stroke(255,247,0);
  textFont(chandas);
  fill(0);
  text(fruit, 690, 762);
  text(corn, 750, 762);
  if(me.nothing != true){
    float tempx = 0;
    if(me.hoe == true)
      tempx = 12.1;
    else if(me.can == true){
      tempx = 14;
      fill(0, 0, 0);
      text(me.getWater(), 495, 762);
    }
    else if(me.fseed == true){
      tempx = 16;
      fill(0);
      text(fseeds, 560, 762);
    }
    else if(me.cseed == true){
      tempx = 18;
      fill(0);
      text(cseeds, 624, 762); 
    }
    image(loadImage("select box.png"),size * tempx - 4, 705 , size * 2, size * 2);
  }
  
  //SELL BUTTON
  stroke(149,104,47);
  strokeWeight(3);
  fill(247,230,134);
  rect(size * 2, size * 22, size * 4, size * 2);
  fill(255);
  textSize(25);
  text("sell fruit", size * 2.4, size * 23.4);
}

void drawMoney(){
  image(coin, 16, 640, 32,36);
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

void step(){
    image(box, me.pos.x + size, me.pos.y, 176, 48);
}


void buy(){
   
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
    if (area.canStep(me.getGridPos())){
      area.stepOn(me.getGridPos());
      //step();
    }
  }
  if((key == 'S' || key == 's') && me.getPos().y <= 512){
    me.direction(1); // down
    if (area.canStep(me.getGridPos())){
      area.stepOn(me.getGridPos());
      step();
    }
  }
  if((key == 'A' || key == 'a') && me.getPos().x > 0){
    me.direction(2); //left
    if (area.canStep(me.getGridPos())){
      area.stepOn(me.getGridPos());
      step();
    }
  }
  if((key == 'D' || key == 'd') && me.getPos().x < width - size){
    me.direction(3); //right
    if (area.canStep(me.getGridPos())){
      area.stepOn(me.getGridPos());
      step();
    }
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
