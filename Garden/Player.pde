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
  int nDir;
  int size = 32;
  int water; // # of plants player can water
  boolean nothing, hoe, can, fseed, cseed; //equipped status
  
  public Player(){
    curImg = 1;
    nDir = 1;
    pos = new PVector(size * 10, 10 * size);
    gridPos = new PVector(pos.x / size, pos.y / size);
    print(gridPos);
    hoe = can = fseed = cseed = false; 
    nothing = true;
  }
  
  void equip( int hcs){
    if (hcs == 2 && can == false){
      can = true;
      curImg = nDir + 8;
    }
    else {
      can = false;
      nothing = true;
    }
    if (hcs == 1 && hoe == false){
      hoe = true;
      curImg = nDir + 4;
    }
    else { 
      hoe = false;
      nothing = true;
    }
    if (hcs == 3 && fseed == false){
      fseed = true;
      curImg = nDir;
    }
    else {
      fseed = false;
      nothing = true; 
    }
    if (hcs == 4 && cseed == false){
      cseed = true;
      curImg = nDir;
    }
    else {
      cseed = false; 
      nothing = true;
    }
    if(hoe || can || fseed || cseed == true)
      nothing = false;
    if(nothing == true)
      curImg = nDir;
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
  
  boolean getfSeed(){
   return fseed; 
  }
  
  boolean getcSeed(){
    return cseed;
  }
  
  void fillWater(){
    while ( water < 5)
      water ++;
  }
  
  void useWater(){
   if (water > 0)
     water--; 
  }
  
  int getWater(){
    return water; 
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
      image(charImg[curImg], pos.x - 16, pos.y, 48, 32);
    else if (curImg == 6)
      image(charImg[curImg], pos.x , pos.y - 10, 40, 42);
    else if (curImg == 7)
      image(charImg[curImg], pos.x - 8, pos.y - 10, 40, 42);
    else if (curImg == 9)
      image(charImg[curImg], pos.x - 4, pos.y , 36, 36);
    else if (curImg == 2)
      image(charImg[curImg], pos.x + 4, pos.y, 28, 32);
    else if (curImg == 3)
      image(charImg[curImg], pos.x , pos.y, 28, 32);
    else image(charImg[curImg], pos.x , pos.y, 32, 32); 
  }
  
  PVector getPos(){
    return pos;
  }
 
  private void updatePos(){
    // calculate new pos of player 
    pos = new PVector(pos.x + (dir.x * size), pos.y + (dir.y * size));
   /* 
    if(curImg == 5)
      gridPos = new PVector((pos.x + 16)/ size, pos.y / size);
    else if (curImg == 4)
      gridPos = new PVector(pos.x / size, (pos.y + 16)/ size);
    else if (curImg == 6)
      gridPos = new PVector(pos.x / size, (pos.y + 16)/ size);
    else if (curImg == 7)
      gridPos = new PVector(pos.x / size, (pos.y + 16)/ size);
    else if (curImg == 9)
      gridPos = new PVector((pos.x + 8)/ size, pos.y / size);
    else if (curImg == 10)
      gridPos = new PVector((pos.x + 32)/ size, pos.y / size);
    else */
    gridPos = new PVector(pos.x / size, pos.y / size);
    
  }
  
  PVector getGridPos(){
    return gridPos;
  }
  
  boolean inRange(int row , int col){
    if (abs(col - gridPos.x) <= 1 && abs(row - gridPos.y) <= 1 &&
    (col - gridPos.x != 0 || row - gridPos.y != 0 ))
      return true;
    else return false;
  }
  

  private void direction(int d){
    nDir = d;
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
