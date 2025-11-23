SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS passer_defi;
DROP TABLE IF EXISTS consultation_citation;
DROP TABLE IF EXISTS commentaire_contenu;
DROP TABLE IF EXISTS retour_experience;
DROP TABLE IF EXISTS demande_aide;
DROP TABLE IF EXISTS don;
DROP TABLE IF EXISTS citation;
DROP TABLE IF EXISTS defi;
DROP TABLE IF EXISTS utilisateurs;

SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------
-- TABLE UTILISATEURS
-- ----------------------------------------------------
CREATE TABLE utilisateurs (
  id_utilisateur INT PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  affichage_public BOOLEAN DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------
-- TABLE DEFI
-- ----------------------------------------------------
CREATE TABLE defi (
  id_defi INT PRIMARY KEY AUTO_INCREMENT,
  titre VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  difficulte VARCHAR(255) NOT NULL,
  duree INT NOT NULL,
  date_publication VARCHAR(100),
  statut_moderation VARCHAR(50)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------
-- TABLE DON
-- ----------------------------------------------------
CREATE TABLE don (
  id_don INT PRIMARY KEY AUTO_INCREMENT,
  montant INT NOT NULL,
  est_public BOOLEAN NOT NULL DEFAULT 0,
  date_don VARCHAR(100) NOT NULL,
  id_utilisateur INT NOT NULL,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------
-- TABLE CITATION
-- ----------------------------------------------------
CREATE TABLE citation (
  id_citation INT PRIMARY KEY AUTO_INCREMENT,
  contenu VARCHAR(255) NOT NULL,
  auteur VARCHAR(150),
  date_ajout VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------
-- TABLE DEMANDE AIDE
-- ----------------------------------------------------
CREATE TABLE demande_aide (
  id_aide INT PRIMARY KEY AUTO_INCREMENT,
  concernant VARCHAR(225) NOT NULL,
  contenu VARCHAR(255) NOT NULL,
  date_demande VARCHAR(100) NOT NULL,
  id_utilisateur INT NOT NULL,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------
-- TABLE RETOUR EXPERIENCE
-- ----------------------------------------------------
CREATE TABLE retour_experience (
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------
-- TABLE COMMENTAIRE
-- ----------------------------------------------------
CREATE TABLE commentaire_contenu (
  id_commentaire INT PRIMARY KEY AUTO_INCREMENT,
  contenu VARCHAR(255) NOT NULL,
  date_commentaire VARCHAR(100),
  id_utilisateur INT NOT NULL,
  id_retour INT NOT NULL,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_retour) REFERENCES retour_experience(id_retour)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------
-- TABLE PASSER_DEFI (N-N)
-- ----------------------------------------------------
CREATE TABLE passer_defi (
  id_utilisateur INT NOT NULL,
  id_defi INT NOT NULL,
  duree INT,
  date_passage VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_utilisateur, id_defi),
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_defi) REFERENCES defi(id_defi)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------
-- TABLE CONSULTATION CITATION
-- ----------------------------------------------------
CREATE TABLE consultation_citation (
  id_citation INT NOT NULL,
  id_utilisateur INT NOT NULL,
  date_consultation VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_citation, id_utilisateur),
  FOREIGN KEY (id_citation) REFERENCES citation(id_citation)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (id_utilisateur) REFERENCES utilisateurs(id_utilisateur)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
