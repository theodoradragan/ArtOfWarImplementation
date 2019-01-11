// === Tests Unitaires d'un Plateau ===
import ArtOfWarProtocol
// Le test passe si init n'est pas nil.
// Renvoie 1 si le test passe, 0 sinon

var portee: [(Int, Int)] = [(1, 2), (0, 1)];
var porteeVide: [(Int, Int)] = [];

func test_ajouter_plateau() -> Int{
	var carte : Carte
    let p1 = Plateau()
	// let portee: [(Int, Int)] = [(1, 2), (0, 1)]; --> pas utilisee
	// let porteeVide: [(Int, Int)] = [];   --> pas utilisee

    //do {
	    do {
			carte = try Carte("Soldat", 3, 4, 3, portee);
			try p1.ajouter_plateau(carte, -1, 0)
			print("KO : La position X est mauvaise")
			return 0
	    } catch {
		print("OK")
	    }
	
	    do {
			carte = try Carte("Soldat", 3, 4, 3, portee);
			try p1.ajouter_plateau(carte, 0, -1)
			print("KO : La position Y est mauvaise")
			return 0
	    } catch {
		print("OK")
	    }

	    do {
			carte = try Carte("Soldat", 3, 4, 3, portee);
			try p1.ajouter_plateau(carte, 3, 0)
			print("KO : La position X est mauvaise")
			return 0
	    } catch {
		print("OK")
	    }

	    do {
			carte = try Carte("Soldat", 3, 4, 3, portee);
			try p1.ajouter_plateau(carte, 0, 2)
			print("KO : La position Y est mauvaise")
			return 0
	    } catch {
			print("OK")
	    }

	    do {
			carte = try Carte("Soldat", 3, 4, 3, portee);
			try p1.ajouter_plateau(carte, 0, 0)
			print("OK")
	    } catch {
			print("KO : La carte ne s'est pas ajoutee correctement")
			return 0
	    }

	    do {
			let c2 = try Carte("Soldat", 3, 4, 3, portee);
			 do {try p1.ajouter_plateau(c2, 0, 1)} catch{}
			 do {
				let c3 = try Carte("Soldat", 3, 4, 3, portee);
				try p1.ajouter_plateau(c3, 0, 1)
				print("KO : Une carte etait deja a cet emplacement")
				//return 0
			} catch {
				print("OK")
			}
	    } catch{}
	   

	    do {
			let c2 = try Carte("Soldat", 3, 4, 3, portee);
			try p1.ajouter_plateau(c2, 0, 1)
			print("KO : cette carte a deja ete ajoutee")
	    } catch {
			print("OK")
	    }
		
    //} catch {}
    return 1
}


func test_retirer_plateau() -> Int{
	let p1 = Plateau()
	var carte : Carte
	var portee: [(Int, Int)] = [(1, 2), (0, 1)];

	do {
		carte = try Carte("Soldat", 3, 4, 3, portee);

		do {
			try p1.ajouter_plateau(carte, 0, 0)
		} catch {}

		var retire = try p1.retirer_plateau(carte)
		

		
		

		var isNotIn = true
		for c1 in p1 {
		    if c1 === retire {
		        isNotIn = false
		    }
		}
		if isNotIn == false {
		    print("KO : La carte est toujours sur le plateau")
		    return 0
		} else {
		    print("OK")
		}

		do {
		    var c2 = try Carte("Soldat", 3, 4, 3, portee);
		    var retire2 = try p1.retirer_plateau(c2)
		    print("KO : On a retire une carte qui n'est pas sur le plateau")
		    return 0
		} catch {
		    print("OK")
		}
	} catch {}

    return 1
	
}

func test_position_carte() -> Int{
	var carte : Carte
    let p1 = Plateau()

	do {
		carte = try Carte("Soldat", 3, 4, 3, portee);
		do { try p1.ajouter_plateau(carte, 0, 0)} catch {}

		let position = p1.position_carte(carte)

		if position.0 == 0 && position.1 == 0 {
		    print("OK")
		} else {
		    print("KO : On ne renvoie pas les bonnes positions")
		    return 0
		}
	} catch {}
    return 1
}


func test_carte_en_position() -> Int{
	var carte : Carte
    let p1 = Plateau()
	do {
		carte = try Carte("Soldat", 3, 4, 3, portee);
		do { try p1.ajouter_plateau(carte, 0, 0) } catch {}
		
		let retire = p1.carte_en_position(0, 0)
	    print("OK")
	    if retire === carte {
	        print("OK")
	    } else {
	        print("KO : La carte retiree n'est pas la bonne")
	        return 0
	    }
		 
	}
	catch {
	    print("KO : Aucune carte n'a ete retiree")
	    return 0
	}

	if let _ = p1.carte_en_position(0, 1) {
	    print("KO : On a retourne une carte a un emplacement vide")
	    return 0
	} else {
	    print("OK")
	}
	
    return 1
}

func test_est_occupee() -> Int{
	var carte : Carte
    let p1 = Plateau()

	do {
		carte = try Carte("Soldat", 3, 4, 3, portee);
		do { try p1.ajouter_plateau(carte, 0, 0) } catch {}

		if p1.est_occupee(0, 0) {
		    print("OK")
		} else {
		    print("KO : La case est censee ne pas etre occupee")
		    return 0
		}

		if p1.est_occupee(0, 1) {
		    print("KO : La case n'est pas censee etre occupee")
		    return 0
		} else {
		    print("OK")
		}
	} catch {}
    return 1
}

func test_reorganiser_plateau() -> Int{
	var carte : Carte
    let p1 = Plateau()
    let portee: [(Int, Int)] = [(1, 2), (0, 1)];
    // var porteeVide: [(Int, Int)] = [];
    do {
		carte = try Carte("Soldat", 3, 4, 3, portee);
        let c2 = try Carte("Soldat", 3, 4, 3, portee);
		do { try p1.ajouter_plateau(carte, 0,0) } catch {}
		do { try p1.ajouter_plateau(c2, 0, 1) } catch {}

		do { try p1.retirer_plateau(carte)} catch {}
		p1.reorganiser_plateau()

		if p1.est_occupee(0, 0) {
		    print("OK")
		} else if p1.est_occupee(1, 0) || p1.est_occupee(2, 0) {
		    print("KO : La carte a l'Arriere n'a pas ete avancee au bon emplacement")
		    return 0
		} else if p1.est_occupee(1, 1) || p1.est_occupee(2, 1) {
		    print("KO : La carte a l'Arriere n'a pas ete deplacee dans la bonne direction")
		    return 0
		} else {
		    print("KO : La carte n'a pas ete avancee")
		    return 0
		}
    } catch {}

    
    return 1
}


func test_plateau_vide() -> Int{
	var carte : Carte
    let p1 = Plateau()

    if p1.plateau_vide() {
        print("OK")
    } else {
        print("KO : Le plateau est vide")
    }
    
	do {
		carte = try Carte("Soldat", 3, 4, 3, portee);
    	do { try p1.ajouter_plateau(carte, 0, 0) } catch {}

		if p1.plateau_vide() {
		    print("KO : Le plateau n'est pas vide")
		    return 0
		} else {
		    print("OK")
		}
	} catch {}

    return 1
}

func test_tuer() -> Int{
	var carte : Carte
    let p1 = Plateau()
	let portee: [(Int, Int)] = [(1, 2), (0, 1)];

    do { 
		carte = try Carte("Soldat", 3, 4, 3, portee);
		try p1.ajouter_plateau(carte, 0, 0) 
	} catch {}

    do {
		carte = try Carte("Soldat", 3, 4, 3, portee);
        try p1.tuer(carte)
    } catch {}

    do {
		var isNotIn = true
		carte = try Carte("Soldat", 3, 4, 3, portee);
		for c1 in p1 {
		    if c1 === carte {
		        isNotIn = false
		    }
		}
		if isNotIn == false {
		    print("KO : La carte est toujours sur le plateau")
		    return 0
		} else {
		    print("OK")
		}

		do {
			let c2 = try Carte("Soldat", 3, 4, 3, portee);
		    try p1.tuer(c2)
		    print("KO : On a tue une carte qui n'est pas sur le plateau")
		    return 0
		} catch {
		    print("OK")
		}
    } catch {}
    return 1
}

func test_count_cartes_qui_peuvent_attaquer() -> Int{
    let p1 = Plateau()
	var carte : Carte

	do {
		carte = try Carte("Soldat", 3, 4, 3, portee);
		try p1.ajouter_plateau(carte, 0, 0)
		if p1.count_cartes_qui_peuvent_attaquer() != 0 {
		    print("KO : Aucune carte ne peut attaquer")
		    return 0
		} else {
		    print("OK")
		}

		do {
		    try carte.statut(0)
		}

		if p1.count_cartes_qui_peuvent_attaquer() != 1 {
		    print("KO : On ne compte pas le bon nombre de carte")
		    return 0
		} else {
		    print("OK")
		}
	} catch {}
    return 1
}

// ==== Tests ====
var nb_test_ok: Int = 0;
var nb_test_tot: Int = 0;

nb_test_tot += 1;
nb_test_ok += test_ajouter_plateau();

nb_test_tot += 1;
nb_test_ok += test_retirer_plateau();

//nb_test_tot += 1;
//nb_test_ok += test_position_carte();

//nb_test_tot += 1;
//nb_test_ok += test_carte_en_position();

//nb_test_tot += 1;
//nb_test_ok += test_est_occupee();

//nb_test_tot += 1;
//nb_test_ok += test_reorganiser_plateau();

//nb_test_tot += 1;
//nb_test_ok += test_plateau_vide();

//nb_test_tot += 1;
//nb_test_ok += test_tuer();

//nb_test_tot += 1;
//nb_test_ok += test_count_cartes_qui_peuvent_attaquer();

print("=== FIN DES TESTS ===")
print("\(nb_test_ok) fonctions ont passe les tests sur \(nb_test_tot)")

