class Elemento{
  
  int indiceX, indiceY;
  boolean parede, inicio, fim;
  float heuristica;
  float distancia;
  float finalCost;
  
  Elemento pai;
  
  Elemento(float h, int x, int y, boolean p, boolean i, boolean f, Elemento pai_){
    heuristica = h;
    indiceX = x;
    indiceY = y;
    parede = p;
    inicio = i;
    fim = f;
    pai = pai_;
    finalCost = 0;
  }
  
  Elemento(Elemento e){
    heuristica = e.heuristica;
    indiceX = e.indiceX;
    indiceY = e.indiceY;
    parede = e.parede;
    inicio = e.inicio;
    fim = e.fim;
    pai = e.pai;
    finalCost = e.finalCost;
  }
  
  Elemento(){
    
  }
  
  void setParede(){
    heuristica = 9999;
    parede = true;
    inicio = false;
    fim = false;
  }
  
  void setInicio(){
    parede = false;
    inicio = true;
    fim = false;
    pai = getInicio();
    setDistancias();
  }
  
  void setFim(){
    parede = false;
    inicio = false;
    fim = true;
    setHeuristicas();
  }
  
  void Erase(){
    parede = false;
    inicio = false;
    fim = false;
    pai = null;
  }
  
  
  void clear(){
    distancia = 0;
    heuristica = 0;
    indiceX = 0;
    indiceY = 0;
    parede = false;
    inicio = false;
    fim = false;
    pai = null;
  }
  
}