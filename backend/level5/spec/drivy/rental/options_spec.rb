require_relative '../../spec_helper'

describe Drivy::Rental::Options do

  describe 'deductible reduction ' do
    subject{options.deductible_reduction}

    context 'unchecked' do
      let(:options){Drivy::Rental::Options.new(deductible_reduction: false, duration_days:3)}

      it {should eq 0}
    end

    context 'checked' do
      let(:options){Drivy::Rental::Options.new(deductible_reduction: true, duration_days:3)}

      it {should eq 1200}
    end
  end

end
