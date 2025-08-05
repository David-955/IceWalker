let flag, menu;
let fonte16, fonte32;
let niveau;
let balleX, balleY;
let start = 1;
let goalX, goalY;
let etat = 0;
let grid = [];
let sonVex;
let niveauActuel = 1;
let cellSize;
let offsetX, offsetY;

function preload() {
  flag = loadImage("flag.png");
  menu = loadImage("ice.png");
  fonte16 = loadFont("joystix.ttf");
  fonte32 = loadFont("joystix.ttf");
  sonVex = loadSound("Vexento - We Are One - extrait.mp3");
  // Chargement du premier niveau
  niveau = loadStrings("niveau1.iwk");
}

function setup() {
  createCanvas(900, 700);
  textAlign(CENTER, CENTER);
  processNiveau(niveau);
}

function draw() {
  if (etat === 0) {
    drawMenu();
  } else if (etat === 1) {
    drawPlateau();
    drawBalle();
    checkGoal();
  }
}

function drawMenu() {
  image(menu, 0, 0);
  textFont(fonte32);
  fill(255);
  text("ICE WALKER", width/2, 70);
  text("By David Ngo", width/2, 90);
  text("> ESPACE < start", width/2, 650);
  
  textFont(fonte16);
  textAlign(LEFT, TOP);
  text("Aide:", 30, 140);
  text("Principe du jeu:", 30, 190);
  text("Le but du jeu est d'atteindre le drapeau vert.", 20, 220);
  text("Vous glissez sur la glace jusqu'à rencontrer un mur.", 20, 250);
  text("Commandes:", 30, 380);
  text("- Flèches directionnelles", 20, 410);
  text("- 'R' pour redémarrer", 20, 440);
  textAlign(CENTER, CENTER);
}

function keyPressed() {
  if (keyCode === 32 && etat === 0) {  // ESPACE
    etat = 1;
    if (sonVex.isLoaded()) {
      sonVex.loop();
    }

  } else if (key === 'r' || key === 'R') {
    loadNiveau(niveauActuel);
  } else if (etat === 1) {
    if (keyCode === LEFT_ARROW) moveBalle(-1, 0);
    else if (keyCode === RIGHT_ARROW) moveBalle(1, 0);
    else if (keyCode === UP_ARROW) moveBalle(0, -1);
    else if (keyCode === DOWN_ARROW) moveBalle(0, 1);
  }
  return false; // Empêche le comportement par défaut
}

function loadNiveau(n) {
  niveauActuel = n;
  loadStrings(`niveau${n}.iwk`, (lines) => {
    processNiveau(lines);
  });
}

function processNiveau(lines) {
  // Supprime les lignes vides et les espaces
  grid = lines.filter(line => line.trim() !== "")
              .map(line => line.trim().split("").map(c => parseInt(c)));
  
  // Calcule la taille des cellules et les offsets
  calcCellSize();
  
  // Trouve la position de la balle et du but
  for (let j = 0; j < grid.length; j++) {
    for (let i = 0; i < grid[j].length; i++) {
      if (grid[j][i] === 2) {
        balleX = i;
        balleY = j;
      } else if (grid[j][i] === 3) {
        goalX = i;
        goalY = j;
      }
    }
  }
}

function calcCellSize() {
  if (grid.length === 0 || grid[0].length === 0) return;
  
  // Calcule la taille des cellules pour s'adapter au canvas
  cellSize = min(width / grid[0].length, height / grid.length);
  offsetX = (width - grid[0].length * cellSize) / 2;
  offsetY = (height - grid.length * cellSize) / 2;
}

function drawPlateau() {
  background(0);
  
  for (let j = 0; j < grid.length; j++) {
    for (let i = 0; i < grid[j].length; i++) {
      let x = i * cellSize + offsetX;
      let y = j * cellSize + offsetY;
      
      if (grid[j][i] === 1) {
        fill(156, 158, 162); // Mur
      } else {
        fill(23, 159, 215);  // Glace
      }
      rect(x, y, cellSize, cellSize);
      
      if (grid[j][i] === 3) {
        image(flag, x + cellSize/4, y + cellSize/4, cellSize/2, cellSize/2);
      }
    }
  }
}

function drawBalle() {
  fill(225, 169, 26);
  ellipse(
    balleX * cellSize + offsetX + cellSize/2,
    balleY * cellSize + offsetY + cellSize/2,
    cellSize * 0.8,
    cellSize * 0.8
  );
}

function moveBalle(dx, dy) {
  let nx = balleX;
  let ny = balleY;
  
  while (true) {
    let nextX = nx + dx;
    let nextY = ny + dy;
    
    if (!inBounds(nextX, nextY)) break;
    if (grid[nextY][nextX] === 1) break;
    
    nx = nextX;
    ny = nextY;
  }
  
  balleX = nx;
  balleY = ny;
}

function checkGoal() {
  if (balleX === goalX && balleY === goalY) {
    if (niveauActuel < 12) {
      loadNiveau(niveauActuel + 1);
    } else {
      // Tous les niveaux sont complétés
      etat = 0;
      niveauActuel = 1;
    }
  }
}

function inBounds(x, y) {
  return y >= 0 && y < grid.length && x >= 0 && x < grid[0].length;
}

// David Ngo - UEVE 2019
// Jeu de puzzle "Ice Walker" - Licence MIT