class Gulosa{ //<>// //<>//

Gulosa(){
  
}


void executarGulosa() {
  
  reiniciar();

  caminho.clear();
  fechada.clear();
  
  double a = 0;
  
  setFinalCost();
  //matriz
  boolean closed[][] = new boolean[20][20];
  
  Comparator<Elemento> comparator = new Comparator<Elemento>() {
    @Override
    public int compare(Elemento x1, Elemento x2) {
      
       if(x1.finalCost < x2.finalCost) {
         return -1; 
       } else if(x2.finalCost < x1.finalCost) {
         return 1;
       }
       return 0;
    }
  };
  
  PriorityQueue<Elemento> open = new PriorityQueue<Elemento>(20, comparator);
  
  Elemento e = getInicio();
  e.finalCost = 0;
  
  open.add(e);
  
  Elemento atual;
  
  while(true) {
    atual = open.poll();
    if(atual.parede) break;
    //closed[atual.indiceX][atual.indiceY] = true;
    if(atual.equals(getFinal())) break;
    
    Elemento t;
    if(atual.indiceX-1 >= 0) {
      t = matriz[atual.indiceX-1][atual.indiceY];
      checkAndUpdateCost(atual, t, closed, open);
      
      if(atual.indiceY-1 >= 0) {
        t = matriz[atual.indiceX-1][atual.indiceY-1];
        checkAndUpdateCost(atual, t, closed, open);
      }
      
      if(atual.indiceY+1 < 20) {
        t = matriz[atual.indiceX-1][atual.indiceY+1];
        checkAndUpdateCost(atual, t, closed, open);
      }
    }
    
    if(atual.indiceY-1 >= 0) {
      t = matriz[atual.indiceX][atual.indiceY-1];
      checkAndUpdateCost(atual, t, closed, open);
    }
    if(atual.indiceY+1 < 20) {
      t = matriz[atual.indiceX][atual.indiceY+1];
      checkAndUpdateCost(atual, t, closed, open);
    }
    
    if(atual.indiceX+1 < 20) {
      t = matriz[atual.indiceX+1][atual.indiceY];
      checkAndUpdateCost(atual, t, closed, open);
      
      if(atual.indiceY-1 >= 0) {
        t = matriz[atual.indiceX+1][atual.indiceY-1];
        checkAndUpdateCost(atual, t, closed, open);
      }
      
      if(atual.indiceY+1 < 20) {
        t = matriz[atual.indiceX+1][atual.indiceY+1];
        checkAndUpdateCost(atual, t, closed, open);
      }
    }
    a++;
    if(a == Double.MAX_VALUE){
      showMessageDialog(null, "Caminho não econtrado!", "Alerta", ERROR_MESSAGE); 
    }
  }
  
  while(atual != getInicio()){
    caminho.add(atual);
    atual = atual.pai;
  }
  
  if(checkbox.getState(0)) {
  for(int i = 0; i<caminho.size(); i++){
        for(int j = 0; j<fechada.size(); j++){
          if(fechada.get(j) == getInicio()){
            campo[fechada.get(j).indiceX][fechada.get(j).indiceY].changeColor(0, 191, 255);
          }else if(fechada.get(j) == caminho.get(i)){
            campo[fechada.get(j).indiceX][fechada.get(j).indiceY].changeColor(246, 216, 67);
          }else if(fechada.get(j) == getFinal()){
            campo[fechada.get(j).indiceX][fechada.get(j).indiceY].changeColor(61, 145, 64);
          }else if(fechada.get(i).parede == true){
            campo[fechada.get(j).indiceX][fechada.get(j).indiceY].changeColor(139, 37, 0); 
          }else{
            campo[fechada.get(j).indiceX][fechada.get(j).indiceY].changeColor(255, 236, 139);
          }
        }
      }
  }
      
      
  
    for(int i = 1; i<caminho.size(); i++){
        if(caminho.get(i) != getFinal()){
          campo[caminho.get(i).indiceX][caminho.get(i).indiceY].changeColor(255, 255, 0);
        }
    }
    
    if(matriz[0][0] != getInicio() && matriz[0][0] != getFinal()){
      campo[0][0].changeColor(255, 255, 255);
    }
  
  /*
  for(int i = 0; i < 20; i++) {
    for(int j = 0; j < 20; j++) {
       if(closed[i][j]) {
         campo[i][j].changeColor(0, 0, 0); 
       }
    }
  }
  */
  
}

void checkAndUpdateCost(Elemento atual, Elemento t, boolean[][] closed, PriorityQueue<Elemento> open) {
  if(t.parede) return;
  fechada.add(t);
  float t_final_cost = t.heuristica;
  boolean inOpen = open.contains(t);
  if(!inOpen || t_final_cost < t.finalCost) {
    t.finalCost = t_final_cost;
    t.pai = atual;
    if(!inOpen)open.add(t);
  }
} //<>// //<>//
 
}