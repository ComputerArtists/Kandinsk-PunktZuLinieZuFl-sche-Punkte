// GRAFISCHE PARTITUR – nur Kreise & Punkte
// Leertaste = neue Partitur
// 's' = speichern (ideal für 4K-Drucke)

int voices = 12;           // Anzahl der Stimmen / horizontalen Spuren
float duration = 24;       // Länge der Partitur in "Takten"

void setup() {
  size(1400, 900);
  background(252, 248, 240);    // warmes Papier
  generateScore();
  noLoop();
}

void draw() {
  // alles in generateScore()
}

void generateScore() {
  background(252, 248, 240);
  randomSeed(millis());

  float margin = 100;
  float usableW = width - 2*margin;
  float usableH = height - 2*margin;
  float lineStep = usableH / (voices + 1);

  // --- 12 horizontale Linien (unsichtbar, aber als Referenz) ---
  stroke(180, 160, 120, 40);
  strokeWeight(0.8);
  for (int i = 1; i <= voices; i++) {
    float y = margin + i * lineStep;
    line(margin, y, width-margin, y);
  }

  // --- Ereignisse (Noten) erzeugen ---
  for (int v = 0; v < voices; v++) {
    float baseY = margin + (v + 1) * lineStep;

    int events = int(random(4, 14));  // 4–13 Noten pro Stimme

    for (int i = 0; i < events; i++) {
      float t = random(0, duration);          // Zeitposition
      float x = map(t, 0, duration, margin, width-margin);

      float pitchVariation = sin(t * 0.3 + v) * 30;  // sanfte Tonhöhe
      float y = baseY + pitchVariation;

      float intensity = random(0.3, 1.0);     // Lautstärke/Dichte
      float size = map(intensity, 0.3, 1.0, 6, 48);

      // Zufällige Notenform (Kreis, Ring, Punkt, Doppelkreis…)
      int form = int(random(6));

      if (form == 0) {                    // gefüllter Kreis
        fill(20, 40, 80, 180);
        noStroke();
        circle(x, y, size);
      }
      else if (form == 1) {               // offener Kreis
        noFill();
        stroke(20, 40, 80);
        strokeWeight(2.5);
        circle(x, y, size);
      }
      else if (form == 2) {               // kleiner Kern + großer Ring
        fill(20, 40, 80);
        circle(x, y, size * 0.25);
        noFill();
        stroke(20, 40, 80, 120);
        strokeWeight(1.5);
        circle(x, y, size * 1.8);
      }
      else if (form == 3) {               // winziger Punkt (Staccato)
        fill(20);
        noStroke();
        circle(x, y, 4 + intensity*8);
      }
      else if (form == 4) {               // transparente große Blase
        noStroke();
        fill(20, 40, 80, 30);
        circle(x, y, size * 2.5);
        fill(20, 40, 80, 80);
        circle(x, y, size * 0.6);
      }
      else {                              // Cluster aus kleinen Punkten
        for (int k = 0; k < 8; k++) {
          float ax = x + random(-12, 12);
          float ay = y + random(-12, 12);
          fill(20, random(100, 255));
          circle(ax, ay, random(2, 9));
        }
      }

      // Feine vertikale Zeitlinie bei starken Ereignissen
      if (intensity > 0.85 && random(1) < 0.4) {
        stroke(20, 40, 80, 60);
        strokeWeight(0.8);
        line(x, margin, x, height-margin);
      }
    }
  }

  // Titel in der Ecke (optional)
  fill(20, 40, 80, 100);
  textAlign(LEFT, TOP);
  textSize(18);
  text("Grafische Partitur No. " + int(random(1, 999)), margin, margin - 60);
}

void keyPressed() {
  if (key == ' ') {
    generateScore();
    redraw();
  }
  if (key == 's' || key == 'S') {
    saveFrame("partitur-####.png");
    println("Partitur gespeichert!");
  }
}
