// Implementation PlateauProtocol

import Foundation
import ArtOfWarProtocol

// enum PlateauError : ErrorType {
// 	case CoordoneesInvalides
// }

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
	var plateau : [(Int, Int, Carte)] // xCarte , yCarte , Carte

	init(){
		plateau = [(Int, Int, Carte)]()
	}

	// On va implementer ca, parce qu'on a besoin d'un moyen de chercher une carte selon ses coordonnees.
	func carte_en_position(_ x: Int, _ y: Int) -> Carte? {

		if (x < 0 || x > 2) {
			return Vide
		}

		if (y < 0 || y > 1) {
			return Vide
		}

		for carte in plateau {
			let (xCarte , yCarte, instanceCarte) = carte
			if x == xCarte && y == yCarte {
				return instanceCarte
			}
		}

		return Vide

	}

	mutating func ajouter_plateau(_ carte : Carte, _ posX : Int, _ posY : Int) throws {

		// Verifier que les coordonnees sont valides :
		if ( x < 0 || x > 2 || y < 0 || y > 1) {
			// will throw error
			throw Error
		}

		// Verifier si la case est vide :
		if let carteAux = carte_en_position(posX, posY) {
			// will throw error
		}

		// Si on met a l'arriere meme si on a la positions libres a le front,
		// on doit mettre la carte a front

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


}