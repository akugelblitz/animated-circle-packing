PImage img; 
ArrayList<PVector> spots;
ArrayList<Circle> circles; 

void setup() {
  size(733, 300); 
  spots = new ArrayList<PVector>();
  circles = new ArrayList<Circle>();
  img = loadImage("text.png");
  img.loadPixels();
  
  for(int i = 0; i < img.width; i++)
  {
    for(int j = 0; j< img.height; j++)
    {
      int index = i + j*img.width;
      color c = img.pixels[index];
      float b = brightness(c);
      if(b > 10){
        spots.add(new PVector(i, j));
      }
    }
  }
  println(spots.size());
  
}

void draw() {
  background(0); 
  int total = 10;
  int count = 0;
  int attempts = 0;
  while (count < total) {
    Circle newC = newCircle();
    if (newC != null)
    {
      circles.add(newC);
      count ++;
    }
    attempts++;
    if (attempts > 100) {
      noLoop();
      println("Finished");
      break;
    }
  }
  for (Circle c : circles) {
    if (c.growing) {
      if (c.edges()) {
        c.growing = false;
      } else {
        for (Circle other : circles) {
          if (c!= other) {
            float d = dist(c.x, c.y, other.x, other.y);
            if (d< c.r + other.r + 2.2) {
              c.growing = false; 
              break;
            }
          }
        }
      }
    }
    c.show();
    c.grow();
  }
}

Circle newCircle() {
  int ran = int(random(spots.size()));
  PVector spot = spots.get(ran);
  float x = spot.x;
  float y = spot.y;
  boolean valid = true;
  for (Circle c : circles) {
    float d = dist(x, y, c.x, c.y);
    if (d < c.r + 1) {
      valid = false;
      break;
    }
  }
  if (valid) {
    return new Circle(x, y);
  } else {
    return null;
  }
}
