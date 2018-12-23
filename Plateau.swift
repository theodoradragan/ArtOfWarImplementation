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

class Plateau : PlateauProtocol {

	/*

	Schema du Plateau pour un joueur :

	  1     (0,1)   (1,1)   (2,1)   |   Arriere
	  0     (0,0)   (1,0)   (2,0)   |   Front
	  y/x     0       1       2

	*/

	// On va utiliser une matrice
	var plateau : [(Int, Int, CarteProtocol)] // xCarte , yCarte , Carte

	required init() {
		plateau = [(Int, Int, CarteProtocol)]()
	}

	// On va implementer ca, parce qu'on a besoin d'un moyen de chercher une carte selon ses coordonnees.
	func carte_en_position(_ x: Int, _ y: Int) -> CarteProtocol? {

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

	func ajouter_plateau(_ carte : CarteProtocol, _ posX : Int, _ posY : Int) throws {

		// Verifier que les coordonnees sont valides :
		if ( posX < 0 || posX > 2 || posY < 0 || posY > 1) {
      throw PlateauErrors.CoordoneesInvalides
		}

		// Verifie si la case est bien vide :
		if let carteAux = carte_en_position(posX, posY) {
			throw PlateauErrors.CaseNonVide
		}

		// Si on veut mettre a l'arriere alors que le front est libre,
		// on place la carte au front

		if posY == 1 {
			if let carteEnArriere = self.carte_en_position(posX, 0) {
				// on ajoute la carte sur posX et posY
				self.plateau.append((posX, posY, carte))
			}
			else {
				// il y a pas une carte en front en front de notre carte, on ajoute notre carte en front.
				self.plateau.append((posX, 0, carte))
			}
		}
	}


    func plateau_vide() -> Bool{

        if plateau.isEmpty {
            return true
        }
        else {
            return false
        }
    }




    func retirer_plateau(_ carte: CarteProtocol) throws -> CarteProtocol{

        if self.plateau_vide() { //plateau vide renvoie une erreur
            throw PlateauErrors.PlateauVide
        }

        var i : Int = 0
        var nonRetire : Bool = true

        while nonRetire && i<plateau.count {
            if ( carte == plateau[i][2] ) {    //si la carte correspond
                return((plateau.remove(at: i))) //on supprime la carte du plateau et on return
            }
            i = i + 1
        }
		    if i == plateau.count { //si en ayant parcouru tout le plateau on a rien supprime, on renvoie un erreur
			       throw PlateauErrors.CartePasSurPlateau
		    }
	}


	func position_carte(_ carte: CarteProtocol) -> (Int, Int){

		var res : (Int, Int)
		for i in 1...(plateau.count) {
			if carte == plateau[i][2]{ // condition pour verifier que carte est bien dans le plateau
				res = (plateau[i][0], plateau[i][1])
			}
		}
		return res
	}


	func est_occupee(_ x:Int, _ y: Int) -> Bool {

		for c in plateau{
			if c[0]==x && c[1]==y {
				return true //on retourne true si la case est occupee ( attention dans les specifs c'est le contraire ! )
			}
		return false //si on a rien renvoye avant alors la position est vide
		}
	}


	func reorganiser_plateau(){
		for i in 0...2 {

			if !(est_occupee(i,0)) && est_occupee(i,1) {

				//on cree une var temporaire pour ne pas supprimer la carte ajoutee
				if let temp : Carte = carte_en_position(i,1){
					// on enleve la carte a l'arriere
					retirer_plateau(temp)

					//on ajoute au front la carte qui etait a l'arriere
					do { try ajouter_plateau(temp, i, 0)}
					catch {}
				}
			}
		}
	}




	// tuer est presque la meme fonction que retirer_carte sans return
	func tuer(_ carte: CarteProtocol) throws {

		if self.plateau_vide() { //plateau vide renvoie une erreur
      throw PlateauErrors.PlateauVide
        }

        var i : Int = 0
        var nonRetire : Bool = true
        while nonRetire && i<plateau.count {
            if plateau[i][2] == carte {
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


	func est_a_portee(_ p_def: Plateau, _ c_att: CarteProtocol, _ c_def: CarteProtocol) -> Bool {

    var res : Bool = false
    var position_att : (Int,Int) = position_carte(c_att)
    // pour la def ce n'est pas le meme plateau donc on precise:
    var position_def : (Int,Int) = position_carte(p_def.c_def)
    var possible : [(Int,Int)] = [] // on stock les cases atteignables

    if type_carte(c_att) == "Soldat" || type_carte(c_att) == "Garde" {
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

    else if type_carte(c_att) == "Archer" {
      if position_att == (2,1) || position_att == (0,1) {
        possible.append((1,0))
      }
      else if position_att == (1,1) {
        possible.append((0,0),(2,0))
      }
      else if position_att == (2,0) || position_att == (0,0) {
        possible.append((1,1),position_att)
      }
      else if position_att == (1,0) {
        possible.append((0,1),(2,1))
      }
    }

    else if type_carte(c_att) == "Roi-1" {
      if position_att == (0,0) {
        possible.append((2,0),(1,0),(0,0),(2,1))
      }
      else if position_att == (1,0) {
        possible.append((2,0),(1,0),(0,0),(1,1))
      }
      else if position_att == (2,0) {
        possible.append((2,0),(1,0),(0,0),(0,1))
      }
      else if position_att == (0,1) {
        possible.append((2,0))
      }
      else if position_att == (1,1) {
        possible.append((1,0))
      }
      else if position_att == (2,1) {
        possible.append((0,0)))
      }
    }

    else if type_carte(carte_att) == "Roi-2" {
      if position_att == (0,0) {
        possible.append((2,0),(1,0),(0,0))
      }
      else if position_att == (1,0) {
        possible.append((2,0),(1,0),(0,0))
      }
      else if position_att == (2,0) {
        possible.append((2,0),(1,0),(0,0))
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


	func count_cartes_qui_peuvent_attaquer() -> Int {

		var res : Int = 0
		for i in plateau {
			if plateau[2].statut == 0 {
				res+=1
			}
		}
	}

	func makeIterator() -> PlateauIterator {
		return PlateauIterator(self)

	}

}

public class PlateauIterator : PlateauProtocolIterator {

	var courant : Int
	var plateau : Plateau

	required init(_ p : Plateau) {
		self.plateau = p
		courant = -1
	}


	public func next() -> CarteProtocol? {
		// On incremente courant pour passer a la valeur prochaine
		courant = courant + 1

		// On verifie si la courant-ieme valeur existe
		// Sinon, on renvoie Vide
    /*
 _____________________________,add8ba,
____________________________,d888888888b,
___________________________d8888888888888b_________________________,ad8ba,_
__________________________d88888888888888 _____________________,d888888888b,
__________________________I8888888888888888____________________,8888888888888b
__________________________`Y88888888888888P"""""""""""baaa,___,888888888888888 ,
____________,adP"""""""""""9888888888P""^_________________^""Y8888888888888888 I
_________,a8"^___________,d888P"888P^___________________________^"Y8888888888P '
_______,a8^____________,d8888'_____________________________________^Y8888888P'
______a88'___________,d8888P'________________________________________I88P"^
____,d88'___________d88888P'__________________________________________"b,
___,d88'___________d888888'____________________________________________`b,
__,d88'___________d888888I______________________________________________`b,
__d88I___________,8888888'_______________________________________________`b,
_,888'___________d8888888__________,d88888b,______________________________`b,
_d888___________,8888888I_________d88888888b,___________,d8888b,___________`b
,8888___________I8888888I________d8888888888I__________,88888888b___________8,
I8888___________88888888b_______d88888888888'__________8888888888b__________8I
d8886___________888888888_______Y888888888P'___________Y8888888888,________,8b
88888b__________I88888888b______`Y8888888^_____________`Y888888888I________d88 ,
Y88888b_________`888888888b,______`""""^________________`Y8888888P'_______d888 I
`888888b_________88888888888b,___________________________`Y8888P^________d8888 8
_Y888888b_______,8888888888888ba,__________________________`""^________,d88888 8
_I8888888b,____,888888888888888888ba,______d88888888b_______________,ad8888888 I
_`888888888b,__I8888888888888888888888b,____^"Y888P"^__________.,ad88888888888 I
__88888888888b,`888888888888888888888888b,_____""______ad888888888888888888888 '
__8888888888888698888888888888888888888888b_,ad88ba,_,d88888888888888888888888
__88888888888888888888888888888888888888888b,`"""^_d8888888888888888888888888I
__8888888888888888888888888888888888888888888baaad888888888888888888888888888'
__Y8888888888888888888888888888888888888888888888888888888888888888888888888P
__I888888888888888888888888888888888888888888888P Y8888888888888888888888'
__`Y88888888888888888P88888888888888888888888888'_____^88888888888888888888I
___`Y8888888888888888_`8888888888888888888888888_______8888888888888888888P'
____`Y888888888888888__`888888888888888888888888,_____,888888888888888888P'
_____`Y88888888888888b__`88888888888888888888888I_____I888888888888888888'
_______"Y8888888888888b__`8888888888888888888888I_____I88888888888888888'
_________"Y88888888888P___`888888888888888888888b_____d8888888888888888'
____________^88888888^_____`Y88888888888888888888,____888888888888888P'
_____________________________"8888888888888888888b,___Y888888888888
______________________________88888888888888888888____888888888888

    __
___( o)>
\ <_. )
 `---'

  pourquoi as-tu mis plateau.plateau.count et pas seulement plateau.count ?

*/
		if (courant > (plateau.plateau.count - 1)) {
			return nil
		}
		else {
			return (plateau.plateau[courant])[2]
		}
	}
}
