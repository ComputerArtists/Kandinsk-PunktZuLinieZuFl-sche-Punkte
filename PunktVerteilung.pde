// Processing Sketch: Zufällig verteilte Punkte

void setup() {
  size(800, 600);          // Fenstergröße
  background(20);          // Dunkler Hintergrund
  
  // Anzahl der Punkte
int anzahl = int(random(6, 20000));
  
  // Variante 1: Komplett zufällige weiße Punkte
  stroke(255);             // Weiße Farbe
  strokeWeight(2);         // Punktgröße
  
  for (int i = 0; i < anzahl; i++) {
    float x = random(width);
    float y = random(height);
    point(x, y);
  }
  
  // Optional: Speichern als Bild
  // save("verteilte_punkte.png");
}

void essayDRaw(){
  // Anzahl der Punkte
  int anzahl = int(random(6, 20000));
  
  
  // Variante 1: Komplett zufällige weiße Punkte
  stroke(255);             // Weiße Farbe
  strokeWeight(2);         // Punktgröße
  
  background(0);
  
  for (int i = 0; i < anzahl; i++) {
    float x = random(width);
    float y = random(height);
    point(x, y);
  }
}

void colorDRaw(){
  background(0);
  noStroke();
   int anzahl = int(random(6, 20000));
  
  for (int i = 0; i < anzahl; i++) {
    float x = random(width);
    float y = random(height);
    fill(random(100, 255), random(150, 255), 255, 80); // bunt + transparent
    circle(x, y, random(1, 6));
  }
}

void randomDRaw(){
  background(0);
  strokeWeight(1.5);
  
  int anzahl = int(random(6, 20000));
  
  for (int i = 0; i < anzahl; i++) {
    float x = random(width);
    float y = random(height);
    float bright = random(100, 255);
    stroke(bright);
    point(x, y);
    // Kleine "Glanzpunkte"
    if (random(1) < 0.05) {
      stroke(255, 200);
      point(x+random(-2,2), y+random(-2,2));
    }
  }
}

void poisonDRaw(){
  background(10);
  stroke(240);
  strokeWeight(1.8);
  
  int gridSize = 8;
  int cols = width / gridSize + 1;
  int rows = height / gridSize + 1;
  
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (random(1) < 0.7) {  // 70% Wahrscheinlichkeit pro Zelle
        float x = i * gridSize + random(-gridSize/2, gridSize/2);
        float y = j * gridSize + random(-gridSize/2, gridSize/2);
        x = constrain(x, 0, width);
        y = constrain(y, 0, height);
        point(x, y);
      }
    }
  }
}

void draw() {
  // Falls du später Animation möchtest, hier rein
}



void keyPressed() {
  char z = key;
  if (z == 's') saveFrame("punkte-####.png");
  if (z == 'e') essayDRaw();
  if (z == 'c') colorDRaw();
  if (z == 'r') randomDRaw();
  if (z == 'p') poisonDRaw();
}
