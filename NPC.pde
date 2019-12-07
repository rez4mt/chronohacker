import java.awt.geom.Rectangle2D;

class NPC{
  int x , y;
  int id ;
  int hp = 250;
  int damage = 10;
  int dx , dy;
  int last_change = 0 ;
  int last_item = 0 ;
  PImage talkThing ;
  boolean inwar = false;
  int logoidx;
  PImage[] moving ;
  int frame_count = 0;
  String[][] logos = new String[][]{{"icons/NPC/human.png","icons/NPC/human-2.png","icons/NPC/human-3.png","icons/NPC/human-4.png"},
{"icons/NPC/human2.png","icons/NPC/human2-2.png","icons/NPC/human2-3.png","icons/NPC/human2-4.png"},
{"icons/NPC/zoombie.png","icons/NPC/zoombie-2.png","icons/NPC/zoombie-3.png","icons/NPC/zoombie-4.png"}
,{"icons/NPC/zoombie2.png","icons/NPC/zoombie2-2.png","icons/NPC/zoombie2-3.png","icons/NPC/zoombie2-4.png"}};
  boolean talking = false;
  boolean died = false;
  int last = 0 ;
  
  public NPC(int id , int x , int y)
  {
    this.x = x;
    this.y = y;
    this.id = id;
    logoidx = (int)random(0,logos.length);
    moving = new PImage[4];
    for(int i = 0 ; i < 4 ; i++)
      moving[i] = loadImage(logos[logoidx][i]);
   
    dx = 5 * (int)random(-1,1);
    dy = 5 * (int)random(-1,1);
    if(dx == 0)
      dx = +1;
    if(dy == 0)
      dy = -1;
  }
  public void draw()
  {
    
    if(died)
      return;
    PImage current = moving[0];
    if(inwar)
    {
      current = moving[2+(frame_count % 2)];
    }else if(talking)
    {
      current = moving[0];
    }else
    {
      current = moving[frameCount % 2];
    }
    image(current,x,y,100,100);
  }
  public boolean intersects(int x , int y)
  {
    if(x > this.x && x < this.x + 150 && y > this.y && y < this.y + 150)
    {
      return true;
    }
    if(this.x > x && this.x < x+150 && this.y > y && this.y < y + 150)
    {
      return true;
    }
    return false;
  }
  public void talk()
  {
    if(inwar)
      return;
    //
    talking = true;
    if(abs(last_change - second())>2)
    {
      last_item = last_item % ((id+1)*5);
      last_item ++;
       talkThing = loadImage("icons/chat/"+last_item+".png");
      last_change = second();
    }
    image(talkThing , x+30, y, 100,30);
   
  }
  public void move()
  {
    if(talking)
      return;
    x += dx;
    y += dy;
    if(x < 100)
       {
         dx = -dx;
         x = 100;
       }
     if(x > 1000)
     {
       x = 1000;
     dx = -dx;  
   }
    if(y > 900)
      {
        dy = -dy;
        y = 900;
      }
    if(y < 0)
      {
        dy = -dy;
        y = 0;
      }
  }
  public void hide()
  {
    talking = false;
  }
  public void war()
  {
    inwar = true;
      
  }
}
