require_relative 'rental/commission'
require_relative 'rental/options'
require_relative 'rental/duration_price'
require_relative 'actionable'

module Drivy
  class Rental
    include ActiveModel::Model
    include ActiveModel::Validations

    extend Storable
    include Actionable
    include DurationPrice

    attr_accessor :id, :car_id, :start_date, :end_date, :distance, :deductible_reduction

    #- the driver must pay the rental price and the (optional) deductible reduction
    action :driver,     ->{-price - options.deductible_reduction}
    #- the owner receives the rental price minus the commission
    action :owner,      ->{price - commission.total}
    #- the insurance receives its part of the commission
    action :insurance,  ->{commission.insurance_fee}
    #- the assistance receives its part of the commission
    action :assistance, ->{commission.assistance_fee}
    #- drivy receives its part of the commission, plus the deductible reduction
    action :drivy,      ->{commission.drivy_fee + options.deductible_reduction}

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
      distance * car.price_per_km + duration_price
    end

    def commission
      Commission.new(price: price, duration_days: duration_days)
    end

    def options
      Options.new(deductible_reduction: deductible_reduction, duration_days: duration_days)
    end

    def serialize
      {
          'id' => id,
          'price' => price,
          'options' => options.serialize,
          'commission' => commission.serialize
      }
    end

    def serialize_with_actions
      {
          'id' => id,
          'actions' => serialized_actions
      }
    end


  end
end