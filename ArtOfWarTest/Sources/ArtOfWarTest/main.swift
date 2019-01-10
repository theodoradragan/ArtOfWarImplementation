import ArtOfWarProtocol

// === Tests Unitaires d'une Main ===

print( "===== TESTS MAIN ====== \n")

// Le test passe si init n'est pas nil.
// Renvoie 1 si le test passe, 0 sinon

var portee: [(Int, Int)] = [(1, 2), (0, 1)];
var carte : Carte = try Carte("Soldat", 3, 4, 3, portee)
var c3 : Carte = try Carte("Soldat", 2, 3, 3, portee)

func test_ajouter_main() -> Int{
    var m1 = MainJ()
    m1.ajouter_main(carte)

    var isIn = false
    for c1 in m1 {
        if carte === c1 {
            isIn = true
        }
    }
    if isIn == false {
        print("KO : La carte n'est pas dans la main")
        return 0
    } else {
        print("OK 1.1")
    }

    if m1.count_main() != 0 {
        print("OK 1.2")
    } else {
        print("KO : On ne compte pas le nombre correct de cartes")
        return 0
    }

    return 1
}

func test_retirer_main() -> Int{
    var m1 = MainJ()
    m1.ajouter_main(carte)
	var retire : Carte = carte
    do {
        retire = try m1.retirer_main(carte)
    } catch {}

    let portee: [(Int, Int)] = [(1, 2), (0, 1)];
	var c2 : Carte = carte
    do {
      c2 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {}

    var isNotIn = true
    for c1 in m1 {
        if c1 === retire {
            isNotIn = false
        }
    }
    if isNotIn == false {
        print("KO : La carte est toujours dans la main")
        return 0
    } else {
        print("OK 1.3")
    }

    if m1.count_main() >= 1 {
        print("KO : La carte est toujours comptee dans la main")
        return 0
    } else {
        print("OK 1.4")
    }
	
	m1.ajouter_main(c3)
	var retire2 : Carte
    do {
        retire2 = try m1.retirer_main(c2)
        print("KO : On a retire une carte qui n'est pas dans la main")
        return 0
    } catch {
	print("OK 1.5")
    }

    return 1
}


func test_count_main() -> Int{
    var m1 = MainJ()

    if m1.count_main() != 0 {
		print("KO : On compte un nombre de carte different de 0");
        return 0
    }

    m1.ajouter_main(carte)
    if m1.count_main() != 1 {
        print("KO : On compte un nombre de carte different de 1")
        return 0
    }

    if m1.count_main() == 1 {
        print("OK 1.6")
    } else {
        print("KO : On n'a rajoute une carte et on ne la compte pas")
    }
	var carte2 : Carte
    do {
        carte2 = try m1.retirer_main(carte)
    } catch {}

    if m1.count_main() != 0 {
        print("KO : On compte un nombre de carte different de 0")
        return 0
    }

    return 1
}

func test_est_vide() -> Int{
    var m1 = MainJ()

    if !m1.est_vide() {
        print("KO : La main est censee etre vide")
        return 0
    } else {
        print("OK 1.7")
    }

    m1.ajouter_main(carte)

    if m1.est_vide() {
        print("KO : La main n'est pas censee etre vide")
        return 0
    } else {
        print("OK 1.8")
    }

    return 1
}


// ==== Tests ====
var nb_test_ok: Int = 0;
var nb_test_tot: Int = 0;

nb_test_tot += 1;
nb_test_ok += test_ajouter_main();

nb_test_tot += 1;
nb_test_ok += test_retirer_main();

nb_test_tot += 1;
nb_test_ok += test_count_main();

nb_test_tot += 1;
nb_test_ok += test_est_vide();

print("\n\(nb_test_ok) fonctions ont passe les tests sur \(nb_test_tot)")
print("=== TESTS MAIN === \n \n")

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// === Tests Unitaires d'une Carte ===

print("===== TESTS CARTE ===== \n")

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
    print("   == init ==\n");
    var portee: [(Int, Int)] = [(1, 2), (0, 1)];

    // Carte valide
	var c1 : Carte    
	do {
        c1 = try Carte("Soldat", 3, 4, 3, portee);
        print("OK: carte valide")
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }


    // Cartes non valides
	var c2 : Carte    
	do {
        c2 = try Carte("", 3, 4, 3, portee);
        print("Erreur d'init : Une carte ne peut pas avoir de chaine vide en type_carte");
        return 0;
    } catch {
        print("OK: test chaine vide en type_carte ")
    }

	var c3 : Carte
    do {
        c3 = try Carte("Soldat", -1, 4, 3, portee);
        print("Erreur d'init : Une carte ne peut pas avoir de valeur negative pour puissance_attaque");
        return 0;
    } catch {
        print("OK: test carte puissance_attaque negative ")
    }

	var c4 : Carte
    do {
        c4 = try Carte("Soldat", 3, -1, -1, portee);
        print("Erreur d'init : Une carte ne peut pas avoir de valeur negative pour les pv");
        return 0;
    } catch {
        print("OK: test carte pv negatifs")
    }
	var c5 : Carte
    do {
        // Pv def < pf off ==> Carte non valide
        c5  = try Carte("Soldat", 3, 1, 3, portee);
        print("Erreur d'init : Une carte ne peut pas avoir pv_defensif < pv_offensif");
        return 0;
    } catch {
        print("OK: test carte pv_defensif< pv_offensif")
    }

    print("   == Fin test init ==\n");
    return 1
}

/*
    test_puissance_attaque : -> Int
    verifie si la fonction puissance_attaque() est correcte
*/
func test_puissance_attaque() -> Int{
    print("   == Test de puissance_attaque() ==\n");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
	var c1 : Carte
    do {
        c1 = try Carte("Soldat", 3, 4, 3, portee);
        if (c1.puissance_attaque() != 3) {
            print("Erreur : la puissance d'attaque ne renvoie pas la bonne valeur")
            return 0;
        } else {
            print("OK: puissance attaque correcte")
        }
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

	var c2 : Carte
    do {
        c2 = try Carte("Soldat", -1, 4, 3, portee);
        print("Erreur : La puissance d'attaque ne peut pas etre negative");
        return 0;
    } catch {
        print("OK: valeur negative puissance attaque");
    }

    print("   == Fin test puissance_attaque() ==\n");
    return 1;
}



func test_pv_defensif() -> Int{
    print("   == Test de pv_defensif() ==\n");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
	var c1 : Carte
    do {
        c1 = try Carte("Soldat", 3, 4, 3, portee);
        if (c1.pv_defensif() != 4) {
            print("Erreur: pv_defensif ne renvoie pas la bonne valeur")
            return 0;
        } else {
            print("OK: puissance attaque correcte")
        }
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

	var c2 : Carte
    do {
        c2 = try Carte("Soldat", 4, -1, 3, portee);
        print("Erreur: Les pv_defensif ne peuvent pas etre negatifs");
        return 0;
    } catch {
        print("OK: valeur negative pv_defensif");
    }

	var c3 : Carte
    do {
        c3 = try Carte("Soldat", 4, 0, 3, portee);
        print("Erreur: Les pv_defensif ne peuvent pas etre nuls");
        return 0;
    } catch {
        print("OK: valeur nulle pv_defensif");
    }

	var c4 : Carte
    do {
        c4 = try Carte("Soldat", 4, 3, 5, portee);
        print("Erreur: Les pv_defensif ne peuvent pas etre etre inferieurs aux pv offensifs");
        return 0;
    } catch {
        print("OK: pv_defensif < pv_offensif");
    }

    print("   == Fin test pv_defensif() ==\n");
    return 1;
}


func test_pv_offensif() -> Int{
    print("   == Test de pv_offensif() ==\n");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
	var c1 : Carte
    do {
        c1 = try Carte("Soldat", 3, 4, 3, portee);
        if (c1.pv_offensif() != 3) {
            print("Erreur: pv_offensif ne renvoie pas la bonne valeur")
            return 0;
        } else {
            print("OK: puissance attaque correcte")
        }
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

	var c2 : Carte
    do {
        c2 = try Carte("Soldat", 4, 3, -1, portee);
        print("Erreur: Les pv_offensif ne peuvent pas etre negatifs");
        return 0;
    } catch {
        print("OK: valeur negative pv_offensif");
    }

	var c3 : Carte
    do {
        c3 = try Carte("Soldat", 4, 2, 0, portee);
        print("Erreur: Les pv_offensif ne peuvent pas etre nuls");
        return 0;
    } catch {
        print("OK: valeur nulle pv_offensif");
    }

	var c4 : Carte
    do {
        c4 = try Carte("Soldat", 4, 3, 5, portee);
        print("Erreur: Les pv_offensif ne peuvent pas etre etre superieur aux pv defensif");
        return 0;
    } catch {
        print("OK: pv_offensif > pv_defensif");
    }

    print("   == Fin test pv_offensif() ==\n");
    return 1;
}

func test_statut() -> Int{
    print("   == Test de statut() ==\n");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
	var c1 : Carte    
	do {
        c1 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

    if (c1.statut() != 0) {
        print("Erreur: statut pas en defensif a la creation")
        return 0;
    } else {
        print("OK: statut defensif a la creation")
    }

    do {
        try c1.statut(1);
        if (c1.statut() == 1) {
            print("Test Ok : statut modifie correctement")
        } else {
            print("Erreur: modification statut erreur : mauvaise valeur")
            return 0
        }
    } catch {
        print("Erreur: exception sur statut alors que valide")
        return 0;
    }

    do {
        try c1.statut(2);
        print("Erreur: Le statut ne peut etre que 1 ou 0")
        return 0

    } catch {
        print("OK: 1 ou 0 pour le statut")
    }


    print("   == Fin test statut() ==\n");
    return 1;
}


func test_puissance_attaque2() -> Int{

    print("   == Test de attaque2() ==\n");
    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
	var c1 : Carte ;
	do {
		c1 = try Carte("Soldat", 3, 4, 3, portee);

		do {
			try c1.puissance_attaque(-1)
			print("Erreur: la puissance d'attaque ne peut pas etre negative")
			return 0
			} catch {
			print("OK")
	    }

	    do {
			try c1.puissance_attaque(7)
			print("Erreur: la puissance ne peut pas etre superieure au nombre max de cartes dans la main")
			return 0
			} catch {
			print("OK")
	    }

	    do {
			try c1.puissance_attaque(3)
			print("OK")
			} catch {
			print("Erreur: la puissance d'attaque a mal ete attribuee")
			return 0
	    }

	} catch {}
    print("   == Fin test attaque2 ==\n");
    

    return 1
}


func test_portee() -> Int{
    print("   == Test de portee() ==\n");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
	var c1 : Carte 
    do {
        c1 = try Carte("Soldat", 3, 4, 3, portee);
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
	
	var i : Int = 0
		do {
			for p in c1.portee(){
				if (p != portee[i]) {
			    	print("Erreur: valeur de portee pas valide")
			    	return 0;
				} else {
			    	print("OK: valeur portee valide")
				}
				i+=1
			}
		} catch {
		}
	} catch {
    }	

    var porteeNonValide: [(Int, Int)] = [(1, 2), (0, 0)];
    // Carte valide
	var c2 : Carte
    do {
        c2 = try Carte("Soldat", 3, 4, 3, porteeNonValide);
        print("Erreur: Portee (0,0)  non geree");
        return 0;
    } catch {
        print("OK: Portee (0,0) geree");
    }

    print("   == Fin test portee() ==\n");
    return 1;
}

func test_type_carte() -> Int{
    print("   == Test de type_carte() ==\n");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
	var c1 : Carte
    do {
        c1 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

    if (c1.type_carte() != "Soldat") {
        print("Erreur: valeur de type_carte pas valide")
        return 0;
    } else {
        print("OK: valeur type_carte valide")
    }

    do {
        c1 = try Carte("", 3, 4, 3, portee);
        print("Erreur: Chane vide pas valable")
        return 0
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }


    print("   == Fin test type_carte() ==\n");
    return 1;
}

func test_degats_subis() -> Int{
    print("   == Test de degats_subis() ==\n");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
	var c1 : Carte
    do {
        c1 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

    if (c1.degats_subis() != 0) {
        print("Erreur: Les degats subits doivent etre initialises a 0 a l'Initialisation")
        return 0
    } else {
        print("OK: degats subis init a 0")
    }

    c1.degats_subis(2)
    if (c1.degats_subis() != 2) {
        print("Erreur: Modification invalide des degats_subis")
        return 0
    } else {
        print("OK : Modification correcte des degats subis")
    }

    print("   == Fin test degats_subis() ==\n");
    return 1;
}

func test_attaque() -> Int{
    print("   == Test de attaque() ==\n");

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // Carte valide
	var c1 : Carte
	var c2 : Carte
    do {
        c1 = try Carte("Soldat", 3, 4, 3, portee);
        c2 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {
        print("Erreur d'init : Une carte valide a renvoye une exception");
        return 0;
    }

    // Attque d'une carte de 3 d'attaque sur une carte de 4 de def (statut def). Resultat attendu : retour int positif
	var res : Int
    do {
        res = try c1.attaque(c2)
        if (res <= 0) {
            print("Erreur: La carte n'est pas censee etre morte")
            return 0
        } else {
            print("OK: Carte a subit des degats")
        }
    } catch {
        print("Erreur: Exception sur valide")
        return 0
    }

// Attaque d'une carte de 3 d'attaque sur une carte de 3 de def (statut off). Resultat attendu : retour int null : carte capturee
    do {
        res = try c2.attaque(c1)
        if (res != 0) {
            print("Erreur: La carte est censee etre capturee")
            return 0
        } else {
            print("Test Ok : La carte est capturee")
        }
    } catch {
        print("Erreur: Exception sur valide")
        return 0
    }


    // Attaque d'une carte en position offensive : Erreur attendue
    do {
        res = try c1.attaque(c2)
        print("Erreur: La carte est censee etre en position offensive, elle ne peut donc plus attaquer")
        return 0
    } catch {
        print("OK: La carte ne peut effectivement pas attaquer car elle est en position offensive")
    }

    // Attaque d'une carte de 3 d'attaque sur une carte de 4 de def qui a subit 3 degats. Resultat attendu : Mort de la carte
    do {
        try c1.statut(0)
        try c2.statut(0)
        res = try c1.attaque(c2)
        if (res >= 0) {
            print("Erreur : La carte est censee etre morte")
        }
    } catch {
        print("Erreur: Exception sur une attaque valide")
        return 0
    }
    print("   == Fin test attaque() ==\n");
    return 1
}


// ==== Tests ====
nb_test_ok = 0;
nb_test_tot = 0;

nb_test_tot += 1;
nb_test_ok += test_init();

nb_test_tot += 1;
nb_test_ok += test_puissance_attaque();

nb_test_tot += 1;
nb_test_ok += test_puissance_attaque2();

nb_test_tot += 1;
nb_test_ok += test_portee();

nb_test_tot += 1;
nb_test_ok += test_pv_defensif();

nb_test_tot += 1;
nb_test_ok += test_pv_offensif();

nb_test_tot += 1;
nb_test_ok += test_statut();


nb_test_tot += 1;
nb_test_ok += test_type_carte();

nb_test_tot += 1;
nb_test_ok += test_degats_subis();

nb_test_tot += 1;
nb_test_ok += test_attaque();

print("\n\(nb_test_ok) fonctions ont passe les tests sur \(nb_test_tot) ")
print("=== TESTS CARTE === \n \n")


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// === Tests Unitaires d'une Pioche ===

print("===== TESTS PIOCHE ===== \n")

// Le test passe si init n'est pas nil.
// Renvoie 1 si le test passe, 0 sinon


do {
    carte = try Carte("Soldat", 3, 4, 3, portee);
} catch {}

func test_piocher() -> Int{
    var p1 : Pioche = Pioche()
    p1.ajouter_pioche(carte)
	var retire : Carte?
    do {
        retire = try p1.piocher()
    } catch {}

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
	var c2 : Carte    
	do {
        c2 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {}

    var isNotIn = true
    for i in 0..<p1.count_pioche() {
        if p1.num_pioche(i) === retire {
            isNotIn = false
        }
    }
    if isNotIn == false {
        print("KO : La carte est toujours dans la pioche")
        return 0
    } else {
        print("OK")
    }

    if p1.count_pioche() >= 1 {
        print("KO : La carte est toujours comptee dans la pioche")
        return 0
    } else {
        print("OK")
    }

    if let retire2 = p1.piocher() {
        print("KO : On a retire une carte alors que la pioche est vide")
        return 0
    } else {
        print("OK")
    }

    return 1
}

func test_ajouter_pioche() -> Int{
    var p1 = Pioche()
    p1.ajouter_pioche(carte)

    var isIn = false
    for j in 0..<p1.count_pioche() {
        if p1.num_pioche(j) === carte {
            isIn = true
        }
    }
    if isIn == false {
        print("KO : La carte n'est pas dans la pioche")
        return 0
    } else {
        print("OK")
    }

    if p1.count_pioche() != 0 {
        print("OK")
    } else {
        print("KO : On ne compte pas le nombre correct de cartes")
        return 0
    }

    return 1
}

func test_count_pioche() -> Int{
    var p1 = Pioche()

    if p1.count_pioche() != 0 {
        print("KO : On compte un nombre de carte different de 0")
        return 0
    } else {
        print("OK")
    }

    p1.ajouter_pioche(carte)

    if p1.count_pioche() != 1 {
        print("KO : On compte un nombre de carte different de 1")
        return 0
    } else {
        print("OK")
    }
	
	var retire : Carte?
    do {
        retire = try p1.piocher()
    } catch {}

    if p1.count_pioche() != 0 {
        print("KO : On compte un nombre de carte different de 0")
        return 0
    } else {
        print("OK")
    }

    return 1
}

// ==== Tests ====
nb_test_ok = 0;
nb_test_tot = 0;

nb_test_tot += 1;
nb_test_ok += test_piocher();

nb_test_tot += 1;
nb_test_ok += test_ajouter_pioche();

nb_test_tot += 1;
nb_test_ok += test_count_pioche();


print("\n\(nb_test_ok) fonctions ont passe les tests sur \(nb_test_tot) ")
print("=== TESTS PIOCHE === \n \n")


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// === Tests Unitaires d'un Royaume ===

print("===== TESTS ROYAUMES =====\n")

// Le test passe si init n'est pas nil.
// Renvoie 1 si le test passe, 0 sinon

do {
    var carte = try Carte("Soldat", 3, 4, 3, portee);
} catch {}

func test_ajouter_royaume() -> Int{
    var r1 : Royaume = Royaume()
    r1.ajouter_royaume(carte)

    var isIn = false
    for c1 in r1 {
        if carte === c1 {
            isIn = true
        }
    }
    if isIn == false {
        print("KO : La carte n'est pas dans le Royaume")
        return 0
    } else {
        print("OK")
    }

    if r1.count_royaume() != 0 {
        print("OK")
    } else {
        print("KO : On ne compte pas le nombre correct de cartes")
        return 0
    }

    return 1
}

func test_retirer_royaume() -> Int{
    var r1 : Royaume = Royaume()
    r1.ajouter_royaume(carte)
	var isNotIn : Bool = true
    do {
        var retire = try r1.retirer_royaume()
    	var portee: [(Int, Int)] = [(1, 2), (0, 1)];
		do {
		    var c2 = try Carte("Soldat", 3, 4, 3, portee);
		} catch {}

		for c1 in r1 {
		    if c1 === retire {
		        isNotIn = false
		    }
		}
	} catch {}
    if isNotIn == false {
        print("KO : La carte est toujours dans le Royaume")
        return 0
    } else {
        print("OK")
    }

    if r1.count_royaume() >= 1 {
        print("KO : La carte est toujours comptee dans le Royaume")
        return 0
    } else {
        print("OK")
    }

    do {
        var retire2 = try r1.retirer_royaume()
        print("KO : Le Royaume etait vide")
        return 0
    } catch {
        print("OK")
    }

    r1.ajouter_royaume(carte)
    r1.ajouter_royaume(c3)
	var retire3 : Carte 
    do {
        var retire3 = try r1.retirer_royaume()
    
		if retire3 === c3 {
		    print("KO : On n'a pas retire la carte la plus ancienne")
		    return 0
		} else {
		    print("OK")
		}
	} catch {}

    return 1
}

func est_vide_royaume() -> Int{
    var r1 : Royaume = Royaume()

    if !r1.est_vide() {
        print("KO : Le Royaume est censee etre vide")
        return 0
    } else {
        print("OK")
    }

    r1.ajouter_royaume(carte)

    if r1.est_vide() {
        print("KO : Le Royaume n'est aps censee etre vide")
        return 0
    } else {
        print("OK")
    }

    return 1
}

func test_count_royaume() -> Int{
    var r1 : Royaume = Royaume()

    if r1.count_royaume() != 0 {
        print("KO : On compte un nombre de carte different de 0")
        return 0
    } else {
        print("OK")
    }

    r1.ajouter_royaume(carte)

    if r1.count_royaume() != 1 {
        print("KO : On compte un nombre de carte different de 1")
        return 0
    } else {
        print("OK")
    }

    do {
        var retire = try r1.retirer_royaume()
    } catch {}

    if r1.count_royaume() != 0 {
        print("KO : On compte un nombre de carte different de 0")
        return 0
    } else {
        print("OK")
    }

    return 1
}

// ==== Tests ====
nb_test_ok = 0;
nb_test_tot = 0;

nb_test_tot += 1;
nb_test_ok += test_ajouter_royaume();

nb_test_tot += 1;
nb_test_ok += test_retirer_royaume();

nb_test_tot += 1;
nb_test_ok += est_vide_royaume();

nb_test_tot += 1;
nb_test_ok += test_count_royaume();


print("\n\(nb_test_ok) fonctions ont passe les tests sur \(nb_test_tot)")
print("=== TESTS ROYAUME === \n \n")

