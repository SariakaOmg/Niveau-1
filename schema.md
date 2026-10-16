Etape 1 :

    Table Carte :
        Id_Plat
        Nom_Plat VARCHAR()
        id_Categorie INTEGER
        Prix NUMERIC
    Table Categorie_plat :
        id_Categorie
        nom_categorie
    Table Commande :
        id_Commande
        dates
    Table Commande_Plat:
        id_Commande_Plat
        id_Plat_Carte
        id_Commande
        Quantite