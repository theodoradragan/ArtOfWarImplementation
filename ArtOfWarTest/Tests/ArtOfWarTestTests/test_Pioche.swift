// === Tests Unitaires d'une Pioche ===

// Le test passe si init n'est pas nil.
// Renvoie 1 si le test passe, 0 sinon

var portee: [(Int, Int)] = [(1, 2), (0, 1)];
var porteeVide = [];
do {
    var carte = try Carte("Soldat", 3, 4, 3, portee);
} catch {}

func test_piocher() -> Int{
    var p1 = Pioche()
    p1.ajouter_pioche(carte)
    do {
        var retire = try p1.piocher()
    } catch {}

    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    var porteeVide = [];
    do {
        var c2 = try Carte("Soldat", 3, 4, 3, portee);
    } catch {}

    var isNotIn = true
    for c1 in p1 {
        if c1 === retire {
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
    for c1 in p1 {
        if carte === c1 {
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

    do {
        var retire = try p1.piocher()
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
var nb_test_ok: Int = 0;
var nb_test_tot: Int = 0;

nb_test_tot += 1;
nb_test_ok += test_piocher();

nb_test_tot += 1;
nb_test_ok += test_ajouter_pioche();

nb_test_tot += 1;
nb_test_ok += test_count_pioche();


print("=== FIN DES TESTS ===")
print("\(nb_test_ok) fonctions ont passe les tests sur \(nb_test_tot)")
