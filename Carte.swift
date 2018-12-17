import Foundation
import ArtOfWarProtocol

class Carte : CarteProtocol, Equatable {

	// Les atributs d'une carte
	var type_carte: String
	var puissance_attaque: Int
	var pv_defensif: Int
	var pv_offensif: Int
	var portee: [(Int, Int)]
	var statut : Int // 0 pour deffensif, 1 pour offensif
	var degats_subis : Int // elle sera restauree a 0 chaque neuf tour

	init(_ type_carte: String, _ puissance_attaque: Int, _ pv_defensif: Int,_ pv_offensif: Int,_ portee: [(Int, Int)]) throws {
		if type_carte.isEmpty {
			// will throw error
			// and will not create object anymore
		}

		if puissance_attaque < 0 {
			// will throw error
		}

		if pv_defensif < 0 {
			// will throw error
		}

		if pv_offensif < 0 {
			// will throw error
		}

		if pv_defensif < pv_offensif {
			// will throw error
		}

		for port in portee {
			let (x , y) = port
			if x == nil || y == nil {
				// will throw error
			}
		}

		// On doit ajouter self parce que l'attribut de la classe Carte et le parametre
		// d'init ont le meme nom : type_carte. On peut oublier self si c'est pas le meme nom.
		self.type_carte = type_carte
		self.puissance_attaque = puissance_attaque
		self.pv_defensif = pv_defensif
		self.pv_offensif = pv_offensif
		self.portee = portee
		self.statut = 0 
		self.degats_subis = 0
	}

	func puissance_attaque() -> Int {
		return self.puissance_attaque
	}

	mutating func puissance_attaque(_ puis_att: Int) {
		if (puis_att > 0 && puis_att < 7) {
			self.puissance_attaque = puis_att
		}
	}

	func pv_defensif() -> Int {
		return self.pv_defensif
	}

	func pv_offensif() -> Int {
		return self.pv_offensif
	}
	
	
	func pv_restants() -> Int {
		// TO DO
	} 

	func statut() -> Int {
		return self.statut
	}

	mutating func statut(_ statut : Int) throws{
		if (statut != 0 && statut != 1) {
			// will throw error
		}

		self.statut = statut
	}

	func portee() -> [(Int, Int)] {
		return self.portee
	}

	func type_carte() -> String {
		return self.type_carte
	}

	func degats_subis() -> Int {
		return self.degats_subis
	}

	mutating func degats_subis(_ degats : Int) {
		if degats > 0 {
			self.degats_subis = degats
		}
	}

	func attaque (_ carte_attaquee : Carte ) throws -> Int {

		// Precondition : carte_attaquee doit etre sur le Plateau : je sais pas comment on va verifier ca ?? 

		// Precondition : la carte courante doit etre en statut pv_defensif
		if(self.statut() != 0) { // Si la carte n'est pas en statut defensif
			// will throw exception
		}


		var pv_attaquee : Int // les points de vie de la carte attaquee

		if self.statut() == 0 {
			// statut : deffensif
			pv_attaquee = self.pv_defensif()
		}
		else {
			pv_attaquee = self.pv_offensif()
		}


		if self.puissance_attaque() > pv_attaquee {
			// la carte_attaquee va mourrir
			return -1 
		}

		else if self.puissance_attaque() == pv_attaquee {
			// la carte est capturee
			return 0
		}

		else {
			return self.puissance_attaque()
		}

	}


}