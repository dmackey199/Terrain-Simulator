class Square extends Shape
{
  Square(int maxSteps,int stepRate,int stepSize,float stepScale,boolean constrain,boolean simulate,boolean stroke)
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
        Clamp();
        if(!hash.containsKey(vec))
        {
          hash.put(vec,0);
        }
        CheckHashMap();
        CheckForSimulate();
        fill(r,g,b);
        square(vec.x,vec.y, stepSize);
      }
      currIters += stepRate;
      /*if(currIters >= maxSteps)
      {
        stop = true;
      }*/
    }
  }
  void Update()
  {
    int rand = (int) random(1,5);
    switch(rand)
    {
      case 1:
        vec.y = (float)(vec.y - (stepSize * stepScale));
        break;
      case 2:
        vec.y = (float)(vec.y + (stepSize * stepScale));
        break;
      case 3:
        vec.x = (float)(vec.x - (stepSize * stepScale));
        break;
      case 4:
        vec.x = (float)(vec.x + (stepSize * stepScale));
        break;
    }
  }
  void Clamp()
  {
    if(!constrain)
    {
      if(vec.x < 0)
      {
        vec.x = vec.x + (float)(stepSize * stepScale);   
      }
      if(vec.x + (stepSize * stepScale) > width)
      {
        vec.x = vec.x - (float)(stepSize * stepScale);    
      }
      if(vec.y < 0)
      {
        vec.y = vec.y + (float)(stepSize * stepScale); 
      }
      if(vec.y + (stepSize * stepScale) > height)
      {
        vec.y = vec.y - (float)(stepSize * stepScale);    
      }
    }
    else
    {
      if(vec.x < 200)
      {
        vec.x = vec.x + (float)(stepSize * stepScale);  
      }
      if(vec.x + (stepSize * stepScale) > width)
      {
        vec.x = vec.x - (float)(stepSize * stepScale); 
      }
      if(vec.y < 0)
      {
        vec.y = vec.y + (float)(stepSize * stepScale);
      }
      if(vec.y + (stepSize * stepScale) > height)
      {
        vec.y = vec.y - (float)(stepSize * stepScale);    
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
