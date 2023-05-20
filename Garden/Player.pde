public class Player{
  PImage[] charImg = new PImage[]{ loadImage("up.png"), loadImage("down.png"),
                                  loadImage("left.png"), loadImage("right.png")};  
  int curImg; // to access PImage in the array
  PVector pos; //position of character
  PVector dir = new PVector(0,0);
  int size = 32;
  int water; // # of plants player can water
  boolean hoe, can, seed; //equipped status
  
  public Player(){
    curImg = 1;
    pos = new PVector(size * 10, 10 * size);
    hoe = can = seed = false; 
  }
  
  void equip( int hcs){
    if (hcs == 1)
      hoe = true;
    if (hcs == 2)
      can = true;
    if (hcs ==3)
      seed = true;
  }
  
  boolean getHoe(){
    return hoe;
  }
  boolean getCan(){
   return can; 
  }
  boolean getSeed(){
   return seed; 
  }
  
  void fillWater(){
    water++;
  }
  
  void drawPlayer(){
    // change image based on direction
    image(charImg[curImg], pos.x, pos.y, 32, 32); 
  }
  
  PVector getPos(){
    return pos;
  }
  
  void update(){
    // calculate new pos of player 
    pos = new PVector(pos.x + (dir.x * size), pos.y + (dir.y * size));
  }
  
  boolean inRange(){
  if( abs(mouseX - pos.x) <= size && abs(mouseY - pos.y) <= size)
    return true;
  else return false;
  }
  

  void direction(int d){
    if( d == 0 ) { 
      dir = new PVector(0,-1); //up
      curImg = 0; 
      update();
    }
    if( d == 1) {
      dir = new PVector(0,1); //down
      curImg = 1;
      update();
    }
    if( d == 2){
      dir = new PVector(-1,0); //left
      curImg = 2;
      update();
    }
    if( d == 3){
      dir = new PVector(1,0); //right
      curImg = 3;
      update();
    }
  }

}
