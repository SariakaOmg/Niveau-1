\c bd_gargote_rado

CREATE TABLE Client(
    id_Client SERIAL PRIMARY KEY,
    Nom VARCHAR(50)
);

CREATE TABLE Client_Commande(
    id_Client_Commande SERIAL PRIMARY KEY,
    id_Commande INT NOT NULL,
    id_Client INT
);

INSERT INTO Client (Nom) VALUES 
('Rasoa'), 
('Koto');

INSERT INTO Client_Commande (id_Commande, id_Client) VALUES
(1, 1), -- La commande 1 est liée au client 1 (Rasoa)
(2, 2); -- La commande 2 est liée au client 2 (Koto)
-- Remarquez qu'on n'insère rien pour la commande 3 ! Elle n'a donc pas de client.