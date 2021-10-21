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
end
