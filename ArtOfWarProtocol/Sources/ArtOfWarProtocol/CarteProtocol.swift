/*
 	CarteProtocol (ou carte) est l'element avec lequel le reste du programme interagira.
 	Une Carte represente une unite sur un champ de bataille
	Elle possede comme caracteristique
 		- Un type, C'est la designation de la carte. Une carte peut etre par exemple un "roi", un "soldat", un "garde" ou un "archer".
			Ce type sera surtout utile pour identifier la carte. De nouvelles unites avec des types differents pourraient etre crees.
		- Une puissance d'attaque : C'est les degats que cette carte pourra effectuer lorsqu'elle attaquera une autre carte
		- Un statut (ou position) : Une carte peut etre en statut defensif ou offensif. En fonction de ce statut, elle peut ne pas avoir le meme nombre de PV
		- Des PV en statut defensif
		- Des PV en statut offensif
        ==> PV : Points de vie (= defense dans les regles du jeu)
		- Une portee : C'est la direction relative qu'une carte peut atteindre (on ne peut pas se taper soi-meme)
		Par exemple : un archer peut atteindre les directions (-2 ; 1), (-1 ; 2), (1 ; 2), (2 ; 1)
		par rapport a la position (x ; y) de la carte sur le Plateau. La direction (-2 ; 1) correspond a attaquer
		"deux cases vers la gauche, une case vers l'avant"

	Une carte doit pouvoir :
		- passer de statut defensif a statut offensif
		- infliger des degats
		- attaquer une autre carte
*/
public protocol CarteProtocol {

    // init : String x Int x Int x Int x (Int,Int)[] -> CarteProtocol
    // Creation d'une carte avec toutes ses caracteristiques (type, puissance d'attaque, statut, PV en statut offensif, pv en statut defensif, portee)
    // Le statut est defini en defensif
    // Les degats sont initialises a 0
    // Param : type_carte est le nom du type de la carte. Elle ne peut pas etre une chaine vide
    // Param : puissance_attaque est la puissance d'attaque de la carte, elle doit etre strictement positive
    // Param : pv_defensif est la valeur de pv maximum en statut defensif, elle doit etre strictement positive
    // Param : pv_offensif est la valeur de pv maximum en statut offensif, elle doit etre strictement positive
    // Param : pv_defensif >= pv_offensif
    // Param : portee est un tableau de tuples qui representent chacun une direction possible de l'attaque de la carte
    //			les deux elements des tuples ne peuvent pas etre nuls
    init(_ type_carte: String, _ puissance_attaque: Int, _ pv_defensif: Int,_ pv_offensif: Int,_ portee: [(Int, Int)]) throws

    // puissance_attaque : CarteProtocol -> Int
    // Post : retourne la puissance d'attaque de la carte
    func puissance_attaque() -> Int

    // puissance_attaque : CarteProtocol x Int -> CarteProtocol
    // Param : la puissance d'attaque a appliquer
    // Pre : la puissance d'attaque doit etre prositive
    // Pre : la puissance d'attaque est comprise entre 1 et 6 (inclus)
    // Post : modifie la puissance d'attaque de la carte
    mutating func puissance_attaque(_ puis_att: Int) throws // correction: ajout du throw sinon ne passe pas le test

    // pv_defensif : CarteProtocol -> Int
    // Post : retourne les pv de la carte lorsqu'elle est en statut defensif
    func pv_defensif() -> Int

    // pv_offensif : CarteProtocol -> Int
    // Post : retourne les pv de la carte lorsqu'elle est en statut offensif
    func pv_offensif() -> Int

    // pv_restant : CarteProtocol -> Int
    // fonction get pv qui renvoie les pv en fonction du statut actuel de la carte
    // Post : La difference entre les pv en fonction du statut actuel de la carte et les degats subits durant ce tour
    func pv_restants() -> Int

    // statut : CarteProtocol -> Int
    // Post : retourne le statut actuel de la carte
    func statut() -> Int

    // statut : CarteProtocol x Int -> CarteProtocol
    // Modifie le statut de la carte.
    // La carte est en statut DEFENSIF si son statut est a 0.
    // La carte est en statut OFFENSIF si son statut est a 1.
    // Param : statut represente le nouveau statut de la carte
    // Pre : Statut ne peut unique prendre comme valeur 0 ou 1
    // Post : Modifie le statut en fonction de la valeur en parametre (carte en
    //      offensif si 1, carte en defensif si 0)
    // 	Ne fait rien et genere une erreur si les precondition n'ont pas ete respectees
    mutating func statut(_ statut: Int) throws

    // portee : CarteProtocol x Int -> [(Int, Int)]
    // Renvoie la portee de la carte
    // Post : Retourne un tableau de tuples contenant les portees relatives a la carte
    func portee() -> [(Int, Int)]

    // type_carte : CarteProtocol -> String
    // Post : Retourne le type de la carte sous forme de String
    func type_carte() -> String

    // degats_subis : CarteProtocol -> Int
    // Post : Renvoie les degats subis par la carte
    func degats_subis() -> Int

    // degats_subis : CarteProtocol x Int -> CarteProtocol
    // Param : degats represente les degats totaux subis par la carte
    // Pre : degats ne peut pas etre negative
    // Post : remplace les degats subis par la valeur passee en parametre si les pre sont verifiees
    mutating func degats_subis(_ degats: Int)

    // attaque : CarteProtocol x CarteProtocol -> Int
    // Carte courante (attaquante) attaque carte attaquee
    /*
        Lors d'une attaque, on compare la valeur d'attaque de la carte courante aux pv de la carte attaquee selon son statut (offensif ou defensif)
        Si la valeur d'attaque de la carte courante sont superieurs aux pv de la carte attaquee selon son statut
            la carte attaquee meurt
        Si la valeur d'attaque de la carte courante sont egaux aux pv de la carte attaquee selon son statut
            la carte attaquee est capturee
        Si la valeur d'attaque de la carte courante sont inferieure aux pv de la carte attaquee selon son statut
            la carte attaquee subit des degats selon la puissance_attaque de la carte courante
    */
    // Param : la carte a attaquer
    // Pre : la carte courante et la carte attaquee doivent etre sur le Plateau
    // Pre : la carte courante doit etre en statut defensif
    // Post : Retourne un entier qui represente la situation de la carte attaquee apres attaque
    //			Entier negatif : la carte attaquee est morte
    //			Entier nul : la carte attaquee est capturee
    //			Entier positif : les degats subits par la carte attaquee si elle n'a pas ete tuee ou capturee
    func attaque(_ carte_attaquee: CarteProtocol) throws -> Int

}
