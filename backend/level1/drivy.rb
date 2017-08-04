require 'active_model'
require 'date'

require_relative 'drivy/storable'
require_relative 'drivy/car'
require_relative 'drivy/rental'

module Drivy

  def self.cars
    Car.all
  end

  def self.rentals
    Rental.all
  end


  def self.init_data(data)
    Car.init(data['cars'])
    Rental.init(data['rentals'])
  end

  def self.output
    {'rentals' => rentals.map(&:serialize)}
  end

end