module Drivy
  class Car
    include ActiveModel::Model
    extend Storable

    attr_accessor :id, :price_per_day, :price_per_km

  end
end