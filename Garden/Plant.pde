public class Plant{
  PImage[] stage = new PImage[]{loadImage("fruit bud.png"),loadImage("fruit sprout.png"), loadImage("fruit young.png"), loadImage("fruit adult.png")};
  int curStage;
  int size = 32;
  public Plant(PVector pos){
     w = width/size;
     h = height/size;
     curStage = 0;
     image(stage[curStage], pos.x, pos.y, size, size);
  }
}
