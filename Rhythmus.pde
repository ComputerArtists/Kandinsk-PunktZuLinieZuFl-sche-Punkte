// RHYTHM OF CIRCLES – korrigierte Version
// Leertaste = neue Rhythmik
// Pfeiltasten hoch/runter = Tempo ändern
// 's' = Bild speichern

float time = 0;
float bpm = 120;        // Start-Tempo (60–240 schön)
float beatTime;

ArrayList<Orb> orbs;

void setup() {
  size(1000, 1000);
  colorMode(HSB, 360, 100, 100, 100);
  background(0);
  beatTime = 60.0 / bpm;
  createOrbs();
}

void draw() {
  background(0, 0, 8);        // sehr leichtes Fade für sanften Trail
  
  time += 1.0 / frameRate;
  float phase = (time % beatTime) / beatTime;   // 0.0 → 1.0 pro Beat

  for (Orb o : orbs) {
    o.update(phase);
    o.display();  // Jetzt korrekt aufgerufen
  }
}

void createOrbs() {
  orbs = new ArrayList<Orb>();
  int num = 48;                                   // schön: 32–80
  
  for (int i = 0; i < num; i++) {
    float angle = map(i, 0, num, 0, TWO_PI);
    float dist = map(i % 12, 0, 12, 120, 420);     // rhythmische Abstände
    float x = width/2  + cos(angle) * dist;
    float y = height/2 + sin(angle) * dist;
    
    orbs.add(new Orb(x, y, i));
  }
}

// -------------------------------------------------
class Orb {
  float x, y;
  int index;
  float baseSize = 8;
  
  // Neue Variablen für den State (aus update())
  float pulse;
  float size;
  float bright;
  float alpha;
  
  Orb(float x_, float y_, int i) {
    x = x_;
    y = y_;
    index = i;
  }
  
  void update(float phase) {
    // Jeder Orb hat seinen eigenen Rhythmus-Teiler
    int divisor = (index % 7 == 0) ? 8 :     // seltene Akzente
                  (index % 5 == 0) ? 4 :
                  (index % 3 == 0) ? 2 : 1;
                  
    float localPhase = phase * divisor;
    if (divisor >= 4) localPhase = fract(localPhase * 0.5);
    
    pulse = abs(sin(localPhase * PI));   // 0 → 1 → 0 pro Zyklus
    size = baseSize + pulse * 42;
    bright = 70 + pulse * 30;
    alpha = 80 + pulse * 20;
  }
  
  void display() {
    // Rendering der Kreise
    noStroke();
    fill(220, 60, bright, alpha);              // kühles Weiß-Blau
    circle(x, y, size);
    
    // starker Kern bei vollem Puls
    if (pulse > 0.94) {
      fill(220, 20, 100);
      circle(x, y, size * 0.4);
    }
    
    // feiner äußerer Ring
    noFill();
    stroke(220, 30, bright/2, pulse*40);
    strokeWeight(2);
    circle(x, y, size * 1.6);
  }
}

// kleine Hilfsfunktion
float fract(float x) { return x - floor(x); }

// -------------------------------------------------
void keyPressed() {
  if (key == ' ') {
    background(0);
    createOrbs();
  }
  if (keyCode == UP)    bpm = constrain(bpm + 8, 60, 240);
  if (keyCode == DOWN)  bpm = constrain(bpm - 8, 60, 240);
  if (key == 's' || key == 'S') saveFrame("rhythm-circles-####.png");
  
  if (keyCode == UP || keyCode == DOWN) beatTime = 60.0 / bpm;
}
