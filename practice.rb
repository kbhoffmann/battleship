require './lib/board'
require './lib/cell'
require './lib/ship'

board = Board.new
cruiser = Ship.new("Cruiser", 3)
submarine = Ship.new("Submarine", 2)
board.cells

a = board.cells.combination(3).to_a
puts a
