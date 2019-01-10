/* PiocheProtocol (ou Pioche) est une collection de CarteProtocol
    On doit pouvoir piocher (donc retirer) une carte au hasard dans la Pioche
    On doit pouvoir ajouter des cartes dans la Pioche
    On doit pouvoir savoir le nombre de carte dans la Pioche

*/

protocol PiocheProtocol {
	associatedtype TCarte : CarteProtocol
    /*
      init : -> PiocheProtocol
      Creee une pioche vide
    */
    init()

    /*
      piocher : PiocheProtocol -> PiocheProtocol x CarteProtocol?
      renvoie une carte de la collection de la Pioche au hasard
      Pre :
      Post : retourne une carte choisie au hasard dans la Pioche ou nil si la Pioche est vide
    */
    mutating func piocher() -> TCarte?

    /*
      ajouter_pioche : PiocheProtocol x CarteProtocol -> PiocheProtocol
      Param : carte a ajouter a la Pioche
      Pre : la carte a ajouter ne doit pas etre deja dans la Pioche
      Post : ajoute la carte a la Pioche
    */
    mutating func ajouter_pioche(_ carte: TCarte)

    /*
      count_pioche : PiocheProtocol -> Int
      Post : compte le nombre de carte dans la Pioche
    */
    func count_pioche() -> Int
}
