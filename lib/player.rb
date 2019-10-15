class Player
  attr_accessor :name
  attr_accessor :life_points

  def initialize(name)
  	@name = name		# attribue le nom souhaité au joueur
  	@life_points = 10 # attribue 10 points de vie à la création du joueur
  end
 
  def showstate
  	puts "#{@name} a #{@life_points} point(s) de vie" #affiche l'état du joueur
  end

  def gets_damage(points_lost)
  	@life_points = life_points.to_i - points_lost #diminution des points de vie du joueur
  	if life_points.to_i <= 0
  		puts "#{@name} has been killed!"
  	else 
  		return @life_points
  	end
  end

  def attacks(player)
  	puts "#{@name} attaque #{player.name}."
  	damage = compute_damage() # simulation du nombre de points de vie perdus
   	puts "#{player.name} a perdu #{damage} point(s)"
 	return player.life_points = player.gets_damage(damage) # mise à jour des points de vie
  end 

  def compute_damage
    return rand(1..6)
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(name)
		@name = name
		@life_points = 100
		@weapon_level = 1
  end

  def showstate
  	if @life_points > 0
  		puts "#{@name} a #{@life_points} point(s) de vie et une arme de niveau #{@weapon_level}!" #affiche l'état du joueur
  	else 
  		puts "#{@name} is fucking dead!"
  	end
  end

  def compute_damage
    return rand(1..6)*@weapon_level
  end

  def search_weapon
  	dice = rand(1..6)
  	puts "Tu as trouvé une arme de niveau #{dice}"
  	if dice > @weapon_level
  		puts "Youhou ! elle est meilleure que ton arme actuelle : tu la prends."
  		@weapon_level = dice
  	else puts "M@*#$... elle n'est pas mieux que ton arme actuelle..."
  	end
  	return @weapon_level	
  end

  def  search_health_pack
		dice = rand(1..6)
		if dice == 1
			puts "Tu n'as rien trouvé cette fois"
		elsif dice < 6
			@life_points = [life_points + 50, 100].min
			puts "Bravo, tu as trouvé un pack de +50 points de vie !"
		else
			@life_points = [life_points + 80, 100].min
			puts "Waow, tu as trouvé un pack de +80 points de vie !"
		end
		return @life_points
  end

end

