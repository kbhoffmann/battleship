require './lib/board'
require './lib/cell'
require './lib/ship'

board = Board.new
cruiser = Ship.new("Cruiser", 3)
submarine = Ship.new("Submarine", 2)
board.cells

all_combos = board.coordinates.combination(3).to_a


valid_combo = []
all_combos.each do |combo|
  if board.valid_placement?(cruiser, combo)
    valid_combo << combo
  end
end
valid_combo


cruiser_placement = valid_combo.shuffle.first
p cruiser_placement
board.place(cruiser, cruiser_placement)


all_combos = board.coordinates.combination(2).to_a

valid_combo_sub = []
all_combos.each do |combo|
  if board.valid_placement?(submarine, combo)
    valid_combo_sub << combo
  end
end
valid_combo_sub

sub_placement = valid_combo_sub.shuffle.first
p sub_placement
