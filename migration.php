<?php

// VARIABLES ENVIRONNEMENT 
$servername = getenv('DB_SERVER') ?: $_ENV['DB_SERVER'] ?? 'localhost';
$username   = getenv('DB_USERNAME') ?: $_ENV['DB_USERNAME'] ?? 'root';
$password   = getenv('DB_PASSWORD') ?: $_ENV['DB_PASSWORD'] ?? '';
$dbname     = getenv('DB_NAME') ?: $_ENV['DB_NAME'] ?? 'bienveillance_app';

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$conn->set_charset("utf8mb4");
$conn->query("SET FOREIGN_KEY_CHECKS = 0");

echo "Dropping existing tables...\n";

$dropTables = [
  "passer_defi",
  "consultation_citation",
  "commentaire_contenu",
  "retour_experience",
  "demande_aide",
  "don",
  "citation",
  "defi",
  "utilisateurs"
];

foreach ($dropTables as $table) {
  $conn->query("DROP TABLE IF EXISTS $table");
  echo "Dropped: $table\n";
}

echo "All old tables dropped.\n\n";


// -----------------------------------------------
//  CREATION DES TABLES SELON mon MPD
// -----------------------------------------------

$sqls = [

// 1) UTILISATEURS
"CREATE TABLE IF NOT EXISTS utilisateurs (
  id_utilisateur INT PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  affichage_public BOOLEAN DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4",

// 2) DEFI
"CREATE TABLE IF NOT EXISTS defi (
  id_defi INT PRIMARY KEY AUTO_INCREMENT,
  titre VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  difficulte VARCHAR(255) NOT NULL,
  duree INT NOT NULL,
  date_publication VARCHAR(100),
  statut_moderation VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4",

// 3) DON
"CREATE TABLE IF NOT EXISTS don (
  id_don INT PRIMARY KEY AUTO_INCREMENT,
  montant INT NOT NULL,
  est_public BOOLEAN NOT NULL DEFAULT 0,
  date_don VARCHAR(100) NOT NULL,
  id_utilisateur INT NOT NULL,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4",

// 4) CITATION
"CREATE TABLE IF NOT EXISTS citation (
  id_citation INT PRIMARY KEY AUTO_INCREMENT,
  contenu VARCHAR(255) NOT NULL,
  auteur VARCHAR(150),
  date_ajout VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4",

// 5) DEMANDE AIDE
"CREATE TABLE IF NOT EXISTS demande_aide (
  id_aide INT PRIMARY KEY AUTO_INCREMENT,
  concernant VARCHAR(225) NOT NULL,
  contenu VARCHAR(255) NOT NULL,
  date_demande VARCHAR(100) NOT NULL,
  id_utilisateur INT NOT NULL,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4",

// 6) RETOUR EXPERIENCE
"CREATE TABLE IF NOT EXISTS retour_experience (
  id_retour INT PRIMARY KEY AUTO_INCREMENT,
  commentaire VARCHAR(255) NOT NULL,
  note INT NOT NULL,
  emoji VARCHAR(10) NOT NULL,
  date_retour VARCHAR(100) NOT NULL,
  id_utilisateur INT NOT NULL,
  id_defi INT NOT NULL,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_defi) REFERENCES defi(id_defi)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4",

// 7) COMMENTAIRE CONTENU
"CREATE TABLE IF NOT EXISTS commentaire_contenu (
  id_commentaire INT PRIMARY KEY AUTO_INCREMENT,
  contenu VARCHAR(255) NOT NULL,
  date_commentaire VARCHAR(100),
  id_utilisateur INT NOT NULL,
  id_retour INT NOT NULL,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_retour) REFERENCES retour_experience(id_retour)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4",

// 8) PASSER UNE DEFI (table N-N)
"CREATE TABLE IF NOT EXISTS passer_defi (
  id_utilisateur INT NOT NULL,
  id_defi INT NOT NULL,
  duree INT,
  date_passage VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_utilisateur, id_defi),
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_defi) REFERENCES defi(id_defi)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4",

// 9) CONSULTATION CITATION
"CREATE TABLE IF NOT EXISTS consultation_citation (
  id_citation INT NOT NULL,
  id_utilisateur INT NOT NULL,
  date_consultation VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_citation, id_utilisateur),
  FOREIGN KEY (id_citation) REFERENCES citation(id_citation)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"

];


echo "Creating tables...\n";
foreach ($sqls as $sql) {
  if ($conn->query($sql) === TRUE) {
    echo "OK: " . strtok($sql, "(") . "\n";
  } else {
    echo "ERROR: " . $conn->error . "\n";
  }
}

$conn->query("SET FOREIGN_KEY_CHECKS = 1");
$conn->close();

echo "\nMigration completed.\n";

?>
