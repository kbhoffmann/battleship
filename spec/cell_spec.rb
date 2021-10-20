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

  it '#empty? returns true empty' do
    cell = Cell.new("B4")
    expect(cell.empty?).to eq true
  end

  it '#place_ship puts a ship into cell' do
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(cruiser)
    expect(cell.occupied.length).to eq 1
  end

  it '#place_ship puts a ship into cell' do
    cruiser = Ship.new("Cruiser", 3)
    cell = Cell.new("B4")
    cell.place_ship(cruiser)
    expect(cell.ship).to eq (cruiser)
    expect(cell.empty?).to eq false
  end



end
