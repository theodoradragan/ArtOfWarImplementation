/*
  PlateauProtocol (ou Plateau) est une collection qui contiendra des CarteProtocol (ou Cartes)
  Un Plateau represente le champ de bataille de chaque joueur, on aura donc un plateau par joueur
  Regles du Plateau :
  Le Plateau compte deux lignes et trois colonnes
  Les deux lignes representent le Front et l'Arriere du Plateau
  Quand on ajoute des cartes au Plateau, elles doivent etre placees sur le Front
  Si le Front est occupe, on les place sur l'Arriere

  Representation du Plateau :
  Dans ce programme, on considere le Plateau par rapport a des axes orthonormes x et y
  l'axe des x represente les colonnes, l'axe des y represente les lignes
  L'origine du repere se trouve a la premiere colonne du
  Front : la ligne de Front est a 0, la ligne Arriere est a 1
  La premiere colonne est a 0, la derniere est a 2

  Schema du Plateau pour un joueur :
  1     (0,1)   (1,1)   (2,1)   |   Arriere
  0     (0,0)   (1,0)   (2,0)   |   Front
  y/x     0       1       2

  Sur un Plateau d'un meme joueur on doit pouvoir :
    - y ajouter une carte
    - y retirer une carte
    - savoir les cartes presentes sur le Plateau
    - connaitre la position d'une carte
    - savoir quelle carte se trouve a une certaine position
    - savoir si une case du plateau est occupee par une carte
    - reorganiser les cartes du plateau par rapport aux regles du jeu
    - savoir si le Plateau est vide
    - tuer une carte
    - savoir le nombre de carte qui peuvent encore attaquer lors d'un tour
    - savoir quelles sont les cartes qui peuvent encore attaquer lors d'un tour
*/
public protocol PlateauProtocol: Sequence {
  associatedtype PlateauProtocolIterator : IteratorProtocol
	associatedtype TCarte : CarteProtocol
    /*
      init : -> PlateauProtocol
      Creee un plateau vide
    */
    init()

    /*
      ajouter_plateau : PlateauProtocol x CarteProtocol -> PlateauProtocol
      Ajoute une carte aux positions x et y

      Quand on ajoute des cartes au Plateau, elles doivent etre placees sur le Front
      Si les coordonnees passees en parametres representent une case de l'Arriere
      et que la case devant (au Front) est vide alors on place la carte sur le Front

      Param : Carte a ajouter au plateau
      Param : position x ou placer la carte
      Param : position y ou placer la carte
      Pre : la case du plateau doit etre vide
      Post : la carte est ajoutee au plateau
      Post : lance une erreur si une carte est deja presente (n'ajoute pas la carte)
      Post : lance une erreur si les coordonnes ne sont pas valides (<0 ou >=3)
    */
    mutating func ajouter_plateau(_ carte: TCarte, _ posX: Int, _ posY: Int) throws

    /*
      retirer_plateau : PlateauProtocol x CarteProtocol -> PlateauProtocol x CarteProtocol
      Retire une carte du plateau
      Param : carte a retirer
      Pre : la carte a retirer doit etre sur le plateau
      Pre : le plateau ne doit pas etre vide
      Post : la carte est retiree du plateau
      Post : Lance une erreur si la precontion n'est pas respectee
    */
    mutating func retirer_plateau(_ carte: TCarte) throws -> TCarte

    /*
      position_carte : PlateauProtocol x CarteProtocol -> (Int, Int)
      Donne la position d'une carte sur le plateau
      Param : carte dont on veut savoir la position
      Pre : la carte doit etre sur le plateau
      Post : retourne un tuple d'entier representant la position de la carte
    */
    func position_carte(_ carte: TCarte) -> (Int, Int)

    /*
      carte_en_position : PlateauProtocol x Int x Int -> CarteProtocol
      Donne la carte a une position du plateau
      Param : position x et position y en entiers
      Pre : x doit etre compris entre 0 et 2
      Pre : y doit etre compris entre 0 et 1
      Post : retourne la carte a la position donnee au parametre
    */
    func carte_en_position(_ x: Int, _ y: Int) -> TCarte?

    /*
      est_occupee : PlateauProtocol x Int x Int -> Bool
      Verifie si une case est occupee par une carte
      Pre : x doit etre compris entre 0 et 2
      Pre : y doit etre compris entre 0 et 1
      Post : retourne true si la case est vide, false sinon
    */
    func est_occupee(_ x: Int, _ y: Int) -> Bool

    /*
      est_a_portee : PlateauProtocol x PlateauProtocol x CarteProtocol x CarteProtocol -> Bool
      Verifie si une carte attaquee est a portee d'une carte attaquante 
      Param : - p_def le plateau ennemi
              - c_att la carte attaquante
              - c_def la carte attaquee
      Pre : - la carte attaquante doit etre sur le plateau attaquant
            - la carte attaquee doit etre sur le plateau attaque
      Post : retourne true si la carte est a portee, false sinon
    */
    func est_a_portee(_ p_def: Self, _ c_att: TCarte, _ c_def: TCarte) -> Bool

    /*
      reorganiser_plateau : PlateauProtocol -> PlateauProtocol
      Reorganise les cartes sur le plateau

      On avance les cartes de l'Arriere vers le Front si les cases
      du Front sont vides (cad sans carte) comme suit :

      F1(vide)    F2(plein)    F3(vide)
         ||
      A1(plein)   A2(plein)    A3(vide)

      Dans cet exemple, la carte en A1 avance en F1 (et pas en F3)
      Les cartes sont toujours avancees sur les cases directement devant elles

      Pre :
      Post : Il n'y a plus de cases a l'Arriere pleine si les
      cases du Front directement devant elles sont vides
    */
    mutating func reorganiser_plateau()

    /*
      plateau_vide : PlateauProtocol -> Bool
      Verifie si le tableau est vide
      Pre :
      Post : retourne true si le tableau est vide, false sinon
    */
    func plateau_vide() -> Bool

    /*
      tuer : PlateauProtocol x CarteProtocol -> PlateauProtocol
      Supprime une carte du plateau et du jeu
      Note : Cette fonction est l'equivalent de l'envoi au cimetiere, cependant,
      un cimetiere est inutile dans cette version du jeu. La carte est juste Supprime
      du plateau et ne sera pas reatribuee dans une autre collection : cela aura
      pour effet de la supprimer du jeu.
      Pre : la carte doit etre sur le plateau
      Post : supprime la carte du plateau si elle meurt
    */
    mutating func tuer(_ carte: TCarte) throws

    /*
      count_cartes_qui_peuvent_attaquer : PlateauProtocol -> Int
      Compte les cartes qui peuvent encore attaquer sur le plateau
      Les cartes qui peuvent encore attaquer pendant un tour sont les cartes en
      position defensive (les cartes qui ont deja attaque sont en position offensive)

      Pre :
      Post : retourne le nombre entier de carte qui peuvent encore attaquer
    */
    func count_cartes_qui_peuvent_attaquer() -> Int

    /*
      makeIterator : PlateauProtocol -> PlateauProtocolIterator
      cree un iterateur sur la collection de cartes du Plateau
    */
    func makeIterator() -> PlateauProtocolIterator
}


/*
  PlateauProtocolIterator est le protocol iterateur de PlateauProtocol, qui va donc parcourir la collection
  de CarteProtocol du PlateauProtocol

  (rappel) Schema du Plateau :
     F1(0,0)   F2(1,0)   F3(2,0)   |   Front J
     A1(0,1)   A2(1,1)   A3(2,1)   |   Arriere J


  On veut parcourir le Plateau en partant de la Carte en position (0,0) jusqu'en position (3,1)
*/
protocol PlateauProtocolIterator : IteratorProtocol {
	associatedtype TCarte : CarteProtocol

  /*
    next : PlateauProtocolIterator -> PlateauProtocolIterator x CarteProtocol?
    renvoie la prochaine carte dans la collection du Plateau
    Pre :
    Post : retourne la carte suivante dans la collection du Plateau, ou nil si on a atteint le fin de la collection
  */
  mutating func next() -> TCarte?
}
