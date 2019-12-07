int posx ,posy;
int W = 1000, H = 1000;
PImage user ;
int TRESH_MOVE = 10;
int inv_items = 0 ;
int MYHP = 1000;
//spawn some NPC
int BOXNUM = 3 ;
int MYDAMAGE = 10;
int STATE_INTERSECT = 0 ,STATE_WAR = 1 , STATE_DEAD = 2,STATE_HEAL = 3,STATE_TRAIN = 4;
int tX = 150,tY = 150;
ArrayList<Ball> balls;
void reAddBalls(int x,int y)
{
  balls=new ArrayList();
  // init 11 balls first 
  for (int i=0; i < 11; i++) {
    // get a random number 
    color col1 = color (int(random(100, 255)), int(random(0, 255)), int(random(0, 255)));
    // make a ball (an object taken from the class with new 
    Ball newBall = new Ball( x , y, random(9, 52), col1) ;
    // add the ball object to the arraylist 
    balls.add ( newBall );
  }
}
void displayAllBalls() {
 
  //
 
  for (int i=0; i < balls.size(); i++) {
 
    // get one ball from the arraylist 
    Ball ball = balls.get(i);
 
    // we work with this ball now: 
    fill(ball.colorBall);
    ellipse(ball.x, ball.y, ball.balldiam, ball.balldiam);//display ball
 
    ball.vely=ball.vely + 0.1;//acelera
    ball.x=ball.x + ball.velx;//mueve en x
    ball.y=ball.y + ball.vely;//mueve en y
  }
}// func 
int intersection =-1 ; 
int current_state = -1;
int mydamage = 100;
int turn = 0 ;
ArrayList<Moves> available ;
NPC[] npcs ;
Heal[] heals; 
Moves[] moves;
int[] inventory ;
int skls = 1;
boolean performed = false;
int last = -1;
PImage trainer ;
void setup()
{
  reAddBalls(1200,1000);
  smooth();
  available = new ArrayList<Moves>();
  available.add(new Moves("Normal" , 10));
  available.add(new Moves("Not Normal" , 20));
  available.add(new Moves("Rez Att" , 22));
  available.add(new Moves("Alpha Att" , 25));
  available.add(new Moves("BB Att" , 31));
  available.add(new Moves("CC^_^" , 12));
  
  moves = new Moves[5];
  user = loadImage("icons/ninja.png");
  size(1200,1000);
  npcs = new NPC[3];
  heals = new Heal[10];
  trainer = loadImage("icons/trainer.png");
  image(trainer , tX , tY,100,100);
  for(int i= 0 ; i < heals.length ; i++)
  {
    heals[i] = new Heal((int)random(100,W-100),(int)random(H-100));
  }
  moves[0] = new Moves("Normal Attack",10);
  randpos();
  inventory = new int[BOXNUM];
  for(int i = 0 ; i < npcs.length ;i++)
  {
    npcs[i] = new NPC(i,(int)random(100,W-100),(int)random(H-100));
   
  }
  
}
int distance(int dx , int dy)
{
  return (int)sqrt(pow(dx-posx,2)+pow(dy-posy,2));
}
void randpos()
{
  
  posx =(int)random(100,W-100);
  posy = (int) random(H-100);
}
void keyPressed() {
  
  if(current_state == STATE_WAR)
  {
    if(key>='0' && key <'0'+skls)
     {
       performed = true;
       last = key -'0';
     }
    return;
  }else if(current_state == STATE_TRAIN)
  {
    if(key>='0' && key <'0'+available.size())
     {
       performed = true;
       int idx = key -'0';
       moves[skls++] = available.get(idx);
       available.remove(idx);
       current_state = -1;
       tX = (int) random(100 , 900);
       tY = (int) random(100,900);
       return;
     }
  }
   
   if(keyCode == UP)
   {
     posy -=TRESH_MOVE;
     if(posy < 0)
     posy = 0;
   }else if(keyCode == DOWN)
   {
     posy +=TRESH_MOVE;
     if(posy > 900)
       posy = 900;
   }else if(keyCode == RIGHT)
   {
     posx+=TRESH_MOVE;
     if(posx > 1000)
       posx = 1000;
   }else if(keyCode == LEFT)
   {
     posx-=TRESH_MOVE;
     if(posx < 100)
       posx = 100;
   
   }else if(key == 'y')
   {
     if(current_state!=-1)
       {
         npcs[intersection].war();
         current_state = STATE_WAR;
                reAddBalls(posx,posy);

       }
   }else if(key == 'r')
   {
     if(current_state==STATE_DEAD)
      {
        MYHP = 5000;
        current_state = -1;
       randpos();
              reAddBalls(posx,posy);

      }
 }else if(key == 'e')
 {
   if(current_state!=STATE_HEAL)
     return;
   for(int i = 0 ; i < BOXNUM ; i++)
   {
     if(inventory[i]<5)
     {
       heals[intersection].used = true;
       current_state = -1;
       intersection = -1;
       inventory[i]++;
       reAddBalls(posx,posy);
       break;
     }
   }
 }
 if(key>='a' && key<='c')
 {
    if(current_state==-1)
    {
      if(inventory[key-'a']>0)
      {
        inventory['a'-key]--;
        MYHP += 20;
        reAddBalls(posx,posy);
      }
    }
 }
   
}

void drawFrame()
{
  stroke(0);
  line(100,0,100,H);
  stroke(0);
  line(1100,0,1100,H);
  drawBox();
  drawInfo();
}
void drawBox()
{
  fill(255);
  stroke(0);
  for(int i = 0 ; i < BOXNUM ; i++)
  {
    int x = 10 * (i+1);
    x += i * 80;
    int y = 10 * (i+1);
    fill(255);
    y += i * 80;
    rect(10,y,80,80);
    fill(0);
    textSize(14);
    text("Items : "+inventory[i],12,y+15);
    text("Press : "+((char)('a'+i))+"\nto use",12,y+30);
  }
}
void drawInfo()
{
  int x = 1105;
  int y = 20;
  textSize(18);
  fill(0);
  text("HP : "+MYHP,x,y);
  drawOptions(current_state);
}
void drawOptions(int state)
{
  if(state == -1)
      return ; 
  if(state == STATE_INTERSECT)
  {
    //show options (fight , ignore)
    int x = 1105;
    int y = 100;
    textSize(12);
    fill(0);
    text("Start War ?\nPress Y for yes.",x,y);
  }else if(state == STATE_WAR)
  {
    int x = 1105;
    int y = 100;
    textSize(12);
    fill(0);
    text("NPC HP : "+npcs[intersection].hp,x,y);
    text("Moves",x,y+100);
    fill(255);
    y += 130;
    stroke(0);
    
    for(int i = 0 ; i < skls ; i++)
    {
      int my = 10 * (i+1) + y;;
      my += i * 80;
      fill(255);
      rect(x,my,80,80);
      fill(0);
      text(moves[i].name,x+2,my+15);
      text("damge : "+moves[i].damage+"",x+2,my+30);
      text("Press "+i,x+2,my+50);
    }
    
  }else if(state == STATE_DEAD)
  {
    int x = 1105;
    int y = 100;
    textSize(12);
    fill(0);
    text("You Died..\npress R for revive. ",x,y);
    
  }else if(state == STATE_HEAL)
  {
    int x = 1105;
    int y = 100;
    textSize(12);
    fill(0);
    text("Pick up heal ?\npress E",x,y);
  }else if(state == STATE_TRAIN)
  {
    int x = 1105;
    int y = 100;
    textSize(12);
    fill(0);
    text("Train Skill ?",x,y);
    for(int i = 0 ; i < available.size() ; i++)
    {
      int my = 10 * (i+1) + y;;
      my += i * 80;
      fill(255);
      rect(x,my,80,80);
      fill(0);
      Moves m = available.get(i);
      text(m.name,x+2,my+15);
      text("damge : "+m.damage+"",x+2,my+30);
      text("Press "+i,x+2,my+50);
      
    }
  }
}
void draw()
{
  
  background(255);
  
  displayAllBalls(); 
  image(user,posx,posy,100,100);
  if(skls < 4)
    image(trainer , tX , tY,100,100);
  drawFrame();
  if(current_state == -1)
  {
    for(int i = 0 ; i < npcs.length ;i++)
    {
      if(npcs[i].died)
        continue;
      npcs[i].draw();
      if(current_state == -1 && npcs[i].intersects(posx,posy))
        {
          current_state = STATE_INTERSECT ; 
          drawOptions(STATE_INTERSECT);
          intersection = i;
          npcs[i].talk();
        }  
        else
        {
          npcs[i].move();
        }
    }
  }else
  {
    if(current_state == STATE_WAR)
    {
      if(turn %2 == 0)
      {
        if(performed)
          {
            npcs[intersection].frame_count++;
            npcs[intersection].draw();
           
            npcs[intersection].hp -= moves[last].damage;
            performed = false;
        if(npcs[intersection].hp  < 0)
        {
          //died;
          npcs[intersection].died = true;
          current_state = -1;
          reAddBalls(posx,posy);
          intersection = -1;
        }
        turn ++;
          }
        //npc attack
        
      }else
      {
        //i attack
        MYHP -= npcs[intersection].damage;
        
        if(MYHP <= 0)
        {
          //show game over
          current_state = STATE_DEAD;
          MYHP = 0 ;
        }
        turn++;
      }
    }else if(current_state == STATE_HEAL)
    {
    
    }else
    {
      if(current_state == STATE_INTERSECT)
      {
        if(!npcs[intersection].intersects(posx,posy))
        {
          
          npcs[intersection].hide();
          intersection = -1 ;
          current_state = -1;
          
        }
      }
      
    }
    
  }
  for(int i = 0 ; i < npcs.length ;i++)
  {
     
     npcs[i].draw();
     if(current_state == -1)
     {
       npcs[i].move();
     }else
     {
       if(intersection!=i)
       {
         npcs[i].move();
       }else
       {
         if(current_state == STATE_INTERSECT)
           npcs[i].talk();
       }
     }

    
  }
  boolean hasint = false;
  for(int i= 0 ; i < heals.length ; i++)
  {
    heals[i].draw();
    if(heals[i].intersects(posx,posy))
    {
      if(!hasint)
      {
        intersection = i ;
      }
      hasint = true;
      current_state = STATE_HEAL;
      rect(heals[i].x,heals[i].y,30,30);
      
    }
  }
  if(current_state == STATE_HEAL && !hasint)
  {
    current_state = -1;
  }
  if(distance(tX , tY)<100)
  {
    if(current_state == -1)
      current_state = STATE_TRAIN;
  }else if(current_state == STATE_TRAIN)
  {
    current_state = -1;
  }
  delay(10);
}
