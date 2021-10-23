require './lib/board'
require './lib/cell'
require './lib/ship'
require './lib/game'

board_comp = Board.new
board_player = Board.new
cruiser_comp = Ship.new("Cruiser", 3)
cruiser_player = Ship.new("Cruiser", 3)
submarine_comp = Ship.new("Submarine", 2)
submarine_player = Ship.new("Submarine", 2)
board_comp.cells
board_player.cells
game = Game.new

puts "Welcome to BATTLESHIP"
puts "Enter p to play. Enter q to quit."
answer = gets.chomp
game.starter(answer)

# This does computer ship placement
board_comp.cruiser_placement(cruiser_comp)
board_comp.sub_placement(submarine_comp)

## This isn't necessary but I put it here to make sure it works
p board_comp.cruiser_loc
p board_comp.sub_loc


puts "I have laid out my ships on the grid."
puts "You now need to lay out your two ships."
puts "The Cruiser is three units long and the Submarine is two units long."
puts board_player.render
puts "Enter the squares for the Cruiser (3 spaces):"
## I'm going to call it here, we need to take either 3 user inputs or
## convert the user input in three seperate elements of an array
##  This should work up to here.
