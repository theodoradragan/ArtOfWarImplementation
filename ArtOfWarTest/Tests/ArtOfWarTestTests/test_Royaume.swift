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

