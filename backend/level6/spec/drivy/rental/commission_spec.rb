require_relative '../../spec_helper'

describe Drivy::Rental::Commission do

  context 'single day' do
    subject{Drivy::Rental::Commission.new(price: 3000, duration_days:1)}

    describe '#insurance_fee' do
      it 'has the correct value' do
        expect(subject.insurance_fee).to eq 450
      end
    end

    describe '#assistance_fee' do
      it 'has the correct value' do
        expect(subject.assistance_fee).to eq 100
      end
    end

    describe '#drivy_fee' do
      it 'has the correct value' do
        expect(subject.drivy_fee).to eq 350
      end
    end
  end

  context 'several days' do
    subject{Drivy::Rental::Commission.new(price: 3000, duration_days:2)}

    describe '#insurance_fee' do
      it 'has the correct value' do
        expect(subject.insurance_fee).to eq 450
      end
    end

    describe '#assistance_fee' do
      it 'has the correct value' do
        expect(subject.assistance_fee).to eq 200
      end
    end

    describe '#drivy_fee' do
      it 'has the correct value' do
        expect(subject.drivy_fee).to eq 250
      end
    end
  end

end
