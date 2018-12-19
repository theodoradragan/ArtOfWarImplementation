/* MainProtocol (ou La Main) represente la collection qui contiendra des CarteProtocol (Cartes)
  Une MainProtocol possede les caracteristiques suivantes :
    On doit pouvoir ajouter des cartes a La Main
    On doit pouvoir retirer des cartes a La Main
    On doit pouvoir savoir le nombre de cartes dans La Main
*/

public protocol MainProtocol: Sequence {
    associatedtype MainProtocolIterator : IteratorProtocol
    /*
      init : -> MainProtocol
      Creee une Main vide
    */
    init()

    /*
      ajouter_main : MainProtocol x CarteProtocol -> MainProtocol
      Param : la carte a ajouter
      Pre :
      Post : la carte est ajoutee a La Main
    */
    mutating func ajouter_main(_ carte: CarteProtocol)

    /*
      retirer_main : MainProtocol x CarteProtocol -> MainProtocol x CarteProtocol
      retire la carte de la main : la carte a retirer ne sera plus dans la Main
      Param : la carte a retirer
      Pre : La main ne doit pas etre vide
      Pre: La carte doit faire partie de la main (erreur si ce n'est pas le cas)
      Post : renvoie la carte retiree si elle est retiree
      (Note : renvoyer la carte est inutile car le parametre demande la reference
      mais il s'agit plutot d'une verification)
    */
    mutating func retirer_main(_ carte: CarteProtocol) throws -> CarteProtocol

    /*
      count_main : MainProtocol -> Int
      Pre :
      Post : retourne le nombre de carte dans la main
    */
    func count_main() -> Int

    /*
      est_vide : MainProtocol -> Bool
      Pre :
      Post : retourne vrai si la main est vide
    */
    func est_vide() -> Bool

    /*
      makeIterator : MainProtocol -> MainProtocolIterator
      cree un iterateur sur la collection de cartes de la Main
    */
    func makeIterator() -> MainProtocolIterator
}

/*
  MainProtocolIterator est un iterateur de MainProtocol qui aide au parcours de la collection
  de MainProtocol.
*/
protocol MainProtocolIterator: IteratorProtocol {

    /*
      next : MainProtocolIterator -> MainProtocolIterator x CarteProtocol?
      renvoie la prochaine carte de la collection de la Main
      Pre :
      Post : retourne la carte suivante dans la collection de la Main, ou nil si on a atteint le fin de la collection
    */
    mutating func next() -> CarteProtocol?
}
