Particle[] stars = new Particle[250];
OddestballParticle spaceship;

void setup(){
  size(800,650);
  for(int i=0;i<stars.length;i++)
  {
    stars[i]= new Particle();
  }
  for(int i=0;i<5;i++)
  {
    stars[i]= new OddballParticle();
  }
  for(int i=5;i<55;i++)
  {
    stars[i]= new OdderballParticle(625,350,color(255,229,143));
  }
  for(int i=55;i<95;i++)
  {
    stars[i]= new OdderballParticle(500,450,color(154,255,143));
  }
  for(int i=95;i<135;i++)
  {
    stars[i]= new OdderballParticle(725,400,color(255,177,143));
  }
  spaceship = new OddestballParticle();
}

void draw(){
  background(0,0,0);
  noStroke();
  for(int i=0;i<100;i++){
    fill(i,i,i*4);
    rect(0,i*2+200,800,i*2+202);
  }
  fill(12,28,4);
  ellipse(400,650,2000,250);
  
  int standsX=500;
  while(standsX<=760)
  {
    noStroke();
    fill(143,96,39);
    if(standsX>500 && standsX<758){
      rect(standsX-30,534,60,20);
    } else if(standsX==500){
      rect(standsX,534,30,20);
    } else {
      rect(standsX-30,534,30,20);
    }
    if(standsX>500 && standsX<758){
      fill(255,(int)(Math.random()*255/2),0);
      quad(standsX-30,500,standsX,495,standsX,510,standsX-30,510);
      fill(255,(int)(Math.random()*255/2),0);
      quad(standsX+30,500,standsX,495,standsX,510,standsX+30,510);
    } else if(standsX==500){
      fill(255,(int)(Math.random()*255/2),0);
      quad(standsX+30,500,standsX,495,standsX,510,standsX+30,510);
    }else {
      fill(255,(int)(Math.random()*255/2),0);
      quad(standsX-30,500,standsX,495,standsX,510,standsX-30,510);
    }
    stroke(105,71,29);
    strokeWeight(8);
    line(standsX,495,standsX,550);
    standsX+=86;
  }
  noStroke();
  strokeWeight(1);
  standsX=500;
  while(standsX<=760)
  {
    fill(255,(int)(Math.random()*50+205),143);
    ellipse(standsX,500-(float)Math.sin(standsX)*5,8,8);
    standsX+=20;
  }
  
  for(int i=0;i<stars.length;i++)
  {
    stars[i].blink();
    stars[i].show();
    stars[i].move();
  }
  spaceship.move();
  spaceship.show();
}

class Particle
{
  double myX, myY;
  int myOpacity, mySize, cycle;
  
  Particle()
  {
    myX = (double) (Math.random()*800);
    myY = (double) (Math.random()*500);
    mySize = (int) (Math.random()*5 +2);
    myOpacity = (int) (Math.random()*255);
    cycle = (int) (Math.random()*255);
  }
  void move(){
    if(myOpacity==0)
    {
      myX = (int) (Math.random()*800);
      myY = (int) (Math.random()*500);
    }
  }
  void blink()
  {
    myOpacity = (int) (127.5+127.5*cos(0.02464*cycle));
    cycle++;
    if(cycle>=255)
    {
      cycle = 0;
    }
  }
  void show()
  {
    fill(255,255,255,myOpacity);
    ellipse((int)myX,(int)myY,mySize,mySize);
  }
}

class OddballParticle extends Particle
{
  boolean burn;
  int tailLength;
  OddballParticle()
  {
    myX = (double) (Math.random()*1000-200);
    myY = (double) (Math.random()*300);
    mySize = 5;
    myOpacity = (int) (Math.random()*300 -100);
    burn = false;
    tailLength= (int) (Math.random()*20+5);
  }
  void move()
  {
    myX++;
    myY++;
    if(myY>=500)
    {
      burn=true;
    }
    if(burn==true && myOpacity<=0)
    {
      myX = (int) (Math.random()*1000-200);
      myY = (int) (Math.random()*300);
      myOpacity = (int) (Math.random()*300 -100);
      burn=false;
    }
  }
  void blink()
  {
    if(burn==false)
    {
    myOpacity+=2;
    }
    if(myOpacity>=255){
      burn = true;
    }
    if(burn==true)
    {
      myOpacity-=10;
    }
  }
  void show()
  {
    fill(255,255,255,myOpacity);
    ellipse((int)myX,(int)myY,mySize,mySize);
    for(int i=0;i<tailLength;i++)
    {
      fill(255,255,255,myOpacity-i*10);
      ellipse((int)myX-i,(int)myY-i,mySize,mySize);
    }
  }
}

class OdderballParticle extends OddballParticle
{
  float angle, speed;
  int myColor, startX, startY;
  
  OdderballParticle(int x,int y,int Color)
  {
    myX = startX= x;
    myY = startY= y;
    mySize = 8;
    myColor = Color;
    if(myColor==color(255,229,143))
    {
      myOpacity = 85;
    } else if(myColor==color(154,255,143))
    {
      myOpacity = 170;
    } else {
      myOpacity = 255;
    }
    angle = (float)(Math.random()*2*Math.PI);
    speed = (float)(Math.random()*50);
  }
  void move()
  {
    myX += (double) cos(angle*speed);
    myY += (double) sin(angle*speed);
  }
  void blink()
  {
    myOpacity-=10;
    if(mySize<=0 || myOpacity<=0)
    {
      myX = startX;
      myY = startY;
      myOpacity = 255;
    }
    if(myY>515)
    {
      myOpacity=0;
    }
  }
  void show()
  {
    fill(myColor,myOpacity);
    ellipse((int)myX,(int)myY,mySize,mySize);
  }
}

class OddestballParticle
{
  int shipX, shipY, cowX, cowY;
  boolean captured;
  
  OddestballParticle()
  {
    shipX = (int) (Math.random()*800);
    shipY = (int) (Math.random()*200);
    cowX = (int) (Math.random()*300+10);
    cowY = 550;
    captured = false;
  }
  void move()
  {
    if(cowX>shipX)
    {
      shipX++;
    }
    else if(cowX<shipX)
    {
      shipX--;
    }

    if(shipY<490 && captured==false)
      {
        shipY++;
      }
      
      
    if(shipY==490 && shipX==cowX)
    {
      captured=true;
    }
    
    if(captured==true)
    {
      cowY--;
      if(cowY<shipY-5)
      {
      cowX++;
      cowY-=3;
      shipY--;
      }
    }
  }
  void show()
  {
    //cow
    if(cowY>shipY)
    {
    fill(255);
    stroke(0);
    //horns: left, right
    ellipse(cowX-11,cowY-9,2,5);
    ellipse(cowX-6,cowY-9,2,5);
    //left ear
    ellipse(cowX-14,cowY-5,6,4);
    //legs: left to right
    ellipse(cowX-8,cowY+4,3,5);
    ellipse(cowX-3,cowY+5,3,5);
    ellipse(cowX+3,cowY+4,3,5);
    ellipse(cowX+8,cowY+5,3,5);
    //body
    ellipse(cowX,cowY,20,10);
    //head
    ellipse(cowX-8,cowY-4,14,10);
    //right ear
    ellipse(cowX-3,cowY-5,6,4);
    fill(0);
    //head spot
    ellipse(cowX-4,cowY-5,5,4);
    //body spot
    ellipse(cowX+5,cowY-2,8,5);
    //nose
    fill(255,196,196);
    noStroke();
    ellipse(cowX-11,cowY-2,4,3);
    }
    
    //beam
    if(captured==true && cowY>shipY)
    {
      fill(0,255,0,50);
      triangle(shipX,shipY,cowX-25,cowY+5,cowX+25,cowY+5);
    }
    
    //ship
    noStroke();
    fill(150);
    ellipse(shipX,shipY,100,40);
    
    if(captured==true && cowY<=shipY)
    {
      //COW
      fill(255);
      stroke(0);
      //horns: left, right
      ellipse(shipX-3,shipY-9,2,5);
      ellipse(shipX+2,shipY-9,2,5);
      //left ear
      ellipse(shipX-6,shipY-5,6,4);
      //legs: left to right
      ellipse(shipX,shipY+4,3,5);
      ellipse(shipX+5,shipY+5,3,5);
      ellipse(shipX+11,shipY+4,3,5);
      ellipse(shipX+16,shipY+3,3,5);
      //body
      ellipse(shipX+8,shipY,20,10);
      //head
      ellipse(shipX,shipY-4,14,10);
      //right ear
      ellipse(shipX+5,shipY-5,6,4);
      fill(0);
      //head spot
      ellipse(shipX+4,shipY-5,5,4);
      //body spot
      ellipse(shipX+13,shipY-2,8,5);
      //nose
      fill(255,196,196);
      noStroke();
      ellipse(shipX-3,shipY-2,4,3);
      
      //alien
      noStroke();
      fill(0,255,0);
      ellipse(shipX-10,shipY-10,20,20);
      triangle(shipX-10,shipY+7,shipX-15,shipY+1,shipX-5,shipY+1);
      ellipse(shipX-10,shipY,3,7);
      stroke(0);
      strokeWeight(3);
      line(shipX-17,shipY-10,shipX-13,shipY-7);
      line(shipX-3,shipY-10,shipX-7,shipY-7);
      strokeWeight(1);
      noStroke();
    } else {
      fill(0,255,0);
      ellipse(shipX,shipY-10,20,20);
      triangle(shipX,shipY+7,shipX-5,shipY+1,shipX+5,shipY+1);
      ellipse(shipX,shipY,3,7);
      stroke(0);
      strokeWeight(3);
      line(shipX-7,shipY-10,shipX-3,shipY-7);
      line(shipX+7,shipY-10,shipX+3,shipY-7);
      strokeWeight(1);
      noStroke();
    }
    
    fill(255,255,255,200);
    ellipse(shipX,shipY-10,60,40);
  }
}
