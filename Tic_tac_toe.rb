#Bienvenue dans mon script du jeu Tic_tac_toe
#Bonne lecture!

#La classe suivante crée des objects "carré"
#Chaque objet généré à partir de la classe "carré" a un emplacement spécifique sur le plateau défini par sa position verticale et sa position horizontale
class Square

	def initialize(horizontal_position=1, vertical_position=1, played=false, player=1, square_high=8, square_width=14)
		@horizontal_position = horizontal_position
		@vertical_position = vertical_position
		@played = played
		@player = player
		@square_high = square_high
		@square_width = square_width
		@lines_list = []	
	end
	
	#La métrode suivante retourne la ligne du haut de chaque carré sous forme d'un string
	def high_line
		if @vertical_position == 1
			return "_"*@square_width + " "
		else
			return ""
		end
	end

	#La méthode suivante retourne sous forme de string les lignes de chaque carré comprises entre la première et la dernière ligne
	def middle_line(line_number=1)

		if @horizontal_position == 1
			middle_line = "|" + " "*@square_width + "|"
		else
			middle_line = " "*@square_width + "|"
		end

		#Le bloc suivant gère l'intégration des "X" et des "O" au sein de chaque carré
		if @played && line_number > 1
			if @player == 1 && line_number > 2
				middle_line[line_number+2] = "\\"
				middle_line[12-line_number] = "/"
			elsif @player==2
				if line_number == 2
					middle_line[4..9] = "_"*6
				elsif line_number > 2 && line_number < 7
					middle_line[3] = "|"
					middle_line[10] = "|"
				elsif line_number == 7
					middle_line[3] = "|"
					middle_line[4..9] = "_"*6
					middle_line[10] = "|"

				end
			end
		end
		return middle_line
	end

	#La méthode suivante retoune la dernière ligne de chaque carré sous forme de string
	def low_line		
		if @horizontal_position == 1
			return "|" + "_"*@square_width + "|"
		else
			return "_"*(@square_width) + "|"
		end
		
	end

	#La méthode suivante prend comem paramètre le numéro de la ligne et appelle les méthodes précédentes afin de renvoyer le bonne ligne du carré
	def get_line(line_number)
		if line_number == 1
			return high_line()
		elsif line_number == @square_high
			return low_line()
		else
			return middle_line(line_number)
		end
	end
end


#La classe suivante appelle la méthode Square et génère des objets(carrés) afin de créer le plateau
class Board

	def initialize(hash_des_coups, width=3, high=3)		
		@width = width
		@high = high
		@squares_list = []
		@board = ""
		@hash_des_coups = Hash.new
		@hash_des_coups = hash_des_coups
		
	end

	#Création de chaque objet(carré) issu de la méthode square
	def get_squares
		@square1 = Square.new(horizontal_position=1, vertical_position=1, played=@hash_des_coups[1], joueur=@hash_des_coups[1])
		@square2 = Square.new(horizontal_position=2, vertical_position=1, played=@hash_des_coups[2], joueur=@hash_des_coups[2])
		@square3 = Square.new(horizontal_position=2, vertical_position=1, played=@hash_des_coups[3], joueur=@hash_des_coups[3])
		@square4 = Square.new(horizontal_position=1, vertical_position=2, played=@hash_des_coups[4], joueur=@hash_des_coups[4])
		@square5 = Square.new(horizontal_position=2, vertical_position=2, played=@hash_des_coups[5], joueur=@hash_des_coups[5])
		@square6 = Square.new(horizontal_position=3, vertical_position=2, played=@hash_des_coups[6], joueur=@hash_des_coups[6])
		@square7 = Square.new(horizontal_position=1, vertical_position=3, played=@hash_des_coups[7], joueur=@hash_des_coups[7])
		@square8 = Square.new(horizontal_position=2, vertical_position=3, played=@hash_des_coups[8], joueur=@hash_des_coups[8])
		@square9 = Square.new(horizontal_position=3, vertical_position=3, played=@hash_des_coups[9], joueur=@hash_des_coups[9])
		return [@square1, @square2, @square3, @square4, @square5, @square6, @square7, @square8, @square9]		
	end

	#Création du plateau à partir des 9 object précedemment générés
	def get_board

		squares_list = get_squares
		line_counter = 1
		@board += " "
		while line_counter <= 8
			@board += @square1.get_line(line_counter) + @square2.get_line(line_counter) + @square3.get_line(line_counter) + "\n"
			line_counter += 1
		end
		line_counter = 2
		while line_counter <= 8
			@board += @square4.get_line(line_counter) + @square5.get_line(line_counter) + @square6.get_line(line_counter) + "\n"
			line_counter += 1
		end
		line_counter = 2
		while line_counter <= 8
			@board += @square7.get_line(line_counter) + @square8.get_line(line_counter) + @square9.get_line(line_counter) + "\n"
			line_counter += 1
		end
		return @board

	end

end


class Player
	def initialize(player_name, player_number)
		@player_name = player_name
		@player_number = player_number
	end
	def player_name
		return @player_name.capitalize!
	end
	def player_number
		return @player
	end
end

#Classe qui va générer des objets dont la fonction est de gérer le déroulement de la partie
class Game
	def initialize
		@game = Hash.new
		@game_turn = 1
		@nombre_de_coups = 0

	end

	#Début de partie
	def begin
		puts "\n Bienvenue dans le jeu Tic-tac-toe"
		puts "\n Apuyez sur Entrer pour continuer"
		a = gets
		puts " Entrer le nom du premier joueur :"
		player1_name = gets
		puts " Entrer le nom du second joueur :"
		player2_name = gets
		@player1 = Player.new(player1_name, 1)
		@player2 = Player.new(player2_name, 2)
		puts "\n Les cases sont numérotes comme suit :"
		puts "\n     1   2   3"
		puts "\n     4   5   6"
		puts "\n     7   8   9"
	end

	#La méthode méthode suivante génère un nouveau platau après chaque coup d'un joueur
	def game_turn
		puts "\n Tour #{@game_turn}"
		print "\n #{@player1.player_name} quelle case voulez vous jouer?"
		
		loop do
			coup = gets.to_i
			if @game[coup] != nil
				puts "\n Vous devez entrer le numéro d'une case qui n'a pas été jouée"
			else
				@game[coup] = 1
				break
			
			end
		end
		
		board = Board.new(@game)
		puts board.get_board	
		if @nombre_de_coups != 4
			print "\n #{@player2.player_name} quelle case voulez vous jouer?"
			loop do
			coup = gets.to_i
			if @game[coup] != nil
				puts "\n Vous devez entrer le numéro d'une case qui n'a pas été jouée"
			else
				@game[coup] = 2
				break			
			end
		end
		end
		board = Board.new(@game)
		puts board.get_board
		@game_turn += 1
		@nombre_de_coups += 2
	end

	#La méthode suivante prévoit dans quel cas la boucle sera arrêtée pour cause de victoire
	def victory
		if (@game[1] == 1) && (@game[2] == 1) && (@game[3] == 1)
			return true
		elsif (@game[1] == 2) && (@game[2] == 2) && (@game[3] == 2)
			return true
		elsif (@game[4] == 1) && (@game[5] == 1) && (@game[6] == 1)
			return true
		elsif (@game[4] == 2) && (@game[5] == 2) && (@game[6] == 2)
			return true
		elsif (@game[7] == 1) && (@game[8] == 1) && (@game[9] == 1)
			return true
		elsif (@game[7] == 2) && (@game[8] == 2) && (@game[9] == 2)
			return true
		elsif (@game[1] == 1) && (@game[4] == 1) && (@game[7] == 1)
			return true
		elsif (@game[1] == 2) && (@game[4] == 2) && (@game[7] == 2)
			return true
		elsif (@game[2] == 1) && (@game[5] == 1) && (@game[8] == 1)
			return true
		elsif (@game[2] == 2) && (@game[5] == 2) && (@game[8] == 2)
			return true
		elsif (@game[3] == 1) && (@game[6] == 1) && (@game[9] == 1)
			return true
		elsif (@game[3] == 2) && (@game[6] == 2) && (@game[9] == 2)
			return true
		elsif (@game[1] == 1) && (@game[5] == 1) && (@game[9] == 1)
			return true
		elsif (@game[1] == 2) && (@game[5] == 2) && (@game[9] == 2)
			return true
		elsif (@game[3] == 1) && (@game[5] == 1) && (@game[7] == 1)
			return true
		elsif (@game[3] == 2) && (@game[5] == 2) && (@game[7] == 2)
			return true
		end
	end

	#La méthode suivante prévoit le cas où toutes les cases seraient remplies et où personne n'aurait gagné
	def match_nul
		if @game.keys.length == 9
			return true
		end
	end

end




#Corps du script
game = Game.new
game.begin

loop do
	game.game_turn
	if game.victory==true
		puts "\n      Victoire!\n\n"
		break
	end
	if game.match_nul
		puts "\n      Match nul!\n\n"
		break
	end
end








