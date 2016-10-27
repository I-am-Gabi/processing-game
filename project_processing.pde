/* OBS:  As coordenadas da tela consideram o canto superior 
 * esquerdo como o ponto (0,0), e a unidade de tudo isso é pixels.
*/

//********* variaveis de posiçao
// elipse vars
int elipse_x = 50, elipse_y = 450, elipse_width = 50, elipse_height = 50;
// rect
int rect_x = 450, rect_y = 450, rect_width = 50, rect_height = 50;
// line 
int p1_x = 255, p1_y = 0, p2_x = 255, p2_y = 510;
// 
int h = 510, w = 510;

/* setup(): é rodada uma vez só, e é usada pra declarações 
 * iniciais como tamanho da tela, fundo, frameRate, etc.
 */
void setup() 
{
  // função size() é o que define o tamanho da janela
  size(h, w); 
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
  if (keyCode == UP) {
    elipse_y -= 1;
    if (elipse_y > h + elipse_height) {
      elipse_y = 0;
    }
  } else if (keyCode == DOWN) {
    elipse_y += 1;
  } else if (keyCode == LEFT) {
    elipse_x -= 1;
  } else if (keyCode == RIGHT) {
    elipse_x += 1;
  }
}

/** draw(): é rodada em loop, uma vez a cada frame
*/
void draw()
{ 
  // a próxima forma que ele desenhar não vai ter nenhum preenchimento
  noFill();
  // reseto o background para nao deixar rastro de círculos a cada quadro processado
  background(170);
  // o contorno das proximas imagens sera branca
  stroke(#FFFFFF);
  // ellipse([coordenada x],[coordenada y], [largura], [altura])
  ellipse(elipse_x, elipse_y, elipse_width, elipse_height);
  // a forma seguinte não vai ter contorno
  noStroke();
  // o preenchimento vai ser vermelho 
  fill(255, 0, 0);
  // rect([coordenada x],[coordenada y], [largura], [altura])
  rect(rect_x, rect_y, rect_width, rect_height);
  // o contorno vai ser um verde
  stroke(60, 150, 60);
  // 3 pixels de espessura 
  strokeWeight(3);
  // a linha que desenhamos vai do ponto (100, 300) ao ponto (400, 400)
  line(p1_x, p1_y, p2_x, p2_y);
}