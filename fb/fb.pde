color c111, b111; //used as colors of the buttons
int m;            //milisecond(not commonly used)
PImage pip, bg, gr, bir, open; //images such as background, ground, pipes, and flappy bird
int screen;  //screen being displayed


//page 0/homepage
button play; 
button[] buttons = new button[10];//buttons on homepage
int bcount; //amount of players

//page 1/birdsetup screen
ArrayList<birdsetup> bs;  //hmmm the list of birdsetups sorry for the name

//page2/play screen
bird b;
boundry ground;
pipe closest;
ArrayList<bird> abirds; //ArrayList of all alive birds
pipe s, s2; //we wanted to only move 3 pipes at a time to save space, see details at Grame page void movePipes():)
Stack<pipe> pipes;
int dis;    //distance between pipes


//page 3.end game
button learn;
button exit2;
Stack<bird> ranks;  //the rank of teh players, in order of death

//page4
int wspan, sizeb2;
bird b2;
Stack<pipe> pipes2;
pipe s11, s22;

//data
int d1;
int d2;
int d3;
int d4;
int[][][][] data; //a way to store data from birds of x, y, to the closest pipe and if they jumped and not...used to train future birds



void setup(){  

  screen = 0;
  size(900,1000);
  pip = loadImage("pipe1.png");
  bir = loadImage("fb.png");
  gr = loadImage("ground.png");
  bg = loadImage("bg.png");
  open = loadImage("fbopenpage.jpg");
  color c111 = color(255,255,255);
  color b111 = color(230,230,230);
  
  //screen0, homepage
  bcount = 0;
  
  //screen1, setuppage
  play =  new button(740,900,120,70,c111, b111);


  //screen2, gamepage
  pipes = new LStack<pipe>();
  ground = new boundry(0,800,1000,1000);
  for(int i=0;i<20;i++){
    int h = int(random(100,600));
   pipes.push(new pipe(h, pip, 1000));
  }
  int hs = int(random(100,600));
  int hs2 = int(random(100,600));
  s2 = new pipe(hs, pip, 1000);
  s = new pipe(hs2, pip, 1000);
  dis = 650;
  
  //screen3, gameoverpage
  ranks = new LStack<bird>();
  learn = new button(595,780,230,40, c111, b111);
  exit2 = new button(400,780,120,40,c111,b111);
  
  //screen4
  wspan = int(random(1,3));
  sizeb2 = int(random(1,3));
  b2 = new bird(c111, sizeb2*30, bir, wspan*10 + 20, 100,200);
  pipes2 = new LStack<pipe>();
  for(int i=0;i<20;i++){
    int h = int(random(100,600));
   pipes2.push(new pipe(h, pip, 1000));
  }
   s11 = new pipe(hs, pip, 1000);
  s22 = new pipe(hs2, pip, 1000);
  
  //data
  d1 = 3;
  d2 = 3;
  d3 = 33;
  d4 = 41;
  System.out.println(int((d1)*(d2)*(d3)*(d4)));
  data = new int[d1][d2][d3][d4];
  readline();
}

void draw(){
        //represent different states/screens of game
        if(screen == 0){
        Homepage();
        }
 
       if(screen == 1){
         s13();
       }
        
        if(screen == 2){   
        screen = Gamepage();
        }
        
        if(screen == 3){
        Gameoverpage();
        }
        
        //display buttons on the gamesoverpage
        if(screen ==4){
          screen = 4;
          
           learn.display();
           fill(0,0,0);
           textSize(20);
           text("See the learning bird", 700,810);
           if(learn.pressed){
               screen = 5;
             }
          
          exit2.display();
          fill(0,0,0);
           textSize(20);
           text("exit game", 450,810);
          if(exit2.pressed){
            exit();
          }
           
        }
        
        if(screen ==5){
          birdrun2();
        }
  }

//class structure of a bird
class bird{
float ypos;
float xpos;
float s;
float wingspan;
float m;
float v;
boolean l;
boundry bo;
color c123;
int score;
int player;
boolean alive;

//initialization
bird(color c, float size, PImage p, float w, float x, float y){
  s = size;
  wingspan = w;
  v = 0;
  xpos = x;
  ypos = y;
  tint(c);
  image(p, x, y, size, 0.75*size);
  noTint();
  l = true;
  bo = new boundry(xpos, ypos, size, 0.75*size);
  c123 = c;
  alive = true;
  score = 0;
}


void display(PImage pi){
  if(alive){
tint(c123);
image(pi, xpos, ypos, s, 0.75*s);
noTint();
updatebo();
  }
}

void grav(){
  v-= 0.6*9.8;
  ypos-= 0.6*v;
  updatebo();
}

void jump(){
  v = wingspan;
  updatebo();
  }
  
void death(){
   v =0;
   alive = false;
   updatebo(); //update the boundries of the bird
 }


void updatebo(){
  bo = new boundry(xpos, ypos, s, 0.75*s);
}
}

//a data strcuture containing a background, a bird and a button. This made it easier to set up the dispalying on the birdsetup page
//birdsetup class is used mainly for screen1, when users can click a button and the shape of the birds will be randomly generated
class birdsetup{
  bird b;
  button bu;
  
  //images
  PImage bir;
  PImage bg;
  
  float x;  //xpos
  float y;  //ypos
  float s;  //size
  float w; //wingspan
  color c; // color for the bird
  color c111, b111; //color for the buttons
  
  //birdsetup constructor
  birdsetup(float xo, float yo, PImage br, PImage pg){
    bg = pg;
    color c111 = color(250,250,250);
    color b111 = color(230,230,230);
    x = xo;
    y = yo;
    bir = br;
    bu = new button(x, y, 20.0, 20.0, c111, b111);
    ranbird();
  }
  
  //displaying new randomly generated bird
  void display(){
    image(bg, x,y,170,170);
    bu.display();
    b.display(bir);
    if(bu.pressed){
    ranbird();
    }
  }
  
  //setting b into a random bird
  void ranbird(){
    float r = random(150,255);
    float g = random(150,255);
    float b1 = random(150,255);
    float si = int(random(1,3))*30;
    float wi = int(random(1,3))*10 + 20;
    c = color(r, g, b1);
    c111=c;
    s = si;
    w = wi;
    b = new bird(c111, s, bir, w, x, y);
  }
}

//strcture boundry, this dedicates if there's a collision between two objects
class boundry{
  float x1;
  float y1;
  float x2;
  float y2;
  float w;
  float h;
  
  boundry(float x, float y, float wi, float he){
  x1 = x;
  y1 = y;
  x2 = x1+wi;
  y2 = y1+he;
  w = wi;
  h = he;
  }
  
  
  
}



class button{
int rectX, rectY;      // x, y position of the button
int rectSize = 90;  
boolean rectOver;    //indicare if the mosue hovers over the button
boolean pressed;    //indicate if the button is clicked
float x, y, w, h;
color c, b;            // c= color of button, b = colro of button when hovered

button(float x1, float y1, float w1, float h1, color c1, color b1){
  pressed = false;
  x = x1;
  y = y1;
  w = w1;
  h = h1;
  c = c1;
  b = b1;
} 


void overRect()  {
  if (mouseX >= x && mouseX <= (x+w) && //if the mouse hovers over the area of the button
      mouseY >= y && mouseY <= (y+h)) {
    rectOver = true;
  } else {
    rectOver = false;
  }
}

void display(){
  overRect();
  pressed = false;
  if(rectOver){
    fill(b);
    rect(x, y, w, h);
    noFill();
    if(mousePressed){
       pressed = true;
     }
  }
  else{
    fill(c);
    rect(x, y, w, h);
    noFill();
  }
}
}

 
//the run for the AI bird
  void birdrun2() {
  closest = findclose2();
  int m = millis();
  image(bg, 0, 0, 1000, 1000);
  s11.display(pip);
   s11.move();
  s22.display(pip);
  pipes.topValue().display(pip);
  pipesmove();
  
  image(gr, 0-(m*0.05)%50, 800, 1000, 250);
  
  //birds fall based on gravity
    b2.display(bir);
    b2.grav();
    int c1111 = int(closest.xpos - b.xpos)/40 + 5;
    int d1111 = int((closest.ypos+927 - b.ypos)/40) + 20;
    if(data[wspan][sizeb2][c1111][d1111] == 1){
      b2.jump();
    }
  
  //bird collides with pipes/ground/celing
  if(collision(b2.bo, pipes2.topValue().bo2)|| collision(b2.bo, pipes2.topValue().bo) || collision(b2.bo, s22.bo2) 
  || collision(b2.bo, s22.bo) || collision(b2.bo, s11.bo2) || collision(b2.bo, s11.bo) || (b2.ypos>=800)|| b2.ypos<=-10){
      b2.death();
      exit();
  }
  }
   
   
  void Gameoverpage() {
    int i11=0;
    background(100,150,200);
     while(ranks.length()>0){
     b = ranks.pop();
     fill(244,179,66);
     textAlign(CENTER);
     textSize(40);
     //dispaly placements & socres
     text("Place #" + int(i11+1) + " goes to Player " + int(b.player+1) + " Score: " + b.score, 450, 100 + 50*i11);
     i11++;
   }
  //stores data such as wingspan, size, and x and y coordinates of failed jump into 3D array for possible future use
   set();
   
   screen = 4;
   }
   
     //Game page
  
  int Gamepage() {
  closest = findclose();
  int a11 = 0, b11 = 0, c11 = 0, d11 =0;
  int m = millis();
  image(bg, 0, 0, 1000, 1000);
  //pipes
  s.display(pip);
   s.move();
  s2.display(pip);
  pipes.topValue().display(pip);
  
  //shifts the pipes and get score
  pipesmove();
  
  image(gr, 0-(m*0.05)%50, 800, 1000, 250);
  
  //birds fall based on gravity
  if(abirds.size()!=0){
  for(int i = 0; i < abirds.size(); i++){
    b = abirds.get(i);
    b.display(bir);
    b.grav();
  
  //birds jump is key is pressed
    if(keyPressed){
      int n = b.player + 1;
      if(int(key) == int(49+b.player)){
        b.jump();
        System.out.println(closest.xpos + " " + closest.ypos);
        a11 = int((b.wingspan - 20)/10);
        b11 = int(b.s/30);
        c11 = int(closest.xpos - b.xpos)/40 + 5;
        d11 = int((closest.ypos+927 - b.ypos)/40) + 20;
        data[a11][b11][c11][d11]= 1;
        }
      }
  
  //bird collides with pipes
  if(collision(b.bo, pipes.topValue().bo2)|| collision(b.bo, pipes.topValue().bo) || collision(b.bo, s2.bo2) 
  || collision(b.bo, s2.bo) || collision(b.bo, s.bo2) || collision(b.bo, s.bo) || (b.ypos>=800)|| b.ypos<=-10){
      b.death();
      data[a11][b11][c11][d11] = 0;//doesn't learn from the leap that caused it to die
      ranks.push(b);
      abirds.remove(b);
  }
  }
  }
  //all birds are dead, stop Game page
  else{
   return 3;
  }
  
return 2;
   }
   
     
  pipe findclose(){
    if(s.xpos<=-70){
    return s2;
  }
  else{
    return s;}
  }
  
  pipe findclose2(){
  if(s11.xpos<= -70){
  return s22;
}else{
  return s11;
  }
  }
 
  //method determines whether two objects are colliding 
  boolean collision(boundry b1, boundry b2){
    return (Math.max(b1.y1, b2.y1) <= Math.min(b1.y2, b2.y2) && 
    Math.min(b1.x2, b2.x2) >= Math.max(b1.x1, b2.x1));
  }
  
  //page where birds are randomly set up
   
 void pipesmove(){
   if(s2.xpos - s.xpos >= dis){
    s2.move();
  }
  
  if(pipes.topValue().xpos - s2.xpos >= dis){
  pipes.topValue().move();
  }
  
  if(s.xpos<=-170){
  s = s2;
  s2 = pipes.pop();
  for(int i=0;i<abirds.size();i++){
      abirds.get(i).score++;
  }
  }
  }
  
     void Homepage() {
   image(open, 0,0,900,1000);
   //text
     fill(255,255,0);
     textAlign(CENTER);
     textSize(50);
     text("Select the Number of Players!",450,700);
     c111 = color(255, 255, 255);
     b111 = color(230,230,230);
   
   //creating buttons along bottom
   for(int i=0;i<10;i++){
     buttons[i] = new button(80*i + 100, 800,70,70, c111, b111);
     buttons[i].display();
     fill(204, 0, 153);
     textSize(60);
     text(i+1, 80*i+130,858);
   }
   //setting up buttons
   for(int i=0;i<10;i++){
     if(buttons[i].pressed){
       bcount = i+1;
       screen = 1;
         abirds = new ArrayList<bird>(bcount);
           bs = new ArrayList<birdsetup>(bcount);
               for(int x=0;x<bcount;x++){
              bs.add(new birdsetup(50+200*(x%4)*1.0, 200 + int(x/4)*200*1.0, bir, bg));
            }
       }
     }
  }

class pipe{
float height;
float xpos;
PImage pi;
boundry bo;
boundry bo2;
float ypos;


pipe(float h, PImage p, float xp){
  height = h;
  pi = p;
  xpos = xp;
  ypos = height-920;
  bo = new boundry(xpos, ypos, 170, 1000);
  bo2 = new boundry(xpos, ypos+1063, 170, 1000);
}

void move(){
  xpos = xpos-15;
  updatebo();
  }
  
  void display(PImage pi){
    image(pi, xpos, ypos, 170,2000);
  }
  
  void updatebo(){
  bo = new boundry(xpos, ypos, 170, 927);
  bo2 = new boundry(xpos, ypos+1063, 170, 936);
}
}

BufferedReader reader;
String line;
 
//readling data from out.txt and converting into the 4d array
void readline(){
  reader = createReader("out.txt");    
  for(int i=0;i<int((d1)*(d2)*(d3)*(d4));i++){
  try {
    line = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  if (line == null) {
    noLoop();  
  } else {
    //breakdown each line into componets of the 4d array
    String[] pieces = split(line, ' ');
    int x = int(pieces[0]);
    int y = int(pieces[1]);
    int h = int(pieces[2]);
    int z = int(pieces[3]);
    int u = int(pieces[4]);
    data[x][y][h][z] = u;
    }
    }
  }
  
  //setbird page
    void s13(){
   background(0,150,200);
   play.display();
   textSize(50);
   fill(0,0,0);
   text("Play", 800,950);
    
   for(int i=0;i<bcount;i++){
     bs.get(i).display();
   }
   if(play.pressed){
     //update bs into abird for the gameplay page
     for(int i=0;i<bcount;i++){
       abirds.add(bs.get(i).b);
       abirds.get(i).player = i;
       abirds.get(i).xpos = 100;
       abirds.get(i).ypos = 200;
     }
     screen = 2;
   }
  }
  
  /** Array-based stack implementation */
/** Stack ADT */
public interface Stack<E> {
/** Reinitialize the stack. The user is responsible for
reclaiming the storage used by the stack elements. */
public void clear();
/** Push an element onto the top of the stack.
@param it The element being pushed onto the stack. */
public void push(E it);
/** Remove and return the element at the top of the stack.
@return The element at the top of the stack. */
public E pop();
/** @return A copy of the top element. */
public E topValue();
/** @return The number of elements in the stack. */
public int length();
};


import java.io.BufferedWriter;
import java.io.FileWriter;
PrintWriter output;

//updates out.txt after each run
void set(){
  output = createWriter("out.txt");
  // Write some text to the file
  for(int i111=0; i111<d1; i111++){//50-159/80
  //30-80 / 80
    for(int x111=0;x111<d2;x111++){
      //1 - 650/40 
      for(int y111 = 0;y111<d3;y111++){
        //0 - 800 / 40
        for(int h111 = 0;h111<d4;h111++){
            //keeps record of data in out.txt
            output.println(i111 + " " + x111 + " " + y111 + " " + h111 + " " + data[i111][x111][y111][h111]);
        }
      }
    }
  }
  output.close();
  //exit();
}

/**
 * Appends text to the end of a text file located in the data directory, 
 * creates the file if it does not exist.
 * Can be used for big files with lots of rows, 
 * existing lines will not be rewritten
 */
 
/*void appendTextToFile(String filename, String text){
  File f = new File(dataPath(filename));
  if(!f.exists()){
    createFile(f);
  }
  try {
    PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(f, false)));
    out.println(text);
    out.close();
  }catch (IOException e){
      e.printStackTrace();
  }
}

/**
 * Creates a new file including all subfolders
 */
/*void createFile(File f){
  File parentDir = f.getParentFile();
  try{
    parentDir.mkdirs(); 
    f.createNewFile();
  }catch(Exception e){
    e.printStackTrace();
  }*/
  
    /** Singly linked list node */
class Link<E> {
  private E element; // Value for this node
  private Link<E> next; // Pointer to next node in list
  // Constructors
  
  Link(E it, Link<E> nextval)
  { element = it; next = nextval; }
  
  Link(Link<E> nextval) { next = nextval; }
  
  Link<E> next() { return next; } // Return next field
  
  Link<E> setNext(Link<E> nextval) // Set next field
  { return next = nextval; } // Return element field
  E element() { return element; } // Set element field
  E setElement(E it) { return element = it; }
}


/** Linked stack implementation */
class LStack<E> implements Stack<E> {
  private Link<E> top;          // Pointer to first element
  private int size;             // Number of elements
  /** Constructors */
  public LStack() { top = null; size = 0; }
  public LStack(int size) { top = null; size = 0; }
  /** Reinitialize stack */
  public void clear() { top = null; size = 0; }
  /** Put "it" on stack */
  public void push(E it) {
    top = new Link<E>(it, top);
size++; }
  /** Remove "it" from stack */
  public E pop() {
    assert top != null : "Stack is empty";
    E it = top.element();
    top = top.next();
    size--;
return it; }
  /** @return Top value */
  public E topValue() {
    assert top != null : "Stack is empty";
    return top.element();
  }
  /** @return Stack length */
  public int length() { return size; }
}


//thanks for reading