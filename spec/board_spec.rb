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

  #wasn't sure what to name this test
  xit 'can display itself' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)

    board.place(cruiser, ["A1", "A2", "A3"])

    expected_1 = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"

    expected_2 = "  1 2 3 4 \n" +   #this is the same value as expected_1
                 "A . . . . \n" +   #just better readability. Don't have to test
                 "B . . . . \n" +   #both, but both should work!
                 "C . . . . \n" +
                 "D . . . . \n"

    expected_3 = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"

    expected_4 = "  1 2 3 4 \n" +   #this is the same value as expected_3
                 "A S S S . \n" +   #the same situation as above, better readability
                 "B . . . . \n" +
                 "C . . . . \n" +
                 "D . . . . \n"
    expect(board.render).to eq(expected_1)
    expect(board.render).to eq(expected_2)
    expect(board.render(true)).to eq(expected_3)
    expect(board.render(true)).to eq(expected_4)
  end
end
