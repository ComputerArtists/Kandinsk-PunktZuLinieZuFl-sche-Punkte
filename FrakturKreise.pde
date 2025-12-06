// Muster-Farben-Kreise
// Leertaste → neue Komposition
// s → speichern (perfekt für 4K-Drucke)

void setup() {
  size(1200, 1200);
  colorMode(HSB, 360, 100, 100, 100);  // für sanfte Farbübergänge
  background(0, 0, 98);                // fast weißes Papier
  noStroke();
  generate();
  // Für 4K einfach: size(3840, 3840);
}

void draw() {
  // alles in generate()
}

void generate() {
  background(0, 0, 98);
  randomSeed(millis());

  int numCircles = 180;  // 120–300 sehen toll aus

  for (int i = 0; i < numCircles; i++) {
    float x = random(width);
    float y = random(height);
    float radius = random(20, 280);

    // Muster-typische Farbpalette (türkis – magenta – gold – rosa – mint)
    float hue = random(360);
    if (hue > 180 && hue < 300) hue += 120;  // bevorzugt Türkis- und Magenta-Töne
    
    float sat = random(40, 95);
    float bri = random(80, 100);
    float alpha = random(60, 95);

    // sanfter Farbverlauf im Kreis selbst
    for (int r = int(radius); r > 0; r--) {
      float inter = map(r, 0, radius, 0, 1);
      float cHue = (hue + inter * 40) % 360;           // leichter Farbdreh
      float cBri = bri - inter * 20;
      float cAlpha = alpha * (r / radius);

      fill(cHue, sat, cBri, cAlpha);
      circle(x, y, r * 2);
    }

    // gelegentlich ein zarter schwarzer oder weißer Rand
    if (random(1) < 0.25) {
      noFill();
      stroke(0, 30);
      strokeWeight(random(1, 4));
      circle(x, y, radius * 2 + random(5, 20));
    }
  }
}

void keyPressed() {
  if (key == ' ') {
    generate();
  }
  if (key == 's' || key == 'S') {
    saveFrame("muster-kreise-####.png");
    println("Gespeichert!");
  }
}
