// === Tests Unitaires d'une Main ===

// Le test passe si init n'est pas nil.
// Renvoie 1 si le test passe, 0 sinon

var portee: [(Int, Int)] = [(1, 2), (0, 1)];
var porteeVide = [];
do {
    try var carte = Carte("Soldat", 3, 4, 3, portee);
} catch {}

func test_ajouter_main() -> Int{
    var m1 = Main()
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
        print("OK")
    }

    if m1.count_main() != 0 {
        print("OK")
    } else {
        print("KO : On ne compte pas le nombre correct de cartes")
        return 0
    }

    return 1
}

func test_retirer_main() -> Int{
    var m1 = Main()
    m1.ajouter_main(carte)
    do {
        try var retire = m1.retirer_main(carte)
    } catch {}
    
    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    var porteeVide = [];
    do {
        try var c2 = Carte("Soldat", 3, 4, 3, portee);
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
        print("OK")
    }

    if m1.count_main() >= 1 {
        print("KO : La carte est toujours comptee dans la main")
        return 0
    } else {
        print("OK")
    }

    do {
        try var retire2 = m1.retirer_main(c2)
        print("KO : On a retire une carte qui n'est pas dans la main")
        return 0
    } catch {
        print("OK")
    }

    return 1
}

func test_count_main() -> Int{
    var m1 = Main()
    
    if m1.count_main() != 0 {
        print("KO : On compte un nombre de carte different de 0")
        return 0
    }

    m1.ajouter_main(carte)

    if m1.count_main() != 1 {
        print("KO : On compte un nombre de carte different de 1")
        return 0
    }

    if m1.count_main() == 1 {
        print("OK")
    } else {
        print("KO : On n'a rajoute une carte et on ne la compte pas")
    }

    do {
        try var carte = m1.retirer_main(carte)
    } catch {}
    
    if m1.count_main() != 0 {
        print("KO : On compte un nombre de carte different de 0")
        return 0
    }

    return 1
}

func test_est_vide() -> Int{
    var m1 = Main()

    if !m1.est_vide() {
        print("KO : La main est censee etre vide")
        return 0
    } else {
        print("OK")
    }

    m1.ajouter_main(carte)
    
    if m1.est_vide() {
        print("KO : La main n'est aps censee etre vide")
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
nb_test_ok += test_ajouter_main();

nb_test_tot += 1;
nb_test_ok += test_retirer_main();

nb_test_tot += 1;
nb_test_ok += test_count_main();

nb_test_tot += 1;
nb_test_ok += test_est_vide();

print("=== FIN DES TESTS ===")
print("\(nb_test_ok) fonctions ont passe les tests sur \(nb_test_tot)")