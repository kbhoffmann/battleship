 require './lib/ship'

RSpec.describe Ship do
  it "exists" do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser).to be_an_instance_of(Ship)
  end

  it "has attributes" do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.name).to eq("Cruiser")
    expect(cruiser.length).to eq(3)
  end

  it "starts at full health" do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.health).to eq(3)
  end

  it "starts not sunk" do
    cruiser = Ship.new("Cruiser", 3)

    expect(cruiser.sunk?).to be(false)
  end

  it "has less health when hit" do
    cruiser = Ship.new("Cruiser", 3)

    cruiser.hit
    expect(cruiser.health).to eq(2)
    cruiser.hit
    expect(cruiser.health).to eq(1)
    expect(cruiser.sunk?).to be(false)
    cruiser.hit
    expect(cruiser.sunk?).to be(true)
  end
end
