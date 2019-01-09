// Implementation Royaume protocol

import Foundation

public class Royaume : RoyaumeProtocol{

	public typealias TCarte = Carte

	enum RoyaumeErreur : Error {
		case royaumeVide
	}

	
	// On utilisera un tableau pour implementer la file (FIFO)
	var list : [Carte]

	public required init(){
		list = [] 
	}

	// Pour ajouter une Carte
	public func ajouter_royaume(_ carte : TCarte) {
		// Si la carte n'est deja dans la liste, on l'ajoute
		
		for i in 1...list.count{
			if list[i] === carte {
				return
			}
		}
		
		list.append(carte)
	}


	public func est_vide() -> Bool {
		return list.isEmpty
	}

	// Pour enlever une Carte
	public func retirer_royaume() throws -> Carte {
		if (self.est_vide()) {
			throw RoyaumeErreur.royaumeVide
		}
		else {
			return list.removeFirst()
		}
	}

	public func count_royaume() -> Int {
		return list.count
	}

	public func makeIterator() -> RoyaumeIterator {
		return RoyaumeIterator(self)
	}

}

public class RoyaumeIterator : RoyaumeProtocolIterator {

	var courant : Int
	var royaume : Royaume

	init(_ r : Royaume) {
		self.royaume = r
		courant = -1
	}


	public func next() -> CarteProtocol? {
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
