CREATE TABLE augmentation(
    id_augmentation SERIAL PRIMARY KEY,
    Montant INT,
    Dates DATE,
    id_Plat INT
);

INSERT INTO augmentation(Montant, Dates, id_Plat) VALUES (7500, '2026-10-15',1);