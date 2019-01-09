// Implementation Royaume protocol

import Foundation

class Royaume : RoyaumeProtocol{

	typealias TCarte = Carte

	enum RoyaumeErreur : Error {
		case royaumeVide
	}

	
	// On utilisera un tableau pour implementer la file (FIFO)
	var list : [Carte]

	required init(){
		list = [] 
	}

	// Pour ajouter une Carte
	func ajouter_royaume(_ carte : TCarte) {
		// Si la carte n'est deja dans la liste, on l'ajoute
		
		for i in 1...list.count{
			if list[i] === carte {
				return
			}
		}
		
		list.append(carte)
	}


	func est_vide() -> Bool {
		return list.isEmpty
	}

	// Pour enlever une Carte
	func retirer_royaume() throws -> Carte {
		if (self.est_vide()) {
			throw RoyaumeErreur.royaumeVide
		}
		else {
			return list.removeFirst()
		}
	}

	func count_royaume() -> Int {
		return list.count
	}

	func makeIterator() -> RoyaumeIterator {
		return RoyaumeIterator(self)
	}

}

class RoyaumeIterator : RoyaumeProtocolIterator {

	var courant : Int
	var royaume : Royaume

	init(_ r : Royaume) {
		self.royaume = r
		courant = -1
	}


	func next() -> CarteProtocol? {
		// On incremente courant pour passer a la valeur prochaine
		courant = courant + 1

		// On verifie si la courant-ieme valeur existe
		// Sinon, on renvoie Vide
		if (courant > (royaume.list.count - 1)){
			return nil
		}
		else {
			return royaume.list[courant]
		}
	}
}
