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

  it 'checks for consecutive numbers' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    array = [1,2,3]
    expect(board.consecutive_numbers(array)).to eq(true)
    array_2 = [1,3,2]
    expect(board.consecutive_numbers(array_2)).to eq(false)
    array_3 = [1,2]
    expect(board.consecutive_numbers(array_3)).to eq(true)
    array_4 = [1,3]
    expect(board.consecutive_numbers(array_4)).to eq(false)
  end

  it 'checks for all characters same in an array' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    array = ["A","A","A"]
    expect(board.all_same(array)).to eq(true)

    array_2 = ["A","B","A"]
    expect(board.all_same(array_2)).to eq(false)

    array_3 = ["A","A"]
    expect(board.all_same(array)).to eq(true)

    array_4 = ["A","B"]
    expect(board.all_same(array_2)).to eq(false)


  end


  xit 'Validates if a ship placement is true for ship length' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.valid_placement?(cruiser, ["A1","A2"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A2","A3","A4"])).to eq(false)
  end

  xit 'Validates if a ship placement is true for consecutive coordinates' do
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.valid_placement?(cruiser, ["A1","A2","A4"])).to eq(false)
    expect(board.valid_placement?(submarine, ["A1","C1"])).to eq(false)
    expect(board.valid_placement?(cruiser, ["A3","A2","A1"])).to eq(false)
    expect(board.valid_placement?(submarine, ["C1","B1"])).to eq(false)
  end


end
