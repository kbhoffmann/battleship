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

  it 'can tell if it has been fired_upon' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    expect(cell.fired_upon?).to be(false)
  end

  it 'can be fired upon' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    cell.fire_upon
    expect(cell.ship.health).to eq(2)
    expect(cell.fired_upon?).to be(true)
  end

  it 'can show if an empty cell has been fired upon and return its status' do
    cell_1 = Cell.new("B4")

    expect(cell_1.render).to eq(".")
    cell_1.fire_upon
    expect(cell_1.render).to eq("M")
  end

  it 'when it has a ship, ship starts unfired upon' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    expect(cell_2.render).to eq(".")
  end

  it '#render(true) registers an S when optional argument is true' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    expect(cell_2.render(true)).to eq("S")
  end

  it 'can show if cell has been fired upon and hit and return status' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    expect(cell_2.render).to eq("H")
  end

  it 'can show if cell has been fired upon and hit and returns not sunk' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    expect(cruiser.sunk?).to eq(false)
  end

  it 'can show that ship is sunk after health is zero' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    cell_2.fire_upon
    cell_2.fire_upon
    expect(cruiser.sunk?).to eq(true)
  end

  it 'returns X if ship has been sunk' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    cell_2.fire_upon
    cell_2.fire_upon
    cruiser.sunk?
      expect(cell_2.render).to eq("X")
  end
end
