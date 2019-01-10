// Implementation de PiocheProtocol

import Foundation

public class Pioche : PiocheProtocol{
	public typealias TCarte = Carte

	//pioche est une collection de cartes de type Carte
	var pioche : [TCarte] 
	
	// on cree une pioche vide
	public required init(){
		pioche = []
	}

	public func piocher() -> TCarte? {
	
		// On renvoie nil si la pioche est vide
		
		if pioche.isEmpty { 
				return nil
			}
			else{ 
				// on renvoie un element aleatoire de la pioche sinon, et on le supprime de la pioche
				//print(count_pioche())
				let rang : Int = Int.random(in: 0..<count_pioche())
				return pioche.remove(at: rang) //remove() renvoie l'element supprime
			}

	}

	public func ajouter_pioche(_ carte: TCarte) {
		pioche.append(carte)
		
	}

	public func count_pioche() -> Int {
		return pioche.count
	
	}

}
