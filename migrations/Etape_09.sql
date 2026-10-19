\c bd_gargote_rado

CREATE TABLE Menu(
    id_Menu SERIAL PRIMARY KEY,
    libelle VARCHAR(50),
    prix INT
);

CREATE TABLE Menu_Plat(
    id_Menu_Plat SERIAL PRIMARY KEY,
    id_Menu INT,
    id_Plat INT,
    quantite NUMERIC(10,2)
);