require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def welcome_message
	puts "-"*70
	puts " "*30+"WELCOME !!"
	puts " "*20+"The Great Fight is about to begin"
	puts "-"*70
end

def create_game
	puts "A ma droite le champion toutes catégories des Human Players"
	print ">" # entrer le nom de son champion
	name = gets.chomp
	return my_game = Game.new("my_game",name) # possibilié de modifier le nombre d'adversaires en ajoutant un argument (integer) après name, par défaut 4 adversaires
end


welcome_message
my_game = create_game
while my_game.is_still_ongoing? # la boucle continue tant que HumanPlayer ou tous les players ne sont pas morts
	my_game.show_players
	my_game.menu
	action = gets.chomp
	my_game.menu_choice(action)
	gets.chomp # permet de marquer une pause, taper entrer pour continuer le jeu
	my_game.enemies_attack
end
my_game.end