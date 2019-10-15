require 'pry'

class Game
	attr_accessor :human_player
	attr_accessor :enemies

	def initialize(name,human_player,number_of_enemies=4)
		@enemies = create_enemies(number_of_enemies)
		@human_player = HumanPlayer.new(human_player)
	end

	def kill_player(player)
		return @enemies.delete_if{|user| user.name == player.name}
	end

	def create_enemies(number_of_enemies=2)
		enemies = []
		for i in 0..number_of_enemies-1
			enemies << Player.new("Enemy#{i}")
		end
		return enemies
	end

	def is_still_ongoing?
		human_player.life_points > 0 && @enemies.size > 0
	end

	def show_players
		human_player.showstate
		puts "Il vous reste #{@enemies.count} ennemis"
	end

	def menu
		puts "Quelle action veux-tu effectuer ?"
		puts ""
		puts "a - chercher une meilleure arme"
		puts "s - chercher à se soigner"
		puts ""
		puts "attaquer un joueur en vue :"
		for i in 0..@enemies.size-1
			if @enemies[i].life_points.to_i > 0
				print "#{i} - "
				print @enemies[i].showstate
			end
		end
	end

	def menu_choice (action)
		if action == "a"
			@human_player.search_weapon
		elsif action == "s"
			@human_player.search_health_pack
		elsif action.to_i >= 0 && action.to_i < @enemies.size.to_i
			@human_player.attacks(@enemies[action.to_i])
			if @enemies[action.to_i].life_points.to_i <=0
				kill_player(@enemies[action.to_i])
			end
		else
			puts "Wrong command, tu perds ton tour"
		end
	end

	def enemies_attack
		if human_player.life_points.to_i > 0
				@enemies.each {|enemy| if (enemy.life_points).to_i > 0 then enemy.attacks(human_player) end}
		end
	end

	def end
		if human_player.life_points.to_i > 0
			puts "BRAVO, tu restes le champion! Tous tes ennemis sont morts!!"
		else
			puts "GAME OVER!!!!"
		end
	end

end

