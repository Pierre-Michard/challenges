module Drivy
  class Rental
    include ActiveModel::Model
    extend Storable

    attr_accessor :id, :car_id, :start_date, :end_date, :distance

    def start_date=(start_date)
      @start_date = Date.parse(start_date.to_s)
    end

    def end_date=(end_date)
      @end_date = Date.parse(end_date.to_s)
    end

    def car
      Car.find(car_id)
    end

    def duration
      1+ (end_date - start_date).to_i
    end

    def price
      distance * car.price_per_km + duration * car.price_per_day
    end

    def serialize
      {'id' => id, 'price' => price}
    end

  end
end