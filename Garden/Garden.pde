int water;
int seeds;
String[] items = new String[]{"nothing", "seed", "water", "shovel"};
int curItem;
int size = 32;
int w, h;
// inRange variable and click to change

PImage river;

void setup(){
  background(169,206,150);
  size(1120,800);
  w = width/size;
  h = height/size;
  river = loadImage("Water.png");
}

void draw(){
  drawRiver();
  drawGrid();
}

void drawRiver(){
  for(int x = 0 ; x < width; x+= size){
  for(int y = 546; y < height; y += size){
    
    image(river, x, y, 128, 32);
  }
  }
}

void drawGrid(){
  for(int x = 0; x < width; x += size){ 
      stroke(255);
      line(x, 0, x, height);
  }
  for(int y = 0; y < height; y+= size){
    stroke(255);
    line(0,y,width, y);
  }
}
