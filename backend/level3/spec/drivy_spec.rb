require 'rspec'
require 'json'

require_relative '../drivy'

RSPEC_ROOT = File.dirname __FILE__

describe Drivy do
  let(:data_file_path){File.join(RSPEC_ROOT, '..', 'data.json')}
  let(:output_file_path){File.join(RSPEC_ROOT, '..', 'output.json')}
  let(:data){JSON.parse(File.open(data_file_path).read)}


  describe '.init_data' do
    it 'creates cars' do
      Drivy.init_data(data)
      expect(Drivy.cars.size).to eq 1
    end

    it 'creates rentals' do
      Drivy.init_data(data)
      expect(Drivy.rentals.size).to eq 3
    end
  end

  describe '.output' do
    let(:expected){JSON.parse(File.open(output_file_path).read)}
    before do
      Drivy.init_data(data)
    end

    it 'has correct value' do
      expect(subject.output).to eq expected
    end
  end

  describe Drivy::Rental do
    before do
      Drivy.init_data(data)
    end

    subject{Drivy::Rental.all[1]}

    describe '#car' do
      it 'returns a car' do
        expect(subject.car).to be_a Drivy::Car
      end

      it 'returns a car with correct id' do
        expect(subject.car.id).to eq 1
      end
    end

    describe '#start_date' do
      it 'is a date' do
        expect(subject.start_date).to be_a Date
      end
    end

    describe '#end_date' do
      it 'is a date' do
        expect(subject.end_date).to be_a Date
      end
    end

    describe '#duration' do
      it 'has the correct value' do
        expect(subject.duration_days).to eq 2
      end
    end

    describe '#price' do
      it 'has the correct value' do
        expect(subject.price).to eq 6800
      end
    end

  end

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

end

