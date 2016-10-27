/* 
 * Implementaçao feita cumprindo os requisitos do Projeto Final.
 * DISCIPLINA: Lógica de Programação – Turma 01 – 2016.2
 * PROFESSOR : Orivaldo V. de Santana Jr.
 * ETAPAS    : 1, 2, 3, 4, 5.
 *
 * OBS:  
 * 1) As coordenadas da tela consideram o canto superior 
 * esquerdo como o ponto (0,0), e a unidade de tudo isso é pixels.
 * 2) Definimos 'd' como sendo o movimento 'FRENTE' (sentido direita) e 'a' como 'TRAS' (sentido esquerda).
 * 3) O sentido 'direita' é representado com valor 1, e o sentido 'esquerda' com -1.
 * 3) Substituimos o objeto elipse por uma imagem. 
*/

// global var
Player player;
Obstacle[] obstaculos; 

float esquerda;
float direita;
float up;
float down;

// metade de um pixel por frame gravity.
float gravidade = .5;
// coordenada Y do chao para colisao
float ground = 450;
// diment
int h = 500, w = 800;  

//********* variaveis de posiçao   
int p1_x = w/2, p1_y = 0, p2_x = w/2, p2_y = h;

/* setup(): é rodada uma vez só, e é usada pra declarações 
 * iniciais como tamanho da tela, fundo, frameRate, etc.
 */
void setup() 
{
  // setando informaçoes do player
  player = new Player();
  player.posicao = new PVector(50, ground); 
  player.velocidade = new PVector(0, 0);
  player.velocidadeSalto = 10;
  player.velocidadeMovimento = 4; 
  player.icon = loadImage("ball-icon.png");
  player.vida = 10;
  
  
  Obstacle o1 = new Obstacle();
  o1.icon = loadImage("stone-icon.png");
  o1.posicao = new PVector(750, ground - 10);
  o1.velocidade = 2;
  o1.flagToShow = true;
  o1.tempToShow = 5;
  o1.contTemp = 0;  
  
  obstaculos = new Obstacle[1];
  obstaculos[0] = o1; 
  
  // função size() é o que define o tamanho da janela
  size(800, 500);
  
  // função background() é o que define a cor do fundo
  background(170);
  frameRate(25);
}

/** keyPressed(): detecta tecla pressionada
 * As variaveis UP, DOWN, LEFT, e RIGHT ja sao 
 * fornecidas como 'variaveis de ambiente' do processing.
 */
void keyPressed()
{
  if (key == 'd') {
    direita = 1; 
  } else if (key == 'a') {
    esquerda = -1; 
  } else if (key == ' ') {
    up = -1;
  } 
}

void keyReleased()
{
  if (key == 'd') {
    direita = 0;
  } else if (key == 'a') {
    esquerda = 0;
  } else if (key == ' ') {
    up = 0;
  }
}

 
void draw_obstacle() {    
  for (int i = 0; i < obstaculos.length; i++) {
    Obstacle o = obstaculos[i];
    
    if (checkCollision(o)) { 
      player.vida--; 
      text("Vida: " + player.vida, 10, 30);
    }
    
    if (o.contTemp == o.tempToShow) {
      o.contTemp = 0;
      o.flagToShow = true;
      continue;
    }
    
    if (o.flagToShow) {
      o.posicao.x -= o.velocidade;
      image(o.icon, o.posicao.x, o.posicao.y);
    } else {
      o.contTemp++;
    }
    
    if (o.posicao.x < 0) {
      o.posicao.x = 750;
      o.tempToShow = 1 + (int)random(5);
      o.flagToShow = false;
    }
  } 
}

void draw_line() {
  // o contorno vai ser um verde
  stroke(60, 150, 60);
  // 3 pixels de espessura 
  strokeWeight(3);
  // a linha que desenhamos vai do ponto (100, 300) ao ponto (400, 400)
  line(p1_x, p1_y, p2_x, p2_y);
}

void draw_player() {
  // Se o player estiver sobre o chao (player.posicao.y < ground), a gravidade é aplicada nele.
  // Note que usei < aqui porque subindo o valor y diminui ja que a posicao (0,0) é o topo esquedo da tela.
  if (player.posicao.y < ground) 
    player.velocidade.y += gravidade;
  else
    player.velocidade.y = 0; 
  
  // si o player estiver no chao e clicar para pular
  // a velocidade Y do player vai ser diminuida da velocidade do salto 
  if (player.posicao.y >= ground && up != 0) 
    player.velocidade.y = -player.velocidadeSalto;
  
  // regular o valor da velocidade.x considerando a desvios a esquerda e a direita
  player.velocidade.x = player.velocidadeSalto * (esquerda + direita);
  
  // fazemos a adiçao de vetores para obtermos o vetor da proxima posiçao
  // posicao atual + vetor velocidade === vga
  PVector nova_posicao = new PVector(player.posicao.x, player.posicao.y);
  nova_posicao.add(player.velocidade);
  
  // conferir se houve colisao com os cantos da tela
  float offset = 0;
  if (nova_posicao.x > offset && nova_posicao.x < (width - offset)) {
    player.posicao.x = nova_posicao.x;
  } 
  if (nova_posicao.y > offset && nova_posicao.y < (height - offset)) {
    player.posicao.y = nova_posicao.y;
  } 
  
  pushMatrix();
  translate(player.posicao.x, player.posicao.y);
  image(player.icon, 0, 0); 
  popMatrix();
}


boolean checkCollision(Obstacle o) { 
  if (dist(player.posicao.x, player.posicao.y, o.posicao.x, o.posicao.y) <= 15)  return true;
  return false;
}

/** draw(): é rodada em loop, uma vez a cada frame
*/
void draw()
{ 
  // a próxima forma que ele desenhar não vai ter nenhum preenchimento
  noFill();
  // reseto o background para nao deixar rastro de círculos a cada quadro processado
  background(100);
  
  textSize(32);
  text("Vida: " + player.vida, 10, 30);
  fill(255, 255, 255);
   
  
  draw_player();
  draw_obstacle();
  draw_line(); 
}