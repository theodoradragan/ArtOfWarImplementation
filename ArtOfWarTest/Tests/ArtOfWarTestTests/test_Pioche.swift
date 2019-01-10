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
