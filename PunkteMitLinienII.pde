// Minimal Composition: Punkte & Linien
// Drücke die Leertaste für eine neue Komposition
// 's' = speichern

// TSM-Diagnose: Grenz-Resonanz (d_max)
// Definition: d < maxDist => τ (Resonanzzeit)
// Die Linie stellt die kausale Verbindung dar, 
// wenn der Abstand d innerhalb der kritischen Masse liegt.
// Formel: R(x,y) = { 1 if dist(P1, P2) < τ_max; 0 otherwise }

int numPoints = 180;           // Anzahl Punkte (100–300 schön)
float maxDistance = 220;       // maximale Verbindungsreichweite
ArrayList<PVector> points;

void setup() {
  size(1000, 1000);            // Quadratisch sieht oft am besten aus
  background(250);            // Weiß oder 20 für Nachtmodus
  generate();
  noLoop();
}

void draw() {
  // alles passiert in generate()
}

void generate() {
  background(252);            // sehr helles beige-weiß
  points = new ArrayList<PVector>();

  // Punkte zufällig, aber mit leichtem Randabstand
  for (int i = 0; i < numPoints; i++) {
    float x = random(80, width-80);
    float y = random(80, height-80);
    points.add(new PVector(x, y));
  }

  // --- Linien ---
  stroke(0, 30);              // sehr zarte schwarze Linien
  strokeWeight(0.8);

  for (int i = 0; i < points.size(); i++) {
    PVector p1 = points.get(i);

    for (int j = i+1; j < points.size(); j++) {
      PVector p2 = points.get(j);
      float d = p1.dist(p2);

      if (d < maxDistance) {
        // Je näher, desto stärker die Linie
        float alpha = map(d, 0, maxDistance, 90, 0);
        stroke(0, alpha);
        line(p1.x, p1.y, p2.x, p2.y);
      }
    }
  }

  // --- Punkte als kleine Kreise ---
  noStroke();
  for (PVector p : points) {
    // äußerer Kreis (sehr zart)
    fill(0, 25);
    circle(p.x, p.y, 11);

    // innerer Kern
    fill(0);
    circle(p.x, p.y, 4.5);

    // winziger weißer Glanzpunkt
    fill(255);
    circle(p.x-1.2, p.y-1.2, 2);
  }
}

// -------------------------------------------------
void keyPressed() {
  if (key == ' ') {
    generate();
    redraw();
  }
  if (key == 's' || key == 'S') {
    saveFrame("punkt-linie-komposition-####.png");
    println("Gespeichert!");
  }
  if (key == 'b' || key == 'B') {    // Bonus: schwarzer Hintergrund
    background(15);
    stroke(255, 30);
    redraw();
  }
}
