// === Tests Unitaires d'une Main ===

// Le test passe si init n'est pas nil.
// Renvoie 1 si le test passe, 0 sinon
import ArtOfWarProtocol
var portee: [(Int, Int)] = [(1, 2), (0, 1)];
var carte : Carte = try Carte("Soldat", 3, 4, 3, portee)
var c3 : Carte = try Carte("Soldat", 2, 3, 3, portee)

func test_ajouter_main() -> Int{
    let m1 = MainJ()
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
    let m1 = MainJ()
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
    do {
        _ = try m1.retirer_main(c2)
        print("KO : On a retire une carte qui n'est pas dans la main")
        return 0
    } catch {
	print("OK 1.5")
    }

    return 1
}


func test_count_main() -> Int{
    let m1 = MainJ()

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

    do {
        _ = try m1.retirer_main(carte)
    } catch {}

    if m1.count_main() != 0 {
        print("KO : On compte un nombre de carte different de 0")
        return 0
    }

    return 1
}

func test_est_vide() -> Int{
    let m1 = MainJ()

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

print("=== FIN DES TESTS ===")
print("\(nb_test_ok) fonctions ont passe les tests sur \(nb_test_tot)")
