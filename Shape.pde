abstract class Shape
{
  abstract void Update();
  abstract void Draw();
  abstract void CheckHashMap();
  abstract void CheckForSimulate();
  PVector vec = new PVector(700,400);
  HashMap<PVector, Integer> hash = new HashMap<PVector, Integer>();
  int maxSteps;
  int stepRate;
  int stepSize;
  double stepScale;
  boolean constrain;
  boolean simulate;
  boolean stroke;
}
