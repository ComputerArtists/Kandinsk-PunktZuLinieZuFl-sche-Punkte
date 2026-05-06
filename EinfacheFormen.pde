void setup() {
  size(800, 600);
  background(255);
  noStroke();

  zeichnen();
}

void draw() {
  // alles passiert in setup()
}

void zeichnen(){
  background(255);
  drawTriangles();
  drawSquares();
  drawCircles();
}

// ------------------
// GELBE DREIECKE
// ------------------
void drawTriangles() {
  int N_TRI = int(random(3, 36));
  for (int i = 0; i < N_TRI; i++) {
    // Gelbtöne: hohes R + G, wenig B
    fill(random(200, 255), random(180, 230), random(0, 80), 200);

    float x = random(width);
    float y = random(height);
    float s = random(30, 120);

    triangle(
      x, y,
      x + random(-s, s), y + random(-s, s),
      x + random(-s, s), y + random(-s, s)
    );
  }
}

// ------------------
// ROTE QUADRATE
// ------------------
void drawSquares() {
  
  int N_SQ = int(random(3, 36));
  
  for (int i = 0; i < N_SQ; i++) {
    // Rottöne: hohes R, wenig G/B
    fill(random(180, 255), random(0, 80), random(50, 120), 200);

    float x = random(width);
    float y = random(height);
    float s = random(20, 100);

    rectMode(CENTER);
    rect(x, y, s, s);
  }
}

// ------------------
// BLAUE KREISE
// ------------------
void drawCircles() {
  
  int N_CIR = int(random(3, 36));
  
  for (int i = 0; i < N_CIR; i++) {
    // Blautöne: hohes B, etwas G, wenig R
    fill(random(0, 80), random(80, 150), random(180, 255), 200);

    float x = random(width);
    float y = random(height);
    float r = random(20, 100);

    ellipse(x, y, r, r);
  }
}

void keyPressed() {
  if (key == 'n') {
    zeichnen();
  }
  if (key == 's' || key == 'S') {
    saveFrame("muster-kreise-####.png");
    println("Gespeichert!");
  }
}
