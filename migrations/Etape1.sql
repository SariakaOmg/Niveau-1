CREATE DATABASE bd_Gargote_Rado;

\c bd_gargote_rado

CREATE TABLE Plat_Carte (
    id_Plat SERIAL PRIMARY KEY,
    Nom_Plat VARCHAR(100) NOT NULL,
    Categorie_Plat VARCHAR(50) NOT NULL,
    Prix_Plat_Ar NUMERIC(10) NOT NULL
);

INSERT INTO Plat_Carte (Nom_Plat, Categorie_Plat, Prix_Plat_Ar) VALUES
('Romazava', 'Plat malagasy', 7000.00),
('Ravitoto sy henakisoa', 'Plat malagasy', 8000.00),
('Akoho sy voanio', 'Plat malagasy', 8500.00),
('Mi sao', 'Plat chinois', 6000.00),
('Soupe chinoise', 'Soupe', 5000.00),
('Mofo gasy (les 4)', 'Dessert et goûter', 1000.00),
('Ranon''ampango', 'Boisson', 500.00);

