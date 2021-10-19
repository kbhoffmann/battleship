 require './lib/ship'
 require './lib/cell'

 describe Cell do
   it 'exists' do
     cell = Cell.new("B4")
     expect(cell).to be_a Cell
   end

  it 'returns cell coordinate' do
    cell = Cell.new("B4")
    expect(cell.coordinate).to eq ("B4")
  end

  it '#ship returns nil when empty' do
    cell = Cell.new("B4")
    expect(cell.ship).to eq (nil)
  end
end
