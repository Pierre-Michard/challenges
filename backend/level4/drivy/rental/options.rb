module Drivy
  class Rental
    class Options
      def initialize(deductible_reduction:false, duration_days: )
        @deductible_reduction = deductible_reduction
        @duration_days = duration_days
      end

      def deductible_reduction
        if @deductible_reduction
          400 * @duration_days
        else
          0
        end
      end

      def serialize
        {'deductible_reduction' => deductible_reduction}
      end

    end
  end
end