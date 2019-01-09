// Implementation de MainJ

import Foundation

public class MainJ : MainProtocol{
	public typealias TCarte = Carte
	
	// Pour creer l'erreur(s) necessaire(s)
	enum MainErreur : Error {
		case cartePasTrouvee 
	} 

    var mainJ : [Carte]

    public required init(){
        mainJ = []
    }

    public func ajouter_main(_ carte: TCarte){
        mainJ.append(carte)
    }

    public func retirer_main(_ carte: TCarte) throws -> TCarte {
		let n = mainJ.count - 1
		for i in 0...n {
			// On efface la premiere carte avec le nom "Archer"
			if mainJ[i].type_carte() == carte.type_carte(){
				let x = carte
				mainJ.remove(at: i)
				return x
			}

		}
		// Si je suis arrive ici, la carte n'est pas dans la mainJ
		throw MainErreur.cartePasTrouvee
    }

	public func count_main() -> Int {
		return mainJ.count
	}

	public func est_vide() -> Bool {
		return mainJ.isEmpty
	}




	public func makeIterator() -> MainIterator {
		return MainIterator(self)
	}
}

	public class MainIterator : MainProtocolIterator {
		public typealias TCarte = Carte
		var courant : Int
		var mainJ : MainJ

		init(_ m : MainJ) {
			self.mainJ = m
			courant = -1
		}


		public func next() -> TCarte? {
			// On incremente courant pour passer a la valeur prochaine
			courant = courant + 1

			// On verifie si la courant-ieme valeur existe
			// Sinon, on renvoie Vide
			if (courant > (mainJ.mainJ.count - 1)) {
				return nil
			}
			else {
				return mainJ.mainJ[courant]
			}
		}
	}
