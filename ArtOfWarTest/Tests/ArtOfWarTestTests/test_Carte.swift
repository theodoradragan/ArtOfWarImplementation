// === Tests Unitaires d'une Carte ===

// Le test passe si init n'est pas nil.
// Renvoie 1 si le test passe, 0 sinon

/*
    test_init : -> Int
    verifie si l'initialisation d'une carte est bien effectuee
    Une carte doit avoir :
    - un type_carte qui est un String non vide
    - une puissance_attaque qui est un entier strictement positif
    - des pv_offensifs et pv_defensifs qui sont des entiers strictement positifs
    - pv_defensif est plus grand que pv_offensif
    - une portee qui est un tableau de tuples d'entier non-nuls
*/
func test_init() -> Int{
    print("== Test de l'init(String x Int x Int x Int x (Int,Int)[]) ==");
    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    var porteeVide = [];

    // Carte valide
    do {
        var c1 = try Carte("Soldat", 3, 4, 3, portee);
        print("Test Carte valide Ok")
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }


    // Cartes non valides
    do {
        var c2 = try Carte("", 3, 4, 3, portee);
        print("Erreur d'init : Une carte ne peut pas avoir de chaine vide en type_carte");
        return 0;
    } catch {
        print("Test carte chaine vide en type_carte ok")
    }

    do {
        var c3 = try Carte("Soldat", -1, 4, 3, portee);
        print("Erreur d'init : Une carte ne peut pas avoir de valeur negative pour puissance_attaque");
        return 0;
    } catch {
        print("Test carte puissance_attaque negative ok")
    }

    do {
        var c4 = try Carte("Soldat", 3, -1, -1, portee);
        print("Erreur d'init : Une carte ne peut pas avoir de valeur negative pour les pv");
        return 0;
    } catch {
        print("Test carte pv negatifs ok")
    }

    do {
        // Pv def < pf off ==> Carte non valide
        var c5  = try Carte("Soldat", 3, 1, 3, portee);
        print("Erreur d'init : Une carte ne peut pas avoir pv_defensif < pv_offensif");
        return 0;
    } catch {
        print("Test carte pv_defensif< pv_offensif ok")
    }

    do {
        var c6 = try Carte("Soldat", 3, 4, 3, nil);
        print("Erreur d'init : Une carte ne peut pas avoir nil en portee");
        return 0;
    } catch {
        print("Test carte portee nil ok")
    }

    do {
        var c7 = try Carte("Soldat", 3, 4, 3, porteeVide);
        print("Erreur d'init : Une carte ne peut pas avoir un tableau vide en portee");
        return 0;
    } catch {
        print("Test carte portee tableau vide ok")
    }

    print("== Fin test init(String x Int x Int x Int x (Int,Int)[]) ==");
    return 1
}

/*
    test_puissance_attaque : -> Int
    verifie si la fonction puissance_attaque() est correcte
*/
func test_puissance_attaque() -> Int{
    print("== Test de puissance_attaque() ==");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
    do {
        var c1 = try Carte("Soldat", 3, 4, 3, portee);
        if (c1.puissance_attaque() != 3) {
            print("Test ko : la puissance d'attaque ne renvoie pas la bonne valeur")
            return 0;
        } else {
            print("Test ok : puissance attaque correcte")
        }
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

    do {
        var c2 = try Carte("Soldat", -1, 4, 3, portee);
        print("Test ko : La puissance d'attaque ne peut pas etre negative");
        return 0;
    } catch {
        print("Test ok : valeur negative puissance attaque");
    }

    print("== Fin test puissance_attaque() ==");
    return 1;
}

func test_puissance_attaque2() -> Int{
    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    do {
        var c1 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {}

    do {
        try c1.puissance_attaque(-1)
        print("KO : la puissance d'attaque ne peut pas etre negative")
        return 0
    } catch {
        print("OK")
    }

    do {
        try c1.puissance_attaque(7)
        print("KO : la puissance ne peut pas etre superieure au nombre max de cartes dans la main")
        return 0
    } catch {
        print("OK")
    }

    do {
        try c1.puissance_attaque(3)
        print("OK")
    } catch {
        print("KO : la puissance d'attaque a mal ete attribuee")
        return 0
    }

    return 1
}

func test_pv_defensif() -> Int{
    print("== Test de pv_defensif() ==");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
    do {
        var c1 = try Carte("Soldat", 3, 4, 3, portee);
        if (c1.pv_defensif() != 4) {
            print("Test ko : pv_defensif ne renvoie pas la bonne valeur")
            return 0;
        } else {
            print("Test ok : puissance attaque correcte")
        }
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

    do {
        var c2 = try Carte("Soldat", 4, -1, 3, portee);
        print("Test ko : Les pv_defensif ne peuvent pas etre negatifs");
        return 0;
    } catch {
        print("Test ok : valeur negative pv_defensif");
    }

    do {
        var c3 = try Carte("Soldat", 4, 0, 3, portee);
        print("Test ko : Les pv_defensif ne peuvent pas etre nuls");
        return 0;
    } catch {
        print("Test ok : valeur nulle pv_defensif");
    }

    do {
        var c4 = try Carte("Soldat", 4, 3, 5, portee);
        print("Test ko : Les pv_defensif ne peuvent pas etre etre inferieurs aux pv offensifs");
        return 0;
    } catch {
        print("Test ok : pv_defensif < pv_offensif");
    }

    print("== Fin test pv_defensif() ==");
    return 1;
}


func test_pv_offensif() -> Int{
    print("== Test de pv_offensif() ==");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
    do {
        var c1 = try Carte("Soldat", 3, 4, 3, portee);
        if (c1.pv_offensif() != 3) {
            print("Test ko : pv_offensif ne renvoie pas la bonne valeur")
            return 0;
        } else {
            print("Test ok : puissance attaque correcte")
        }
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

    do {
        var c2 = try Carte("Soldat", 4, 3, -1, portee);
        print("Test ko : Les pv_offensif ne peuvent pas etre negatifs");
        return 0;
    } catch {
        print("Test ok : valeur negative pv_offensif");
    }

    do {
        var c3 = try Carte("Soldat", 4, 2, 0, portee);
        print("Test ko : Les pv_offensif ne peuvent pas etre nuls");
        return 0;
    } catch {
        print("Test ok : valeur nulle pv_offensif");
    }

    do {
        var c4 = try Carte("Soldat", 4, 3, 5, portee);
        print("Test ko : Les pv_offensif ne peuvent pas etre etre superieur aux pv defensif");
        return 0;
    } catch {
        print("Test ok : pv_offensif > pv_defensif");
    }

    print("== Fin test pv_offensif() ==");
    return 1;
}

func test_statut() -> Int{
    print("== Test de statut() ==");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
    do {
        var c1 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

    if (c1.statut() != 0) {
        print("Test ko : statut pas en defensif a la creation")
        return 0;
    } else {
        print("Test ok : statut defensif a la creation")
    }

    do {
        try c1.statut(1);
        if (c1.statut == 1) {
            print("Test Ok : statut modifie correctement")
        } else {
            print("Test Ko : modification statut erreur : mauvaise valeur")
            return 0
        }
    } catch {
        print("Test ko : exception sur statut alors que valide")
        return 0;
    }

    do {
        try c1.statut(2);
        print("Test Ko : Le statut ne peut etre que 1 ou 0")
        return 0

    } catch {
        print("Test Ok : 1 ou 0 pour le statut")
    }


    print("== Fin test statut() ==");
    return 1;
}

func test_portee() -> Int{
    print("== Test de portee() ==");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
    do {
        var c1 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

    if (c1.portee() != portee) {
        print("Test ko : valeur de portee pas valide")
        return 0;
    } else {
        print("Test ok : valeur portee valide")
    }

    var porteeNonValide: [(Int, Int)] = [(1, 2), (0, 0)];
    // Carte valide
    do {
        var c2 = try Carte("Soldat", 3, 4, 3, porteeNonValide);
        print("Test ko : Portee (0,0)  non geree");
        return 0;
    } catch {
        print("Test Ok : Portee (0,0) geree");
    }

    print("== Fin test portee() ==");
    return 1;
}


func test_type_carte() -> Int{
    print("== Test de type_carte() ==");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
    do {
        var c1 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

    if (c1.type_carte() != "Soldat") {
        print("Test ko : valeur de type_carte pas valide")
        return 0;
    } else {
        print("Test ok : valeur type_carte valide")
    }

    do {
        var c1 = try Carte("", 3, 4, 3, portee);
        print("Test Ko : Chane vide pas valable")
        return 0
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }


    print("== Fin test type_carte() ==");
    return 1;
}

func test_degats_subis() -> Int{
    print("== Test de degats_subis() ==");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
    do {
        var c1 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

    if (c1.degats_subis() != 0) {
        print("Test ko : Les degats subits doivent etre initialises a 0 a l'Initialisation")
        return 0
    } else {
        print("Test Ok : degats subis init a 0")
    }

    c1.degats_subis(2)
    if (c1.degats_subis() != 2) {
        print("Test ko : Modification invalide des degats_subis")
        return 0
    } else {
        print("Test Ok : Modification correcte des degats subis")
    }

    print("== Fin test degats_subis() ==");
    return 1;
}

func test_attaque() -> Int{
    print("== Test de attaque() ==");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
    do {
        var c1 = try Carte("Soldat", 3, 4, 3, portee);
        var c2 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

    // Attque d'une carte de 3 d'attaque sur une carte de 4 de def (statut def). Resultat attendu : retour int positif
    do {
        res = try c1.attaque(c2)
        if (res <= 0) {
            print("Test Ko : La carte n'est pas censee etre morte")
            return 0
        } else {
            print("Test ok : Carte a subit des degats")
        }
    } catch {
        print("Test Ko : Exception sur valide")
        return 0
    }

// Attaque d'une carte de 3 d'attaque sur une carte de 3 de def (statut off). Resultat attendu : retour int null : carte capturee
    do {
        res = c2.attaque(c1)
        if (res != 0) {
            print("Test Ko : La carte est censee etre capturee")
            return 0
        } else {
            print("Test Ok : La carte est capturee")
        }
    } catch {
        print("Test Ko : Exception sur valide")
        return 0
    }


    // Attaque d'une carte en position offensive : Erreur attendue
    do {
        res = c1.attaque(c2)
        print("Test ko : La carte est censee etre en position offensive, elle ne peut donc plus attaquer")
        return 0
    } catch {
        print("Test ok : La carte ne peut effectivement pas attaquer car elle est en position offensive")
    }

    // Attaque d'une carte de 3 d'attaque sur une carte de 4 de def qui a subit 3 degats. Resultat attendu : Mort de la carte
    do {
        c1.statut(0)
        c2.statut(0)
        res = c1.attaque(c2)
        if (res >= 0) {
            print("test Ko : La carte est censee etre morte")
        }
    } catch {
        print("Test Ko : Exception sur une attaque valide")
        return 0
    }
    print("== Fin test attaque() ==");
    return 1
}


// ==== Tests ====
var nb_test_ok: Int = 0;
var nb_test_tot: Int = 0;

nb_test_tot += 1;
nb_test_ok += test_init();

nb_test_tot += 1;
nb_test_ok += test_puissance_attaque();

nb_test_tot += 1;
nb_test_ok += test_puissance_attaque2();

nb_test_tot += 1;
nb_test_ok += test_pv_defensif();

nb_test_tot += 1;
nb_test_ok += test_pv_offensif();

nb_test_tot += 1;
nb_test_ok += test_statut();

nb_test_tot += 1;
nb_test_ok += test_portee();

nb_test_tot += 1;
nb_test_ok += test_type_carte();

nb_test_tot += 1;
nb_test_ok += test_degats_subis();

nb_test_tot += 1;
nb_test_ok += test_attaque();

print("=== FIN DES TESTS ===")
print("\(nb_test_ok) fonctions ont passe les tests sur \(nb_test_tot)")
