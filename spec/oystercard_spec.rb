require 'oystercard'

describe Oystercard do

it {is_expected.to respond_to(:top_up).with(1).argument}

#let(:monies) {double :monies}

describe "#top_up" do
  it "should add money to oyster card" do 
  expect(subject.top_up(1)).to eq(subject.balance)
  end 
end

describe "#balance" do
  it "should start with a balance of zero" do
  expect(subject.balance).to eq(0)
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

end