/*Etape 1 :
Commande :*/
 SELECT * FROM Plat_Carte ORDER BY prix_plat_ar DESC;

/*Piege : */
-- Type pour le prix : 
NUMERIC (10)

-- Identifiant
id_Plat SERIAL PRIMARY KEY,