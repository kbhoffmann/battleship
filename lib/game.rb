
require './lib/board'
require './lib/cell'
require './lib/ship'

class Game
  attr_reader :player_board,
              :player_cruiser,
              :player_sub

  def initialize
    @player_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_sub = Ship.new("Submarine", 2)
  end

  def starter(answer)
    if answer == "p"
      p "Game will start"
      #Computer places ships on computer board, then player is prompt to place cruiser
      player_cruiser_placement_instructions
    elsif answer == "q"
      p "Good Bye"
      exit!
    else
      p "Invalid Response"
      puts "Enter p to play. Enter q to quit."
      new_answer = gets.chomp
      self.starter(new_answer)
    end

  end
  def player_cruiser_placement_instructions
      puts "I have laid out my ships on the grid.
      You now need to lay out your two ships.
      The Cruiser is three units long and the Submarine is two units long.
        1 2 3 4
      A . . . .
      B . . . .
      C . . . .
      D . . . .
      Enter the 3 sets of coordinates for the Cruiser (example: a4b4c4 ):"
      #need them separated by comma? no commas? no spaces? change our code to be case insensitive?
      gets.chomp
  end

  def player_cruiser_coords_formatted
    #mocking the gets.chomp, will have to remove this variable later
    player_cruiser_placement_instructions = "a1b1c1"
    player_cruiser_placement_instructions.upcase.scan(/../)
      #=> ["A1", "B1", "C1"]
  end

end

#   def place_player_cruiser
#     ship = @cruiser
#     coord = board.coordinates
#     all_combos = coord.combination(3).to_a
#     all_combos.each do |combo|
#       if board.valid_placement?(ship, combo)
#         @valid_combo_cruiser << combo
#     #elsif board.valid_placement? == false
#       # p Those are invalid coordinates. Please try again:
#       #gets.chomp
#     #make user input loop, exit if valid_placement? == true
#       end
#     end
#     @valid_combo_cruiser
#   #do we still have to shuffle this when the player is choosing locations?
#     cruiser_placement = valid_combo_cruiser.shuffle.first
#     board.place(cruiser, cruiser_placement)
#     board.render(true)
#   end
#
#   def place_player_sub
#     all_combos = board.coordinates.combination(2).to_a
#     all_combos.each do |combo|
#       if board.valid_placement?(submarine, combo)
#         @valid_combo_sub << combo
#       end
#     end
#     @valid_combo_sub
# #do we still have to shuffle this when the player is choosing locations?
#     sub_placement = valid_combo_sub.shuffle.first
#     board.place(submarine, sub_placement)
#     board.render(true)
#   end
