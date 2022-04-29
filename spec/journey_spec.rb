require 'journey'

describe Journey do

  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }

  describe '#start_journey' do

    it 'stores entry station' do
      subject.start_journey(entry_station)
      expect(subject.information[:entry_station]).to eq(entry_station)
    end

  end

  describe '#finish_journey' do

    it 'stores exit station' do
      subject.finish_journey(exit_station)
      expect(subject.information[:exit_station]).to eq(exit_station)
    end

  end

  describe '#calculate_fare' do

  it 'returns min fare if journey complete' do
    subject.start_journey(entry_station)
    subject.finish_journey(exit_station)
    expect(subject.calculate_fare).to eq Journey::MIN_FARE
  end

  
  
  it 'deducts penalty fare if user didn\'t touch in' do
    subject.information[:entry_station] = nil
    expect(subject.calculate_fare).to eq Journey::PENALTY_FARE
  end




  end

  describe '#journey_complete?' do 

    it 'returns true when when information is populated' do
      subject.start_journey(entry_station)
      subject.finish_journey(exit_station)
      expect(subject).to be_journey_complete
    end 
  end
end

