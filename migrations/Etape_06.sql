\c bd_gargote_rado

CREATE TABLE Paiement(
    id_paiement SERIAL PRIMARY KEY,
    id_Commande INT NOT NULL,
    id_Mode_paiement INT,
    Montant INT,
    reference_transaction VARCHAR(10)
);

CREATE TABLE Mode_paiement(
    id_Mode_paiement SERIAL PRIMARY KEY,
    Libelle VARCHAR(20)
);

INSERT INTO Mode_paiement (Libelle) VALUES 
('Espèces'),
('MVola'),
('Orange Money'),
('Airtel Money');

