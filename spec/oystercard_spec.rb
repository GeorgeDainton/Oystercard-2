require 'oystercard'

describe Oystercard do
  
  let(:station){ double :station }
  let(:entry_station){ double :station }
  let(:exit_station){ double :station }

  it 'returns balance' do
    expect(subject.balance).to eq(0)
  end
  
  it 'checks that new oystercard is not in journey' do
    expect(subject.in_journey?).to be false
  end

  it 'creates an instance of Oystercard' do
    expect(subject).to be_instance_of(Oystercard)
  end
  
  describe '#add_money' do
    it 'does not allow user to add more than maximum funds' do
      subject.add_money(Oystercard::MAX_BALANCE)
      expect { subject.add_money(1) }.to raise_error("funds cannot be added: maximum balance £#{Oystercard::MAX_BALANCE}")
    end
  end

  it 'stores the entry station' do 
    subject.add_money(Oystercard::MIN_FARE)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  describe '#touch_in' do
    it 'when card touches in, in journey is changed to true' do
      subject.add_money(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'it does not let you touch in if balance is less than min fare' do
      expect { subject.touch_in(station) }.to raise_error('Insufficient balance')
    end
  end

  describe '#touch_out' do
    it 'when card touches out, in journey is changed to false' do  
      subject.add_money(Oystercard::MIN_FARE)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end
    
    it 'deducts fare from balance' do
      subject.add_money(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MIN_FARE)
    end

    it 'resets entry station to nil' do
      subject.add_money(Oystercard::MIN_FARE)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq nil
    end

    it 'stores the exit station' do 
      subject.add_money(Oystercard::MIN_FARE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end

end






# it 'allows user to touch in' do
#   expect(subject).to respond_to :touch_in
# end
# it 'allows user to touch out' do
# expect(subject).to respond_to :touch_out
# end
