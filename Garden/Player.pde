public class Player{
  PImage[] charImg = new PImage[]{ loadImage("up.png"), loadImage("down.png"),
                                  loadImage("left.png"), loadImage("right.png")};  
  int curImg; // to access PImage in the array
  PVector pos; //position of character
  PVector dir = new PVector(0,0);
  PVector gridPos; // grid position of character
  int size = 32;
  int water; // # of plants player can water
  boolean hoe, can, seed; //equipped status
  
  public Player(){
    curImg = 1;
    pos = new PVector(5 * size, 5 * size);
    gridPos = new PVector(pos.x / size, pos.y / size);
    hoe = can = seed = false; 
  }
  
  void equip( int hcs){
    if (hcs == 1 && hoe == false)
      hoe = true;
    else hoe = false;
    if (hcs == 2 && can == false)
      can = true;
    else can = false;
    if (hcs == 3 && seed == false)
      seed = true;
    else seed = false;
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
    if ( water < 5)
      water++;
  }
  
  void drawPlayer(){
    // change image based on direction
    image(charImg[curImg], pos.x, pos.y, 32, 32); 
  }
  
  PVector getPos(){
    return pos;
  }
  
  PVector getDir(){
    return dir; 
  }

  void updatePos(){
    // calculate new pos of player 
    pos = new PVector( pos.x + (dir.x * size), pos.y + (dir.y * size));
  }
  
  PVector getGridPos(){
     return gridPos;
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
      updatePos();
    }
    if( d == 1) {
      dir = new PVector(0,1); //down
      curImg = 1;
      updatePos();
    }
    if( d == 2){
      dir = new PVector(-1,0); //left
      curImg = 2;
      updatePos();
    }
    if( d == 3){
      dir = new PVector(1,0); //right
      curImg = 3;
      updatePos();
    }
  }

}
