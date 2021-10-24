require './lib/board'
require './lib/cell'
require './lib/ship'
require 'pry'

RSpec.describe Board do
  it 'exists' do
    board = Board.new

    expect(board).to be_an_instance_of(Board)
  end

  #Should we test for @coordinates

  it 'keeps a dictionary of cells' do
    board = Board.new

    expect(board.cells.length).to eq(16)
    expect(board.cells).to be_a(Hash)
  end

  it 'can check if coordinate is valid' do
    board = Board.new

    expect(board.valid_coordinate?("A1")).to be(true)
    expect(board.valid_coordinate?("D4")).to be(true)
    expect(board.valid_coordinate?("A5")).to be(false)
    expect(board.valid_coordinate?("E1")).to be(false)
    expect(board.valid_coordinate?("A22")).to be(false)
  end

  it "#number_range returns the possible combo's" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.number_range(cruiser).count).to eq(2)
    expect(board.number_range(cruiser)).to be_a(Array)
  end

  it "#letter_range returns the possible combo's" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.letter_range(cruiser).count).to eq(2)
    expect(board.letter_range(cruiser)).to be_a(Array)
  end

  it "#number_separate returns the possible combo's" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.numbers_separate(["1","2","3"]).count).to eq(3)
    expect(board.numbers_separate(["1","2","3"])).to be_a(Array)
  end

  it "#letter_separate returns the possible combo's" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.letters_separate(["A2","A3","A4"]).count).to eq(3)
    expect(board.letters_separate(["A2","A3","A4"])).to be_a(Array)
  end

  it "#not_occupied returns true of cell does not have a ship" do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.cells
    board.place(cruiser, ["A1", "A2", "A3"])
    expect(board.not_occupied?(["A1","A2"])).to eq(false)
    expect(board.not_occupied?(["B1","B2"])).to eq(true)
  end

  it "#unique_val_test? returns true if all values in array are the same" do
    board = Board.new
    array = ["A", "A", "A"]
    array_2 = ["A", "A", "B"]
    array_3 = ["1", "1", "1"]
    array_4 = ["1", "2", "1"]
    expect(board.unique_val_test?(array)).to eq(true)
    expect(board.unique_val_test?(array_2)).to eq(false)
    expect(board.unique_val_test?(array_3)).to eq(true)
    expect(board.unique_val_test?(array_4)).to eq(false)
  end



  it 'Validates if a ship placement is true for ship length' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells
    expect(board.valid_placement?(cruiser, ["A1","A2"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A2","A3","A4"])).to eq(false)
  end

  it 'Validates if a ship placement is true for consecutive coordinates' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells
    expect(board.valid_placement?(cruiser, ["A1","A2","A4"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A1","C1"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A3","A2","A1"])).to eq(false)
    expect(board.valid_placement?(submarine, ["C1","B1"])).to eq(false)
  end

  it 'validates that ship placement coordinates cannot be diagonal' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells
    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
  end

  it 'can place ships in its cells ' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.cells
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    cell_1.ship
    cell_2.ship
    cell_3.ship

    expect(cell_3.ship == cell_2.ship).to eq(true)
  end

  it 'can check if ships overlap' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.cells
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(submarine, ["A1", "B1"])).to eq(false)
    expect(board.valid_placement?(submarine, ["B1", "B2"])).to eq(true)
  end

  it 'can create an array of all rendered cells' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.cells

    expect(board.render_array).to be_an(Array)
    expect(board.render_array.length).to eq(16)
  end

  it 'can create the top row of board' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.cells

    expect(board.board_top_row).to be_a(String)
  end

  it 'can display an empty board' do
    board = Board.new
    board.cells

    expected_1 = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

    expected_2 = "  1 2 3 4 \n" +
                 "A . . . . \n" +
                 "B . . . . \n" +
                 "C . . . . \n" +
                 "D . . . . \n"

    expect(board.render).to eq(expected_1)
    expect(board.render).to eq(expected_2)
  end

  it 'can display a board with a ship placed' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.cells
    board.place(cruiser, ["A1", "A2", "A3"])

    expected_1 = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

    expected_2 = "  1 2 3 4 \n" +
                 "A S S S . \n" +
                 "B . . . . \n" +
                 "C . . . . \n" +
                 "D . . . . \n"

    expect(board.render(true)).to eq(expected_1)
    expect(board.render(true)).to eq(expected_2)
  end

  it 'can display another ship' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells
    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["C4", "D4"] )

    expected_1 = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . S \nD . . . S \n"

    expected_2 = "  1 2 3 4 \n" +
                 "A S S S . \n" +
                 "B . . . . \n" +
                 "C . . . S \n" +
                 "D . . . S \n"

    expect(board.render(true)).to eq(expected_1)
    expect(board.render(true)).to eq(expected_2)
  end

  it 'computer places cruiser in random valid location' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells
    board.cruiser_placement(cruiser)
    expect(board.cruiser_loc.count).to eq (3)
  end

  it 'computer places sub in random valid location' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells
    board.cruiser_placement(cruiser)
    board.sub_placement(submarine)
    expect(board.sub_loc.count).to eq (2)
  end

  it 'checks player input and places_ship' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.cells
    player_choice = ["A1","A2","A3"]

    expect(board.player_cruiser_placement(cruiser, player_choice)).to be_a(Hash)

    player_choice_2 = ["A1","B2","A3"]
    expect(board.player_cruiser_placement(cruiser,player_choice_2)).to eq false
  end


end
