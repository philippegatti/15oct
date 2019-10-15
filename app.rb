require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

Phil = Player.new("Phil")
Ben = Player.new("Ben")
Dim = HumanPlayer.new("Dim")
Hermine = HumanPlayer.new("Hermine")

puts "Voici l'état de chaque joueur :"
Phil.showstate
Ben.showstate
puts "Let the fight begin !"
while Ben.life_points.to_i > 0
	Ben.attacks(Phil)
	if Phil.life_points.to_i > 0
		Phil.attacks(Ben)
	else
		break	
	end
end

binding.pry