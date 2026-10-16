\c bd_gargote_rado

CREATE TABLE Serveur(
    id_Serveur SERIAL PRIMARY KEY,
    Nom VARCHAR(10),
    Prenom VARCHAR(10)
);

CREATE TABLE Serveur_Commande_Table(
    id_Serveur_Commande_Table SERIAL PRIMARY KEY,
    id_Serveur INT,
    id_Table INT,
    id_Commande INT
);

CREATE TABLE Tables_g(
    id_table_g SERIAL PRIMARY KEY,
    Numero INT
);

INSERT INTO Serveur (Nom, Prenom) VALUES 
('Rakoto', 'Njaka'),
('Rasoa', 'Lalao');

-- 2. Insérer les 8 tables de la salle
INSERT INTO Tables_g (Numero) VALUES 
(1), (2), (3), (4), (5), (6), (7), (8);

INSERT INTO Serveur_Commande_Table (id_Serveur, id_Table, id_Commande) VALUES
(1, 3, 1), -- Commande 1 : Prise par Njaka Rakoto (id=1) à la Table 3 (id=3)
(2, NULL, 2), -- Commande 2 : Prise par Lalao Rasoa (id=2) "À emporter" (id_Table = NULL)
(1, 1, 3); -- Commande 3 : Prise par Njaka Rakoto (id=1) à la Table 1 (id=1)