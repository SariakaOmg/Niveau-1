\c bd_gargote_rado

CREATE TABLE Commande(
    id_Commande SERIAL PRIMARY KEY,
    dates DATE
);
CREATE TABLE Commande_Plat(
    id_Commande_Plat SERIAL PRIMARY KEY,
    id_Plat_Carte INT,
    id_Commande INT,
    Quantite INT
);

INSERT INTO Commande (dates) VALUES
('2026-10-15'),
('2026-10-15'),
('2026-10-16');

INSERT INTO Commande_Plat (id_Commande, id_Plat_Carte, Quantite) VALUES
(1, 2, 2), -- 2 Romazava pour la commande 1
(1, 7, 3), -- 3 Ranon'ampango pour la commande 1
(3, 3, 1), -- 1 Ravitoto sy henakisoa pour la commande 2
(1, 5, 1), -- 1 Mi sao pour la commande 2
(1, 6, 2); -- 2 Mofo gasy pour la commande 2

INSERT INTO Commande_Plat (id_Commande, id_Plat_Carte, Quantite) VALUES
(2,2,1);