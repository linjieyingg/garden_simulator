public class Player{
  PImage[] charImg = new PImage[]{ loadImage("up.png"), loadImage("down.png"),
                                  loadImage("left.png"), loadImage("right.png")};  
  int curImg; // to access PImage in the array
  PVector pos; //position of character
  PVector dir = new PVector(0,0);
  
  public Player(){
    curImg = 1;
    pos = new PVector(width/2,height/2);
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
}
