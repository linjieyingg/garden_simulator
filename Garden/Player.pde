public class Player{
  PImage[] charImg = new PImage[]{ loadImage("up.png"), loadImage("down.png"),
                                  loadImage("left.png"), loadImage("right.png"),
                                  loadImage("hoeB.png"), loadImage("hoeF.png"),
                                  loadImage("hoeL.png"), loadImage("hoeR.png"),
                                  loadImage("canB.png"), loadImage("canF.png"),
                                  loadImage("canL.png"), loadImage("canR.png")};  
  int curImg; // to access PImage in the array
  PVector pos; //position of character
  PVector gridPos;
  PVector dir = new PVector(0,0);
  int size = 32;
  int water; // # of plants player can water
  boolean nothing, hoe, can, seed; //equipped status
  
  public Player(){
    curImg = 1;
    pos = new PVector(size * 10, 10 * size);
    gridPos = new PVector(pos.x / size, pos.y / size);
    hoe = can = seed = false; 
    nothing = true;
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
    if(hoe && can && seed == false)
      nothing = true;
  }
  boolean getN(){
    return nothing;
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
  
  void useWater(){
   if (water > 0)
     water--; 
  }
  
  void drawPlayer(){
    // change image based on direction
    //canL
    if(curImg == 10)
      image(charImg[curImg], pos.x - size, pos.y, 64, 32); 
    else if (curImg == 11 )
      image(charImg[curImg], pos.x , pos.y, 64, 32);
    else if (curImg == 4)
      image(charImg[curImg], pos.x , pos.y - 12, 32, 44);
    else if (curImg == 5)
      image(charImg[curImg], pos.x - 12, pos.y, 44, 32);
    else if (curImg == 6)
      image(charImg[curImg], pos.x , pos.y - 10, 40, 42);
    else if (curImg == 7)
      image(charImg[curImg], pos.x - 8, pos.y - 10, 40, 42);
    else image(charImg[curImg], pos.x, pos.y, 32, 32); 
  }
  
  PVector getPos(){
    return pos;
  }
  

  void updatePos(){
    // calculate new pos of player 
    pos = new PVector(pos.x + (dir.x * size), pos.y + (dir.y * size));
  }
  
  PVector getGridPos(){
     return gridPos;
  }
  
  boolean inRange(){
    int row = mouseY / size;
    int col = mouseX /size;
    if (abs(col - gridPos.x) <= size && abs(row - gridPos.y) <= size 
    && (row != gridPos.y || col != gridPos.x))
      return true;
    else return false;
  }
  

  void direction(int d){
    if( d == 0 ) { 
      dir = new PVector(0,-1); //up
      if( hoe == true)
        curImg = 4;
      else if ( can == true)
        curImg = 8;
      else curImg = 0; 
      updatePos();
    }
    if( d == 1) {
      dir = new PVector(0,1); //down
      if( hoe == true)
        curImg = 5;
      else if ( can == true)
        curImg = 9;
      else curImg = 1;
      updatePos();
    }
    if( d == 2){
      dir = new PVector(-1,0); //left
      if( hoe == true)
        curImg = 6;
      else if ( can == true)
        curImg = 10;
      else curImg = 2;
      updatePos();
    }
    if( d == 3){
      dir = new PVector(1,0); //right
      if( hoe == true)
        curImg = 7;
      else if ( can == true)
        curImg = 11;
      else curImg = 3;
      updatePos();
    }
  }
}
