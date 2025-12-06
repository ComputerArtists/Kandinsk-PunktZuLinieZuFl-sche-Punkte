// Nur Kreise – 4 verschiedene Stilrichtungen
// Taste 1–4 wechseln den Modus
// Leertaste = neue Variation
// 's' = speichern (4K-fähig!)

int mode = 1;          // 1–4
float radiusNoise = 0.02;

void setup() {
  size(1000, 1000);
  background(252);
  noStroke();
  generate();
  // für 4K einfach: size(3840, 2160);
}

void draw() {
  // alles in generate()
}

void generate() {
  background(252);

  if (mode == 1)      mondrianCircles();      // bunt, überlappend, flächig
  else if (mode == 2) spiralGalaxy();         // spiralförmig, dichter Kern
  else if (mode == 3) gridCircles();          // regelmäßiges Gitter + Zufall
  else if (mode == 4) organicBubbles();       // organisch, transparent, weich
}

void keyPressed() {
  if (key >= '1' && key <= '4') {
    mode = key - '0';
    generate();
  }
  if (key == ' ') generate();
  if (key == 's' || key == 'S') {
    saveFrame("kreise-kunst-####.png");
    println("Gespeichert!");
  }
}

// ────────────────────── MODI ──────────────────────

void mondrianCircles() {
  color[] palette = {
    color(220, 40, 40),   // Rot
    color(30, 60, 180),   // Blau
    color(255, 220, 0),   // Gelb
    color(250),           // Weiß
    color(30)             // Schwarz
  };

  for (int i = 0; i < 280; i++) {
    float x = random(width);
    float y = random(height);
    float r = random(30, 280);

    fill(palette[int(random(palette.length))], 240);
    circle(x, y, r*2);

    if (random(1) < 0.25) {
      stroke(0);
      strokeWeight(random(3, 12));
      noFill();
      circle(x, y, r*2 + random(10, 40));
    }
  }
}

void spiralGalaxy() {
  int num = 1200;
  float cx = width/2;
  float cy = height/2;

  for (int i = 0; i < num; i++) {
    float angle = i * 0.17;
    float dist = pow(i / float(num), 0.8) * 420;

    float x = cx + cos(angle) * dist + random(-30, 30);
    float y = cy + sin(angle) * dist + random(-30, 30);
    float r = map(i, 0, num, 18, 1.5);

    float gray = map(i, 0, num, 255, 30);
    fill(gray, 220);
    circle(x, y, r*2);
  }
}

void gridCircles() {
  int cols = 28;
  int rows = 28;
  float stepX = width / float(cols);
  float stepY = height / float(rows);

  for (int ix = 0; ix < cols; ix++) {
    for (int iy = 0; iy < rows; iy++) {
      float x = ix * stepX + stepX/2;
      float y = iy * stepY + stepY/2;

      float n = noise(ix*0.1, iy*0.1, frameCount*0.001);
      float r = map(n, 0, 1, 5, stepX*0.9);

      fill(lerpColor(color(240, 50, 50), color(50, 50, 240), n));
      circle(x + random(-8, 8), y + random(-8, 8), r*2);
    }
  }
}

void organicBubbles() {
  blendMode(ADD);  // wunderschöner Glow-Effekt

  for (int i = 0; i < 600; i++) {
    float x = random(width);
    float y = random(height);
    float r = random(20, 180);

    color c = color(
      random(0, 80), 
      random(100, 200), 
      random(180, 255), 
      random(20, 80)
    );
    fill(c);
    circle(x, y, r*2);

    // zweiter, größerer Kreis für weichen Glow
    fill(red(c)*0.8, green(c)*0.8, blue(c)*0.8, 20);
    circle(x, y, r*2.8);
  }
  blendMode(BLEND);
}
