class Player
	attr_accessor :name, :moves, :score

	def initialize(name)
		@name = name
		@score = 0
	end

	def next_move
		puts "#{name}, choose your next move:"
		new_move = gets.chomp.to_i
		until new_move >= 1 && new_move <=9
			puts "Please put a number between 1 and 9." 	
			new_move = gets.chomp.to_i
	 	end
	  	@moves = @moves << new_move
  	end

	def winner?
		winning_fields = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
		winning_fields.any? { |sequence|
			sequence.include?(@moves[0]) && sequence.include?(@moves[1]) && sequence.include?(@moves[2])
		}
	end

	def wins
		@score =+ 1;
		print "#{name} wins the game! "
	end

end

class Game
	attr_accessor :board

	def initialize
		@board = [0,' ',' ',' ',' ',' ',' ',' ',' ',' ']
	end

	def draw_board
		puts "#{board[1]}|#{board[2]}|#{board[3]}"
		puts "_ _ _"
		puts "#{board[4]}|#{board[5]}|#{board[6]}"
		puts "_ _ _"
		puts "#{board[7]}|#{board[8]}|#{board[9]}"
	end

	def draw?
		@board.all? {|field| field != " "}
	end
end

def still_want_to_play?
	puts "Do you want to play TicTacToe? If yes, type 'Y'. Otherwise, hit any other key."
	input = gets.chomp.to_s
	if input == "y" || input == "Y"
	 true
	end
end


def main
  puts "Welcome to TicTacToe! Here is your cheatsheet so you know which number to type for any of the fields."
  	puts "1|2|3"
		puts "_ _ _"
		puts "4|5|6"
		puts "_ _ _"
		puts "7|8|9"
  
  puts "Please put the first player's name:"
  player1 = Player.new(gets.chomp)
  puts "Thanks, now put the name of the second player:"
  player2 = Player.new(gets.chomp)
  
  while still_want_to_play?

	  game = Game.new
	 	player1.moves = []
	 	player2.moves = []
	  game.draw_board

	  until player1.winner? || player2.winner? || game.draw?
		  
		  if !player2.winner?  && !game.draw?
		  	player1.next_move
		  	while game.board[player1.moves.last] != " "
		  		puts "This field is already taken, please choose a different field."
		  		player1.next_move
		  	end
			  game.board[player1.moves.last] = "X"
			  game.draw_board
			  if  player1.winner? 
			  	player1.wins
			  	puts "The new score is #{player1.name}: #{player1.score}, #{player2.name}: #{player2.score}."
			  elsif game.draw?
			  	puts "This time there is no winner. The score remains #{player1.name}: #{player1.score}, #{player2.name}: #{player2.score}."
			  end
		 	end

		 	if !player1.winner? && !game.draw?
			  player2.next_move
			  while game.board[player2.moves.last] != " "
		  		puts "This field is already taken, please choose a different field."
		  		player1.next_move
		  	end
			  game.board[player2.moves.last] = "0"
			  game.draw_board
			  if  player2.winner? 
			  	player2.wins
			  	puts "The new score is #{player1.name}: #{player1.score}, #{player2.name}: #{player2.score}."
			  elsif game.draw?
			  	puts "This time there is no winner. The score remains #{player1.name}: #{player1.score} and #{player2.name}: #{player2.score}."
			  end
			end
		 
		end
  end
end

main