int water;
int seeds;
String[] items = new String[]{"nothing", "seed", "water", "shovel"};
int curItem;
int size = 32;
int w, h;
// inRange variable and click to change

PImage river;
PImage grass;

void setup(){
  background(169,206,150);
  size(1120,800);
  w = width/size;
  h = height/size;
  river = loadImage("Water.png");
  grass = loadImage("Grass.png");
}

void draw(){
  drawGrass();
  drawRiver();
  drawGrid();
}

void drawRiver(){
  for(int x = 0 ; x < width; x+= 256){
    for(int y = 546; y < height; y += 64){
      image(river, x, y, 256, 64);
    }
  }
}

void drawGrass(){
  for(int x = 0 ; x < width; x+= 32){
    for(int y = 0; y < 546; y += 32){
      image(grass, x, y, 96, 32);
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
  
void keyPressed (){
    if(key == 'W' || key == 'w' )
      dir = new PVector(0, -1);
    if(key == 'S' || key == 's')
      dir = new PVector(0,1);
    if(key == 'A' || key == 'a')
      dir = new PVector(-1, 0);
    if(key == 'D' || key == 'd')
      dir = new PVector(1,0);
}
