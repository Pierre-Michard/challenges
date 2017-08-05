#We decide to take a 30% commission on the rental price to cover our costs and have a solid business model.
#  The commission is split like this:
# - half goes to the insurance
# - 1€/day goes to the roadside assistance
# - the rest goes to us

module Drivy
  class Rental
    class Commission
      attr_reader :total_commission

      def initialize(price:, duration_days:)
        @total_commission = (0.3*price).round
        @duration_days = duration_days
      end

      def insurance_fee
        (@total_commission/2).round
      end

      def assistance_fee
        100 * @duration_days
      end

      def drivy_fee
        @total_commission - insurance_fee - assistance_fee
      end

      def serialize
        {
            'insurance_fee' => insurance_fee,
            'assistance_fee' => assistance_fee,
            'drivy_fee' => drivy_fee
        }
      end
    end
  end
end