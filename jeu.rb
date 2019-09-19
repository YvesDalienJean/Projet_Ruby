class Personne
  attr_accessor :nom, :points_de_vie, :en_vie

  def initialize(nom)
    @nom = nom
    @points_de_vie = 100
    @en_vie = true
  end

  def info
  	#Résolu
    # - Renvoie le nom et les points de vie si la personne est en vie
    # - Renvoie le nom et "vaincu" si la personne a été vaincue
  	if @points_de_vie > 0 
  	    return "#{@nom} (#{@points_de_vie}/100 pv) " 
  	else
  	    return "#{@nom} (Vaincu)"
  	end
  end

  def attaque(personne)
  	#Résolu
    # - Fait subir des dégats à la personne passée en paramètre
    # - Affiche ce qu'il s'est passé
  	puts "#{@nom} attaque #{personne.nom}"
    personne.subit_attaque(degats)
  end

  	
  

  def subit_attaque(degats_recus)
  	#Résolu
    # - Réduit les points de vie en fonction des dégats reçus
    # - Affiche ce qu'il s'est passé
    # - Détermine si la personne est toujours en_vie ou non
  	@points_de_vie = @points_de_vie - degats_recus 
    puts "#{@nom} subit #{degats_recus}hp de dégats!"
   

    if @points_de_vie <= 0
        puts "#{@nom} a été vaincu" 
    end
  end
end

class Joueur < Personne
  attr_accessor :degats_bonus

  def initialize(nom)
    # Par défaut le joueur n'a pas de dégats bonus
    @degats_bonus = 0

    # Appelle le "initialize" de la classe mère (Personne)
    super(nom)
  end

  def degats
    #Résolu
    # - Calculer les dégats
    # - Affiche ce qu'il s'est passé

    degat = @degats_bonus + rand(45..70)
    return degat
  end 

  def soin
    #Résolu
    # - Gagner de la vie
    # - Affiche ce qu'il s'est passé

    numero_hasard = rand(40..50)
    @points_de_vie = @points_de_vie + numero_hasard
    if @points_de_vie>100
        puts "\n---------------------------------Resultat------------------------------------- !"
          puts "Vous avez atteint le points de vie maximal. utilisé 0 pour gagner plus de vie "
        puts "-------------------------------------------------------------------------------- !"
    else
        puts "----------------------Resultat--------------------- !"
        puts "Vous avez augmenté légerement votre point de vie ! " 
        puts "--------------------------------------------------- !"
    end

    
  end

  #Methode que j'ai ajouté pour afficher le bonus qu'on a profiter 
  def attaque(personne)
    #Résolu
    # - Fait subir des dégats à la personne passée en paramètre
    # - Affiche ce qu'il s'est passé
    
    puts "\n-------------------Resultat---------------------- !"
    puts "#{@nom} attaque #{personne.nom}"
    puts "#{@nom} profite de #{@degats_bonus} points de dégats bonus"
    personne.subit_attaque(degats)
    puts "---------------------------------------------------- !"
  end

  def ameliorer_degats
    #Résolu
    # - Augmenter les dégats bonus
    # - Affiche ce qu'il s'est passé

    puts "\n------------------Resultat----------------------- !"
    puts "#{@nom} gagne en puissance !"
    @degats_bonus =+ 30
    puts "#{@nom} a obtenu #{@degats_bonus}hp de bonus"    
    puts "--------------------------------------------------- !"
  end
end

class Ennemi < Personne
  def degats
    #Résolu
    # - Calculer les dégats

    degat = 0

    if(@nom == "Balrog")
    	 degat += rand(5..9)
            
    elsif (@nom == "Goblin")
		   degat += rand(5..9)
      
    elsif (@nom == "Squelette")
    	 degat += rand(1..4)
    end
    return degat
  end
end

class Jeu
  def self.actions_possibles(monde)
    puts "\tACTIONS POSSIBLES :"

    puts "\t0 - Se soigner"
    puts "\t1 - Améliorer son attaque"

    # On commence à 2 car 0 et 1 sont réservés pour les actions
    # de soin et d'amélioration d'attaque
    i = 2
    monde.ennemis.each do |ennemi|
      puts "\t#{i} - Attaquer #{ennemi.info}"
      i = i + 1
    end
    puts "\t99 - Quitter"
  end

  def self.est_fini(joueur, monde)
    #Résolu
    # - Déterminer la condition de fin du jeu
    
    # Si Le le joueur n'a pas de vie la partie est terminée
    return true if joueur.points_de_vie<= 0
  end
end

class Monde
  attr_accessor :ennemis

  def ennemis_en_vie
    #Résolu
    # - Ne retourner que les ennemis en vie
    enn = []
    @ennemis.each do |ennemi|
        enn << ennemi if ennemi.en_vie
    end
    enn
  end

  def affiche_ennemis_en_vie
    ennemis = ennemis_en_vie
    ennemis.each { |ennemi| puts ennemi.nom }
  end
end

# Initialisation du monde
monde = Monde.new

# Ajout des ennemis
monde.ennemis = [
  Ennemi.new("Balrog"),
  Ennemi.new("Goblin"),
  Ennemi.new("Squelette")
]

# Initialisation du joueur
joueur = Joueur.new("Jean-Michel Paladin")

# Message d'introduction. \n signifie "retour à la ligne"
puts "\n\n-------- Ainsi débutent les aventures de #{joueur.nom} --------\n\n"

# Boucle de jeu principale
100.times do |tour|
  puts "\n------------------ Tour numéro #{tour} ------------------"

  # Affiche les différentes actions possibles
  Jeu.actions_possibles(monde)

  puts "\nQUELLE ACTION FAIRE ?"
  # On range dans la variable "choix" ce que l'utilisateur renseigne
  choix = gets.chomp.to_i

        
  # En fonction du choix on appelle différentes méthodes sur le joueur
  if choix == 0
      joueur.soin
  elsif choix == 1
      joueur.ameliorer_degats
  elsif choix == 2    
      ennemi_a_attaquer = monde.ennemis[choix - 5]
      joueur.attaque(ennemi_a_attaquer)
  elsif choix == 3
      ennemi_a_attaquer = monde.ennemis[choix - 5] 
      joueur.attaque(ennemi_a_attaquer)
  elsif choix == 4   
      ennemi_a_attaquer = monde.ennemis[choix - 5]
      joueur.attaque(ennemi_a_attaquer)
  elsif choix == 99
    # On quitte la boucle de jeu si on a choisi
    # 99 qui veut dire "quitter"
      break
  else
      puts "\n----------------------------------------- !"
      puts "\nVous avez appuyé sur une mauvaise touche !"
      puts "\n----------------------------------------- !"

  end
  # end

  puts "\nLES ENNEMIS RIPOSTENT !"
  # Pour tous les ennemis en vie ...
  monde.ennemis_en_vie.each do |ennemi|
    # ... le héro subit une attaque.
    ennemi.attaque(joueur)
  end

  puts "\nEtat du héro: #{joueur.info}\n"

  # Si le jeu est fini, on interompt la boucle
  break if Jeu.est_fini(joueur, monde)
end

puts "\nGame Over!\n"

#Résolu
# - Afficher le résultat de la partie

if joueur.points_de_vie < 0 
    puts "Vous n'avez pas de points de vie."
else
    puts "Vous avez #{joueur.points_de_vie} points de vie."
end 

monde.ennemis.each do |ennemi|
  if ennemi.points_de_vie < 0
    puts "#{ennemi.nom} n'a pas de points de vie. il a été vaincu."
  else    
    puts "#{ennemi.nom} a #{ennemi.points_de_vie} points de vie."
  end
end

if joueur.points_de_vie > 0
  puts "Vous avez gagné !"
else
  puts "Vous avez perdu !"
end




