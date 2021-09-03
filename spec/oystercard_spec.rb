require 'oystercard'

describe Oystercard do

# it {is_expected.to respond_to(:top_up).with(1).argument}
# it {is_expected.to respond_to(:touch_in)}
# it {is_expected.to respond_to(:touch_out)}

let(:entry_station) {double :station}
let(:exit_station) {double :station}

#let(:journey){ {entry_station: entry_station, exit_station: exit_station } }

describe "#balance" do
  it "should start with a balance of zero" do
  expect(subject.balance).to eq(0)
  end
end

describe "#top_up" do
  it "should add money to oyster card" do 
  expect(subject.top_up(1)).to eq(subject.balance)
  end 
end

describe "#top_up error" do
  it "raise an error if top up takes over maximum" do
  maximum_balance = Oystercard::DEFAULT_MAXIMUM
  message = "Topping up this amount will take you over the £#{maximum_balance} maximum"
  subject.top_up maximum_balance
  expect{subject.top_up(1)}.to raise_error(message)
  end
end

describe "#oystercard_journey" do
  it "should not be in journey at the start" do
  expect(subject).to_not be_on_a_journey
  end
end

describe "#top_up_required" do 
  before(:each) do 
    @subject = Oystercard.new
    @subject.top_up(Oystercard::DEFAULT_MAXIMUM)
    end
    it "should be on journey" do
    @subject.touch_in(entry_station)
    expect(@subject).to be_on_a_journey
    end
    it "should have empty list of journeys by default" do 
    expect(@subject.list_of_journeys).to be_empty
    end
end

  describe "#insufficient_funds" do
    it "should throw up error when funds are insufficient" do
    message = "You have insufficient funds to travel"
    expect{subject.touch_in(entry_station)}.to raise_error(message)
    end 
  end 



  context 'when osyter card is on a journey' do 
    #let(:journey){ {entry_station: entry_station, exit_station: exit_station }}
    describe "#remembers_entry_station"do
      it "should remember the entry station on touch in" do 
      subject.top_up(30)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
      end
    end
    describe "#stores_journey" do
      it "should store a journey" do
      subject.top_up(10) #to prevent error for not enough monies
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      #expect(subject.list_of_journeys).to include journey (when trying to use the doubles can't move past the error)
      expect(subject.list_of_journeys).to include subject.journey
      end
    end
  end

  it "stores the stations" do 
    subject.top_up(13)
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq entry_station
    subject.touch_out(exit_station)
    expect(subject.exit_station).to eq exit_station
  end

  describe "#touch_out" do 
    it "should not be on journey" do
    minimum_fare = Oystercard::MINIMUM_AMOUNT
    subject.top_up(Oystercard::DEFAULT_MAXIMUM)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject).to_not be_on_a_journey
    expect{subject.touch_out(exit_station)}.to change{subject.balance}.by -minimum_fare
    end
  end

end