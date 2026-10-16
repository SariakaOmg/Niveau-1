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
