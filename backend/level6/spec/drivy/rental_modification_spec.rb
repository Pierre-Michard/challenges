require_relative '../drivy_spec'

describe Drivy::RentalModification do
  let(:data_file_path){File.join(RSPEC_ROOT, '..', 'data.json')}
  let(:data){JSON.parse(File.open(data_file_path).read)}

  before do
    Drivy.init_data(data)
  end

  subject{Drivy::RentalModification.all[1]}
  it {should be_valid}

  describe '#modifications' do
    it 'returns modified attributes' do
      expect(subject.modifications).to eq({'start_date' => '2015-07-4' })
    end
  end

  describe '#modified_rental' do
    it 'returns a modified rental' do
      expect(subject.modified_rental).not_to eq subject.rental
    end

    it 'returns a rental with applied modifications' do
      expect(subject.modified_rental.start_date).to eq Date.parse('2015-07-4')
    end
  end

  describe '#actions' do
    it 'returns delta' do
      expect(subject.actions).to be_a Hash
    end

    it 'returns delta with correct driver value' do
      expect(subject.actions).to have_key :driver
      expect(subject.actions[:driver]).to eq 1400
    end

    it 'returns delta with correct owner value' do
      expect(subject.actions).to have_key(:owner)
      expect(subject.actions[:owner]).to eq -700
    end

  end

end