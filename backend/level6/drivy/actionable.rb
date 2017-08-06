module Drivy
  module Actionable
    extend ActiveSupport::Concern

    def self.included(klass)
      klass.validate :actions_sum_to_zero
    end

    class_methods do
      def actions
        @actions ||= []
      end

      def action(name, formula)
        actions << [name, formula]
      end
    end

    def actions
      self.class.actions.map{|name, formula|[name, instance_exec(&formula)]}.to_h
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