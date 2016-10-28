class Game { 
  // metade de um pixel por frame gravity.
  private float gravidade;
  // posiçao que representara o "chao" do jogo
  private float ground;
  private int h, w; 
  
  Game(float gravidade, float ground, int h, int w) { 
    this.gravidade = gravidade;
    this.ground = ground;
    this.h = h;
    this.w = w;
  }
}