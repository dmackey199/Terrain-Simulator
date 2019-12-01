import controlP5.*;
import java.util.*;

ControlP5 cp5;

Textlabel tl;
ScrollableList sl;
Textlabel t2;

Shape shape;
int start = 0;

int maxSteps;
int stepRate;
int stepSize;
float stepScale;
boolean constrain;
boolean simulate;
boolean stroke;
boolean randSeed;
int seedVal;
float r,g,b;
//boolean stop = false;

int currIters;

void setup()
{
  frameRate(1000);
  stroke(0);
  size(1200,800);
  background(220,220,220);
  fill(110);
  rect(0,0,200,800);
  
  cp5 = new ControlP5(this);
  cp5.addButton("Start")
      .setPosition(10,20)
      .setCaptionLabel("Start")
      .setSize(80,30)
      .setColorBackground(color(50,205,50));
  List myList = Arrays.asList("Squares", "Hexagons");
  sl = cp5.addScrollableList("Squares")
          .setPosition(10,60)
          .setItemHeight(40)
          .setType(ScrollableList.DROPDOWN)
          .setBarHeight(40)
          .setSize(130,400)
          .setBackgroundColor(color(105))
          .addItems(myList)
          .setValue(0);
  tl = cp5.addTextlabel("textlabel")
          .setPosition(10, 195)
          .setText("Maximum Steps");
  cp5.addSlider("MaxSteps")
      .setPosition(10,205)
      .setSize(140,20)
      .setRange(100,50000)
      .getCaptionLabel()
      .setVisible(false);    
  tl = cp5.addTextlabel("tl2")
          .setPosition(10, 235)
          .setText("Step Rate");
  cp5.addSlider("StepRate")
      .setPosition(10,245)
      .setSize(140,20)
      .setRange(1,1000)
      .getCaptionLabel()
      .setVisible(false);
  cp5.addSlider("StepSize")
      .setCaptionLabel("Step Size")
      .setPosition(10,300)
      .setSize(70,20)
      .setRange(10,30);
  cp5.addSlider("StepScale")
      .setCaptionLabel("Step Scale")
      .setPosition(10,330)
      .setSize(70,20)
      .setRange(1.0,1.5);
  cp5.addToggle("Constrain")
      .setCaptionLabel("Constrain Steps")
      .setPosition(10,380)
      .setSize(20,20);
  cp5.addToggle("Simulate")
      .setCaptionLabel("Simulate Terrain")
      .setPosition(10,420)
      .setSize(20,20);
  cp5.addToggle("Stroke")
      .setCaptionLabel("Use Stroke")
      .setPosition(10,460)
      .setSize(20,20);
  cp5.addToggle("RandSeed")
      .setCaptionLabel("Use Random Seed")
      .setPosition(10,500)
      .setSize(20,20);
  cp5.addTextfield("SeedVal")
      .setCaptionLabel("Seed Value")
      .setInputFilter(ControlP5.INTEGER)
      .setPosition(125,500)
      .setSize(40,20);
}
void draw()
{
  if(start > 0)
  {
      if(sl.getValue() == 0) //squares is chosen
      {
        CheckForStroke(shape.stroke);
        shape.Draw();
      }
      else if(sl.getValue() == 1)    //hexagons is chosen
      {
        CheckForStroke(shape.stroke);
        shape.Draw();
      }
  }
  fill(110);
  stroke(0);
  rect(0,0,200,800);
  
}
void Start()
{
  currIters = 0;
  start++;
  if(sl.getValue() == 0)
  {
    background(220,220,220);
    shape = new Square(maxSteps,stepRate,stepSize,stepScale,constrain,simulate,stroke);
  }
  else if(sl.getValue() == 1)
  {
    background(30,144,255);
    shape = new Hexagon(maxSteps,stepRate,stepSize,stepScale,constrain,simulate,stroke);
  }
  
  if(randSeed)
  {
    randomSeed(seedVal);
  }
}
void MaxSteps(int val)
{
  maxSteps = val;
}
void StepRate(int val)
{
  stepRate = val;
}
void StepSize(int val)
{
  stepSize = val;
}
void StepScale(float val)
{
  stepScale = val;
}
void Constrain(boolean bool)
{
  constrain = bool;
}
void Simulate(boolean bool)
{
  simulate = bool;
}
void Stroke(boolean bool)
{
  stroke = bool;
}
void RandSeed(boolean bool)
{
  randSeed = bool;
}
void SeedVal(String val)
{
  seedVal = Integer.parseInt(val);
}

void CheckForStroke(boolean bool)
{  
  if(bool)
  {
      stroke(0);
  }
  else
  {
    noStroke();
  }
}
