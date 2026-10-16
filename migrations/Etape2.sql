\c bd_gargote_rado
CREATE TABLE Categorie_plat (
    id_Categorie SERIAL PRIMARY KEY,
    nom_categorie VARCHAR(50) UNIQUE NOT NULL
);

INSERT INTO Categorie_plat (nom_categorie) VALUES
('plats malagasy'),
('plats chinois'),
('soupes'),
('desserts'),
('boissons');

ALTER TABLE Plat_Carte ADD COLUMN id_Categorie INT;

UPDATE Plat_Carte SET id_Categorie = 
    CASE 
        WHEN Categorie_Plat = 'Boisson' THEN 5
        WHEN Categorie_Plat = 'Plat malagasy' THEN 1
        WHEN Categorie_Plat = 'Plat chinois' THEN 2
        WHEN Categorie_Plat = 'Soupe' THEN 3
        WHEN Categorie_Plat = 'Dessert et goûter' THEN 4
    END;

ALTER TABLE Plat_Carte DROP COLUMN Categorie_Plat;