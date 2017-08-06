require_relative '../drivy_spec'

describe Drivy::Rental do
  let(:data_file_path){File.join(RSPEC_ROOT, '..', 'data.json')}
  let(:data){JSON.parse(File.open(data_file_path).read)}

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

  describe '#validates' do
    it 'should be valid' do
      expect(subject).to be_valid
    end
  end

end