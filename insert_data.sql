/* INSÉRER LES DONNÉES DANS L’ORDRE CORRECT */
/* ----------------------------------------------------------- */
/* 1) UTILISATEURS */
/* ----------------------------------------------------------- */

INSERT INTO utilisateurs (nom, prenom, email, affichage_public)
VALUES
('Anas', 'Chebbi', 'anas@example.com', 1),
('Sarah', 'Durand', 'sarah@example.com', 0),
('Marc', 'Leroy', 'marc@example.com', 1);


/* ----------------------------------------------------------- */
/* 2) DÉFI */
/* ----------------------------------------------------------- */

INSERT INTO defi (titre, description, difficulte, duree, date_publication, statut_moderation)
VALUES
('Aider un voisin', 'Proposer de l’aide à un voisin dans le besoin', 'Facile', 10, '2025-01-01', 'publie'),
('Envoyer un message positif', 'Envoyer un message bienveillant à un proche', 'Facile', 5, '2025-01-03', 'publie'),
('Faire un don alimentaire', 'Donner de la nourriture à une association', 'Moyen', 30, NULL, 'en_attente');


/* ----------------------------------------------------------- */
/* 3) CITATION  (MUST COME BEFORE consultation_citation) */
/* ----------------------------------------------------------- */

INSERT INTO citation (contenu, auteur, date_ajout)
VALUES
('La bienveillance est un langage universel.', 'Mark Twain', '2025-01-01'),
('Soyez le changement que vous voulez voir.', 'Gandhi', '2025-01-02');


/* ----------------------------------------------------------- */
/* 4) DON */
/* ----------------------------------------------------------- */

INSERT INTO don (montant, est_public, date_don, id_utilisateur)
VALUES
(10, 1, '2025-01-05', 1),
(5, 0, '2025-01-06', 2),
(20, 1, '2025-01-07', 3);


/* ----------------------------------------------------------- */
/* 5) DEMANDE AIDE */
/* ----------------------------------------------------------- */

INSERT INTO demande_aide (concernant, contenu, date_demande, id_utilisateur)
VALUES
('Défi n°1', 'Je ne comprends pas comment valider ce défi.', '2025-01-05', 1),
('Défi n°3', 'Je veux proposer une amélioration.', '2025-01-08', 2);


/* ----------------------------------------------------------- */
/* 6) RETOUR D’EXPÉRIENCE */
/* ----------------------------------------------------------- */

INSERT INTO retour_experience (commentaire, note, emoji, date_retour, id_utilisateur, id_defi)
VALUES
('Très bonne expérience', 5, '😀', '2025-01-04', 1, 1),
('Inspirant et simple', 4, '💡', '2025-01-06', 2, 1),
('J’ai beaucoup apprécié', 5, '❤️', '2025-01-07', 3, 2);


/* ----------------------------------------------------------- */
/* 7) COMMENTAIRE */
/* ----------------------------------------------------------- */

INSERT INTO commentaire_contenu (contenu, date_commentaire, id_utilisateur, id_retour)
VALUES
('Bravo !', '2025-01-04', 2, 1),
('Très inspirant !', '2025-01-06', 1, 2),
('Merci pour ton partage', '2025-01-07', 1, 3);


/* ----------------------------------------------------------- */
/* 8) PASSER UN DÉFI  (TABLE N-N) */
/* ----------------------------------------------------------- */

INSERT INTO passer_defi (id_utilisateur, id_defi, duree, date_passage)
VALUES
(1, 1, 10, '2025-01-04'),
(2, 1, 8, '2025-01-06'),
(3, 2, 5, '2025-01-07');


/* ----------------------------------------------------------- */
/* 9) CONSULTATION CITATION (DÉPEND DE CITATION + UTILISATEUR) */
/* ----------------------------------------------------------- */

INSERT INTO consultation_citation (id_citation, id_utilisateur, date_consultation)
VALUES
(1, 1, '2025-01-05'),
(1, 2, '2025-01-06'),
(2, 3, '2025-01-07');
