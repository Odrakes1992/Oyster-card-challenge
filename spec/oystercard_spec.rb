require 'oystercard'

describe Oystercard do

# it {is_expected.to respond_to(:top_up).with(1).argument}
# it {is_expected.to respond_to(:touch_in)}
# it {is_expected.to respond_to(:touch_out)}


#let(:monies) {double :monies}

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
    it "should deduct the fare from the balance" do
    expect{@subject.deduct_fare(3)}.to change{@subject.balance}.by -3
    end
    it "should be on journey" do
    @subject.touch_in
    expect(@subject.on_journey).to eq true
    end
end

  describe "#insufficient_funds" do
    it "should throw up error when funds are insufficient" do
    message = "You have insufficient funds to travel"
    expect{subject.touch_in}.to raise_error(message)
    end 
  end 

  describe "#touch_out" do 
    it "should not be on journey" do
    subject.top_up(Oystercard::DEFAULT_MAXIMUM)
    subject.touch_in
    subject.touch_out
    expect(subject.on_journey).to eq false
    end
  end

end