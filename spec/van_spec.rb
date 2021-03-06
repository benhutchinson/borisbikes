# this will define the Van tests
# it follows an equivalent template to DockingStation

require './lib/van'
require_relative 'bike_container_spec'

describe Van do

  it_behaves_like "a Bike Container"

  let(:van) { Van.new(:capacity => 80) }
  let(:station_broken) { double :station, :has_broken_bikes? => true}
  let(:station_working) { double :station, :has_broken_bikes? => false }
  let(:garage_has_fixed_bikes) { double :garage, :has_fixed_bikes? => true, :all_bikes_fixed? => true }
  let(:garage_no_fixed_bikes) { double :garage, :has_fixed_bikes? => false }
  let(:garage) { double :garage, :accept => true, :has_fixed_bikes? => true, :bikes_for_transfer => true}
  let(:station) { double :station, :dock => true, :bikes_for_transfer => true}

  it "should allow setting default capacity on initialising" do
    expect(van.capacity).to eq(80)
  end

  it "arrives for broken bikes from docking station" do
    expect(van.arrives_at_docking(station_broken)).to be true
  end

  it "but does not arrive if there are no broken bikes at the docking station" do
    expect(van.arrives_at_docking(station_working)).to be false
  end

  it "does go to garage if there are fixed bikes for collection" do
    expect(van.arrives_at_garage(garage_has_fixed_bikes)).to be true
  end

  it "but does not go to garage if there are no fixed bikes there" do
    expect(van.arrives_at_garage(garage_no_fixed_bikes)).to be false
  end

  it "has no bikes after delivering broken bikes to garage" do
    van.releases_bikes_to_garage(garage)
    expect(van.bike_count).to be 0
  end

  it "has no bikes after delivering fixed bikes to docking station" do
    van.releases_bikes_to_docking_station(station)
    expect(van.bike_count).to be 0
  end


end

