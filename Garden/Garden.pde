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
boolean shop = false;

int curMode = 0; //0 - player On, 1 - player off
//String dialogue = "Hello, dear customer...";
//PImage buysellcheck = loadImage("inventory.png");

PImage river;
PImage grass;
PImage border;
PImage borderR;
PImage borderL;
PImage coin;
Player me;

PImage[] itemPics ; 
Land area;
PFont chandas;
PFont numbers;
PImage box;
PImage[] waterbars;
int curWater;
PImage waterdrop;

void setup(){
  background(169,206,150);
  size(1120,800);
  chandas = createFont("Bold", 25);
  numbers = loadFont("CenturySchL-Bold-12.vlw");
  w = width/size;
  h = height/size;
  river = loadImage("Water.png");
  grass = loadImage("Grass.png");
  border = loadImage("grassborder.png");
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
  waterbars = new PImage[]{loadImage("empty water bar.png"), loadImage("one water bar.png"),
  loadImage("two water bar.png"), loadImage("three water bar.png"),
  loadImage("four water bar.png"), loadImage("five water bar.png"), loadImage("full water bar.png")
  };
  waterdrop = loadImage("water drop.png");
  borderR = loadImage("right border.png");
  borderL = loadImage("left border.png");
}

void draw(){
  area.plot();
  drawRiver();
  drawBorder();
  drawGrid();
  drawItems();
  drawPlayer();
  drawtab();
  drawShop();
  frameRate(20);
  
}

void drawItems(){
  fill(255);
  strokeWeight(3);
  stroke(149,104,47);
  image(loadImage("inventory.png"), size * 11, 695, size * 14, size * 2.75);
   for (int i = 0; i < 6; i++){
    image(loadImage("item box.png"), size * (11.95 + 2 * i) , 705, size * 2, size * 2);
    image(itemPics[i], size * (12.4 + 2* i), 718, size * 1.2, size * 1.2);    //putting all the item icons
  }
  noFill();
  strokeWeight(3);
  stroke(255,247,0);
  textFont(numbers);
  fill(255);
  text(fruit, 686, 758);
  text(corn, 746, 756);
  for (int n = 1; n < 5; n++){
    text(n, 10 * size + (n * size * 2) + 10, size * 22.6);
  }
  
  if(me.nothing != true){
    float tempx = 0;
    fill(255);
    if(me.hoe == true)
      tempx = 12;
    else if(me.can == true){
      tempx = 14;
      text(me.getWater(), 490, 762);
      curWater = me.getWater();
      image(waterdrop, 31 * size, 0, 30, 40);
      image(waterbars[curWater], 32 * size, 0, 96, 40);
    }
    else if(me.fseed == true){
      tempx = 16;
      text(fseeds, 560, 762);
    }
    else if(me.cseed == true){
      tempx = 18;
      text(cseeds, 624, 762); 
    }
    image(loadImage("select box.png"), size * tempx, 706 , size * 1.9, size * 1.9);
    
  }
  text(fseeds, size * 17.5, size * 23.75);
  text(cseeds, size * 19.5, size * 23.75);
}

void drawtab(){
  textFont(chandas);
  image(loadImage("drop down menu.png"), size / 2, size / 2, size * 3.5, size * 4);
  image(loadImage("coin.png"), 25, 27, 32,36);
  text(money, size * 2.25, size * 1.7);
  text("shop", size * 1.35, size * 3.85);
  image(loadImage("down arrow.png"), size * 1.5, size * 4.5, size * 1.5, size * .85);
}

void drawShop(){
  if (shop == true){
    image(loadImage("shop menu.png"), size * 6, size, size * 20, size * 7);
    image(loadImage("seller emote.png"), size * 7.75, size * 2.5, size * 3.75, size * 3.75);
    image(loadImage("shop inventory.png"), size * 6, size * 8, size * 20, size * 6);
    image(loadImage("wood box.png"), size * 7.5, size * 8.5, size * 3, size *3);
    image(loadImage("wood box.png"), size * 11.5, size * 8.5, size * 3, size *3);
    image(loadImage("coin.png"), size * 7.75, size * 11.35, size/1.2, size);
    image(loadImage("coin.png"), size * 11.75, size * 11.35, size/1.2, size);
    //fruit seeds = 12 corn seeds = 25;
    image(loadImage("fruit seeds.png"), size * 8.35, size * 9.45, size * 1.25, size * 1.25);
    image(loadImage("corn seeds.png"), size * 12.35, size * 9.45, size * 1.25, size * 1.25);
     //IMPLEMENT IN MOUSE CLICKED?? if buy box is clicked then change to check mark and x mark,
     //change dialogue as well
    image(loadImage("inventory.png"), size * 7.9, size * 12.5, size * 2, size);
    image(loadImage("inventory.png"), size * 12, size * 12.5,size * 2, size);
    stroke(149,104,47);
    strokeWeight(3);
    //sell button
    //fill(237, 210, 168);
    //rect(size * 18, size * 10, size * 4, size * 2);
    image(loadImage("inventory.png"), size * 17.5, size * 10, size * 5, size * 2);
    fill(255);
    textSize(25);
    text("sell fruit", size * 18.4, size * 11.25);
    
    textSize(23);
    text("12", size * 8.75, size * 12.15);
    text("25", size * 12.75, size * 12.15);
    textSize(20);
    text("BUY", size * 8.25, size * 13.15);
    text("BUY", size * 12.35, size * 13.15);
    textSize(25);
    text("Hello, dear customer...", size * 14, size * 5);
    
  }
}

void drawPlayer(){
  me.drawPlayer();
}

void drawRiver(){
  for(int x = 0 ; x < 4 * size ; x+= 128){
    for(int y = 0; y < 578; y += 32){
      image(river, x, y, 128, 32);
    }
  }
  for(int x = width - 4*size ; x < width ; x+= 128){
    for(int y = 0; y < 578; y += 32){
      image(river, x, y, 128, 32);
    }
  }
  for(int x = 0 ; x < width; x+= 128){
    for(int y = 578; y < height; y += 32){
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
  for(int y = 0; y < 542; y += 32){
    image(borderR, 31 * size, y, 15, 64);
  }
  image(borderR, 31 * size, 526, 15, 64);
  for(int x = 4*size; x < width -  5*size; x += 32){
    image(border, x, 576, 64, 15);
  }
  for(int y = 0; y < 542; y += 32){
    image(borderL, 3.5* size, y, 15, 64);
  }
  image(borderL, 3.5* size, 526, 15, 64);
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
 
      if (mouseX > size / 2 && mouseY > size * 3.85 && row <= 5 && col <= 5){
        if (shop) {
          shop = false;
          curMode = 0;  
        }
        else {
          shop = true;
          curMode = 1;  
        }
    }
    }
    //sell
    //size * 17.5, size * 10, size * 5, size * 2
   if(row >= 10 && row <=12 && mouseX >= 17.5 * size && col <= 22.5 * size){
     if (fruit > 0){
       fruit--;
       money += 20;
     }
     else if (corn > 0){
       corn--;
       money += 45;
     }
   }
   //buy fruit  
   // size * 7.9, size * 12.5, size * 2, size)
   if(row >= 13 && row <= 14 && col >= 8 && col <= 10 && shop == true && money >= 12){
     fseeds++;
     money -= 12;
     //size * 12, size * 12.5,size * 2, size);
   }
   if(row >= 13 && row <= 14 && col >= 12 && col <= 14 && shop == true && money >= 25){
     cseeds++;
     money -= 25;
   }
}

void keyPressed (){
  if(curMode == 0){
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
    if((key == 'A' || key == 'a') && me.getPos().x > 4 * size){
      me.direction(2); //left
      if (area.canStep(me.getGridPos())){
        area.stepOn(me.getGridPos());
        step();
      }
    }
    if((key == 'D' || key == 'd') && me.getPos().x < width - size - 4*size){
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
}
