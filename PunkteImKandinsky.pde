// Kandinsky-inspired Composition
// Generative, aber immer im Kandinsky-Geist
// Drücke die Leertaste für eine neue Komposition

void setup() {
  size(1000, 700);
  colorMode(RGB, 255);
  background(245, 240, 225);  // Leicht cremefarbener Hintergrund wie bei Kandinsky
  noLoop();
  generateKandinsky();
}

void draw() {
  // Alles passiert in generateKandinsky()
}

void generateKandinsky() {
  background(245, 240, 225);
  randomSeed(millis());  // jede Komposition einzigartig

  // 1. Großes schwarzes Gitter im Hintergrund (wie in Komposition VIII)
  drawGrid();

  // 2. Große geometrische Formen (Kandinsky liebte Kreise!)
  drawLargeCircles();

  // 3. Dreiecke und scharfe Formen
  drawTriangles();

  // 4. Viele kleine Punkte und Linien
  drawPointsAndLines();

  // 5. Feine Überlagerung von transparenten Formen
  drawOverlays();
}

// -------------------------------------------------
void drawGrid() {
  stroke(20);
  strokeWeight(1.5);
  int step = 50;
  for (int x = 0; x < width; x += step) {
    float offset = random(-15, 15);
    line(x + offset, 0, x + offset, height);
  }
  for (int y = 0; y < height; y += step) {
    float offset = random(-15, 15);
    line(0, y + offset, width, y + offset);
  }
}

void drawLargeCircles() {
  noStroke();
  int[] colors = { 
    color(220, 20, 60),   // Crimson Rot
    color(30, 50, 180),   // Tiefes Blau
    color(255, 215, 0),   // Sonnengelb
    color(0),             // Schwarz
    color(255)            // Weiß
  };

  for (int i = 0; i < 8; i++) {
    float x = random(100, width-100);
    float y = random(100, height-100);
    float r = random(40, 180);
    fill(colors[int(random(colors.length))], random(180, 255));
    circle(x, y, r*2);

    // Kandinsky liebte doppelte Kreise / Ringe
    if (random(1) < 0.6) {
      stroke(0);
      strokeWeight(random(3, 10));
      noFill();
      circle(x, y, r*2 + random(10, 30));
    }
  }
}

void drawTriangles() {
  for (int i = 0; i < 12; i++) {
    pushMatrix();
    float x = random(width);
    float y = random(height);
    translate(x, y);
    rotate(random(TWO_PI));

    fill(random(1) < 0.5 ? color(220,20,60) : color(30,50,180), 220);
    noStroke();
    triangle(-40, 40, 0, -50, 40, 40);

    if (random(1) < 0.4) {
      stroke(0);
      strokeWeight(4);
      noFill();
      triangle(-40, 40, 0, -50, 40, 40);
    }
    popMatrix();
  }
}

void drawPointsAndLines() {
  strokeWeight(3);
  for (int i = 0; i < 400; i++) {
    float x = random(width);
    float y = random(height);
    if (random(1) < 0.3) {
      // Punkte
      stroke(0);
      point(x, y);
      if (random(1) < 0.2) {
        stroke(220,20,60);
        point(x+random(-8,8), y+random(-8,8));
      }
    } else {
      // Kurze Linien
      stroke(0);
      float len = random(20, 120);
      float ang = random(TWO_PI);
      line(x, y, x + cos(ang)*len, y + sin(ang)*len);
    }
  }
}

void drawOverlays() {
  blendMode(MULTIPLY);
  noStroke();
  fill(255, 200, 0, 30);
  for (int i = 0; i < 5; i++) {
    circle(random(width), random(height), random(200, 500));
  }
  blendMode(BLEND);
}

// -------------------------------------------------
void keyPressed() {
  if (key == ' ') {
    generateKandinsky();
    redraw();
  }
  if (key == 's' || key == 'S') {
    saveFrame("kandinsky-####.png");
    println("Kandinsky-Komposition gespeichert!");
  }
}
