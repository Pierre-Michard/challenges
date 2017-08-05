require_relative 'rental/commission'

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

    def duration_days
      1+ (end_date - start_date).to_i
    end

    def price
      distance * car.price_per_km + duration_price.round
    end

    def commission
      Commission.new(price: price, duration_days: duration_days)
    end

    def serialize
      {'id' => id, 'price' => price, 'commission' => commission.serialize}
    end

    private

    #- price per day decreases by 10% after 1 day
    #- price per day decreases by 30% after 4 days
    #- price per day decreases by 50% after 10 days
    def duration_discount(day_index)
      case day_index
        when 0...1
          0
        when 1...4
          0.1
        when 4...10
          0.3
        else
          0.5
      end
    end

    def duration_price
      (0...duration_days).to_a.inject(0){|sum, day_index| sum + (1-duration_discount(day_index))*car.price_per_day }
    end
  end
end