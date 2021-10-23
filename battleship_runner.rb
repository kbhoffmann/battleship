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
