require 'active_model'
require 'date'

require_relative 'drivy/storable'
require_relative 'drivy/car'
require_relative 'drivy/rental'
require_relative 'drivy/rental_modification'

module Drivy

  def self.cars
    Car.all
  end

  def self.rentals
    Rental.all
  end

  def self.rental_modifications
    RentalModification.all
  end

  def self.init_data(data)
    Car.init(data['cars'])
    Rental.init(data['rentals'])
    RentalModification.init(data['rental_modifications'])
  end

  def self.serialized_rentals
    {'rentals' => rentals.map(:serialize)}
  end

  def self.serialized_rental_actions
    {'rentals' => rentals.map(:serialize_with_actions)}
  end

  def self.serialized_rental_modifications
    {'rental_modifications' => rental_modifications.map(&:serialize)}
  end

end