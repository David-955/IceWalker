// Importe les fonctionnalités Minim permettant de jouer la musique puisque "import processing.sound.*" ne semble pas fonctionner
// Source: https://flossmanuals.developpez.com/tutoriels/processing/?page=page_5#LV-F-1
import ddf.minim.*;
// Vexento contient le moteur Minim
Minim Vexento;
// SonVex contient les données audio
AudioPlayer SonVex;
// on déclare les variables de type PImage
PImage flag;
PImage menu;
// déclare des variables de type PFont
PFont fonte32;
PFont fonte16;
String niveau;     // niveau est associé à chaque fichier texte .iwk pour ensuite les charger
int balleX;        // position en X (horizontale) de la balle
int balleY;        // position en Y (verticale) de la balle
int start;         // start est associé à chaque niveau donc dès que start passera à 1, le programme chargera le niveau 1
int goal1;         // permet d'enregistrer la position en Y du drapeau
int goal;          // permet d'enregistrer la position en X du drapeau
int etat;          // etat permet de savoir si on est dans le menu (etat = 0) ou dans le jeu (etat = 1)
int up;            // repère pour savoir où est le carré gris sur l'axe Y
int k1;            // position du carré gris juste avant le drapeau du niveau 1
int k;             // position du carré gris en bas à droite du niveau 1

void setup() {
  // taille de la fenêtre, 900 pixels en horizontale par 700 pixels en verticale
  size(900, 700); 
  // charge la musique en mémoire
  Vexento = new Minim(this);
  SonVex = Vexento.loadFile("Vexento - We Are One - extrait.mp3");
  //  charge l'image du drapeau
  flag = loadImage("flag.png");
  menu = loadImage("ice.png");
  // crée les fontes, les mêmes que sur Flappy Dunk
  fonte16 = createFont("joystix.ttf", 16);
  fonte32 = createFont("joystix.ttf", 32);
  // initialise une partie du plateau: les carrés gris et la position de départ de la balle
  init();
}

void draw() {
  // Joue la musique dès le lancement du jeu
  SonVex.play();

  // quand etat est à 0, donc au lancement du programme, on sera dans le menu
  if (etat == 0) {
    image(menu, 0, 0);      // image de fond ice.png
    textFont(fonte32);      // choisit la fonte, ici taille 32
    text("ICE WALKER", 300, 70); 
    text("> ESPACE < start", 220, 650); 
    text("aide:", 30, 140);
    textFont(fonte16);      // choisit la fonte, taille 16
    // on affiche sur le menu principal les commandes pour démarrer le jeu et l'aide
    text("Principe du jeu:", 30, 190);
    text("Le but du jeu est d’atteindre le drapeau vert.", 20, 220);
    text("Le seul problème est que vous marchez sur de la glace.", 20, 250);
    text("Si  vous  allez  dans  une  direction,  vous  allez  glisser", 20, 280);
    text("jusqu’à  rencontrer  un  mur  (carré  gris).", 20, 310);
    text("Commandes:", 30, 380);
    text("- Flèches directionnelles (gauche, droite, haut, bas)", 20, 410);
    text("pour diriger la balle", 50, 440);
    text("- ‘R’ pour redémarrer le niveau", 20, 470);
  }

  // lorsque etat passe à 1, on génére le plateau du jeu et on sort du menu   
  if (etat == 1) {
    plateau();  // génére l'autre partie du plateau: les carrés bleus et le drapeau
  }
}

void plateau() {
  // start est associé à chaque niveau
  // start passe à 1 lorsque le joueur appuie sur la touche espace (pour sortir du menu)
  if (start == 1) {
    niveau = "niveau1.iwk";
  }
  if (start == 2) {
    niveau = "niveau2.iwk";
  }
  if (start == 4) {
    niveau = "niveau3.iwk";
  }
  if (start == 4) {
    niveau = "niveau4.iwk";
  }
  if (start == 5) {
    niveau = "niveau5.iwk";
  }
  if (start == 6) {
    niveau = "niveau6.iwk";
  }
  if (start == 7) {
    niveau = "niveau7.iwk";
  }
  if (start == 8) {
    niveau = "niveau8.iwk";
  }
  if (start == 9) {
    niveau = "niveau9.iwk";
  }
  if (start == 10) {
    niveau = "niveau10.iwk";
  }
  if (start == 11) {
    niveau = "niveau11.iwk";
  }
  if (start == 12) {
    niveau = "niveau12.iwk";
  }

  // lit le ﬁchier .iwk associé au niveau et retourne un tableau de String 
  String ligne[] = loadStrings(niveau);

  // boucle allant de 0 à 8 car il y a 9 numéros sur chaque ligne, permettant de générer les carrés bleus et les drapeaux
  for (int i=0; i<9; i++) {

    // ligne 0
    
    // lorsque sur la prenière ligne du fichier .iwk, le numéro est un 0 ou un 2, on génére un carré bleu
    if (ligne[0].charAt(i) - '0' == 0 || ligne[0].charAt(i) - '0' == 2) {
      fill(23, 159, 215);
      rect(i*100, 0, 100, 100);
      noFill();
    }

    // lorsque le numéro est un 3, on génére un carré bleu et on affiche l'image du drapeau
    if (ligne[0].charAt(i) - '0' == 3) {
      fill(23, 159, 215);          // couleur bleue pour le carré
      rect(i*100, 0, 100, 100);    // carré de 100x100 pixels 
      noFill();                    // une fois le carré bleu on arrête fill
      image(flag, (i*100)+25, 25); // l'image du drapeau sera au même endroit que le carré mais +25 en X et en Y pour bien centrer
      goal = i*100;                // on enregistre la position en X du drapeau
      goal1 = 50;                  // on enregistre la position en Y du drapeau
    }

    // ligne 1

    if (ligne[1].charAt(i) - '0' == 0 || ligne[1].charAt(i) - '0' == 2) {
      fill(23, 159, 215);
      rect(i*100, 100, 100, 100);
      noFill();
    }

    if (ligne[1].charAt(i) - '0' == 3) {
      fill(23, 159, 215);
      rect(i*100, 100, 100, 100);
      noFill();
      image(flag, (i*100)+25, 125); 
      goal = i*100;
      goal1 = 150;
    }

    // ligne 2

    if (ligne[2].charAt(i) - '0' == 0 || ligne[2].charAt(i) - '0' == 2) {
      fill(23, 159, 215);
      rect(i*100, 200, 100, 100);
      noFill();
    }

    if (ligne[2].charAt(i) - '0' == 3) {
      fill(23, 159, 215);
      rect(i*100, 200, 100, 100);
      noFill();
      image(flag, (i*100)+25, 225); 
      goal = i*100;
      goal1 = 250;
    }

    // ligne 3

    if (ligne[3].charAt(i) - '0' == 0 || ligne[3].charAt(i) - '0' == 2) {
      fill(23, 159, 215);
      rect(i*100, 300, 100, 100);
      noFill();
    }

    if (ligne[3].charAt(i) - '0' == 3) { 
      fill(23, 159, 215);
      rect(i*100, 300, 100, 100);
      noFill();
      image(flag, (i*100)+25, 325); 
      goal = i*100;
      goal1 = 350;
    }

    // ligne 4

    if (ligne[4].charAt(i) - '0' == 0 || ligne[4].charAt(i) - '0' == 2) {
      fill(23, 159, 215);
      rect(i*100, 400, 100, 100);
      noFill();
    }

    if (ligne[4].charAt(i) - '0' == 3) {
      fill(23, 159, 215);
      rect(i*100, 400, 100, 100);
      noFill();
      image(flag, (i*100)+25, 425); 
      goal = i*100;
      goal1 = 450;
    }

    // ligne 5

    if (ligne[5].charAt(i) - '0' == 0 || ligne[5].charAt(i) - '0' == 2) {
      fill(23, 159, 215);
      rect(i*100, 500, 100, 100);
      noFill();
    }

    if (ligne[5].charAt(i) - '0' == 3) { 
      fill(23, 159, 215);
      rect(i*100, 500, 100, 100);
      noFill();
      image(flag, (i*100)+25, 525); 
      goal = i*100;
      goal1 = 550;
    }

    // ligne 6

    if (ligne[6].charAt(i) - '0' == 0 || ligne[6].charAt(i) - '0' == 2) {
      fill(23, 159, 215);
      rect(i*100, 600, 100, 100);
      noFill();
    }

    if (ligne[6].charAt(i) - '0' == 3) {
      fill(23, 159, 215);
      rect(i*100, 600, 100, 100);
      noFill();
      image(flag, (i*100)+25, 625); 
      goal = i*100;
      goal1 = 650;
    }
  } 
  balle();  // on génére la balle qui prendra les coordonnées balleX et balleY
  goal();   // fonction permettant de vérifier lorsque la balle atteint le drapeau
} 

void init() {
  // lorssque l'on sort du menu en appuyant sur la touche espace, on démarre le jeu en chargeant une partie du plateau et l'autre partie est dans plateau()
  if (etat == 1) {
    // start passe à 1 lorsque le joueur appuie sur la touche espace (pour sortir du menu)
    if (start == 1) {
      niveau = "niveau1.iwk";
    }
    if (start == 2) {
      niveau = "niveau2.iwk";
    }
    if (start == 4) {
      niveau = "niveau3.iwk";
    }
    if (start == 4) {
      niveau = "niveau4.iwk";
    }
    if (start == 5) {
      niveau = "niveau5.iwk";
    }
    if (start == 6) {
      niveau = "niveau6.iwk";
    }
    if (start == 7) {
      niveau = "niveau7.iwk";
    }
    if (start == 8) {
      niveau = "niveau8.iwk";
    }
    if (start == 9) {
      niveau = "niveau9.iwk";
    }
    if (start == 10) {
      niveau = "niveau10.iwk";
    }
    if (start == 11) {
      niveau = "niveau11.iwk";
    }
    if (start == 12) {
      niveau = "niveau12.iwk";
    }

    String ligne[] = loadStrings(niveau);

    // on a préféré générer les carrés gris et les positions de départ dans void setup
    for (int i=0; i<9; i++) {

      // si à la première ligne, à chaque fois que le numéro est un 1, on génére un carré gris
      if (ligne[0].charAt(i) - '0' == 1) {
        fill(156, 158, 162);
        rect(i*100, 0, 100, 100);
        noFill();
      }

      // générer la position de départ dans void setup permet de charger une fois balleX et balleY
      // dans void draw qui boucle, la balle n'aurait pas bougé car elle garderais toujours ces valeurs
      if (ligne[0].charAt(i) - '0' == 2) {
        balleX = i*100+50;
        balleY = 50;
      }

      if (ligne[1].charAt(i) - '0' == 1) {
        fill(156, 158, 162);
        rect(i*100, 100, 100, 100);
        noFill();
        k1 = i*100;        // on a enregistré la position en X du carré gris pour qu'ensuite la balle puisse s'arrêter à cette valeur
      }

      if (ligne[1].charAt(i) - '0' == 2) { 
        balleX = i*100+50;
        balleY = 150;
      }

      if (ligne[2].charAt(i) - '0' == 1) {
        fill(156, 158, 162);
        rect(i*100, 200, 100, 100);
        noFill();
      }

      if (ligne[2].charAt(i) - '0' == 2) { 
        balleX = i*100+50;
        balleY = 250;
      }

      if (ligne[3].charAt(i) - '0' == 1) { 
        fill(156, 158, 162);
        rect(i*100, 300, 100, 100);
        noFill();
        up = 3;
      }

      if (ligne[3].charAt(i) - '0' == 2) { 
        balleX = i*100+50;
        balleY = 350;
      }

      if (ligne[4].charAt(i) - '0' == 1) {
        fill(156, 158, 162);
        rect(i*100, 400, 100, 100);
        noFill();
      }

      if (ligne[4].charAt(i) - '0' == 2) { 
        balleX = i*100+50;
        balleY = 450;
      }

      if (ligne[5].charAt(i) - '0' == 1) {
        fill(156, 158, 162);
        rect(i*100, 500, 100, 100);
        noFill();
      }

      if (ligne[5].charAt(i) - '0' == 2) { 
        balleX = i*100+50;
        balleY = 550;
      }  

      if (ligne[6].charAt(i) - '0' == 1) {
        fill(156, 158, 162);
        rect(i*100, 600, 100, 100);
        noFill();
        k = i*100;        // on a enregistré la position en X du carré gris
      }

      if (ligne[6].charAt(i) - '0' == 2) { 
        balleX = i*100+50;
        balleY = 650;
      }
    }
  }
}

void balle() {
  fill(225, 169, 26);                // couleur jaune de la balle
  ellipse(balleX, balleY, 80, 80);   // balle de 80x80 pixels, de coordonnées balleX et balleY
  noFill();
}

void goal() {
  if (balleX == goal+50 && balleY == goal1) {  // si la balle atteint les coordonnées du drapeau vert
    start++;                                   // le jeu passe au niveau suivant
    init();                                    // on initialise la position des carrés gris et du point de départ
  }
}

void keyPressed() {
  if (key == CODED)

    if (keyCode == UP)
    {      
      // ceci ne marchera que pour le niveau 1 qui nous a posé soucis
      // on remarque que la balle a devant elle 2 carrés gris et qu'elle doit s'arrêter lorsque qu'elle rencontre le premier carré puis une fois passé, elle doit s'arrêter au deuxième carré
      // le problème est que la balle s'arrête au carré gris le plus éloigné si on avait pas mis "up" pour lui dire de s'arrêter au carré le plus proche 
      while (balleY >= 650) {
        balleY--;  // la balle monte tant que la condition while est vraie puis s'arrête
      }
      while (balleY >= 550) {
        balleY--;
      }
      while (balleY >= 450) {
        balleY--;
      }
      // les repères "up" permettent à la balle de continuer vers le haut après avoir dépassé le carré gris qui nous a posé soucis
      // car sans " && up != 3" la balle aurait monté sans s'arrêter au carré gris le plus proche...
      while (balleY > 250 && up != 3) {
        balleY--;
      }
      while (balleY > 150 && up != 3) {
        balleY--;
      }

      // pas trouvé comment faire pour mettre en place un système de frein à chaque carré gris et qui marcherait pour tous les niveaux
      // pour faire marcher le niveau 1, on a "guidé" la balle puisqu'on a pas de système de détection de carré gris
      while (balleY > 250 && balleY > 200 && balleX > 800 && balleX < 900) {
        balleY--;
        up=0; // on remet "up" à 0 car la balle est maintenant au dessus du premier carré gris
      }
    }

  if (keyCode == DOWN ) {
    // cette condition permet à la balle de ne pas sortir de la fenêtre du jeu en appuyant sur la touche bas
    while (balleY < 650) {
      balleY++;
    }
  }

  if (keyCode == LEFT)
  {
    // cette condition permet à la balle de ne pas sortir de la fenêtre du jeu en appuyant sur la touche gauche
    while (balleX > 50) {
      balleX--;
    }
  }

  if (keyCode == RIGHT) {
    if (balleY > 600) {
      // la balle part à droite et va à la position k et -100 pour décaler à gauche car sinon la balle va atterrir dans le carré gris
      balleX = balleX + k -100;
    }
    // ces deux conditions vont "guider" la balle pour faire en sorte que le niveau 1 fonctionne
    if (balleY > 400 && balleY <= 450) {
      balleX = balleX + 800;
    }
    // et ainsi la balle atteint le drapeau vert
    if (balleY > 50 && balleY <= 150) {
      balleX = balleX +k1 -100;
    }
  }

  if (keyCode == ' ') {
    etat = 1;      // etat passe à 1, on sort du menu
    start = 1;     // on génére le plateau avec les carrés bleus et le drapeau
    init();        // on génére la suite du plateau avec la position de départ de la balle et les carrés gris
  }

  if (key == 'r' || key == 'R') {
    // pour réinitialiser la position de la balle au point de départ, on appelle la fonction init() qui va se relancer et donc remettre en place la balle au point de départ.
    init();
  }
}
