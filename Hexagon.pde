class Hexagon extends Shape
{
  Hexagon(int maxSteps,int stepRate,int stepSize,float stepScale,boolean constrain,boolean simulate,boolean stroke)
  {
    this.maxSteps = maxSteps;
    this.stepRate = stepRate;
    this.stepSize = stepSize;
    this.stepScale = stepScale;
    this.constrain = constrain;
    this.simulate = simulate;
    this.stroke = stroke;
  }
  void Draw()
  {

    if(currIters < maxSteps)
    {
      for(int i = 0; i < stepRate; i=i+1)
      {
        Update();
        if(!hash.containsKey(vec))
        {
          hash.put(vec,0);
        }
        CheckHashMap();
        CheckForSimulate();
        fill(r,g,b);
        hexagon(vec.x, vec.y, (float)stepSize/2.0f);
        
      }
      currIters += stepRate;
    }
  }
  void Update()
  {
    int diffX = 0;
    int diffY = 0;
    int rand = (int) random(1,7);
    switch(rand)
    {
      case 1:
        vec.x = vec.x + ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2); 
        diffX = 1;
        diffY = -1;
        break;
      case 2:
          vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3));
          diffY = -1;
        break;
      case 3:
        vec.x = vec.x - ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2); 
        diffX = -1;
        diffY = -1;
        break;
      case 4:
        vec.x = vec.x - ((float)stepSize * (float)stepScale * (float)3  / (float)2); 
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3)  / (float)2); 
        diffX = -1;
        diffY = 1;
        break;
      case 5:
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3));
        diffY = 1;
        break;
      case 6:
        vec.x = vec.x + ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2); 
        diffX = 1;
        diffY = 1;
        break;
    }
    Clamp(diffX, diffY);    //explaining in depth below
  }  
 /*                                (0,0) ______________________ +x
            (0,1)*5                      |
(-1,1)*4     |    (1,1)*6                |
             |                           |
      -------|----------                 |
             |  (1,-1)*1                 |
  (-1,1)*3   |                           |
           (0,-1)*2                      +y
    This clamp will be much different than the Square class's clamp. I ran into an issue where I didnt know how i should translate the hexagon back into place with no sort of overlapping.
    Having diagonal translations forced me to think of a way I could document what sort of movement the hexagon did so i could reverse its movement and bring it back to where it was.
    Thus, I came up with an idea of storing its relative movement in a Cartesian plane sort of way. Above to the left is my x and y variables the clamp function should take in along with what
    movement it corresponds to. For example, if route 4 is randomly selected, the diffY should be positive (1) and diffX should be negative(-1). To reverse its movement if it goes out of bounds, 
    I have to move it down and to the left, aka a translation like route 1 should be used. Another example: route 6 is selected so we must move it down and to the left, or move it like in 
    route 3. Here, the diffX and diffY were 1,1 since it moved up and to the right. So if the shape goes out of bounds of the top of the window, and the diffX was positive, it took route 6 
    in terms of movement.Similarly, if it went out of bounds to the right of the window, and diffY was positive, the movement was up-right(route 6) so I have to move it down and to the 
    left (route 3).
    
 */
  
  
  void Clamp(int x, int y)       
  {              
    if(!constrain)
    {
      if(vec.x - stepSize < 0 && y > 0) //walk algo took route 4 so shift back down-right
      {
        vec.x = vec.x + ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2); 
      }
      else if(vec.x - stepSize < 0 && y < 0) //walk algo took route 3 so shift back up-right
      {
        vec.x = vec.x + ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2);    
      }
      else if(vec.y - stepSize < 0 && x == 0) //walk algo took route 5 so shift back downwards
      {
        vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3));
      }
      else if(vec.y - stepSize < 0 && x < 0 ) //walk algo took route 4 so shift back down-right
      {
        vec.x = vec.x + ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2);     
      }
      else if(vec.y - stepSize < 0 && x > 0 ) //walk algo took route 6 so shift back down-left
      {
        vec.x = vec.x - ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2);
      }
      else if(vec.x + stepSize > width && y > 0) //walk algo took route 6 so shift back down-left
      {
        vec.x = vec.x - ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2);   
      }
      else if(vec.x + stepSize > width && y < 0) //walk algo took route 1 so shift back up-left
      {
        vec.x = vec.x - ((float)stepSize * (float)stepScale * (float)3  / (float)2); 
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3)  / (float)2);    
      }
      else if(vec.y + stepSize > height && x == 0) //walk algo took route 2 so shift back upwards
      {
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3));
      }
      else if(vec.y + stepSize > height && x < 0 ) //walk algo took route 3 so shift back up-right
      {
        vec.x = vec.x + ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2);    
      }
      else if(vec.y + stepSize > height && x > 0 ) //walk algo took route 1 so shift back up-left
      {
        vec.x = vec.x - ((float)stepSize * (float)stepScale * (float)3  / (float)2); 
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3)  / (float)2);  
      }
    }
    else
    {
      if(vec.x - stepSize < 200 && y > 0) //walk algo took route 4 so shift back down-right
      {
        vec.x = vec.x + ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2);    
      }
      else if(vec.x - stepSize < 200 && y < 0) //walk algo took route 3 so shift back up-right
      {
       vec.x = vec.x + ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2);      
      }
      else if(vec.y - stepSize < 0 && x == 0) //walk algo took route 5 so shift back downwards
      {
        vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3));
      }
      else if(vec.y - stepSize < 0 && x < 0 ) //walk algo took route 4 so shift back down-right
      {
        vec.x = vec.x + ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2);    
      }
      else if(vec.y - stepSize < 0 && x > 0 ) //walk algo took route 6 so shift back down-left
      {
        vec.x = vec.x - ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2);
      }
      else if(vec.x + stepSize > width && y > 0) //walk algo took route 6 so shift back down-left
      {
        vec.x = vec.x - ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y + ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2);    
      }
      else if(vec.x + stepSize > width && y < 0) //walk algo took route 1 so shift back up-left
      {
        vec.x = vec.x - ((float)stepSize * (float)stepScale * (float)3  / (float)2); 
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3)  / (float)2);    
      }
      else if(vec.y + stepSize > height && x == 0) //walk algo took route 2 so shift back upwards
      {
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3));
      }
      else if(vec.y + stepSize > height && x < 0 ) //walk algo took route 3 so shift back up-right
      {
       vec.x = vec.x + ((float)stepSize * (float)stepScale * (float)3 / (float)2); 
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3) / (float)2);  
      }
      else if(vec.y + stepSize > height && x > 0 ) //walk algo took route 1 so shift back up-left
      {
        vec.x = vec.x - ((float)stepSize * (float)stepScale * (float)3  / (float)2); 
        vec.y = vec.y - ((float)stepSize * (float)stepScale * (float)sqrt(3)  / (float)2);  
      }
    }
  }
  void CheckHashMap()
  {
    if(hash.containsKey(vec))
    {
      hash.put(vec,hash.get(vec) + 1);
    }
  }
  void hexagon(float x, float y, float r)
  {
   
   beginShape();
    vertex(x - r, y - (float)sqrt(3) * r);
    vertex(x + r, y - (float)sqrt(3) * r);
    vertex(x + 2 * r, y);
    vertex(x + r, y + (float)sqrt(3) * r);
    vertex(x - r, y + (float)sqrt(3) * r);
    vertex(x - 2 * r, y);
    
    endShape(CLOSE);
  }
  void CheckForSimulate()
{
  if(!simulate)
  {
    r = 186;
    g = 85;
    b = 211;
  }
  else
  {
    if(hash.containsKey(vec))
    {
      if(hash.get(vec) < 4)
      {
        r = 160;
        g = 126;
        b = 84;
      }
      else if(hash.get(vec) >= 4 && hash.get(vec) < 7)
      {
        r = 143;
        g = 170;
        b = 64;
      }
      else if(hash.get(vec) >= 7 && hash.get(vec) < 10)
      {
        r = 135;
        g = 135;
        b = 135;
      }
      else
      {
        r = hash.get(vec) * 20;
        g = hash.get(vec) * 20;
        b = hash.get(vec) * 20;
        if(r > 255)
        {
          r = 255;
        }
        if(g > 255)
        {
          g = 255;
        }
        if(b > 255)
        {
          b = 255;
        }
      }
    }
  }
}
}
