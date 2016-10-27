// classe para representar o jogador
class Player
{ 
  // PImage - datatype do processing para armazenar imagens
  PImage icon;
  // PVector - classe do processing para representar um vetor geometrico 
  // Este vetor é o mesmo estudado em geometria, com componente x, y, z, magnitude, direçao, etc.
  PVector posicao; 
  PVector velocidade;
  float velocidadeSalto;
  float velocidadeMovimento;
  float vida;
}