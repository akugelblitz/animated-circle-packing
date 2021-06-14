PImage img; 
ArrayList<Circle> circles; 

void setup() {
  size(500, 333); 
  circles = new ArrayList<Circle>();
  img = loadImage("rick.jpeg");
  img.loadPixels();
}

void draw() {
  //frameRate(1);
  background(0); 
  int total = 100;
  int count = 0;
  int attempts = 0;
  while (count < total) {
    Circle newC = newCircle();
    if (newC != null)
    {
      println(newC);
      circles.add(newC);
      count ++;
    } else {
      attempts++;
    }
    if (attempts > 1000) {
      noLoop();
      println("Finished");

      break;
    }
  }

  for (Circle c : circles) {
    if (c.edges())
    {
      c.growing = false;
    } else 
    {
      for (Circle other : circles) 
      {
        if (c!= other) 
        {
          float d = dist(c.x, c.y, other.x, other.y);
          if (d< c.r + other.r + 2.2)
          {
            c.growing = false; 
            //break;
          }
        }
      }
    }
    c.show();
    c.grow();
  }
}

Circle newCircle() {
  float x = random(width);
  float y = random(height);


  boolean valid = true;
  for (Circle c : circles) {
    float d = dist(x, y, c.x, c.y);
    if (d < c.r + 1) {
      valid = false;
      break;
    }
  }
  if (valid) {
    int index = int(x) + (int(y) * img.width);
    color col = img.pixels[index];
    return new Circle(x, y, col);
  } else {
    return null;
  }
}
