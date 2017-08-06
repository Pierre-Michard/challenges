# Computes the part of the location price which depends on the duration
#
# This takes into account discounts when duration increases
#
module Drivy
  class Rental
    module DurationPrice

      private

      def duration_discount(day_index)
        case day_index
          when 0...1
            0
          #- price per day decreases by 10% after 1 day
          when 1...4
            0.1
          #- price per day decreases by 30% after 4 days
          when 4...10
            0.3
          #- price per day decreases by 50% after 10 days
          else
            0.5
        end
      end

      def duration_price
        price = (0...duration_days).to_a.inject(0){|sum, day_index| sum + (1-duration_discount(day_index))*car.price_per_day }
        price.round
      end
    end
  end
end
