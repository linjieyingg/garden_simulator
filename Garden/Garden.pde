int water;
int seeds;
String[] items = new String[]{"nothing", "seed", "water", "shovel"};
int curItem;
int size = 40;
int w, h;
// inRange variable and click to change

PVector pos;
PVector dir = new PVector(0,0);

void setup(){
  background(169,206,150);
  size(1080,720);
  w = width/size;
  h = height/size;
  PImage river = createImage(
}

boolean inRange(){
  if( abs(mouseX - pos.x) <= size && abs(mouseY - pos.y) <= size)
    return true;
  else return false;
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
