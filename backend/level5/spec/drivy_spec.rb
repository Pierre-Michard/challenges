require_relative 'spec_helper'

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
      expect(subject.serialized_rentals(with_actions: true)).to eq expected
    end
  end


end

