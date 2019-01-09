// Implementation PlateauProtocol

import Foundation

enum PlateauErrors : Error {
 	case CoordoneesInvalides
  case CaseNonVide
  case PlateauVide
  case CartePasSurPlateau
}

// extension PlateauError : CustomStringConvertible {
// 	var description : String {
// 		switch self {
// 			case .CoordoneesInvalides:
// 				return "Coordonees invalides : x doit etre entre 0 et 2 , y entre 0 et 1"
// 		}
// 	}
// }

public class Plateau : PlateauProtocol {

	public typealias TCarte = Carte

	/*

	Schema du Plateau pour un joueur :

	  1     (0,1)   (1,1)   (2,1)   |   Arriere
	  0     (0,0)   (1,0)   (2,0)   |   Front
	  y/x     0       1       2

	*/

	// On va utiliser une matrice
	var plateau : [(xCarte : Int, yCarte: Int, carte : Carte)] // xCarte , yCarte , Carte

	public required init() {
		plateau = [(Int, Int, Carte)]()
	}

	// On va implementer ca, parce qu'on a besoin d'un moyen de chercher une carte selon ses coordonnees.
	public func carte_en_position(_ x: Int, _ y: Int) -> Carte? {

		if (x < 0 || x > 2) {
			return nil
		}

		if (y < 0 || y > 1) {
			return nil
		}

		for carte in plateau {
			let (xCarte , yCarte, instanceCarte) = carte
			if x == xCarte && y == yCarte {
				return instanceCarte
			}
		}

		return nil

	}



	public func ajouter_plateau(_ carte : Carte, _ posX : Int, _ posY : Int) throws {

		// Verifier que les coordonnees sont valides :
		if ( posX < 0 || posX > 2 || posY < 0 || posY > 1) {
      throw PlateauErrors.CoordoneesInvalides
		}

		// Verifie si la case est bien vide :
		if carte_en_position(posX, posY) != nil {
			throw PlateauErrors.CaseNonVide
		}

		// Si on veut mettre a l'arriere alors que le front est libre,
		// on place la carte au front

		if posY == 1 {
			if self.carte_en_position(posX, 0) != nil {
				// on ajoute la carte sur posX et posY
				self.plateau.append((posX, posY, carte))
			}
			else {
				// il y a pas une carte en front en front de notre carte, on ajoute notre carte en front.
				self.plateau.append((posX, 0, carte))
			}
		}
	}

   	

    public func plateau_vide() -> Bool{

        if plateau.isEmpty {
            return true
        }
        else {
            return false
        }
    }



	@discardableResult
    public func retirer_plateau(_ carte: Carte) throws -> CarteProtocol{

        if self.plateau_vide() { //plateau vide renvoie une erreur
            throw PlateauErrors.PlateauVide
        }

        var i : Int = 0

        while i < plateau.count {
            if ( carte === plateau[i].2 ) {    //si la carte correspond
                let x = (plateau.remove(at: i)).2 //on supprime la carte du plateau et on return
				return x
            }
            i = i + 1
        }
		// si on arrive ici, on a retire rien => erreur
	
		throw PlateauErrors.CartePasSurPlateau

	}


	public func position_carte(_ carte: Carte) -> (Int, Int){

		var res : (Int, Int) = (-1 , -1)
		for i in 1...(plateau.count) {
			if carte === plateau[i].2{ // condition pour verifier que carte est bien dans le plateau
				res = (plateau[i].0, plateau[i].1)
			}
		}
		return res
	}


	public func est_occupee(_ x:Int, _ y: Int) -> Bool {

		for c in plateau{
			if (c.0 == x && c.1 == y) {
				return true //on retourne true si la case est occupee ( attention dans les specifs c'est le contraire ! )
			}
		}
		return false //si on a rien renvoye avant alors la position est vide
	}


	public func reorganiser_plateau(){
		for i in 0...2 {

			if !(est_occupee(i,0)) && est_occupee(i,1) {

				//on cree une var temporaire pour ne pas supprimer la carte ajoutee
				if let temp : Carte = carte_en_position(i,1){
					// on enleve la carte a l'arriere
					
					do { 
						try retirer_plateau(temp)
					}
					catch {}

					//on ajoute au front la carte qui etait a l'arriere
					do { 
						try ajouter_plateau(temp, i, 0)
					}
					catch {}
				}
			}
		}
	}


	// tuer est presque la meme fonction que retirer_carte sans return
	public func tuer(_ carte: Carte) throws {

		if self.plateau_vide() { //plateau vide renvoie une erreur
      throw PlateauErrors.PlateauVide
        }

        var i : Int = 0
        var nonRetire : Bool = true
        while nonRetire && i < plateau.count {
            if plateau[i].2 === carte {
			// si la carte du plateau correspond a celle en entree
			// alors on supprime la carte du plateau
              plateau.remove(at: i)
            	nonRetire = false
              i = i - 1 // pour ne pas avoir l'erreur qui suit
            }
            i = i + 1
        }
		if i == plateau.count { //si en ayant parcouru tout le plateau on a rien supprime, on renvoie un erreur
      throw PlateauErrors.CartePasSurPlateau
		}
	}


	public func est_a_portee(_ p_def: Plateau, _ c_att: Carte, _ c_def: Carte) -> Bool {

    var res : Bool = false
    let position_att : (Int,Int) = self.position_carte(c_att)
    // pour la def ce n'est pas le meme plateau donc on precise:
    let position_def : (Int,Int) = p_def.position_carte(c_def)

    var possible : [(Int,Int)] = [] // on stock les cases atteignables

    if c_att.type_carte() == "Soldat" || c_att.type_carte() == "Garde" {
      if position_att == (2,0) {
        possible.append((0,0))
      }
      else if position_att == (1,0) {
        possible.append((1,0))
      }
      else if position_att == (0,0) {
        possible.append((2,0))
      }
    }

    else if c_att.type_carte() == "Archer" {
      if position_att == (2,1) || position_att == (0,1) {
        possible.append((1,0))
      }
      else if position_att == (1,1) {
        possible.append((0,0))
		possible.append((2,0))
      }
      else if position_att == (2,0) || position_att == (0,0) {
        possible.append((1,1))
		possible.append(position_att)
      }
      else if position_att == (1,0) {
        possible.append((0,1))
		possible.append((2,1))
      }
    }

    else if c_att.type_carte() == "Roi-1" {
      if position_att == (0,0) {
        possible.append((2,0))
		possible.append((1,0))
		possible.append((0,0))
		possible.append((2,1))
      }
      else if position_att == (1,0) {
        possible.append((2,0))
		possible.append((1,0))
		possible.append((0,0))
		possible.append((2,1))
      }
      else if position_att == (2,0) {
        possible.append((2,0))
		possible.append((1,0))
		possible.append((0,0))
		possible.append((0,1))
      }
      else if position_att == (0,1) {
        possible.append((2,0))
      }
      else if position_att == (1,1) {
        possible.append((1,0))
      }
      else if position_att == (2,1) {
        possible.append((0,0))
      }
    }

    else if c_att.type_carte() == "Roi-2" {

	// TODO : verifie logique ici.

      if position_att == (0,0) || position_att == (1,0) || position_att == (2,0) {
		possible.append((2,0))
		possible.append((1,0))
		possible.append((0,0))
      }
    }

    // une fois que l'on sait ou une carte peut attaquer on peut verifier
    // que la carte attaquee est ou non atteignable :
    for i in possible {
      if i == position_def {
        res = true
      }
    }
    return res
	}


	public func count_cartes_qui_peuvent_attaquer() -> Int {

		var res : Int = 0
		for p in plateau {
			if (p.2).statut() == 0 {
				res += 1
			}
		}
		return res
	}

	public func makeIterator() -> PlateauIterator {
		return PlateauIterator(self)

	}

}

public class PlateauIterator : PlateauProtocolIterator {

	var courant : Int
	var plateau : Plateau

	public required init(_ p : Plateau) {
		self.plateau = p
		courant = -1
	}


	public func next() -> CarteProtocol? {
		// On incremente courant pour passer a la valeur prochaine
		courant = courant + 1

		// On verifie si la courant-ieme valeur existe
		// Sinon, on renvoie Vide
   
		if (courant > (plateau.plateau.count - 1)) {
			return nil
		}
		else {
			return (plateau.plateau[courant]).2
		}
	}
}
