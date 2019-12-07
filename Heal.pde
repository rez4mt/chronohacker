class Heal{
  int x , y;
  boolean used = false;
  PImage img ;
  public void draw()
  {
    if(!used)
    image(img , x , y , 30 , 30);
  }
  public Heal(int x , int y)
  {
    this.x = x;
    this.y = y;
    img = loadImage("icons/heal.png");
  }
  
  public boolean intersects(int x , int y)
  {
    if(used)
      return false;
    if(x > this.x && x < this.x + 50 && y > this.y && y < this.y + 50)
    {
      return true;
    }
    if(this.x > x && this.x < x+50 && this.y > y && this.y < y + 50)
    {
      return true;
    }
    return false;
  }
}
