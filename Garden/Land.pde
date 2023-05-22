<<<<<<< HEAD

//THINGS TO NOTE
//IF LAND TYPE IS WATER YOU CANNOT CHANGE IT
//THE IMAGE PLACED ON THE SQUARE WHEN TYPE IS PLANT IS STILL JUST DIRT

public class Land{
  String[] type = new String[]{"water", "grass", "dirt", "plant"};
  int curType;
  public Land(int type){
    curType = type;
  }
  public void changeLand(){
    if (curType == 0) break;
    if(curType 
     
  }
=======
public class Land {
  PImage[] stage = new PImage[]{ loadImage("Grass.png"), 
    loadImage("dirt square.png"),
    loadImage("fruit bud.png"), loadImage("fruit sprout.png"),
    loadImage("fruit young.png"),loadImage("fruit adult.png")};
  
  int[][] plot = new int[18][35];
  
  int curStage;
  int size = 32;

  public Land(){
     curStage = 0;
     for (int[] a : plot){
       for(int b : a){
         b = 0;
       }
     }
  }
  
  void changeStage(int n){
    curStage = n;
  }
  
  void plot(){
    for(int h = 0; h < plot.length; h++){
      for(int w = 0; w < plot[h].length ; w++){
        if(plot[h][w] == 0)
          image(stage[0], w * size , h * size, size, size);
        else if (plot[h][w] == 1)
          image(stage[1], h * size, w * size, size, size);
        else if (plot[h][w] == 2)
          image(stage[2], h * size, w * size, size, size);
        else if (plot[h][w] == 3)
          image(stage[3], h * size, w * size, size, size);
        else if (plot[h][w] == 4)
          image(stage[4], h * size, w * size, size, size);
        else if (plot[h][w] == 5)
          image(stage[5], h * size, w * size, size, size);
      }
    }
  }
  void changePlot(int row, int col ){
    if(plot[row][col] == 5)
      plot[row][col] = 1;
    plot[row][col]++;
  }
  
  int returnPlot(int row, int col){
    return plot[row][col];
  }
  
>>>>>>> 7ae13c2b0969612c693c52da73f3e669e8523c52
}
