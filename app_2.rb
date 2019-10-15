require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

Phil = Player.new("Phil")
Ben = Player.new("Ben")
Dim = HumanPlayer.new("Dim")
Hermine = HumanPlayer.new("Hermine")

def welcome_message
	puts "-"*70
	puts " "*30+"WELCOME !!"
	puts " "*20+"The Great Fight is about to begin"
	puts "-"*70
end

def create_player
	puts "A ma droite le champion toutes catégories des Human Players"
	print ">" # entrer le nom de son champion
	name = gets.chomp
	user = HumanPlayer.new(name)
	return user
end

def create_enemies(number_of_enemies=2) # par défaut on lance le jeu avec 2 ennemies mais le code est prévu pour être flexible
	enemies = []
	for i in 0..number_of_enemies-1
		enemies << Player.new("Enemy#{i}")
	end
	return enemies
end

def pad(enemies)
	puts "Quelle action veux-tu effectuer ?"
	puts ""
	puts "a - chercher une meilleure arme"
	puts "s - chercher à se soigner"
	puts ""
	puts "attaquer un joueur en vue :"
	for i in 0..enemies.size-1 # le tableau de commande est adapté en fonction du nombre d'ennemis
		if enemies[i].life_points.to_i > 0
			print "#{i} - "
			print enemies[i].showstate
		end
	end
end

def fight(user, enemies) # j'ai créer une fonction fight pour faciliter la lecture
	while user.life_points.to_i >0 && enemies.count {|enemy| enemy.life_points.to_i > 0} > 0 # la condition est prévue pour s'adapter au nombre de joueurs
		puts user.showstate
		pad(enemies)
		action = gets.chomp
		if action == "a"
			user.search_weapon
		elsif action == "s"
			user.search_health_pack
		else
			user.attacks(enemies[action.to_i])
		end
		gets.chomp
		puts "Au tour des robots de t'attaquer"
		enemies.each {|enemy| if (enemy.life_points).to_i > 0 then enemy.attacks(user) end}
	end
	if user.life_points.to_i > 0
		puts "Ah bah non ils sont tous morts! BRAVO!!! Tu as éliminé tous tes ennemis"
	else
		puts "GAME OVER!!!"
	end
end	

welcome_message
user = create_player
enemies = create_enemies(2) #on peut modifier ici le nombre d'ennemis
fight(user,enemies)
