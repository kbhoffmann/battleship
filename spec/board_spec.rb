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

  it 'Validates if a ship placement is true for ship length' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.valid_placement?(cruiser, ["A1","A2"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A2","A3","A4"])).to eq(false)
  end

  it 'Validates if a ship placement is true for consecutive coordinates' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.valid_placement?(cruiser, ["A1","A2","A4"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A1","C1"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A3","A2","A1"])).to eq(false)
    expect(board.valid_placement?(submarine, ["C1","B1"])).to eq(false)
  end

  it 'validates that ship placement coordinates cannot be diagonal' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
    expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
  end

  xit 'can place ships in its cells ' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    cell_1.ship
    cell_2.ship
    cell_3.ship

    expect(cell_3.ship == cell_2.ship).to eq(true)
  end
end
