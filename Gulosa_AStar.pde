import controlP5.*;
import java.util.Comparator;
import java.util.PriorityQueue;
import static javax.swing.JOptionPane.*;

//Alunos: Luciano Rodrigues Lucio Neto e Emerson Vilar de Oliveira

Gulosa g;
Astar a;
Box[][] campo;
Elemento[][] matriz;
int[][] loop;
ControlP5 cp5;
int option, metodo = 1;
CheckBox checkbox;

ArrayList<Elemento> vizinhos;
ArrayList<Elemento> aberta;
ArrayList<Elemento> fechada;
ArrayList<Elemento> pais;
ArrayList<Elemento> caminho;

//int[] dx = {1, 1, 0, -1, -1, -1, 0, 1};
//int[] dy = {0, 1, 1, 1, 0, -1, -1, -1};

//int[] dx = {1, 0, -1, 0};
//int[] dy = {0, 1, 0, -1};

void setup() {
  size(800, 600);
  background(230);
  g = new Gulosa();
  a = new Astar();
  cp5 = new ControlP5(this);
  matriz = new Elemento[20][20];
  vizinhos = new ArrayList<Elemento>();
  aberta = new ArrayList<Elemento>();
  fechada = new ArrayList<Elemento>();
  pais = new ArrayList<Elemento>();
  caminho = new ArrayList<Elemento>();
  criarCampo();
  criarMenu();
  setMatriz();
  
 // loop = new int[20][20];
}

void draw() {
  for(int i = 0; i < 20; i++) {
    for(int j = 0; j < 20; j++) {
      campo[i][j].draw();
    }
  }
}

void setMatriz(){
  for(int i = 0; i < 20; i++) {
    for(int j = 0; j < 20; j++) {
      Elemento e = new Elemento(1, i, j, false, false, false, null);
      matriz[i][j] = e;
    }
  }
}

void criarCampo() {
  campo = new Box[20][20];
  int x = 0, y = 0, w = 30, h = 30;
  for(int i = 0; i < 20; i++) {
    for(int j = 0; j < 20; j++) {
      campo[i][j] = new Box(i*w, j*h, w, h); 
    }
  }
}

void mouseClicked() {
  if(mouseX >= 0 && mouseX <= 600 && mouseY >= 0 && mouseY <= 600) {
    float[] c = checarCaixa(mouseX, mouseY);
    int i = (int)c[0], j = (int)c[1];
    if(option == 0){
        campo[i][j].changeColor(139, 37, 0);
        matriz[i][j].setParede();
      } else if(option == 1){
        campo[i][j].changeColor(0, 191, 255);
        matriz[i][j].setInicio();
        matriz[i][j].pai = matriz[i][j];
      } else if(option == 2){
        campo[i][j].changeColor(61, 145, 64);
        matriz[i][j].setFim();
      } else if(option == 5){
        campo[i][j].changeColor(255, 255, 255);
        matriz[i][j].Erase();
      } else if(option == 6){
        
      }
      
      println("heuristica: " + matriz[(int)c[0]][(int)c[1]].heuristica + ", " + "indX: " + 
      matriz[(int)c[0]][(int)c[1]].indiceX + ", " + "indY: " + matriz[(int)c[0]][(int)c[1]].indiceY + ", "
      + "parede: " + matriz[(int)c[0]][(int)c[1]].parede + ", " + "inicio: " + matriz[(int)c[0]][(int)c[1]].inicio
       + ", " + "fim: " + matriz[(int)c[0]][(int)c[1]].fim);
  }
}

float[] checarCaixa(float x, float y) {
  float[] coordenadas = new float[2];
  coordenadas[0] = map(x, 0, 600, 0, 20);
  println(x + " -> " + coordenadas[0]);
  coordenadas[1] = map(y, 0, 600, 0, 20);
  println(y + " -> " + coordenadas[1]);
  return coordenadas;
}

void criarMenu() {
  cp5.addButton("Parede")
     .setValue(0)
     .setPosition(650, 10)
     .setSize(100, 50);
     
  cp5.addButton("Inicio")
     .setValue(1)
     .setPosition(650, 80)
     .setSize(100, 50);
     
  cp5.addButton("Final")
     .setValue(2)
     .setPosition(650, 150)
     .setSize(100, 50);
     
  cp5.addButton("Busca Gulosa")
     .setValue(3)
     .setPosition(650, 220)
     .setSize(100, 50);
     
  cp5.addButton("Busca A*")
     .setValue(4)
     .setPosition(650, 290)
     .setSize(100, 50);
     
  cp5.addButton("Borracha")
     .setValue(5)
     .setPosition(650, 460)
     .setSize(100, 50);
     
  cp5.addButton("Reiniciar")
      .setValue(7)
     .setPosition(650, 520)
     .setSize(100, 30);
     
  cp5.addButton("Limpar")
     .setValue(6)
     .setPosition(650, 560)
     .setSize(100, 30);
     
  checkbox = cp5.addCheckBox("checkbox")
                .setPosition(650, 380)
                .setColorBackground(color(255, 255, 255))
                .setColorForeground(color(120))
                .setColorActive(color(0))
                .setColorLabel(color(0))
                .setSize(30, 30)
                .addItem("Mostrar Caminho", 0);

}

public void controlEvent(ControlEvent theEvent) {
  
  if(theEvent.isFrom(checkbox)) {
    println("Teste"); 
    if(metodo == 1){
      g.executarGulosa(); 
    } else{
      a.executarAstar(); 
    }
  }
  
  Button b = (Button) theEvent.getController();
  
  int v = (int) theEvent.getController().getValue();
  if(v == 0) {
    option = 0;
  } else if(v == 1) {
    option = 1;
  } else if(v == 2) {
    option = 2;
  } else if(v == 3) {
    //gulosa
    g.executarGulosa();
    metodo = 1;
  } else if(v == 4) {
    //Aestrela
    a.executarAstar();
    metodo = 2;
  } else if(v == 5){
    option = 5;
  } else if(v == 6){
    option = 6;
    limpar();
  } else if(v == 7){
    reiniciar(); 
  }
  
}
  
 //<>// //<>//

void setFinalCost() {
  for(int i = 0; i < 20; i++) {
    for(int j = 0; j < 20; j++) {
      matriz[i][j].finalCost = matriz[i][j].heuristica + matriz[i][j].distancia; 
    }
  }
}

void setHeuristicas(){
    for(int i=0; i<20; i++){
      for(int j = 0; j<20; j++){
        matriz[i][j].heuristica = sqrt( pow( (getFinal().indiceX - matriz[i][j].indiceX), 2) + pow( (getFinal().indiceY - matriz[i][j].indiceY), 2) );
      }
    }
  }
  
  void setDistancias(){
    for(int i=0; i<20; i++){
      for(int j = 0; j<20; j++){
        matriz[i][j].distancia = sqrt( pow( (getInicio().indiceX - matriz[i][j].indiceX), 2) + pow( (getInicio().indiceY - matriz[i][j].indiceY), 2) );
      }
    }
  }
  
  Elemento getInicio() {
  for(int i=0; i<20; i++){
    for(int j=0; j<20; j++){
      if(matriz[i][j].inicio == true){
        return matriz[i][j];        
      }
    }
  }
  return null;
}
  
  Elemento getFinal(){
    for(int i=0; i<20; i++){
      for(int j=0; j<20; j++){
        if(matriz[i][j].fim == true){
          return matriz[i][j];        
        }
      }
    }
    return null;
  }
  
  
  void limpar(){
    for(int i = 0; i < 20; i ++){
      for(int j = 0; j < 20; j++){
        matriz[i][j].Erase();
        campo[i][j].changeColor(255, 255, 255);
      }
    }
    
    caminho.clear();
    fechada.clear();
    
  }
  
  void reiniciar(){
    
    Elemento in = new Elemento();
    Elemento f = new Elemento();
    
    for(int i = 0; i < 20; i ++){
      for(int j = 0; j < 20; j++){
        if(matriz[i][j] == getInicio()){
          in = matriz[i][j];
          matriz[i][j].Erase();
          campo[i][j].changeColor(255, 255, 255);
        }
        if(matriz[i][j] == getFinal()){
          f = matriz[i][j];
          matriz[i][j].Erase();
          campo[i][j].changeColor(255, 255, 255);
        }
        if(matriz[i][j].parede == false){
          matriz[i][j].Erase();
          campo[i][j].changeColor(255, 255, 255);
        }
      }
    }
    
    in.setInicio();
    f.setFim();
    campo[in.indiceX][in.indiceY].changeColor(0, 191, 255);
    campo[f.indiceX][f.indiceY].changeColor(61, 145, 64);
    
    caminho.clear();
    fechada.clear();
    
  } //<>// //<>//
  