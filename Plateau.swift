// Implementation PlateauProtocol

import Foundation

enum PlateauError : Error {
 	case CoordoneesInvalides
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
			// will throw error
			//throw PlateauError.CoordoneesInvalides
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
    
	
    func plateau_vide() -> Bool{
        
        if plateau.isEmpty {
            return true
        }
        else{
            return false
        }
    }
    
    
    
    
    func retirer_plateau(_ carte: CarteProtocol) throws -> CarteProtocol{

        if self.plateau_vide(){ //plateau vide renvoie une erreur
            // throw Error
        }

        var i : Int = 0
        var nonRetire : Bool = true
        while nonRetire && i<plateau.count {

			let (x, y, c) = plateau[i]
            if (((Carte) c) == ((Carte) carte)) {    
                return((plateau.remove(at: i))[2]) //si on la carte du plateau correspond a celle en entree alors on supprime la carte du plateau et on return
            }
            i = i + 1
        }
		if i == plateau.count { //si en ayant parcouru tout le plateau on a rien supprime, on renvoie un erreur
			// throw Error
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
		for i in 1...3 {

			if !(est_occupee(i, 0)) && est_occupee(i,1) {

				//on cree une var temporaire pour ne pas supprimer la carte ajoutee
				if let temp : Carte = carte_en_position(i,1){ 
					// on enleve la carte a l'arriere
					retirer_plateau(temp)

					//on ajoute la carte qui etait a l'arriere
					do { try ajouter_plateau(temp, i, 0)}
					catch {}
				}
			}
		}
	}




	// tuer est presque la meme fonction que retirer_carte sans return
	func tuer(_ carte: CarteProtocol) throws {

		if self.plateau_vide(){ //plateau vide renvoie une erreur
            // throw Error
        }

        var i : Int = 0
        var nonRetire : Bool = true
        while nonRetire && i < plateau.count {
            if plateau[i][2] == carte {
			// si on la carte du plateau correspond a celle en entree 
			// alors on supprime la carte du plateau     
                plateau.remove(at: i) 
            	nonRetire = false
				i = i - 1 // pour ne pas avoir l'erreur qui suit
			}
            i = i + 1
        }
		if i == plateau.count { //si en ayant parcouru tout le plateau on a rien supprime, on renvoie un erreur
			// throw Error....
		}
	}

////////////////////////////////////////////////////////////////////
	func est_a_portee(_ p_def: Plateau, _ c_att: CarteProtocol, _ c_def: CarteProtocol) -> Bool {

		
	}

/////////////////////////////////////////////////////////////////////

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
		if (courant > (plateau.plateau.count - 1)) {
			return nil
		}
		else {
			return (plateau.plateau[courant])[2]
		}
	}
}





