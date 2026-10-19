\c bd_gargote_rado

CREATE TABLE Ingredient(
    id_ingredient SERIAL PRIMARY KEY,
    libelle VARCHAR(100),
    unite VARCHAR(10)
);

CREATE TABLE Stock_Ingredient(
    id_Stock_Ingredient SERIAL PRIMARY KEY,
    quantite_stock NUMERIC(10,2),
    id_ingredient INT
);

CREATE TABLE Composition_Plat(
    id_Composition_Plat SERIAL PRIMARY KEY,
    id_Plat INT,
    quantite NUMERIC(10,2),
    id_ingredient INT
);

INSERT INTO Ingredient (libelle, unite) VALUES
('Riz', 'g'),
('Viande de zébu', 'g'),
('Brèdes mafana', 'g');

INSERT INTO Composition_Plat (id_Plat, quantite, id_ingredient) VALUES
(1, 250.00, 1), -- 250 g de riz pour le Romazava
(1, 150.00, 2), -- 150 g de viande de zébu pour le Romazava
(1, 100.00, 3); -- 100 g de brèdes mafana pour le Romazava

-- Insertion de stocks initiaux pour les ingrédients
-- (Riz = id 1, Viande de zébu = id 2, Brèdes mafana = id 3)
INSERT INTO Stock_Ingredient (quantite_stock, id_ingredient) VALUES
(500.00, 1),  -- 50 kg (50 000 g) de riz en stock
(1500.00, 2),  -- 15 kg (15 000 g) de viande de zébu en stock
(800.00, 3);   -- 8 kg (8 000 g) de brèdes mafana en stock
