module Drivy
  class Rental
    module Actionable

      def self.included(klass)
        klass.validate :actions_sum_to_zero
      end

      #- the driver must pay the rental price and the (optional) deductible reduction
      #- the owner receives the rental price minus the commission
      #- the insurance receives its part of the commission
      #- the assistance receives its part of the commission
      #- drivy receives its part of the commission, plus the deductible reduction

      def actions
        {
            driver: -price - options.deductible_reduction,
            owner:  price - commission.total_commission,
            insurance: commission.insurance_fee,
            assistance: commission.assistance_fee,
            drivy: commission.drivy_fee + options.deductible_reduction
        }
      end

      def serialized_actions
        actions.map do |who, amount|
          {
              'who' => who.to_s,
              'type' => (amount > 0)? 'credit' : 'debit',
              'amount' => amount.abs
          }
        end
      end

      private
      def actions_sum_to_zero
        actions.values.inject(:+).zero?
      end
    end
  end
end