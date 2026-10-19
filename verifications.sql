/*Etape 1 :
Commande :*/
 SELECT * FROM Plat_Carte ORDER BY prix_plat_ar DESC;

/*Piege : */
-- Type pour le prix : 
NUMERIC (10)

-- Identifiant
id_Plat SERIAL PRIMARY KEY,

-- Etape 2 :
-- nombre de plats par catégorie, y compris les catégories sans plat
SELECT  Categorie_plat.nom_categorie , COUNT(*) as nombrePlat FROM Plat_Carte RIGHT JOIN Categorie_plat ON Plat_Carte.id_Categorie = Categorie_plat.id_Categorie GROUP BY Categorie_plat.id_Categorie;

-- Piege :
-- Inconvénient d'utiliser un simple VARCHAR pour la catégorie :
-- Si une faute de frappe ou une variation se glisse (ex: "plat malagasy" au lieu de "plats malagasy"),
-- le système les considérera comme deux catégories totalement différentes.

-- Etape 3 :
-- montant total de chaque commande
SELECT Commande.dates, SUM(Plat_Carte.Prix_Plat_Ar) 
FROM Plat_Carte 
RIGHT JOIN Commande_Plat ON Plat_Carte.id_Plat = Commande_Plat.id_Plat_Carte 
RIGHT JOIN Commande ON Commande.id_Commande = Commande_Plat.id_Commande 
GROUP BY Commande.id_Commande, Commande.dates;
-- piege
-- j ai mis dans Commande_Plat la quantite car 

-- Etape 4:
SELECT Commande.id_Commande ,Commande.dates,Client_Commande.id_Client,Client.Nom , CASE WHEN Client_Commande.id_Client IS NULL THEN 'Client de passage' END AS "Titre client" FROM Commande LEFT JOIN Client_Commande ON Commande.id_Commande = Client_Commande.id_Commande LEFT JOIN Client ON Client.id_Client = Client_Commande.id_Client;

-- piege 
-- la cle etrangere id_Commande est NOT NULL
-- mais le id_Client n'est pas NOT NULL

-- Etape 5
-- Nombre de Commande  par serveur
SELECT Serveur.Nom, Serveur.Prenom,count(*)  FROM Serveur_Commande_Table RIGHT JOIN Serveur ON Serveur.id_Serveur =  Serveur_Commande_Table.id_Serveur GROUP BY Serveur.id_Serveur;
-- Chiffre d'affaire par serveur
SELECT 
    Serveur.Nom, 
    Serveur.Prenom, 
    COALESCE(COUNT(Commande_Plat.id_Commande_Plat),0) AS Nombre_commande,
    COALESCE(SUM((Plat_Carte.Prix_Plat_Ar)*(Commande_Plat.Quantite) ),0) AS nombre_plats_pris
FROM Serveur_Commande_Table
RIGHT JOIN Serveur ON Serveur.id_Serveur = Serveur_Commande_Table.id_Serveur
LEFT JOIN Commande_Plat ON Commande_Plat.id_Commande = Serveur_Commande_Table.id_Commande
LEFT JOIN Plat_Carte ON Plat_Carte.id_Plat = Commande_Plat.id_Plat_Carte 
GROUP BY Serveur.id_Serveur, Serveur.Nom, Serveur.Prenom;

-- Piege
-- Une table de la salle et une commande sont deux choses différentes : parce qu une commande ne veut pas dire une table : une table peut correspondre a plusieur commande et plusisuer commande peut correspondre a une table 
-- Pourquoi le nom table pose-t-il problème en SQL : Le mot TABLE est un mot-réservé (keyword) fondamental du langage SQL (utilisé pour créer des tables : CREATE TABLE, modifier des tables, etc.).

-- Etape 6
-- Verification
-- liste des commandes non soldées avec le montant dû, le montant payé et le reste à payer
WITH MontantDu AS (
    -- 1. Calcul du total des plats commandés pour chaque commande
    SELECT 
        cp.id_Commande,
        SUM(cp.Quantite * ca.Prix_Plat_Ar) AS montant_du
    FROM Commande_Plat cp
    JOIN Plat_Carte ca ON cp.id_Plat_Carte = ca.id_Plat
    GROUP BY cp.id_Commande
),
MontantPaye AS (
    -- 2. Récupération du montant déjà payé par commande
    SELECT 
        id_Commande,
        SUM(Montant) AS montant_payer
    FROM Paiement
    GROUP BY id_Commande
),
CalculReste AS (
    -- 3. Assemblage et calcul du reste
    SELECT 
        c.id_Commande,
        c.dates AS date_commande,
        COALESCE(md.montant_du, 0) AS montant_du,
        COALESCE(mp.montant_payer, 0) AS montant_payer,
        (COALESCE(md.montant_du, 0) - COALESCE(mp.montant_payer, 0)) AS reste
    FROM Commande c
    LEFT JOIN MontantDu md ON c.id_Commande = md.id_Commande
    LEFT JOIN MontantPaye mp ON c.id_Commande = mp.id_Commande
)
-- 4. Filtrage final sur les commandes non soldées
SELECT * 
FROM CalculReste 
WHERE reste != 0;

-- piege
-- Pourquoi une colonne montant_paye dans la table des commandes ne suffit-elle pas ?
-- -> parce qu une commande peut y avoir plusieurs paiement

-- Etape 7
WITH CommandeAvecPrixReel AS (
    SELECT 
        c.id_Commande,
        c.dates,
        cp.Quantite,
        -- On cherche le prix dans 'augmentation' à la date de la commande, sinon on prend le prix de base
        COALESCE(
            (
                SELECT a.Montant
                FROM augmentation a
                WHERE a.id_Plat = cp.id_Plat_Carte 
                  AND a.Dates <= c.dates
                ORDER BY a.Dates DESC
                LIMIT 1
            ), 
            ca.Prix_Plat_Ar
        ) AS prix_unitaire_reel
    FROM Commande c
    JOIN Commande_Plat cp ON c.id_Commande = cp.id_Commande
    JOIN Plat_Carte ca ON cp.id_Plat_Carte = ca.id_Plat
)
-- Calcul du total par commande
SELECT 
    id_Commande,
    dates AS date_commande,
    SUM(prix_unitaire_reel * Quantite) AS total_commande_ariary
FROM CommandeAvecPrixReel
GROUP BY id_Commande, dates;

-- Corrigez le schéma pour que le montant d'une commande ne change plus
-- jamais.

ALTER TABLE Commande_Plat ADD COLUMN prix_unitaire NUMERIC;

-- Etape 8
-- consommation théorique de chaque ingrédient pour la journée du 12 octobre
WITH QntPlatDate_n AS (
    SELECT 
        Commande_Plat.id_Plat_Carte, 
        Commande_Plat.quantite 
    FROM Commande 
    RIGHT JOIN Commande_Plat ON Commande.id_Commande = Commande_Plat.id_Commande 
    WHERE Commande.dates = '2026-10-12'
),
QntPlatDate AS (
    SELECT 
        id_Plat_Carte, 
        SUM(quantite) AS total_quantite  
    FROM QntPlatDate_n 
    GROUP BY id_Plat_Carte
),
Compo_plat AS (
    SELECT Composition_Plat.id_ingredient ,QntPlatDate.id_Plat_Carte, (Composition_Plat.quantite * QntPlatDate.total_quantite) AS Totalqt  FROM Composition_Plat JOIN QntPlatDate ON Composition_Plat.id_Plat = QntPlatDate.id_Plat_Carte
),
Qte_par_Ingred AS(
    SELECT id_ingredient, SUM(Totalqt) AS C_t FROM Compo_plat GROUP BY id_ingredient
)
SELECT Ingredient.libelle , Qte_par_Ingred.C_t FROM Ingredient JOIN Qte_par_Ingred ON Ingredient.id_ingredient = Qte_par_Ingred.id_ingredient ;

-- piege
-- parce que risque de faute de frappe peut faussee les donnee 