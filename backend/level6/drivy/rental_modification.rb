require_relative 'actionable'

module Drivy
  class RentalModification
    include ActiveModel::Model

    extend Storable
    include Actionable

    attr_accessor :id, :rental_id, :start_date, :end_date, :distance

    attr_reader :modifications

    CHANGEABLE_ATTRIBUTES = %w(start_date end_date distance)

    def initialize(attrs={})
      @modifications = attrs.slice(*CHANGEABLE_ATTRIBUTES)
      super(attrs)
    end

    def rental
      Rental.find(rental_id)
    end

    def modified_rental
      new_rental = rental.dup
      new_rental.assign_attributes(@modifications)
      new_rental
    end

    # the delta amount is basically the difference between:
    #    - the amount the actor owes (or is owed) after the modification
    #    - the amount the actor has already paid (or been given) before the modification
    def actions
      modified_rental.actions.merge(rental.actions) { |_, l, r| l-r }
    end

    def serialize
      {
          'id' => id,
          'rental_id' => rental_id,
          'actions' => serialized_actions
      }
    end

  end
end