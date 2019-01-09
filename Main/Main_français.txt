ART OF WAR - Algo en Français

// === Initialisation de la partie === 

Remplir les pioches des 2 joueurs de 9 soldats, 6 gardes et 5 archers
Mettre dans les mains des 2 joueurs 1 roi (random) et les 3 premières cartes de la pioche (= piocher 3x)
Piocher une carte dans la pioche et la placer dans le Royaume (pour les 2 joueurs)
J1 : Choisir n’importe quelle carte de sa main et la placer sur le Front
J2 : Choisir n’importe quelle carte de sa main et la placer sur le Front
Vérifier que chaque joueur a 3 cartes dans sa main // Normalement tout le temps vrai 

// === JEU ===
// === Tour de jeu ===
Tant que condition de fin pas remplie :

	// === Phase de préparation ===
	Passez les cartes sur le champ de bataille du joueurs actif en position défensive
	Reinitialiser les dégâts subits par les cartes du joueurs actifs // Remettre à 0
	S'il reste encore des cartes dans la pioche
		Piocher : Prendre la première carte de la pioche et la placer dans sa main
	Sinon 
		FinDeLaGuerre // Fin de la partie : Les 2 pioches sont à 0, et le joueur actif doit piocher

	// === Phase d'action ===

	Choisir entre “Rien”, “Déployer”, “Attaquer” 

	Si Rien : Passer à la phase de développement

	Si Déployer : 
		Choisir et placer une carte de sa main sur le plateau 
		Si déjà occupé : 
			Échange entre carte de la main et carte du champ de bataille

	Si Attaquer :
		Tant qu’il reste des cartes qui peuvent attaquer 
		ET que le joueur veut continuer d’attaquer 
		ET que des cartes sont à portée :
			Choisir la carte qui attaque 
			Choisir la carte à attaquer 
			
			Verification de la validité // La carte peut attaquer et est à portée d'attaque de la 2ème carte

			La carte attaque : La carte attaquée est soit morte, soit capturée, soit blessée

			Si la carte est morte :
				si c’est le roi
					Exécution // Fin de la partie : Le roi a été tué
				Sinon
					Envoyée au cimetière

			Si la carte est capturée :
				La carte va dans le royaume du joueur attaquant

			S'il y avait une carte derrière la carte morte ou capturée :
				Cette carte avance au Front

			
			//action du joueur 2 (ou joueur touché)
			Si le plateau du joueur attaqué est vide alors // Conscription
				Si le Royaume du joueur attaqué n'est pas vide alors
					On sort la première carte du royaume et on la place sur le champ de bataille
				Sinon si la main du joueur attaqué n'est pas vide alors
					Le joueur attaqué choisis une carte de sa main et la place sur le Front
				Sinon 
					Effondrement // Fin de la partie : Le joueur ne peut plus envoyer d'unités
			
				
	// === Phase de développement ===
	Si le joueur actif a plus de 6 cartes en main alors
		Le joueur DOIT choisir une carte de sa main et la placer dans le royaume jusqu’à avoir <6 cartes
	Sinon 
		Le joueur PEUT choisir une ou plusieurs cartes de sa main pour les placer dans le royaume 

// === Fin du tour ===
	Changement du joueur actif


// === Fin de Partie ===

Par Effondrement : Un joueur ne peut plus conscrire et son royaume s'effondre
Par Exécution : Le Roi d'un des joueurs est mort
Fin de la guerre : Les deux joueurs on vidé leur pioche
