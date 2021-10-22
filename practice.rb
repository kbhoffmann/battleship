require './lib/board'
require './lib/cell'
require './lib/ship'

board = Board.new
cruiser = Ship.new("Cruiser", 3)
board.place(cruiser, ["A1", "A2", "A3"])
cell_1 = board.cells["A1"]
cell_2 = board.cells["A2"]
cell_3 = board.cells["A3"]

cell_1.ship
cell_2.ship
cell_3.ship

p cell_3
puts board.cells
