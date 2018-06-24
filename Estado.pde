class Estado{
 
  int horizontal, veritcal;
  Elemento anterior, incial, fim;
  
  Estado(Elemento prev, int h, int v){
    anterior = prev;
    
  }
  
  void getInicio(){
    for(int i=0; i<10; i++){
      for(int j=0; j<10; j++){
        if(matriz[i][j].inicio == true){
          incial = matriz[i][j];        
        }
      }
    }
  }
  
  void getFinal(){
    for(int i=0; i<10; i++){
      for(int j=0; j<10; j++){
        if(matriz[i][j].fim == true){
          fim = matriz[i][j];        
        }
      }
    }
  }
  
}