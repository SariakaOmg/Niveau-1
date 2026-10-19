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
    Table Commande_Plat:(modifie)
        id_Commande_Plat
        id_Plat_Carte
        id_Commande
        Quantite
        prix unitaire
    Table Client_Commande :
        id_Client_Commande
        id_Commande
        id_Client
    Table Client:
        id_Client
        Nom
    Table Serveur :
        id_Serveur
        Nom
        Prenom
    Table Serveur_Commande_Table :
        id_Serveur_Commande_Table
        id_Serveur
        id_Table
        id_Commande
    Table Tables_g:
        id_table_g
        Numero
    Table Paiement:
        id_paiement
        id_Commande
        id_Mode_paiement
        Montant
        reference_transaction
    Table Mode_paiement:
        id_Mode_paiement
        Libelle
    Table augmentation :
        id_augmentation
        Montant
        Dates
        id_Plat
    Table Ingredient :
        id_ingredient
        libelle
        unite
    Table Stock_Ingredient:
        id_Stock_Ingredient
        quantite_stock
        id_ingredient
    Table Composition_Plat:
        id_Composition_Plat
        id_Plat
        quantite
        id_ingredient