float x,y;
float scl= 150; // scale 
PVector size,box[]; // screensize,boxes
PVector p[],res; // points,reset position
int counter,et,var[][]; //et=previous tap
int tap = 9;
boolean pb[],win; 
color c,sc,pc[],blk,bg,red,green;
String winCode[]={"0.1.2","3.4.5","6.7.8",
                  "0.3.6","1.4.7","2.5.8",
                  "0.4.8","6.4.2"};

void setup(){
  var = new int[8][3];
  background (50);
  size = new PVector(displayWidth,
                     displayHeight);
  size(displayWidth,displayHeight);
  x = (size.x/2)-scl/2;
  y = (size.y/2)-scl/2;
  p = new PVector[4];
  box = new PVector[9];
  pb = new boolean[9];
  bg = color(40,40,40);
  pc = new color[9];
  red = color(255,0,0);
  counter = 0;
  green = color(0,255,0);
  win = false;
  for(int i=0;i<9;i++){
    pb[i] = false;
    pc[i] = blk;
    tap = 9;
  }
  setBox();
}

void draw(){
  background(bg);
  autoReset();
  check();
  resetButton();
  drawBoard();
  update();
  drawChar();
  checkWin();
  }
  
void setBox(){
  p[0] = new PVector(x,y);
  p[1] = new PVector(x+scl,y);
  p[2] = new PVector(x+scl,y+scl);
  p[3] = new PVector(x,y+scl);
  
  box[0] = new PVector(p[0].x-scl,p[0].y-scl);
  box[1] = new PVector(p[0].x,p[0].y-scl );
  box[2] = new PVector(p[0].x+scl,p[0].y-scl );
  box[3] = new PVector(p[0].x-scl,p[0].y );
  box[4] = new PVector(p[0].x,p[0].y );
  box[5] = new PVector(p[0].x+scl,p[0].y );
  box[6] = new PVector(p[0].x-scl,p[0].y+scl );
  box[7] = new PVector(p[0].x,p[0].y+scl );
  box[8] = new PVector(p[0].x+scl,p[0].y+scl );
}

void drawBoard() {
  stroke(255);
  strokeWeight(5);
  fill(bg);
  rect(x,y,scl,scl);
  line(p[0].x,p[0].y,p[0].x-scl,p[0].y);
  line(p[0].x,p[0].y,p[0].x,p[0].y-scl);
  line(p[1].x,p[1].y,p[1].x,p[1].y-scl);
  line(p[1].x,p[1].y,p[1].x+scl,p[1].y);
  line(p[2].x,p[2].y,p[2].x+scl,p[2].y);
  line(p[2].x,p[2].y,p[2].x,p[2].y+scl);
  line(p[3].x,p[3].y,p[3].x,p[3].y+scl);
  line(p[3].x,p[3].y,p[3].x-scl,p[3].y);
}

void mouseReleased(){
  if(!checkWin()){
   if(pmouseX < p[0].x &&
     pmouseX > p[0].x-scl){
    if(pmouseY < p[0].y && 
       pmouseY > p[0].y-scl) tap = 0;
       
    if(pmouseY > p[0].y &&
       pmouseY < p[3].y) tap = 3;
      
    if(pmouseY > p[3].y &&
       pmouseY < p[3].y+scl) tap = 6;
    }
    
   if(pmouseX > p[0].x && 
     pmouseX < p[1].x){
    if(pmouseY < p[0].y &&
       pmouseY > p[0].y-scl) tap = 1;
  
    if(pmouseY > p[0].y && 
       pmouseY < p[3].y) tap =  4;
      
    if(pmouseY > p[3].y &&
       pmouseY < p[3].y+scl) tap =  7;
    }
    
   if(pmouseX > p[1].x && 
     pmouseX < p[1].x+scl){
    if(pmouseY < p[0].y && 
       pmouseY > p[0].y-scl) tap =  2;
      
    if(pmouseY > p[0].y && 
       pmouseY < p[3].y) tap =  5;
      
    if(pmouseY > p[3].y && 
       pmouseY < p[3].y+scl) tap =  8;
      
    }
   else{
    }
   if(tap!=et && tap<9 && pc[tap]==blk){
      counter++;
    }
    et = tap;
    }
  }
  
void update(){
  if(tap>8){ 
  }else{
   pb[tap]=true;
   if(pc[tap]==blk){
     pc[tap]=c;
   }
  for(int i=0;i<9;i++){
   if(pb[i]){
    fill(pc[i]);
    rect(box[i].x,box[i].y,scl,scl);
  }else{
  }
  }
  }
}

void check(){
  if(counter%2==0){
    c = color(255,0,0);
    sc = color(0,255,0);
  }
  else if(counter%2!=0){
    c = color(0,255,0);
    sc = color(255,0,0);
    }
}

void resetButton(){
  res = new PVector(size.x/2-scl/4,
                    size.y-scl*2);
  if(mousePressed){
    if(mouseX >= res.x-10 &&
       mouseX <= res.x-10+scl/2+32 &&
       mouseY >= res.y-scl/5 &&
       mouseY <= res.y-scl/5+scl/4 
       ){
      setup();
    }
  }
  fill(bg);
  rect(res.x-10,res.y-scl/5,
       scl/2+32,scl/4);
  fill(200,255,100);
  textSize(scl/4);
  text("reset",res.x,res.y);
}

boolean checkWin(){
  for(int i=0;i<8;i++){
   var[i] = int(split(winCode[i],"."));
   if(pc[var[i][0]] == pc[var[i][1]] &&
      pc[var[i][1]] == pc[var[i][2]] && 
      pc[var[i][0]] != blk){
       win = true;
       fill(pc[var[i][0]]);
       textSize(100);
       stroke(pc[var[i][0]]);
       strokeWeight(10);
       textAlign(TOP);
       text((pc[var[i][0]] == red ? 
             "  RED":"GREEN")+" WON",
             100,350);
       color l = pc[var[i][0]] == red ?
                 green : red;
       drawLine(var[i],l);
     }
  }
  return win;
  }
  
void autoReset(){
   for(int i=0; i<9; i++){
     if(!pb[i]) return;
   }
  delay(1000);
  setup();
}

void drawChar(){
  for(int i=0; i<9; i++){
    if(pb[i]){
      String ch = pc[i]==green? "X" : "O";
      textSize(scl);
      fill(0);
      text(ch,box[i].x+25,box[i].y+130);
    }
  }
}

void drawLine(int[] k,color l){
  stroke(l);
  line(box[k[0]].x+scl/2,box[k[0]].y+scl/2,
       box[k[2]].x+scl/2,box[k[2]].y+scl/2);
}