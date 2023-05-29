public class Land {
  PImage[] stage = new PImage[]{ loadImage("Grass.png"), 
    loadImage("dirt square.png"),
    loadImage("fruit bud.png"), loadImage("fruit sprout.png"),
    loadImage("fruit young.png"),loadImage("fruit adult.png"),
    loadImage("corn bud.png"), loadImage("corn sprout.png"),
    loadImage("corn young.png"), loadImage("corn adult.png")
    };
  
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
        if (plot[h][w] >= 1)
          image(stage[1], w * size, h * size, size, size);
        if (plot[h][w] == 2)
          image(stage[2], w * size + 8, h * size + 14, size - 16, size-16);
        if (plot[h][w] == 3)
          image(stage[3], w * size + 4, h * size + 7, size- 8, size-8);
        if (plot[h][w] == 4)
          image(stage[4], w * size + 2, h * size + 3, size - 4, size - 4);
        if (plot[h][w] == 5)
          image(stage[5], w * size + 4, h * size + 3, size-6, size-4);
      }
    }
  }
  void changePlot(int row, int col ){
    if(plot[row][col] == 5)
      plot[row][col] = 1;
    else plot[row][col]++;
  }

  void changePlotCorn(int row, int col){
    if(plot[row][col] == 9)
      plot[row][col] = 1;
    if(plot[row][col] == 1)
      plot[row][col] = 6;
    else plot[row][col]++;
  }
  
  int returnPlot(int row, int col){
    return plot[row][col];
  }
  
}
