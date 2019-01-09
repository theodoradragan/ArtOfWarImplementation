// === Tests Unitaires d'un Royaume ===

// Le test passe si init n'est pas nil.
// Renvoie 1 si le test passe, 0 sinon

var portee: [(Int, Int)] = [(1, 2), (0, 1)];
var porteeVide = [];
do {
    try var carte = Carte("Soldat", 3, 4, 3, portee);
} catch {}

func test_ajouter_royaume() -> Int{
    var r1 = Royaume()
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

    if m1.count_royaume() != 0 {
        print("OK")
    } else {
        print("KO : On ne compte pas le nombre correct de cartes")
        return 0
    }

    return 1
}

func test_retirer_royaume() -> Int{
    var r1 = Royaume()
    var c1 = r1.ajouter_Royaume(carte)
    do {
        try var retire = m1.retirer_royaume(carte)
    } catch {}
    
    var portee: [(Int, Int)] = [(1, 2), (0, 1)];
    var porteeVide = [];
    do {
        try var c2 = Carte("Soldat", 3, 4, 3, portee);
    } catch {}

    var isNotIn = true
    for c1 in r1 {
        if c1 === retire {
            isNotIn = false
        }
    }
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
        try var retire2 = r1.retirer_royaume()
        print("KO : Le Royaume etait vide")
        return 0
    } catch {
        print("OK")
    }

    r1.ajouter_royaume(carte)
    r1.ajouter_royaume(c2)
    do {
        try var retire3 = r1.retirer_royaume()
    } catch {}
    if retire3 === c2 {
        print("KO : On n'a pas retire la carte la plus ancienne")
        return 0
    } else {
        print("OK")
    }

    return 1
}

func test_est_vide() -> Int{
    var r1 = Royaume()

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
    var r1 = Royaume()
    
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
        try var retire = r1.retirer_royaume(carte)
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
var nb_test_ok: Int = 0;
var nb_test_tot: Int = 0;

nb_test_tot += 1;
nb_test_ok += test_ajouter_royaume();

nb_test_tot += 1;
nb_test_ok += test_retirer_royaume();

nb_test_tot += 1;
nb_test_ok += test_est_vide();

nb_test_tot += 1;
nb_test_ok += test_count_royaume();


print("=== FIN DES TESTS ===")
print("\(nb_test_ok) fonctions ont passe les tests sur \(nb_test_tot)")