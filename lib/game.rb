
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


  #------------------------------------------------------
  #This is where I left off for now.  Ran into issues, may need to rethink some things(sorry I know thats vague)
    def check_player_cruiser_placement_coords(coordinates)
      #?MAYBE MAKE VALID PLACEMENT A MODULE INSTEAD OF LEAVING IT IN BOARD CLASS??? or recreate valid placement in game
      # coordinates = player_cruiser_coords_formatted
      if @player_board.valid_placement?(@player_cruiser, coordinates)
        #if true, proceed to place_player_cruiser method
        #proceed to the method to prompt user to place submarine.
      elsif board.valid_placement? == false
        p "Those coordinates are invalid, try again. (example: a4, b4, c4 )"
        player_cruiser_placement = gets.chomp
      end
    end

    def player_sub_placement_instructions
        puts "You now need to place the Submarine
        The Submarine is two units long.  Choose coordinates that do not include you Cruiser (denoted by 'S')
        Enter the 2 sets of coordinates for the Submarine (example: a4, b4 ):"
        # show player board after cruiser placement
        #need input separated by comma? no commas? no spaces? change our code to be case insensitive?
        player_sub_placement = gets.chomp
        #need to put user input into an array such as ["A1","A2"] SEE player_sub_coords_formatted method
        check_player_sub_placement_coords
    end

    def player_sub_coords_formatted
      #CONVERT STRING FROM GETS.CHOMP TO AN ARRAY OF 2 ELEMENTS
    end

    def check_player_sub_placement_coords
      #?MAYBE MAKE VALID PLACEMENT A MODULE INSTEAD OF LEAVING IT IN BOARD CLASS??? or recreate valid placement in game
      if player_sub_coords_formatted.board.valid_placement?
        #if true, proceed to place_player_sub method
        #then proceed to method for the TURN???
      elsif player_sub_coords_formatted.board.valid_placement? == false
        p "Those coordinates are invalid, try again. (example: a4, b4 )"
        player_cruiser_placement = gets.chomp
      end
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
