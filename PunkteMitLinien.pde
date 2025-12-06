// Processing: Connecting Dots mit automatischem PNG-Export
// Drücke "r" zum Starten der Aufnahme, "s" zum Speichern eines einzelnen Frames

ArrayList<Particle> particles;
boolean recording = false;      // wird mit "r" ein-/ausgeschaltet
int frameCountStart = 0;

void setup() {
  size(1000, 700, P2D);        // P2D ist schneller bei vielen Linien
  generateParticles(140);
  background(10, 10, 30);
  smooth();
}

void draw() {
  background(10, 10, 30);

  for (Particle p : particles) {
    p.update();
    p.display();
  }

  // ---- Verbindungen ----
  strokeWeight(0.7);
  for (int i = 0; i < particles.size(); i++) {
    Particle p1 = particles.get(i);
    for (int j = i+1; j < particles.size(); j++) {
      Particle p2 = particles.get(j);
      float d = dist(p1.x, p1.y, p2.x, p2.y);
      if (d < 140) {
        float alpha = map(d, 0, 140, 200, 0);
        stroke(180, 220, 255, alpha);
        line(p1.x, p1.y, p2.x, p2.y);
      }
    }
  }

  // ---- Export ----
  if (recording) {
    int currentFrame = frameCount - frameCountStart;
    saveFrame("export/frames-####.png");   // speichert als frames-0001.png usw.
    
    // Optional: nach z. B. 600 Frames automatisch stoppen
    if (currentFrame > 600) {
      recording = false;
      println("Export fertig – 600 Frames gespeichert!");
    }
  }
}

// -------------------------------------------------
void keyPressed() {
  if (key == 'r' || key == 'R') {          // Aufnahme starten/stoppen
    if (!recording) {
      // Neuen Ordner anlegen falls nicht vorhanden
      File folder = new File(sketchPath("export"));
      if (!folder.exists()) folder.mkdir();
      
      frameCountStart = frameCount;
      recording = true;
      println("Aufnahme gestartet – Frames werden in /export gespeichert");
    } else {
      recording = false;
      println("Aufnahme gestoppt");
    }
  }
  
  if (key == 's' || key == 'S') {          // Einzelbild speichern
    saveFrame("snapshot-####.png");
    println("Einzelbild gespeichert");
  }
  
  if (key == ' ') {                        // Neue zufällige Konfiguration
    generateParticles(int(random(80, 180)));
    background(10, 10, 30);
  }
}

// Der Rest bleibt gleich (Particle-Klasse + generateParticles)
class Particle {
  float x, y, vx, vy;
  float speed = 0.6;

  Particle() {
    x = random(width);
    y = random(height);
    float angle = random(TWO_PI);
    vx = cos(angle) * speed;
    vy = sin(angle) * speed;
  }

  void update() {
    x += vx; y += vy;
    if (x < 0 || x > width)  vx *= -1;
    if (y < 0 || y > height) vy *= -1;
    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }

  void display() {
    noStroke();
    fill(200, 230, 255);
    circle(x, y, 7);
    fill(255);
    circle(x, y, 3);
  }
}

void generateParticles(int num) {
  particles = new ArrayList<Particle>();
  for (int i = 0; i < num; i++) particles.add(new Particle());
}
