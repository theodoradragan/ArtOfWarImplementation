/*
  RoyaumeProtocol (ou Royaume) est une file (FIFO) qui contient des CarteProtocol (ou Cartes)
  Le Royaume contient des cartes "demobilisees" et chaque joueur possede un Royaume
  Avec le Royaume on doit pouvoir :
    - ajouter une carte 
    - retirer une carte 
    - savoir s'il est vide
    - compter le nombre de cartes
*/

public protocol RoyaumeProtocol: Sequence {
  associatedtype RoyaumeProtocolIterator : IteratorProtocol
associatedtype TCarte : CarteProtocol
    /*
      init : -> RoyaumeProtocol
      Creee un Royaume vide
    */
    init()

    /*
      ajouter_royaume : RoyaumeProtocol x CarteProtocol -> RoyaumeProtocol
      Ajoute une carte au Royaume
      Pre : la carte a ajouter ne doit pas etre deja dans le Royaume
      Post : ajoute la carte au Royaume
    */
    mutating func ajouter_royaume(_ carte: TCarte)

    /*
      retirer_royaume : RoyaumeProtocol x CarteProtocol -> RoyaumeProtocol x CarteProtocol
      Retire la premiere carte/la carte la plus ancienne ajoutee au Royaume (FIFO)
      Pre : le Royaume n'est pas vide, sinon renvoie une erreur
      Post : retire la carte du Royaume
    */
    mutating func retirer_royaume() throws -> TCarte

    /*
      est_vide : RoyaumeProtocol -> Bool
      Verifie si le Royaume est vide
      Pre :
      Post : retourne true si le Royaume est vide, false sinon
    */
    func est_vide() -> Bool

    /*
      count_royaume : RoyaumeProtocol -> Int
      Compte le nombre de cartes dans le Royaume
      Pre :
      Post : retourne le nombre de cartes dans le Royaume
    */
    func count_royaume() -> Int

    /*
      makeIterator : RoyaumeProtocol -> RoyaumeProtocolIterator
      cree un iterateur sur la collection de cartes en FIFO (premiere carte ajoutee, premiere carte sortie)
    */
    func makeIterator() -> RoyaumeProtocolIterator 
}


/*
  RoyaumeProtocolIterator (ou iterateur de RoyaumeProtocol) est un iterateur qui sert a aider au parcours de la collection
  de RoyaumeProtocol. 

  On itere dans le Royaume de la plus ancienne a la plus recente.
*/
protocol RoyaumeProtocolIterator: IteratorProtocol {
associatedtype TCarte : CarteProtocol
  /*
    next : RoyaumeProtocolIterator -> RoyaumeProtocolIterator x CarteProtocol?
    renvoie la prochaine carte dans la collection du Royaume
    Pre :
    Post : retourne la carte suivante dans la collection du Royaume, ou nil si on a atteint le fin de la collection
  */
  mutating func next() -> TCarte?
}
