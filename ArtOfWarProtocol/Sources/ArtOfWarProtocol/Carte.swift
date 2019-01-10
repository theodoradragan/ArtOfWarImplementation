import Foundation

// on doit ajouter le protocol Equatable plus tard
public class Carte : CarteProtocol {

	// Les attributs d'une carte
	var Type_carte: String
	var Puissance_attaque: Int
	var Pv_defensif: Int
	var Pv_offensif: Int
	var Portee: [(Int, Int)]
	var Statut : Int // 0 pour deffensif, 1 pour offensif
	var Degats_subis : Int // elle sera restauree a 0 chaque neuf tour

	enum CarteErreur : Error {
		case carteVide
		case attaqueNegative
		case pvDefNegatif
		case pvOffNegatif
		case pvDef_INF_pvOff
		case mauvaisStatut
		case statutNonDefensif
	}



	// TO DO : find why we need 'required'

	public required init(_ type_carte: String, _ puissance_attaque: Int, _ pv_defensif: Int,_ pv_offensif: Int,_ portee: [(Int, Int)]) throws {
		if type_carte.isEmpty {
			throw CarteErreur.carteVide
		}

		if puissance_attaque < 0 {
			throw CarteErreur.attaqueNegative
		}

		if pv_defensif < 0 {
			throw CarteErreur.pvDefNegatif
		}

		if pv_offensif <= 0 {
			throw CarteErreur.pvOffNegatif
		}

		if pv_defensif < pv_offensif {
			throw CarteErreur.pvDef_INF_pvOff
		}

		// On doit ajouter self parce que l'attribut de la classe Carte et le parametre
		// d'init ont le meme nom : type_carte. On peut oublier self si c'est pas le meme nom.
		self.Type_carte = type_carte
		self.Puissance_attaque = puissance_attaque
		self.Pv_defensif = pv_defensif
		self.Pv_offensif = pv_offensif
		self.Portee = portee
		self.Statut = 0 
		self.Degats_subis = 0

	}

	public func puissance_attaque() -> Int {
		return self.Puissance_attaque
	}

	public func puissance_attaque(_ puis_att: Int) {
		if (puis_att > 0 && puis_att < 7) {
			self.Puissance_attaque = puis_att
		}
	}

	public func pv_defensif() -> Int {
		return self.Pv_defensif
	}

	public func pv_offensif() -> Int {
		return self.Pv_offensif
	}
	
	
	public func pv_restants() -> Int {
		if self.Statut == 0{ 	//statut = 0 = defensif
			return self.Pv_defensif - self.Degats_subis
		}
		else{ 	//sinon on est en position offensif
			return self.Pv_offensif - self.Degats_subis
		}
	} 

	public func statut() -> Int {
		return self.Statut
	}

	public func statut(_ statut : Int) throws{
		if (statut != 0 && statut != 1) {
			throw CarteErreur.mauvaisStatut
		}
		self.Statut = statut
	}

	public func portee() -> [(Int, Int)] {
		return self.Portee
	}

	public func type_carte() -> String {
		return self.Type_carte
	}

	public func degats_subis() -> Int {
		return self.Degats_subis
	}

	public func degats_subis(_ degats : Int) {
		if degats > 0 {
			self.Degats_subis = degats
		}
	}

	public func attaque (_ carte_attaquee : CarteProtocol ) throws -> Int {

		// Precondition : carte_attaquee doit etre sur le Plateau : je sais pas comment on va verifier ca ?? 

		// Precondition : la carte courante doit etre en statut pv_defensif
		if(self.statut() != 0) { // Si la carte n'est pas en statut defensif
			throw CarteErreur.statutNonDefensif
		}


		var pv_attaquee : Int // les points de vie de la carte attaquee

		if carte_attaquee.statut() == 0 {
			// statut : deffensif
			pv_attaquee = carte_attaquee.pv_defensif()
		}
		else {
			pv_attaquee = carte_attaquee.pv_offensif()
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
