# this will refer to the Van class
# this follows the DockingStation template below.


# load BikeContainer
require_relative 'bike_container'

class Van

  # this gives us all the methods 
  # that are to be used in this class
  include BikeContainer


  def initialize(options = {})
    # self.capacity is calling the capacity=() method
    # (note the equals sign) defined in BikeContainer

    # capacity (the second argument to fetch()) is calling
    # the capacity() method in BikeContainer

    self.capacity=(options.fetch(:capacity, capacity))

  end

  def arrives(station)
    if station.has_broken_bikes?
      true
    else
      false
    end
  end

  def collect(station)
    if station.has_fixed_bikes?
      true
    else
      false
    end
  end

end